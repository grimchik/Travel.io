<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WELCOME</title>
    <style>
        .login-box {
            position: absolute;
            top: 50%;
            left: 50%;
            width: 400px;
            padding: 40px;
            margin: 20px auto;
            transform: translate(-50%, -55%);
            background: rgba(0,0,0,.9);
            box-sizing: border-box;
            box-shadow: 0 15px 25px rgba(0,0,0,.6);
            border-radius: 10px;
            text-align: center; /* Добавлено выравнивание по центру */
        }

        .login-box .custom-button {
            position: relative;
            display: inline-block;
            padding: 10px 20px;
            font-weight: bold;
            color: #fff;
            font-size: 16px;
            text-decoration: none;
            text-transform: uppercase;
            overflow: hidden;
            transition: .5s;
            margin-top: 40px;
            letter-spacing: 3px;
            border: none;
            background: transparent;
            cursor: pointer;
            margin-right: 10px; /* Добавлено отступ между кнопками */
        }

        .login-box .custom-button:hover {
            background: #fff;
            color: #272727;
            border-radius: 5px;
        }

        .login-box .custom-button span {
            position: absolute;
            display: block;
        }

        .login-box .custom-button span:nth-child(1) {
            top: 0;
            left: -100%;
            width: 100%;
            height: 2px;
            background: linear-gradient(90deg, transparent, #fff);
            animation: btn-anim1 1.5s linear infinite;
        }

        @keyframes btn-anim1 {
            0% {
                left: -100%;
            }

            50%,100% {
                left: 100%;
            }
        }
    </style>
</head>
<body>
<div class="login-box">
    <form action="/login" method="get">
        <button class="custom-button" type="submit">
            <span></span>
            <span></span>
            <span></span>
            <span></span>
            Log In
        </button>
    </form>
    <form action="/registration" method="get">
        <button class="custom-button" type="submit">
            <span></span>
            <span></span>
            <span></span>
            <span></span>
            Sign Up
        </button>
    </form>
</div>
</body>
</html>
<!--
<!DOCTYPE html>
<!DOCTYPE html>
<style>
    .login-box {
     position: absolute;
     top: 50%;
     left: 50%;
     width: 400px;
     padding: 40px;
     margin: 20px auto;
     transform: translate(-50%, -55%);
     background: rgba(0,0,0,.9);
     box-sizing: border-box;
     box-shadow: 0 15px 25px rgba(0,0,0,.6);
     border-radius: 10px;
   }

   .login-box p:first-child {
     margin: 0 0 30px;
     padding: 0;
     color: #fff;
     text-align: center;
     font-size: 1.5rem;
     font-weight: bold;
     letter-spacing: 1px;
   }

   .login-box .user-box {
     position: relative;
   }

   .login-box .user-box input {
     width: 100%;
     padding: 10px 0;
     font-size: 16px;
     color: #fff;
     margin-bottom: 30px;
     border: none;
     border-bottom: 1px solid #fff;
     outline: none;
     background: transparent;
   }

   .login-box .user-box label {
     position: absolute;
     top: 0;
     left: 0;
     padding: 10px 0;
     font-size: 16px;
     color: #fff;
     pointer-events: none;
     transition: .5s;
   }

   .login-box .user-box input:focus ~ label,
   .login-box .user-box input:valid ~ label {
     top: -20px;
     left: 0;
     color: #fff;
     font-size: 12px;
   }

   .login-box form a {
     position: relative;
     display: inline-block;
     padding: 10px 20px;
     font-weight: bold;
     color: #fff;
     font-size: 16px;
     text-decoration: none;
     text-transform: uppercase;
     overflow: hidden;
     transition: .5s;
     margin-top: 40px;
     letter-spacing: 3px
   }

   .login-box a:hover {
     background: #fff;
     color: #272727;
     border-radius: 5px;
   }

   .login-box a span {
     position: absolute;
     display: block;
   }

   .login-box a span:nth-child(1) {
     top: 0;
     left: -100%;
     width: 100%;
     height: 2px;
     background: linear-gradient(90deg, transparent, #fff);
     animation: btn-anim1 1.5s linear infinite;
   }

   @keyframes btn-anim1 {
     0% {
       left: -100%;
     }

     50%,100% {
       left: 100%;
     }
   }

   .login-box a span:nth-child(2) {
     top: -100%;
     right: 0;
     width: 2px;
     height: 100%;
     background: linear-gradient(180deg, transparent, #fff);
     animation: btn-anim2 1.5s linear infinite;
     animation-delay: .375s
   }

   @keyframes btn-anim2 {
     0% {
       top: -100%;
     }

     50%,100% {
       top: 100%;
     }
   }

   .login-box a span:nth-child(3) {
     bottom: 0;
     right: -100%;
     width: 100%;
     height: 2px;
     background: linear-gradient(270deg, transparent, #fff);
     animation: btn-anim3 1.5s linear infinite;
     animation-delay: .75s
   }

   @keyframes btn-anim3 {
     0% {
       right: -100%;
     }

     50%,100% {
       right: 100%;
     }
   }

   .login-box a span:nth-child(4) {
     bottom: -100%;
     left: 0;
     width: 2px;
     height: 100%;
     background: linear-gradient(360deg, transparent, #fff);
     animation: btn-anim4 1.5s linear infinite;
     animation-delay: 1.125s
   }

   @keyframes btn-anim4 {
     0% {
       bottom: -100%;
     }

     50%,100% {
       bottom: 100%;
     }
   }

   .login-box p:last-child {
     color: #aaa;
     font-size: 14px;
   }

   .login-box a.a2 {
     color: #fff;
     text-decoration: none;
   }

   .login-box a.a2:hover {
     background: transparent;
     color: #aaa;
     border-radius: 5px;
   }
    .custom-button {
    position: relative;
    display: inline-block;
    padding: 10px 20px;
    font-weight: bold;
    color: #fff;
    font-size: 16px;
    text-decoration: none;
    text-transform: uppercase;
    overflow: hidden;
    transition: .5s;
    margin-top: 40px;
    letter-spacing: 3px;
    border: none;
    background: transparent;
    cursor: pointer;
}

.custom-button:hover {
    background: #fff;
    color: #272727;
    border-radius: 5px;
}

.custom-button span {
    position: absolute;
    display: block;
}

.custom-button span:nth-child(1) {
    top: 0;
    left: -100%;
    width: 100%;
    height: 2px;
    background: linear-gradient(90deg, transparent, #fff);
    animation: btn-anim1 1.5s linear infinite;
}
</style>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WELCOME</title>
</head>
<div class="login-box">
<form action="/login" method="post">
    <button class="custom-button" type="submit">
    <span></span>
    <span></span>
    <span></span>
    <span></span>
    Log In
    </button>
</form>
<form action="/registration" method="post">
    <button class="custom-button" type="submit">
        <span></span>
        <span></span>
        <span></span>
        <span></span>
        Sign Up
    </button>
</form>
</div>
</html>
-->
