require "socket"

class Connection

  attr_accessor :path

  def initialize(path)
    @path = path
    File.unlink if File.exists?(@path)
  end

  def server
    @server ||= UNIXServer.new(@path)
  end

  def on_request
    socket = server.accept
    yield(socket)
    socket.close
  end
end

class AppServer
  attr_reader :connection
  attr_reader :view

  def initialize(connection, view)
    @connection = connection
    @view = view
  end

  def run
    while true
      connection.on_request do |socket|
        while (line = socket.readline) != "\r\n"
          puts line
        end
        socket.write(view.render)
      end
    end
  end
end

class TimeView

  def render
<<-EOF
%[HTTP]/1.1 200 OK

Content-Length: 36
Content-type: text/plain

Wooo we are using sockets for cool stuff. ^__^

EOF
  end
end

AppServer.new(Connection.new("/tmp/sockmain.sock"), TimeView.new).run
