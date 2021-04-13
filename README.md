# create_gdocs_microservice

A microservice for creating google docs as the authenticated user.

[Notes](https://docs.google.com/document/d/1n-9UxWj9THxh2jd6sxAvjdTLEZcvgpTz2M_EqI7lWB0/edit?usp=sharing)

## Description 

Sending a HTTP GET request to ... with a json payload of ... results in ... 


## Simulate a hosted environment with Docker

```shell
$ docker build -t hello .
...

$ docker run -it -p 8080:8080 --name app hello
Listening on :8080
```

From another terminal:

```shell
curl http://localhost:8080
Hello, World!
```

## Testing 

### Running tests

```shell
$ dart test
00:02 +1: All tests passed!
```

## Prototyping 

### Run the function locally

```shell
$ dart run bin/server.dart
Listening on :8080
```

### Interact with the locally running function

From another terminal, send a JSON request:

```shell
$ curl -X POST -H "content-type: application/json" -d '{ "name": "World" }' -i localhost:8080
HTTP/1.1 200 OK
date: Sat, 19 Dec 2020 02:17:42 GMT
content-length: 37
x-frame-options: SAMEORIGIN
content-type: application/json
x-xss-protection: 1; mode=block
x-content-type-options: nosniff
server: dart:io with Shelf

{"salutation":"Hello","name":"World"}
```

Tools like [curl] (and [postman]) are good for sending HTTP requests. The
options used in this example are:

- `-X POST` - send an HTTP POST request
- `-H "content-type: application/json"` - set an HTTP header to indicate that
  the body is a JSON document
- `-d '{ "name": "World" }'` - set the request body to a JSON document
- `-i` - show the response headers (to confirm the response body content type is
  also a JSON document)

The last line, separated by a blank line, prints the response body.
