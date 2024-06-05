<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <title>New Travel Planning</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
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
         justify-content: space-between;
       }

       #map {
          width: 90%;
          height: 80vh;
          margin-right: 20px;
       }

       #markerTable {
         width: 40%;
         margin-top: 20px;
       }

       .button-container {
         position: absolute;
         margin-bottom: 10px;
         bottom: 20px;
       }

       .button {
         font-family: 'Arial', sans-serif;
         font-size: 14px;
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
         display: block;
         margin-bottom: 5px;
       }

       .button:hover {
         background-color: rgb(192, 255, 20);
         transition-duration: .5s;
       }

       .button:active {
         transform: scale(0.97);
         transition-duration: .2s;
       }

       .radio-inputs {
         display: flex;
         justify-content: center;
         align-items: center;
         max-width: 350px;
         -webkit-user-select: none;
         -moz-user-select: none;
         -ms-user-select: none;
         user-select: none;
         margin-left: 20px;
       }

       .radio-inputs > * {
         margin: 6px;
       }
       .row-m-t{
           margin-top : 160px
       }
       .btn-group-m-t
       {
        margin-top : 20px
       }
       .row-m-b{
           margin-bottom : 20px
       }
       .radio-input:checked + .radio-tile {
         border-color: #2260ff;
         box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
         color: #2260ff;
       }

       .radio-input:checked + .radio-tile:before {
         transform: scale(1);
         opacity: 1;
         background-color: #2260ff;
         border-color: #2260ff;
       }

       .radio-input:checked + .radio-tile .radio-icon svg {
         fill: #2260ff;
       }

       .radio-input:checked + .radio-tile .radio-label {
         color: #2260ff;
       }

       .radio-input:focus + .radio-tile {
         border-color: #2260ff;
         box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1), 0 0 0 4px #b5c9fc;
       }

       .radio-input:focus + .radio-tile:before {
         transform: scale(1);
         opacity: 1;
       }

       .radio-tile {
         display: flex;
         flex-direction: column;
         align-items: center;
         justify-content: center;
         width: 80px;
         min-height: 80px;
         border-radius: 0.5rem;
         border: 2px solid #b5bfd9;
         background-color: #fff;
         box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
         transition: 0.15s ease;
         cursor: pointer;
         position: relative;
       }

       .radio-tile:before {
         content: "";
         position: absolute;
         display: block;
         width: 0.75rem;
         height: 0.75rem;
         border: 2px solid #b5bfd9;
         background-color: #fff;
         border-radius: 50%;
         top: 0.25rem;
         left: 0.25rem;
         opacity: 0;
         transform: scale(0);
         transition: 0.25s ease;
       }

       .radio-tile:hover {
         border-color: #2260ff;
       }

       .radio-tile:hover:before {
         transform: scale(1);
         opacity: 1;
       }

       .radio-icon svg {
         width: 2rem;
         height: 2rem;
         fill: #494949;
       }

       .avatar-container {
         margin-right: 10px;
       }

       .avatar {
         width: 50px;
         height: 50px;
         border-radius: 50%;
       }

       .radio-label {
         color: #707070;
         transition: 0.375s ease;
         text-align: center;
         font-size: 13px;
       }

       .radio-input {
         clip: rect(0 0 0 0);
         -webkit-clip-path: inset(100%);
         clip-path: inset(100%);
         height: 1px;
         overflow: hidden;
         position: absolute;
         white-space: nowrap;
         width: 1px;
       }

       .modal {
         display: none;
         position: fixed;
         z-index: 1;
         left: 0;
         top: 0;
         width: 100%;
         height: 100%;
         overflow: auto;
         background-color: rgba(0,0,0,0.4);
       }

       .modal-content {
         background-color: #fefefe;
         margin: 15% auto;
         padding: 20px;
         border: 1px solid #888;
         width: 80%;
       }

       .close {
         color: #aaa;
         float: right;
         font-size: 28px;
         font-weight: bold;
       }

       .close:hover,
       .close:focus {
         color: black;
         text-decoration: none;
         cursor: pointer;
       }

       .Btn {
         display: flex;
         align-items: center;
         justify-content: flex-start;
         width: 40px;
         height: 40px;
         border: none;
         border-radius: 50%;
         cursor: pointer;
         position: relative;
         overflow: hidden;
         transition-duration: 0.3s;
         box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.199);
         background-color: rgb(161, 255, 20);
       }

       .bg-rgb-menu {
         background-color: rgb(161, 255, 20);
       }

       .sign {
         width: 100%;
         transition-duration: 0.3s;
         display: flex;
         align-items: center;
         justify-content: center;
       }

       .sign svg {
         width: 18px;
       }

       .sign svg path {
         fill: black;
       }

       .avatar {
         width: 50px;
         height: 50px;
         border-radius: 50%;
       }

       .text {
         position: absolute;
         right: 0%;
         width: 0%;
         opacity: 0;
         color: black;
         font-size: 1.2em;
         font-weight: 600;
         transition-duration: 0.3s;
       }

       .Btn:hover {
         width: 155px;
         border-radius: 40px;
         transition-duration: 0.3s;
       }

       .Btn:hover .sign {
         width: 30%;
         transition-duration: 0.3s;
         padding-left: 20px;
       }

       .Btn:hover .text {
         opacity: 1;
         width: 70%;
         transition-duration: 0.3s;
         padding-right: 10px;
       }

       .Btn:active {
         transform: translate(2px, 2px);
       }

       .button2 {
         width: 220px;
         height: 40px;
         display: flex;
         align-items: center;
         justify-content: flex-start;
         gap: 10px;
         background-color: rgb(161, 255, 20);
         border-radius: 30px;
         color: rgb(19, 19, 19);
         font-weight: 600;
         border: none;
         position: relative;
         cursor: pointer;
         transition-duration: .2s;
         box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.116);
         padding-left: 8px;
         transition-duration: .5s;
       }

       .svgIcon {
         height: 25px;
         transition-duration: 1.5s;
       }

       .bell2 path {
         fill: rgb(19, 19, 19);
       }

       .button2:hover {
         background-color: rgb(192, 255, 20);
         transition-duration: .5s;
       }

       .button2:active {
         transform: scale(0.97);
         transition-duration: .2s;
       }

       .button2:hover .svgIcon {
         transform: rotate(250deg);
         transition-duration: 1.5s;
       }
        .button3 {
         width: 220px;
         height: 40px;
         display: flex;
         align-items: center;
         justify-content: flex-start;
         gap: 10px;
         background-color: rgb(255,0,0);
         border-radius: 30px;
         color: rgb(19, 19, 19);
         font-weight: 600;
         border: none;
         position: relative;
         cursor: pointer;
         transition-duration: .2s;
         box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.116);
         padding-left: 8px;
         transition-duration: .5s;
       }

       .svgIcon {
         height: 25px;
         transition-duration: 1.5s;
       }

       .bell2 path {
         fill: rgb(19, 19, 19);
       }

       .button3:hover {
         background-color: rgb(255,102,102);
         transition-duration: .5s;
       }

       .button3:active {
         transform: scale(0.97);
         transition-duration: .2s;
       }

       .button3:hover .svgIcon {
         transform: rotate(250deg);
         transition-duration: 1.5s;
       }
       .modal {
         display: none;
         position: fixed;
         z-index: 1;
         left: 0;
         top: 0;
         width: 100%;
         height: 100%;
         overflow: auto;
         background-color: rgba(0,0,0,0.4);
       }

       .modal-content {
         background-color: #fefefe;
         margin: 15% auto;
         padding: 20px;
         border: 1px solid #888;
         width: 80%;
       }

       .close {
         color: #aaa;
         float: right;
         font-size: 28px;
         font-weight: bold;
       }

       .close:hover,
       .close:focus {
         color: black;
         text-decoration: none;
         cursor: pointer;
       }

       body {
         margin: 0;
         padding: 0;
         display: flex;
         flex-direction: column;
         height: 100vh;
         justify-content: center;
         align-items: center;
       }

       #circular-image {
         border-radius: 50%;
         width: 150px;
         height: 150px;
       }

       #image-container {
         position: absolute;
         top: 20px;
         right: 20px;
         border-radius: 50%;
       }


       .button-container {
         position: absolute;
         bottom: 20px;
       }

       #profile-form {
         margin-right: 10px;
       }

       .buttonbell {
         width: 30px;
         height: 30px;
         display: flex;
         align-items: center;
         justify-content: center;
         background-color: rgb(44, 44, 44);
         border-radius: 50%;
         cursor: pointer;
         transition-duration: .3s;
         box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.13);
         border: none;
       }

       .bell {
         width: 18px;
       }

       .bell path {
         fill: white;
       }

       .buttonbell:hover {
         background-color: rgb(56, 56, 56);
       }

       .buttonbell:hover .bell {
         animation: bellRing 0.9s both;
       }

       @keyframes bellRing {
         0%,
         100% {
           transform-origin: top;
         }
         15% {
           transform: rotateZ(10deg);
         }
         30% {
           transform: rotateZ(-10deg);
         }
         45% {
           transform: rotateZ(5deg);
         }
         60% {
           transform: rotateZ(-5deg);
         }
         75% {
           transform: rotateZ(2deg);
         }
       }

       .buttonbell:active {
         transform: scale(0.8);
       }

       .navbar-brand img {
         width: 30px;
         height: 30px;
       }

       .nav-link {
         font-family: 'Arial', sans-serif;
         font-size: 16px;
         color: black;
       }

       .nav-item + .nav-item {
         border-left: 2px solid black;
         padding-left: 15px;
       }

       .bg-rgb-menu {
         background-color: rgb(192, 255, 20);
       }
       body {
         margin: 0;
         padding: 0;
         display: flex;
         justify-content: space-between;
       }


       #markerTable {
         width: 40%;
         margin-top: 20px;
       }

       .button-container {
         position: absolute;
         margin-bottom: 10px;
         bottom: 20px;
       }
       .button2 {
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
           display: block;
           margin-bottom: 5px;
       }
       .button {
           width: 200px;
           height: 40px;
           display: none;
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
           margin-bottom: 5px;
       }

       .button:hover {
           background-color: rgb(192, 255, 20);
           transition-duration: .5s;
       }

       .button:active {
           transform: scale(0.97);
           transition-duration: .2s;
       }
       .radio-inputs {
 display: flex;
 justify-content: center;
 align-items: center;
 max-width: 350px;
 -webkit-user-select: none;
 -moz-user-select: none;
 -ms-user-select: none;
 user-select: none;
 margin-left: 20px;
}
.radio-inputs > * {
 margin: 6px;
}

.radio-input:checked + .radio-tile {
 border-color: #2260ff;
 box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
 color: #2260ff;
}

.radio-input:checked + .radio-tile:before {
 transform: scale(1);
 opacity: 1;
 background-color: #2260ff;
 border-color: #2260ff;
}

.radio-input:checked + .radio-tile .radio-icon svg {
 fill: #2260ff;
}

.radio-input:checked + .radio-tile .radio-label {
 color: #2260ff;
}

.radio-input:focus + .radio-tile {
 border-color: #2260ff;
 box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1), 0 0 0 4px #b5c9fc;
}

.radio-input:focus + .radio-tile:before {
 transform: scale(1);
 opacity: 1;
}

.radio-tile {
 display: flex;
 flex-direction: column;
 align-items: center;
 justify-content: center;
 width: 80px;
 min-height: 80px;
 border-radius: 0.5rem;
 border: 2px solid #b5bfd9;
 background-color: #fff;
 box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
 transition: 0.15s ease;
 cursor: pointer;
 position: relative;
}

.radio-tile:before {
 content: "";
 position: absolute;
 display: block;
 width: 0.75rem;
 height: 0.75rem;
 border: 2px solid #b5bfd9;
 background-color: #fff;
 border-radius: 50%;
 top: 0.25rem;
 left: 0.25rem;
 opacity: 0;
 transform: scale(0);
 transition: 0.25s ease;
}

.radio-tile:hover {
 border-color: #2260ff;
}

.radio-tile:hover:before {
 transform: scale(1);
 opacity: 1;
}

.radio-icon svg {
 width: 2rem;
 height: 2rem;
 fill: #494949;
}

.avatar-container {
   margin-right: 10px;
}

.avatar {
   width: 50px;
   height: 50px;
   border-radius: 50%;
}
.radio-label {
 color: #707070;
 transition: 0.375s ease;
 text-align: center;
 font-size: 13px;
}

.radio-input {
 clip: rect(0 0 0 0);
 -webkit-clip-path: inset(100%);
 clip-path: inset(100%);
 height: 1px;
 overflow: hidden;
 position: absolute;
 white-space: nowrap;
 width: 1px;
}
       .modal {
       display: none;
       position: fixed;
       z-index: 1;
       left: 0;
       top: 0;
       width: 100%;
       height: 100%;
       overflow: auto;
       background-color: rgba(0,0,0,0.4);
   }
   .modal-content {
       background-color: #fefefe;
       margin: 15% auto;
       padding: 20px;
       border: 1px solid #888;
       width: 80%;
   }
   .close {
       color: #aaa;
       float: right;
       font-size: 28px;
       font-weight: bold;
   }
   .close:hover,
   .close:focus {
       color: black;
       text-decoration: none;
       cursor: pointer;
   }
    </style>
</head>
<body>
<div class="container-fluid">
    <nav class="navbar navbar-expand-lg navbar-light bg-rgb-menu fixed-top">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">
                <img src="/LogoWeb.png" alt="" class="d-inline-block align-top">Voyage
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0" style="display: flex; align-items: center;">
                    <li class="nav-item">
                        <a class="nav-link" href="/hello">Главная</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/your-travels">Ваши Путешествия</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/friends-list">Список Друзей</a>
                    </li>
                </ul>
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0" style="display: flex; align-items: center;">
                    <li class="nav-item">
                        <button id="showRequestsButton" class="buttonbell">
                            <svg viewBox="0 0 448 512" class="bell"><path d="M224 0c-17.7 0-32 14.3-32 32V49.9C119.5 61.4 64 124.2 64 200v33.4c0 45.4-15.5 89.5-43.8 124.9L5.3 377c-5.8 7.2-6.9 17.1-2.9 25.4S14.8 416 24 416H424c9.2 0 17.6-5.3 21.6-13.6s2.9-18.2-2.9-25.4l-14.9-18.6C399.5 322.9 384 278.8 384 233.4V200c0-75.8-55.5-138.6-128-150.1V32c0-17.7-14.3-32-32-32zm0 96h8c57.4 0 104 46.6 104 104v33.4c0 47.9 13.9 94.6 39.7 134.6H72.3C98.1 328 112 281.3 112 233.4V200c0-57.4 46.6-104 104-104h8zm64 352H224 160c0 17 6.7 33.3 18.7 45.3s28.3 18.7 45.3 18.7s33.3-6.7 45.3-18.7s18.7-28.3 18.7-45.3z"></path></svg>
                        </button>
                    </li>
                    <li class="nav-item" style="margin-right: auto;">
                        <form id="profile-form" action="/profile" method="get" style="display: flex; align-items: center;">
                            <button type="submit" class="btn" style="border: none; background: none; padding: 0; margin: 0;" disabled>
                                <img id="circular-image" src="data:image/png;base64,${base64Image}" alt="avatar" style="width: 50px; height: 50px;">
                            </button>
                            <a class="nav-link" href="/profile">Профиль</a>
                        </form>
                    </li>
                    <li class="nav-item">
                        <form action="/logout" method="post">
                            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                            <button class="btn" type="submit">
                                <div class="sign">
                                    <svg viewBox="0 0 512 512">
                                        <path d="M377.9 105.9L500.7 228.7c7.2 7.2 11.3 17.1 11.3 27.3s-4.1 20.1-11.3 27.3L377.9 406.1c-6.4 6.4-15 9.9-24 9.9c-18.7 0-33.9-15.2-33.9-33.9l0-62.1-128 0c-17.7 0-32-14.3-32-32l0-64c0-17.7 14.3-32 32-32l128 0 0-62.1c0-18.7 15.2-33.9 33.9-33.9c9 0 17.6 3.6 24 9.9zM160 96L96 96c-17.7 0-32 14.3-32 32l0 256c0 17.7 14.3 32 32 32l64 0c17.7 0 32 14.3 32 32s-14.3 32-32 32l-64 0c-53 0-96-43-96-96L0 128C0 75 43 32 96 32l64 0c17.7 0 32 14.3 32 32s-14.3 32-32 32z"></path>
                                    </svg>
                                </div>
                                <div class="text">Logout</div>
                            </button>
                        </form>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</div>
<div class="container mt-3">
    <div class="row row-m-t row-m-b">
        <div class="col-auto">
            <div> <input type="text" id="text" name="name" maxlength="255" value="${name}" <#if status == 'user'>readonly</#if>></div>
    </div>
        <div class="col-auto">
            <div class="form-check form-check-inline">
                <input class="form-check-input radio-input" type="radio" name="engine" value="cycling" id="cycling">
                <label class="form-check-label radio-tile" for="cycling">
          <span class="radio-icon">
            <svg stroke="currentColor" xml:space="preserve" viewBox="0 0 493.407 493.407" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg" id="Capa_1" version="1.1" width="200px" height="200px" fill="none"><g stroke-width="0" id="SVGRepo_bgCarrier"></g><g stroke-linejoin="round" stroke-linecap="round" id="SVGRepo_tracerCarrier"></g><g id="SVGRepo_iconCarrier"> <path d="M488.474,270.899c-12.647-37.192-47.527-62.182-86.791-62.182c-5.892,0-11.728,0.749-17.499,1.879l-34.324-100.94 c-1.71-5.014-6.417-8.392-11.721-8.392H315.02c-6.836,0-12.382,5.547-12.382,12.382c0,6.836,5.545,12.381,12.382,12.381h14.252 l12.462,36.645H206.069v-21.998l21.732-2.821c3.353-0.434,6.135-3.079,6.585-6.585c0.54-4.183-2.402-8.013-6.585-8.553l-68.929-8.94 c-1.362-0.168-2.853-0.185-4.281,0c-9.116,1.186-15.55,9.537-14.373,18.653c1.185,9.118,9.537,15.55,18.653,14.364l22.434-2.909 v26.004l-41.255,52.798c-14.059-8.771-30.592-13.93-48.349-13.93C41.135,208.757,0,249.885,0,300.443 c0,50.565,41.135,91.7,91.701,91.7c44.882,0,82.261-32.437,90.113-75.095h33.605v12.647h-5.909c-4.563,0-8.254,3.693-8.254,8.254 c0,4.563,3.691,8.254,8.254,8.254h36.58c4.563,0,8.254-3.691,8.254-8.254c0-4.561-3.691-8.254-8.254-8.254h-5.908v-12.647h5.545 c3.814,0,7.409-1.756,9.755-4.756l95.546-122.267l9.776,28.729c-17.854,8.892-32.444,22.965-41.409,41.168 c-10.825,21.973-12.438,46.842-4.553,70.034c12.662,37.201,47.55,62.189,86.815,62.189c10.021,0,19.951-1.645,29.519-4.9 c23.191-7.885,41.926-24.329,52.744-46.302C494.746,318.966,496.367,294.09,488.474,270.899z M143.46,258.542 c7.698,9.488,12.776,21.014,14.349,33.742h-40.717L143.46,258.542z M91.701,367.379c-36.912,0-66.938-30.026-66.938-66.936 c0-36.904,30.026-66.923,66.938-66.923c12.002,0,23.11,3.427,32.864,8.981l-42.619,54.54c-2.917,3.732-3.448,8.794-1.378,13.05 c2.08,4.256,6.4,6.957,11.134,6.957h64.592C148.861,345.906,122.84,367.379,91.701,367.379z M239.69,292.284h-56.707 c-1.839-20.667-10.586-39.329-23.868-53.782l22.191-28.398v32.47c0,6.836,5.545,12.381,12.381,12.381 c6.836,0,12.382-5.545,12.382-12.381v-55.138h115.553L239.69,292.284z M383.546,285.618l6.384,18.79 c1.75,5.151,6.562,8.392,11.721,8.392c1.321,0,2.667-0.21,3.99-0.661c6.471-2.201,9.93-9.23,7.729-15.711l-6.336-18.637 c7.731,1.838,14.221,7.312,16.855,15.083c2.024,5.94,1.613,12.309-1.161,17.935c-2.773,5.626-7.569,9.835-13.509,11.858 c-12.068,4.078-25.716-2.717-29.785-14.671C376.735,300.055,378.597,291.689,383.546,285.618z M461.712,329.994 c-7.908,16.042-21.579,28.044-38.507,33.808c-6.997,2.378-14.244,3.578-21.547,3.578c-28.664,0-54.129-18.249-63.374-45.399 c-5.757-16.926-4.571-35.081,3.328-51.112c6.047-12.27,15.494-22.112,27.165-28.666l8.981,26.416 c-13.414,10.108-19.644,27.931-13.954,44.691c5.522,16.227,20.732,27.124,37.853,27.124c4.378,0,8.707-0.725,12.882-2.145 c10.108-3.434,18.282-10.607,22.999-20.184c4.723-9.585,5.425-20.435,1.982-30.551c-5.545-16.299-21.57-26.787-38.289-26.818 l-8.997-26.472c3.128-0.453,6.28-0.783,9.448-0.783c28.658,0,54.112,18.242,63.351,45.399 C470.788,295.799,469.613,313.96,461.712,329.994z"></path> </g></svg>
          </span>
                    <span class="radio-label">Велосипед</span>
                </label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input radio-input" type="radio" name="engine" value="walking" id="walking">
                <label class="form-check-label radio-tile" for="walking">
          <span class="radio-icon">
           <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" fill="#000000"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"><path d="M13.9 2.999A1.9 1.9 0 1 1 12 1.1a1.9 1.9 0 0 1 1.9 1.899zM13.544 6h-3.088a1.855 1.855 0 0 0-1.8 1.405l-1.662 6.652a.667.667 0 0 0 .14.573.873.873 0 0 0 .665.33.718.718 0 0 0 .653-.445L10 9.1V13l-.922 9.219a.71.71 0 0 0 .707.781h.074a.69.69 0 0 0 .678-.563L12 14.583l1.463 7.854a.69.69 0 0 0 .678.563h.074a.71.71 0 0 0 .707-.781L14 13V9.1l1.548 5.415a.718.718 0 0 0 .653.444.873.873 0 0 0 .665-.329.667.667 0 0 0 .14-.573l-1.662-6.652A1.855 1.855 0 0 0 13.544 6z"></path><path fill="none" d="M0 0h24v24H0z"></path></g></svg>
          </span>
                    <span class="radio-label">Пешком</span>
                </label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input radio-input" type="radio" name="engine" value="driving" id="driving" checked>
                <label class="form-check-label radio-tile" for="driving">
          <span class="radio-icon">
            <svg stroke="currentColor" xml:space="preserve" viewBox="0 0 324.018 324.017" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg" id="Capa_1" version="1.1" fill="none"><g stroke-width="0" id="SVGRepo_bgCarrier"></g><g stroke-linejoin="round" stroke-linecap="round" id="SVGRepo_tracerCarrier"></g><g id="SVGRepo_iconCarrier"> <g> <g> <path d="M317.833,197.111c3.346-11.148,2.455-20.541-2.65-27.945c-9.715-14.064-31.308-15.864-35.43-16.076l-8.077-4.352 l-0.528-0.217c-8.969-2.561-42.745-3.591-47.805-3.733c-7.979-3.936-14.607-7.62-20.475-10.879 c-20.536-11.413-34.107-18.958-72.959-18.958c-47.049,0-85.447,20.395-90.597,23.25c-2.812,0.212-5.297,0.404-7.646,0.59 l-6.455-8.733l7.34,0.774c2.91,0.306,4.267-1.243,3.031-3.459c-1.24-2.216-4.603-4.262-7.519-4.57l-23.951-2.524 c-2.91-0.305-4.267,1.243-3.026,3.459c1.24,2.216,4.603,4.262,7.519,4.57l3.679,0.386l8.166,11.05 c-13.823,1.315-13.823,2.139-13.823,4.371c0,18.331-2.343,22.556-2.832,23.369L0,164.443v19.019l2.248,2.89 c-0.088,2.775,0.823,5.323,2.674,7.431c5.981,6.804,19.713,7.001,21.256,7.001c4.634,0,14.211-2.366,20.78-4.153 c-0.456-0.781-0.927-1.553-1.3-2.392c-0.36-0.809-0.603-1.668-0.885-2.517c-0.811-2.485-1.362-5.096-1.362-7.845 c0-14.074,11.449-25.516,25.515-25.516s25.52,11.446,25.52,25.521c0,6.068-2.221,11.578-5.773,15.964 c-0.753,0.927-1.527,1.828-2.397,2.641c-1.022,0.958-2.089,1.859-3.254,2.641c29.332,0.109,112.164,0.514,168.708,1.771 c-0.828-0.823-1.533-1.771-2.237-2.703c-0.652-0.854-1.222-1.75-1.761-2.688c-2.164-3.744-3.5-8.025-3.5-12.655 c0-14.069,11.454-25.513,25.518-25.513c14.064,0,25.518,11.449,25.518,25.513c0,5.126-1.553,9.875-4.152,13.878 c-0.605,0.922-1.326,1.755-2.04,2.594c-0.782,0.922-1.616,1.781-2.527,2.584c5.209,0.155,9.699,0.232,13.546,0.232 c19.563,0,23.385-1.688,23.861-5.018C324.114,202.108,324.472,199.602,317.833,197.111z"></path> <path d="M52.17,195.175c3.638,5.379,9.794,8.922,16.756,8.922c0.228,0,0.44-0.062,0.663-0.073c2.576-0.083,5.043-0.61,7.291-1.574 c1.574-0.678,2.996-1.6,4.332-2.636c4.782-3.702,7.927-9.429,7.927-15.933c0-11.144-9.066-20.216-20.212-20.216 s-20.213,9.072-20.213,20.216c0,2.263,0.461,4.411,1.149,6.446c0.288,0.85,0.616,1.673,1.015,2.471 C51.279,193.606,51.667,194.434,52.17,195.175z"></path> <path d="M269.755,209.068c2.656,0,5.173-0.549,7.503-1.481c1.589-0.642,3.06-1.491,4.422-2.495 c1.035-0.767,1.988-1.616,2.863-2.559c3.34-3.604,5.432-8.389,5.432-13.681c0-11.144-9.071-20.21-20.215-20.21 s-20.216,9.066-20.216,20.21c0,4.878,1.812,9.3,4.702,12.801c0.818,0.989,1.719,1.89,2.708,2.713 c1.311,1.088,2.729,2.024,4.293,2.755C263.836,208.333,266.704,209.068,269.755,209.068z"></path> </g> </g> </g></svg>
          </span>
                    <span class="radio-label">На машине</span>
                </label>
            </div>
        </div>
    </div>
</div>

<div id="searchModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeSearchModal()">&times;</span>
        <div id="searchResults"></div>
    </div>
</div>
<script type="text/javascript">
    var status = "${status}";
</script>
<div class="container">
    <div class="row">
        <div class="col-md-9">
            <div id="map"></div>
        </div>
        <div class="col-md-2">
            <table class="table" id="markerTable">
                <thead>
                <tr>
                    <th scope="col">Маркер</th>
                    <th scope="col">Координаты</th>
                    <th scope="col">Действия</th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
</div>
<div class="btn-group btn-group-m-t" role="group">
    <button id="copyTravel" class="button2" <#if get == 'none'>style="display:inline;"<#else>style="display:none;"</#if>>Скопировать путешествие</button>&nbsp;&nbsp;
<button id="addMarkerButton" class="button" <#if status == 'admin'>style="display:inline;"<#else>style="display:none;"</#if>>Добавить маркер</button>&nbsp;&nbsp;
<button id="buildRouteButton" class="button" <#if get == 'none' || get == 'get'>style="display:inline;"<#else>style="display:none;"</#if>> Построить маршрут</button>&nbsp;&nbsp;
<button id="tryAddMarkerButton" class="button" <#if get == 'get' && status == 'user' >style="display:inline;"<#else>style="display:none;"</#if>>Предложить новый пункт</button>&nbsp;&nbsp;
<button id="saveTravelButton" class="button" <#if status == 'admin'>style="display:inline;"<#else>style="display:none;"</#if>>Сохранить путешествие</button>&nbsp;&nbsp;
<button id="addFriendToTravelButton" class="button" onclick="openSearchModal()" <#if status == 'admin'>style="display:inline;"<#else>style="display:none;"</#if>>Добавить друга в планирование</button>&nbsp;&nbsp;
<button id="leaveTravelButton" class="button3" <#if get == 'get' && status == 'user' >style="display:inline;"<#else>style="display:none;"</#if>>Покинуть Путешествие</button>&nbsp;&nbsp;
</div>
<script>
    let mapboxMarkers = [];
   var statusAccount = status;
   let selectedTransport = 'driving';
   document.querySelectorAll('.radio-input').forEach(radio => {
           radio.addEventListener('change', (event) => {
               selectedTransport = event.target.value;
           });
       });
   let markersArray =[];
   let travelNames = [];
   window.onload = function() {
      getSubTripCoordinates();
  };
  function addMarkerToTable(lng, lat, status) {
   const table = document.getElementById('markerTable').getElementsByTagName('tbody')[0];
   const newRow = table.insertRow();
   const cell1 = newRow.insertCell(0);
   const cell2 = newRow.insertCell(1);
   const cell3 = newRow.insertCell(2);
   const cell4 = newRow.insertCell(3);

   cell1.innerHTML = 'Маркер ' + markerCounter;
   cell2.innerHTML = lng + ', ' + lat;
   if (status === true  && statusAccount === 'admin') {
       cell3.innerHTML = '<span class="move-up">⬆️</span> <span class="move-down">⬇️</span> <span class="delete-row">❌</span>';
       cell3.querySelector('.move-up').addEventListener('click', () => moveMarkerUp(newRow));
       cell3.querySelector('.move-down').addEventListener('click', () => moveMarkerDown(newRow));
       cell3.querySelector('.delete-row').addEventListener('click', () => deleteMarker(newRow));
   }
   if (status === false && statusAccount === 'admin') {
       cell3.innerHTML = '<span class="move-up">⬆️</span> <span class="move-down">⬇️</span> <span class="delete-row">❌</span>';
       cell3.querySelector('.move-up').addEventListener('click', () => moveMarkerUp(newRow));
       cell3.querySelector('.move-down').addEventListener('click', () => moveMarkerDown(newRow));
       cell3.querySelector('.delete-row').addEventListener('click', () => deleteMarker(newRow));
       cell4.innerHTML = '<span class="confirm-marker">✅</span>';
       cell4.querySelector('.confirm-marker').addEventListener('click', () => confirmMarker(newRow));
   }
   if (status === false && statusAccount  === 'user')
   {
       cell3.innerHTML = '<span style="color: blue;">Ждет ответа</span>';
   }
   markerCounter++;
}
function confirmMarker(row) {
   console.log("CHECK");
   var index = row.rowIndex - 1;
   markersArray[index].status = true;
   const newMarker = new mapboxgl.Marker({ color: 'rgb(161, 255, 20)' })
      .setLngLat([markersArray[index].lng,markersArray[index].lat])
      .addTo(map);
   const confirmCell = row.cells[3]; // Получаем ячейку с кнопкой зеленой галочки
   confirmCell.innerHTML = '';
   saveTravel();
}

   function deleteMarker(row) {
   console.log("DELETE");
   const index = row.rowIndex - 1;
   if (index >= 0 && index < markersArray.length) {
       console.log(index);
       console.log(markersArray);
       markersArray.splice(index, 1);
       const markerToRemove = mapboxMarkers[index];
       if (markerToRemove) {
           markerToRemove.remove();
           mapboxMarkers.splice(index, 1);
       }
       markerCounter--;
       row.remove();
   }
   saveTravel();
   getRoute();
}
   function moveMarkerUp(row) {
   const previousRow = row.previousElementSibling;
   if (previousRow) {
       swapMarkersInArray(row.rowIndex - 1, row.rowIndex - 2);
       row.parentNode.insertBefore(row, previousRow);
   }
}

function moveMarkerDown(row) {
   const nextRow = row.nextElementSibling;
   if (nextRow) {
       swapMarkersInArray(row.rowIndex - 1, row.rowIndex);
       row.parentNode.insertBefore(nextRow, row);
   }
}

function swapMarkersInArray(index1, index2) {
   if (index1 >= 0 && index1 < markersArray.length && index2 >= 0 && index2 < markersArray.length) {
       [markersArray[index1], markersArray[index2]] = [markersArray[index2], markersArray[index1]];
       [mapboxMarkers[index1], mapboxMarkers[index2]] = [mapboxMarkers[index2],mapboxMarkers[index1]];
   }
   getRoute();
}
  function getSubTripCoordinates()
  {
       fetch('/getSubTripCoordinates')
       .then(response => response.json())
       .then(data => {
           markersArray = data.map(coordinateSubTrips => ({
               lng: coordinateSubTrips.lng,
               lat: coordinateSubTrips.lat,
               status: coordinateSubTrips.status
           }));
           if (data.length > 0) {
               const typeOfTransport = data[0].typeOfTransport;
               selectTransportRadio(typeOfTransport);
           }
           console.log("Markers ARRAY:" + markersArray);
           markersArray.forEach((marker, index) => {
           const color = marker.status ? 'rgb(161, 255, 20)' : 'rgb(0, 122, 255)';
              const newMarker = new mapboxgl.Marker({ color: color })
                   .setLngLat([marker.lng, marker.lat])
                   .addTo(map);
               mapboxMarkers.push(newMarker);
               addMarkerToTable(marker.lng, marker.lat,marker.status);
           });
           getRoute();
       })
       .catch(error => console.error('Ошибка получения координат: ', error));
  }
   function selectTransportRadio(selectedTransp) {
   selectedTransport = selectedTransp;
   const radios = document.querySelectorAll('input[name="engine"]');
   radios.forEach(radio => {
       if (radio.value === selectedTransp) {
           radio.checked = true;
       }
   });
}
  let markerCounter = 1;
  <#if longitudeValue?has_content && latitudeValue?has_content>
      var longitude = ${longitudeValue};
      var latitude = ${latitudeValue};
      <#else>
      var longitude = 27.5667; // Долгота Минска
      var latitude = 53.9; // Широта Минска
      </#if>

  mapboxgl.accessToken = 'pk.eyJ1IjoiZ3JpbWNoaWsiLCJhIjoiY2x1YmlyNmJ6MGZ4MTJwcGdkMW4wajFtdyJ9.DQjm2ZXzV6ggKJCKbNdlMw';
  const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v11',
      center: [longitude, latitude],
      zoom: 9
  });

  const geocoder = new MapboxGeocoder({
      accessToken: mapboxgl.accessToken,
      mapboxgl: mapboxgl,
      marker: false,
      placeholder: 'Search...',
  });
  map.addControl(geocoder);
  map.addControl(new mapboxgl.NavigationControl());
  map.addControl(new mapboxgl.GeolocateControl({
      positionOptions: {
          enableHighAccuracy: true
      },
      trackUserLocation: true
  }));

  let marker2;

  map.on('contextmenu', function(e) {
           var markerColor = (status === 'admin') ? 'rgb(161, 255, 20)' : 'rgb(0, 122, 255)';
           if (!marker2) {
               marker2 = new mapboxgl.Marker({ color: markerColor })
                   .setLngLat(e.lngLat)
                   .addTo(map);
           } else {
               marker2.setLngLat(e.lngLat);
           }
       });
  function saveTravel() {
  var inputElement = document.getElementById('text');
  var text = inputElement.value;
  travelNames.push(text);
  var csrfTokenValue = "${_csrf.token}";
  console.log(travelNames);
  fetch('/saveTravelAdminCheck', {
      method: 'POST',
      headers: {
          'Content-Type': 'application/json',
          'X-CSRF-TOKEN': csrfTokenValue
      },
      body: JSON.stringify
      ({
          names: travelNames,
          markers: markersArray,
          name: text,
          transportType: selectedTransport,
          type: 'new',
          status: status
      })
  })
  .then(response => {
      if (response.ok) {

      } else {

      }
  })
  .catch(error => console.error('Ошибка при отправке запроса:', error));
  }

  document.getElementById('saveTravelButton').addEventListener('click', saveTravel);
  document.getElementById('tryAddMarkerButton').addEventListener('click', function() {
  const newMarker = new mapboxgl.Marker({ color: 'rgb(0, 122, 255)' })
      .setLngLat(marker2.getLngLat())
      .addTo(map);
  mapboxMarkers.push(newMarker);
  const lngLat = marker2.getLngLat();
  const status = false;
  const markerData = {
       lng: lngLat.lng,
       lat: lngLat.lat,
       status: status
  };
  markersArray.push(markerData);
  console.log(markersArray);
  addMarkerToTable(lngLat.lng,lngLat.lat,false);
  console.log('Массив координат маркеров:', markersArray);
  saveTravel();
  });
  document.getElementById('addMarkerButton').addEventListener('click', function() {
  const newMarker = new mapboxgl.Marker({ color: 'rgb(161, 255, 20)' })
      .setLngLat(marker2.getLngLat())
      .addTo(map);
   const lngLat = marker2.getLngLat();
   mapboxMarkers.push(newMarker);
   const status = true;
   const markerData = {
       lng: lngLat.lng,
       lat: lngLat.lat,
       status: status
   };
  addMarkerToTable(lngLat.lng,lngLat.lat,true);
  markersArray.push(markerData);
  console.log(markersArray);
  console.log('Массив координат маркеров:', markersArray);
  saveTravel();
  });

   document.getElementById('copyTravel').addEventListener('click', function() {
   var buttons = document.querySelectorAll('.button');
   var button2 = document.querySelectorAll('.button2');
   buttons.forEach(function(button) {
       if (button.id === 'copyTravel') {
           button.classList.remove('button2');
           button.classList.add('button');
       } else {
           button.classList.remove('button');
           button.classList.add('button2');
       }
   });
   //saveTravel();
  });

  function getCoordinates() {
  let coordinates = "";
      if (markersArray.length < 2) {
          console.log('Для построения маршрута необходимо как минимум два маркера');
          return coordinates;
      }
      console.log(markersArray.length);
      if (markersArray.length >= 2) {
          for (let i = 0; i < markersArray.length; i++) {
              coordinates += markersArray[i].lng + ',' + markersArray[i].lat;
              if (i !== markersArray.length - 1) {
                  coordinates += ';';
              }
          }
      }
      return coordinates;
  }
  async function getRoute() {
   clearRoutes();
   console.log('Количество маркеров:', markersArray.length);
   console.log(markersArray);
   console.log(selectedTransport);
   if (markersArray.length < 2) {
       console.log('Для построения маршрута необходимо как минимум два маркера');
       return;
   }

   try {
       for (let i = 0; i < markersArray.length - 1; i++) {
           const query = await fetch(
               'https://api.mapbox.com/directions/v5/mapbox/'+selectedTransport+'/' +
               markersArray[i].lng + ',' + markersArray[i].lat + ';' +
               markersArray[i + 1].lng + ',' + markersArray[i + 1].lat +
               '?steps=true&geometries=geojson&access_token=' + mapboxgl.accessToken,
               { method: 'GET' }
           );
           const json = await query.json();
           const data = json.routes[0];
           const route = data.geometry.coordinates;
           const geojson = {
               type: 'Feature',
               properties: {},
               geometry: {
                   type: 'LineString',
                   coordinates: route
               }
           };
           if (map.getSource('route' + i)) {
               map.getSource('route' + i).setData(geojson);
           } else {
               map.addLayer({
                   id: 'route' + i,
                   type: 'line',
                   source: {
                       type: 'geojson',
                       data: geojson
                   },
                   layout: {
                       'line-join': 'round',
                       'line-cap': 'round'
                   },
                   paint: {
                       'line-color': '#3887be',
                       'line-width': 5,
                       'line-opacity': 0.75
                   }
               });
           }
       }
   } catch (error) {
       console.error('Ошибка при построении маршрута:', error);
       alert('Ошибка при построении маршрута. Невозможно построить маршрут!');
   }
}
function clearRoutes() {
   const layers = map.getStyle().layers;
   if (layers) {
       layers.forEach(layer => {
           if (layer.id.startsWith('route')) {
               map.removeLayer(layer.id);
               map.removeSource(layer.id);
           }
       });
   }
}
  function openSearchModal() {
      document.getElementById('searchModal').style.display = 'block';
      displayFriends();
  }
  function getFriends() {

  fetch('/get_friends')
      .then(response => {
          if (!response.ok) {
              throw new Error('Ошибка при получении списка друзей: ' + response.status);
          }
          return response.json();
      })
      .then(friends => {
      console.log(friends);
      })
      .catch(error => {
          console.error('Ошибка:', error);
      });
  }
  function closeSearchModal() {
      document.getElementById('searchModal').style.display = 'none';
  }
  function inviteToTravel(username)
  {
  var inputElement = document.getElementById('text');
  var name = inputElement.value;
  var csrfTokenValue = "${_csrf.token}";
      fetch('/invitetotravel', {
          method: 'POST',
          headers: {
              'Content-Type': 'application/json',
              'X-CSRF-TOKEN': csrfTokenValue
          },
          body: JSON.stringify({
              username: username,
              name: name,
          }),
      })
      .then(response => {
          if (response.ok) {
              alert('Отправлена заявка пользователю ' + username + ' для добавления в путешествие!');
          } else {
              alert('Не удалось отправить заявку пользователю ' + username + ' для добавления в путешествие.');
          }
      })
      .catch(error => console.error('Ошибка при отправке запроса:', error));
  }
  function displayFriends() {
  var resultsContainer = document.getElementById("searchResults");
  resultsContainer.innerHTML = "";
  fetch('/get_friends')
      .then(response => {
          if (!response.ok) {
              throw new Error('Ошибка при получении списка друзей: ' + response.status);
          }
          return response.json();
      })
      .then(friends => {
  friends.forEach(function(friend) {
      var friendElement = document.createElement("div");
      friendElement.classList.add("friend");
      var friendAvatarHTML = '<img class="avatar" src="data:image/jpeg;base64,' + friend.image + '" alt="' + friend.login + '">';
      friendElement.innerHTML = friendAvatarHTML;
      var friendName = document.createElement("span");
      friendName.textContent = friend.login;
      friendElement.appendChild(friendName);
      var inviteButton = document.createElement("button");
      inviteButton.textContent = "Пригласить в планирование";
      inviteButton.addEventListener("click", function() {
          inviteToTravel(friend.login);
      });
      friendElement.appendChild(inviteButton);
      resultsContainer.appendChild(friendElement);
      });
  })
      .catch(error => {
          console.error('Ошибка:', error);
      });
}

function reloadPage() {
   location.reload();
}
function leaveTravel()
{
var inputElement = document.getElementById('text');
  var text = inputElement.value;
  var csrfTokenValue = "${_csrf.token}";
  console.log(travelNames);
  fetch('/leave-travel', {
      method: 'POST',
      headers: {
          'Content-Type': 'application/json',
          'X-CSRF-TOKEN': csrfTokenValue
      },
      body: JSON.stringify
      ({
          name: text
      })
  })
  .then(response => {
      if (response.ok) {
        window.location.href = response.url;
      } else {

      }
  })
  .catch(error => console.error('Ошибка при отправке запроса:', error));
}
//setInterval(reloadPage, 10000);
document.getElementById('leaveTravelButton').addEventListener('click', leaveTravel);
document.getElementById('buildRouteButton').addEventListener('click', getRoute);
</script>
</body>
</html>
