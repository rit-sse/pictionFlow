# RNN Classifier Current Progress
I have added some starter code for our train_model script. I intend to create a function which will return an estimator with a working .predict() method.
<br>
The data that comes in from the application will have to be converted into a TFrecord. It will have to go through a pre-processing algorithm first, which is still to be written.

Pre-processing will most likely go as follows:
<br>
    Align the drawing to the top-left corner, to have minimum values of 0.

    Uniformly scale the drawing, to have a maximum value of 255.

    Resample all strokes with a 1 pixel spacing.

    Simplify all strokes using the Ramer–Douglas–Peucker algorithm with an epsilon value of 2.0.
<br>
The ramer-douglas-peucker algorithm will help to normalize data that comes in through different devices. Because some devices are faster than others, the screen event which we will be leveraging to collect x, y, t data will be inconsistent. Some devices will have more data points as increments in t will be smaller. Ramer-Douglas-Peucker algorithm will approximate the curve with fewer specified points, and will ultimately save time as well since it 
