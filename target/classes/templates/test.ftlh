<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Demo: Trip Planner</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <script src="https://api.tiles.mapbox.com/mapbox-gl-js/v3.1.0/mapbox-gl.js"></script>
    <link
            href="https://api.tiles.mapbox.com/mapbox-gl-js/v3.1.0/mapbox-gl.css"
            rel="stylesheet"
    />
    <script src="https://api.mapbox.com/mapbox-gl-js/plugins/mapbox-gl-geocoder/v4.7.0/mapbox-gl-geocoder.min.js"></script>
    <link
            rel="stylesheet"
            href="https://api.mapbox.com/mapbox-gl-js/plugins/mapbox-gl-geocoder/v4.7.0/mapbox-gl-geocoder.css"
            type="text/css"
    />
    <style>
        body {
          margin: 0;
          padding: 0;
          display: flex;
          flex-direction: column;
          height: 100vh;
        }

        #map-container {
          width: 60%;
          height: 100%;
          position: relative;
        }

        #map {
          width: 100%;
          height: 100%;
        }

        #right-panel {
          width: 40%;
          height: 100%;
          overflow-y: auto;
          padding: 10px;
          box-sizing: border-box;
        }

        .button-container {
          margin-top: 10px;
          display: flex;
          justify-content: center;
        }

        .button {
            width: 200px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: rgb(161, 255, 20);
            border-radius: 30px;
            color: rgb(19, 19, 19);
            font-weight: 600;
            border: none;
            cursor: pointer;
            transition-duration: .2s;
            box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.116);
            font-size: 14px;
        }

        .button:hover {
            background-color: rgb(192, 255, 20);
            transition-duration: .5s;
        }

        .button:active {
            transform: scale(0.97);
            transition-duration: .2s;
        }
    </style>
</head>
<body>
<div id="map-container">
    <div id="map"></div>
    <div class="button-container">
        <button class="button">Return to Start</button>
    </div>
</div>
<div id="right-panel">
    <!-- Place your list of intermediate points here -->
</div>
<script>
    // Your JavaScript code here
</script>
</body>
</html>
