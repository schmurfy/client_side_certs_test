This is just basic test project for using client side certificates with ruby, I figured it may be useful to someone else.

# How to get started:

- start by installing required gems
```
$ bundle
```

- then create your self signed server Certificate
```
$ ./create_server_cert.sh
```

- one or more client certificates (you will need to enter a password and remember it !)
```
$ ruby create_cert.rb user1
$ ruby create_cert.rb user2
```

- now you just need to add the certificate to your browser with the password entered above (the p12 file), and start the server:
```
$ foreman start
```

You should now be able to connect to https://127.0.0.1:8443/ to access the web server which will greet you and display the username linked to the certificate you sent.
