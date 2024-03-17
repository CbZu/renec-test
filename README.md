# About project - BE part of Funny Movies

Our project is a web application designed to facilitate the sharing and viewing of videos among users.
Key features of the application include:
  1. **Register/Login**: Users can login with existing account or register if email doesn't exist.
  2. **Video sharing**: Users can share favorite video to other user.
  3. **Video Viewing**: Users can browse through a collection of shared videos and watch them directly within the application.

# Prerequisites

  - **Rails version**: 7.0.8.1
  - **Ruby version**: ruby 3.1.3p185
  - **RubyGems version**: 3.5.6
  - **Rack version**: 2.2.8.1
  - **Database adapter**: postgresql

# Installation

1.  Clone repo `git clone https://github.com/CbZu/renec-test.git`
2.  Cd to the root folder `cd renec-test`
3.  Install dependencies: `bundle install`
4.  Set up the database: `rails db:create`, after that `rails db:migrate`
5.  Run tests: `rspec`
6.  Start the server: `rails server` and access applocation via port 3000 (Eg. `http://localhost:3000/videos-sharing`)

# Testing API:
Import postman collection `Renec test API.postman_collection.json` file.
APIs:
```
  /videos-sharing
    GET - Get all shared videos.
    POST - Share video via url, required header Authorization: your-token
   
  /login
    POST - If the entered email already exists, the application will proceed with the login process.
           However, if the entered email does not exist in the system, the application will automatically
           register a new account using the provided credentials.
```

# Testing Websocket in Development Environment: 
1. Connect to `ws://localhost:3000/cable`
2. Send message to subscribe channel: `{"command":"subscribe","identifier":"{\"channel\":\"VideosSharingChannel\"}"}`
3. Share a video and recieve message detail.


