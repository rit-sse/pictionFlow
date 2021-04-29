## PictionFlow
<h1 align="center">
    <br>
    <img src="https://github.com/rit-sse/pictionFlow/blob/master/images/logo.PNG" width="600" alt = "pictionflow">
</h1>
<h4 align="center" style="font-size:10000%:">An iOS (for the meantime) game for guessing doodles.</h4>

<p align="center" style="font-size:180%;">
    PictionFlow will be a mobile application seeded with data from <a href="https://github.com/googlecreativelab/quickdraw-dataset" target="_blank">Quick, Draw!</a>
</p>

<br>
<h4 align="left"> CLICK BELOW!</h4>
<details>
<summary>Current Trajectory</summary>
<br>
# Current Plan (For Static Model)
<h2 align="left"> Overview</h2>
<p2 align="left">
Cost minimization will be one aspect of the project. IOS applications will have to compiled on a Mac OS; as such, I plan to use <a href="https://www.macincloud.com/" target = "_blank">CloudInMac</a>, which will charge a monthly fee. While it is not too high cost, to save money, and so we know where we're shooting, we will design the back-end first. Incase you're wondering what I mean by "static model," we will first get the app communicating with a rudimentary model. The TensorFlow model will be trained with seeded data, and simply be inquired for a prediction. The dynamic model, where new data will be added to the model, will be kept in mind as we design the API.

The data from the client will be processed to conform to the expected input of the model. Since we would like to minimize the amount of memory the consumer uses, it would be ideal to do as much of this processing on our end as possible, while maintaining reasonable request package size. The classification the model predicts will most likely be a concise string to be sent back to the client-side.

As you can see, it's unlikely we will need to have a database for this stage. If we were to design a dynamic model, the data would have to be maintained in perhaps a mySQL database.
</p2>
<br>
<h2 align="left"> Model</h2>
<p2 align="left">
The model itself will most likely be a Recurrent Neural Network (RNN), which will use the temporal data collected by Quick, Draw! This of course would mean the application would have to track the users movement, and update the data log every 1 ms. I've never made a project like this before, and I've never worked on a mobile app before -- If this can be done without causing ridiculous stutter, then this will produce the best predictions. Otherwise, we may be able to resort to a Convolutional Neural Network, which will simply attempt to assocate the raw pixel data with a prediction. I believe the Recurrent Neural Network should be our target, since it will force us to optimize. If we must, we may be able update the data log slightly less frequently and interpolate the data from there.

This will probably be in python. I've heard models can be saved in a file.
</p2>
<br>
<h2 align="left"> API</h2>
<p2 align="left">
The API is a relative coin-toss at the moment in terms of language. It may be be written with either java's Spring framework, Python's Flask framework, or Node.js. I personally think Node.js is a good choice for experience. The API will essentially listen for data, have the server process the data, and send a response back.

We will have to acquire an SSL certificate, and use HTTPS.

>I will update more on the API shortly.
</p2>
<br>
<h2 align="left">iOS/Android Application(Client)</h2>
<p2 align="left">
The application will most likely be an IOS application developed in swift. The application will employ a canvas that allows the user to draw. The application will likely have to be multi-threaded, as to allow the UI to hopefully run smoothly as the application uses another thread to add temporal data to the log. If this is not doable, we will resort to a CNN. The application will then send the data to the server and wait for a response.

>More on the application shortly.
</p2>
</details>

# Funded by SSE
<h1 align="center">
    <br>
    <img src="https://avatars.githubusercontent.com/u/1082445?s=200&v=4" width="200" alt = "SSE">
</h1>
