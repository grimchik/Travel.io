<!DOCTYPE html>
<html lang="en">
<head>
    <style>
        body {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
        }

        #image-container {
            text-align: center;
            margin-bottom: 20px;
        }

        #circular-image {
            border-radius: 50%;
            width: 100px;
            height: 100px;
        }
        .user-container {
    display: flex;
    align-items: center;
    margin-bottom: 10px;
}

.avatar-container {
    margin-right: 10px;
}

.avatar {
    width: 50px;
    height: 50px;
    border-radius: 50%;
}

.username-container p {
    margin: 0;
    font-size: 16px;
}

.button-container {
    margin-left: auto;
}

        .Btn {
            position: relative;
            display: flex;
            align-items: center;
            justify-content: flex-start;
            width: 100px;
            height: 40px;
            border: none;
            padding: 0px 20px;
            background-color: rgb(168, 38, 255);
            color: white;
            font-weight: 500;
            cursor: pointer;
            border-radius: 10px;
            box-shadow: 5px 5px 0px rgb(140, 32, 212);
            transition-duration: .3s;
            margin-bottom: 20px;
        }

        .svg {
            width: 13px;
            position: absolute;
            right: 0;
            margin-right: 20px;
            fill: white;
            transition-duration: .3s;
        }

        .Btn:hover {
            color: transparent;
        }

        .Btn:hover svg {
            right: 43%;
            margin: 0;
            padding: 0;
            border: none;
            transition-duration: .3s;
        }

        .Btn:active {
            transform: translate(3px , 3px);
            transition-duration: .3s;
            box-shadow: 2px 2px 0px rgb(140, 32, 212);
        }
    </style>
</head>
<body>
<div id="image-container">
    <img id="circular-image" src="data:image/png;base64,${base64Image}" alt="avatar">
</div>
<div id="friends-list"></div>
</body>
<script>
    window.onload = function() {
    var userLogin = getUserLogin();
    loadFriendsList(userLogin);
};

    function getUserLogin() {
    var url = window.location.href;
    var username = "";
    var parts = url.split("/");
    for (var i = 0; i < parts.length; i++) {
        if (parts[i] === "profile") {
            username = parts[i + 1];
            break;
        }
    }
    return username;
    }
    function loadFriendsList(userLogin) {
        fetch('/get_user_friends?userLogin=' + userLogin)
            .then(response => {
                if (response.ok) {
                    return response.json();
                } else {
                    throw new Error('Failed to fetch friends list');
                }
            })
            .then(data => {
                displayFriends(data);
            })
            .catch(error => {
                console.error('Error loading friends list:', error);
                alert('Failed to load friends list');
            });
    }
    function displayFriends(friends) {
        var friendsListContainer = document.getElementById('friends-list');
        friends.forEach(function(friend) {
            var friendElement = document.createElement('div');
            friendElement.classList.add('friend');
            friendElement.innerHTML = '<div class="avatar-container">' +
                '<img class="avatar" src="data:image/jpeg;base64,' + friend.image + '" alt="Avatar">' +
                '</div>' +
                '<div class="username-container">' +
                '<p><a href="/profile/' + friend.login + '">' + friend.login + '</a></p>' +
                '</div>';
            friendsListContainer.appendChild(friendElement);
        });
    }
</script>
</html>
