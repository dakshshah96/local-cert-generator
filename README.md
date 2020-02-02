# HTTPS for `localhost`

A set of scripts to quickly generate a HTTPS certificate for your local development environment.

## How-to

1. Clone this repository and `cd` into it:

```
git clone https://github.com/dakshshah96/local-cert-generator.git
cd local-cert-generator
```
2. Run the script to create a root certificate:

```
sh createRootCA.sh
```

3. Add the root certificate we just generated to your list of trusted certificates. This step depends on the operating system you're running:

    - **windows - chrome**: Open Chrome's SSL-Dialog in the settings and import the root certificate (rootCA.pem) to your System keychain.

    ![Trust root certificate](https://raw.githubusercontent.com/sufius/local-cert-generator/master/images/add-rootCA.pem-to-chrome.png)

    - **macOS**: Open Keychain Access and import the root certificate to your System keychain. Then mark the certificate as trusted.

    ![Trust root certificate](https://cdn-images-1.medium.com/max/1600/1*NWwMb0yV9ClHDj87Kug9Ng.png)

    - **Linux**: Depending on your Linux distribution, you can use `trust`, `update-ca-certificates` or another command to mark the generated root certificate as trusted.

*Note*: You may need to restart your browser to load the newly trusted root certificate correctly.

4. Run the script to create a domain certificate for `localhost`:

```
sh createSelfSigned.sh
```

5. Move `server.key` and `server.crt` to an accessible location on your server and include them when starting it. In an Express app running on Node.js, you'd do something like this:

```js
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
```

6. Demo server available in the "example" directory

```
cd example
node server.js
```

Open in browser by addressing
```
https://localhost:8443
```

Or - after adding DNS-Entry to your etc/hosts-file - open in browser by addressing
```
https://dev.example.com:8443
```

Note: Don't forget to switch the port if you want to test the NON-Secure-URL
