<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VOYAGE</title>
</head>
<body>
<h2>Login</h2>
<form action="/submit-login" method="post">
    <label for="username">Username:</label><br>
    <input type="text" id="username" name="username"><br>
    <label for="password">Password:</label><br>
    <input type="password" id="password" name="password"><br><br>
    <input type="submit" value="Login">
</form>
<form action="/submit-registration" method="post">
    <input type="submit" value="Registration">
</form>
</body>
</html>
