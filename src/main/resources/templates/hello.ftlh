<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8' />
    <title>Map</title>
    <script src='https://api.mapbox.com/mapbox-gl-js/v2.7.0/mapbox-gl.js'></script>
    <link href='https://api.mapbox.com/mapbox-gl-js/v2.7.0/mapbox-gl.css' rel='stylesheet' />
    <style>
        #map-container {
            position: relative;
            width: 66.66%;
            height: 100vh;
            float: left;
        }

        #empty-container {
            width: 33.33%;
            height: 100vh;
            float: left;
        }
    </style>
</head>
<body th:inline="text">
<div id='map-container'>
    <div id='map' style='width: 100%; height: 100%;'></div>
</div>

<div id='empty-container'></div>

<script th:inline="javascript">
    var longitude = parseFloat([[${longitude}]]);
    var latitude = parseFloat([[${latitude}]]);
    console.log(latitude);
    console.log(longitude);
    var map;

    mapboxgl.accessToken = 'pk.eyJ1IjoiZ3JpbWNoaWsiLCJhIjoiY2x1YmlyNmJ6MGZ4MTJwcGdkMW4wajFtdyJ9.DQjm2ZXzV6ggKJCKbNdlMw';
    map = new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/mapbox/streets-v11',
        center: [longitude, latitude], // Используем долготу и широту
        zoom: 15
    });

    map.addControl(new mapboxgl.NavigationControl());
    var marker = new mapboxgl.Marker({ color: 'red' })
        .setLngLat([longitude, latitude])
        .addTo(map);
</script>
</body>
</html>