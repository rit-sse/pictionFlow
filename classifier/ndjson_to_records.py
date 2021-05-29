#Author Joseph Casale
#data directory contains 32gb of ndjson drawing files, and will also contain tfrecords once this is fully operational.
import json
import os
import tensorflow as tf
import numpy as np
import time
import get_classes
from tensorflow._api.v2 import data

from tensorflow.core.example.feature_pb2 import BytesList, Feature
TARGET_DIR = 'data/records'
CLASSES = get_classes('data/ndjson')

def verify_record_integrity():
    data = tf.data.TFRecordDataset('data/records/t-shirt.tfrecord')
    def _parse_fn(proto):
        ex = tf.io.parse_single_example(
            proto,
            {
                'xyData': tf.io.VarLenFeature(dtype=tf.float32),
                'n': tf.io.VarLenFeature(dtype=tf.float32),
                'label' : tf.io.VarLenFeature(dtype = tf.string)
            }
        )
        return ex
        
    print(data.map(_parse_fn))
        
    

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
    
    max_p = np.max([drawing[0][:], drawing[1][:]])
    min_p = np.min([drawing[0][:], drawing[1][:]])
    
    stroke_count = max_num - min_num
    range = max_p - min_p
    if range == 0:
        range = 1
    if stroke_count == 0:
        stroke_count = 1
    drawing[0:2, :] = (drawing[0:2, :]/range)
    drawing[2, :] = (drawing[2, :][::-1] / stroke_count)#[::-1]reverses the array
    return drawing
def merge_arrays(arr1, arr2):
    full_array = []
    flop = False
    arr1_index = 0
    arr2_index = 0
    while arr1_index < len(arr1) and arr2_index < len(arr2):
        if flop:
            full_array.append(arr2[arr2_index])
            arr2_index += 1
            flop = False
        else:
            full_array.append(arr1[arr1_index])
            arr1_index+=1
            flop = True
    while(arr1_index < len(arr1)):
        full_array.append(arr1[arr1_index])
        arr1_index += 1
    while(arr2_index < len(arr2)):
        full_array.append(arr2[arr2_index])
        arr2_index += 1
    
    return np.array(full_array)
        
def process_data(drawing, label=None):
    """
    parses a data from the json object and returns nparray for drawing and a label string
    
    input: 
        Label : String for drawing classification. May not be present. This function may be moved to C for production
        drawing:
            [[
                [x vector],
                [y vector],rint(classes_dict)
    Returns: drawing np array, drawing label
    
    """
    data_array = np.empty((sum([len(stroke[0]) for stroke in drawing]), 3),dtype=np.dtype('float32'))
    print('here')
    current = 0
    for i, stroke in enumerate(drawing):
        data_array[current:(current+len(stroke[0])), 0] = stroke[0]
        data_array[current:(current+len(stroke[0])), 1] = stroke[1]
        data_array[current:(current+len(stroke[0])), 2] = i
        current += len(stroke[0])
    data_array = np.transpose(data_array)
    data_array = normalize_drawing(data_array)

    #Merge drawing data so [x1,x2,...],[y1,y2,...] becomes [x1, y1, x2, y2, ...]
    data_final = np.empty((2,2*len(data_array[0])))

    data_final[0,:] = merge_arrays(data_array[0,:], data_array[1,:])
    data_final[1,:]  = [s for s in data_array[2,:] for _ in (0,1) ]
    print(data_final)
    return data_final, label
def convert_to_record(drawing, label):
    label = str(label).encode('utf-8')
    # feature={
    #     'xyData' : tf.train.Feature(
    #         float_list=tf.train.FloatList(value=drawing[0])
    #     ),
    #     'n' : tf.train.Feature(
    #         float_list=tf.train.FloatList(value=drawing[1])
    #     ),
    #     'label' : tf.train.Feature(
    #         bytes_list=tf.train.BytesList(value=[label])
    #     )
    # }
    features = tf.data.Dataset.from_tensor_slices(drawing)

    example = tf.train.Example(features=tf.train.Features(feature=features))

    return example
    
def ndjson_to_records(path):
    """
    Converts a ndjson file for pictionFlow drawing to TFrecord for training.
    Saves record in TARGET_DIR
    """    
    for filename in sorted(os.listdir('data/ndjson')):
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
def get_classes(path):
    """
    parses a directory of ndjson files for "word" attribute and appends it all to a list
    
    encodes them with a number scheme
    """
    classes = []
    for filename in sorted(os.listdir('data/ndjson')):
        with open('data/ndjson/' + filename) as f:
            record = f.readline()
            classes.append(json.loads(record)['word'])

    classes_dict = {i:classes[i] for i in range(len(classes))}
    return classes_dict

        
if __name__ == "__main__":
    #print(process_data([[[1,2,3], [4, 5, 6]], [[4,3,1], [5,5,5]]], "test"))
    #ndjson_to_records('data/ndjson')
    #verify_record_integrity()
    get_classes('data/ndjson')                          
                