#A small application server that interfaces with nginx.

##How to get it to work
1. Download nginx using [brew](http://brew.sh/)
2. Open/create the /tmp/nginx.conf file
3. Forward requests to the file you created in your tmp folder, so something like "/tmp/sockets.sock"
4. Visit http://localhost:2048/ and have fun.
