#Author Joseph Casale
#data directory contains 32gb of ndjson drawing files, and will also contain tfrecords once this is fully operational.
import json
import os
import tensorflow as tf
import numpy as np
import time

from tensorflow.core.example.feature_pb2 import BytesList, Feature
TARGET_DIR = 'data/records'

def verify_record_integrity():
    data = tf.data.TFRecordDataset('data/records/t-shirt.tfrecord')
    
    print( tf.io.parse_single_example(
        data,
        {
            'x': tf.io.RaggedFeature(dtype=tf.b),
            'y': tf.io.RaggedFeature(dtype=tf.float64),
            'n': tf.io.RaggedFeature(dtype=tf.float64),
            'label' : tf.io.VarLenFeature(dtype = tf.string)
        }
    ))

def normalize_drawing(drawing):
    """
    Drawing is list of strokes
    
    [[
        strokenum,
        [x vector],
        [y vector],
    ],
    [
        ...
    ]]
    """
    max_num = drawing[-1][-1]
    min_num = drawing[-1][0]
    print(f'Max{max_num} min {min_num}')
    
    max_p = np.max([drawing[0][:], drawing[1][:]])
    min_p = np.min([drawing[0][:], drawing[1][:]])
    
    stroke_count = max_num - min_num
    range = max_p - min_p
    if range == 0:
        range = 1
    if stroke_count == 0:
        stroke_count = 1
    drawing[0:2, :] = (drawing[0:2, :]/range)
    drawing[2, :] = (drawing[2, :] / stroke_count)
    
    return drawing

def process_data(drawing, label=None):
    """
    parses a data from the json object and returns nparray for drawing and a label string
    
    input: 
        Label : String for drawing classification. May not be present. This function may be moved to C for production
        drawing:
            [[
                [x vector],
                [y vector],
                [stroke nums]
            ],
            [
                ...
            ]]         
    Returns: drawing np array, drawing label
    
    """
    data_array = np.empty((sum([len(stroke[0]) for stroke in drawing]), 3),dtype=object)
    current = 0
    for i, stroke in enumerate(drawing):
        data_array[current:(current+len(stroke[0])), 0] = stroke[0]
        data_array[current:(current+len(stroke[0])), 1] = stroke[1]
        data_array[current:(current+len(stroke[0])), 2] = i
        current += len(stroke[0])
    data_array = np.transpose(data_array)
    data_array = normalize_drawing(data_array)
    return data_array, label
def convert_to_record(drawing, label):
    label = str(label).encode('utf-8')
    example = tf.train.Example(features=tf.train.Features(feature={
        'x' : tf.train.Feature(
            float_list=tf.train.FloatList(value=drawing[0])
        ),
        'y' : tf.train.Feature(
            float_list=tf.train.FloatList(value=drawing[1])
        ),
        'n' : tf.train.Feature(
            float_list=tf.train.FloatList(value=drawing[2])
        ),
        'label' : tf.train.Feature(
            bytes_list=tf.train.BytesList(value=[label])
        )
    })).SerializeToString()


    return example      
def ndjson_to_records(path):
    """
    Converts a ndjson file for pictionFlow drawing to TFrecord for training.
    Saves record in TARGET_DIR
    """    
    for filename in os.listdir('data/ndjson'):
        print(filename)
        with open('data/ndjson/' + filename) as f:

            for line in f:
                content = json.loads(line)
                if content["recognized"] == False:
                    continue
                
                drawing, label = process_data(content["drawing"], content["word"])
                example = convert_to_record(drawing, label)
                with tf.io.TFRecordWriter('data/records/'+content["word"]+'.tfrecord') as writer:
                    writer.write(example)
                break
            break
if __name__ == "__main__":
    #print(process_data([[[1,2,3], [4, 5, 6]], [[4,3,1], [5,5,5]]], "test"))
    ndjson_to_records('data/ndjson')
    #verify_record_integrity()
                                
                