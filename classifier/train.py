import tensorflow as tf
from tensorflow._api.v2 import data
from tensorflow.python.ops.gen_math_ops import mod
from tensorflow_estimator.python.estimator import run_config

BATCH_SIZE = 10
    

def get_input_fn(mode, data_path):
    """
    returns an input_fn
    
    params:
     - ModeKeys.mode : may be .TRAIN, .EVAL, or .PREDICT mode
     - data_path     : path to data directory for this 
    ==========================================================
    
    input_fn is parameter-less,
    
    input_fn returns a tuple (batch_features, batch_labels)
    
    ({
        'x': [[x01, x02, ..., x0n], [x11, x12, ..., x1n], ... ],
        'y': [[y01, y02, ..., y0n], [y11, y12, ..., y1n], ... ]
    },
        [label0, label1, ... ]
    )
    """
    def _input_fn():
        dataset = tf.data.Dataset.from_tensor_slices(
            
        )
        return

    return _input_fn


def model_fn(features, labels, mode, params):
    """
    Custom model function to be provoked under 3 circumstances specified by mode.
    
    features: batch_features from input_fn
    labels: batch_labels from input_fn
    mode: tf.esimator.ModeKeys
    params: dict of parameters to aid with versatility
    
    returns: tf.estimator.EstimatorSpec
    
    """
    return 



if __name__ == "__main__":
    
    
    configuration = tf.estimator.RunConfig(
        model_dir="model",
        save_checkpoints_secs= 270,
    )
    
    model_params = {
        'data_path' : 'data',
        'num_layers' : 3,
        'num_nodes' : 128,
        'num_conv' : [48, 64, 96],
        'conv_len' : [5, 5, 3],
        'model_dir' : 'model'
    }
    
    estimator = tf.estimator.Estimator(
        model_fn=model_fn,
        config=configuration,
        params=model_params
    )
    
    trainer = tf.estimator.TrainSpec(input_fn=get_input_fn(
        mode=tf.estimator.ModeKeys.TRAIN,
        data_path=model_params['data_path']), max_steps=150000)