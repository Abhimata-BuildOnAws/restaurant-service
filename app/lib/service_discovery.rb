class ServiceDiscovery
  @client = Aws::ServiceDiscovery::Client.new(
    region: ENV['AWS_REGION'],
    access_key_id: ENV['AWS_ACCESS_KEY'],
    secret_access_key: ENV['AWS_SECRET_KEY']
  )

  def self.list_services
    @client.list_services
  end

  def self.get_service(service_id)
    @client.get_service({
      id: service_id
    })
  end

  def self.list_instances(service_id)
    @client.list_instances({
      service_id: service_id
    })
  end

  def self.order_service_ip
    resp = @client.list_instances({
      service_id: ENV['ORDER_SERVICE_ID']
    })
    resp.instances[0].attributes["AWS_INSTANCE_IPV4"]
  end
end