#!/usr/bin/env ruby
require 'hodor_services'

class HodorService < Hodor::HodorService::Service

  def talk(request, _unused_call)
    puts "Someone said: #{request.message}"
    Hodor::HodorResponse.new(message: "Hodor!")
  end
end


def main
  s = GRPC::RpcServer.new
  s.add_http2_port('0.0.0.0:50055', :this_port_is_insecure)
  s.handle(HodorService)
  s.run_till_terminated
end

main