#Author Joseph Casale
#data directory contains 32gb of ndjson drawing files, and will also contain tfrecords once this is fully operational.
import json
import os
import tensorflow as tf
import numpy as np
import time

from tensorflow.core.example.feature_pb2 import BytesList, Feature
TARGET_DIR = 'data/records'
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
    data_array[:,0] = np.append([], [stroke[0] for stroke in drawing]) # X data
    data_array[:,1] = np.append([], [stroke[1] for stroke in drawing])  # Y data
    data_array[:, 2] = np.append([],[[i[0] * np.ones((len(i[1][0]), 1))] for i in enumerate(drawing)]) #stroke index
    
    #must then normalize, and consider other changes
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
    }))
    print(example)
       
def ndjson_to_records(path):
    """
    Converts a ndjson file for pictionFlow drawing to TFrecord for training.
    Saves record in TARGET_DIR
    """    
    for filename in os.listdir('data/ndjson'):
        with open('data/ndjson/' + filename) as f:

            for line in f:
                content = json.loads(line)
                if content["recognized"] == False:
                    continue
                
                drawing, label = process_data(content["drawing"], content["word"])
                del(content)
                print(label)
                convert_to_record(drawing, label)
                #temp break
                break

if __name__ == "__main__":
    print(process_data([[[1,2,3], [4, 5, 6]], [[4,3,1], [5,5,5]]], "test"))
    ndjson_to_records('data/ndjson')
                                
                