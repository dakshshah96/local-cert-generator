const app = require("express")();
const https = require("https");
const http = require("http");
const fs = require("fs");

const port = process.env.PORT || 8080;
const port_ssl = process.env.PORT_SSL || 8443;

console.log(`Listening on ${port} and ${port_ssl}`);

//GET home route
app.get("/", (req, res) => {
  var fullUrl = req.protocol + '://' + req.get('host') + req.originalUrl;
  console.log(fullUrl);
  res.send("Hello World from: " + fullUrl);
});

// we will pass our 'app' to 'https' server
https
  .createServer(
    {
      key: fs.readFileSync("./certs/server.key"),
      cert: fs.readFileSync("./certs/server.crt")
    },
    app
  )
  .listen(port_ssl);

http.createServer(app).listen(port);
