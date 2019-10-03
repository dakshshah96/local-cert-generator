const app = require("express")();
const https = require("https");
const http = require("http");
const fs = require("fs");

console.log("Listening on 80 and 443");

//GET home route
app.get("/", (req, res) => {
  res.send("Hello World");
});

// we will pass our 'app' to 'https' server
https
  .createServer(
    {
      key: fs.readFileSync("./server.key"),
      cert: fs.readFileSync("./server.crt")
    },
    app
  )
  .listen(443);

http.createServer(app).listen(80);
