module ::Bcome::FogHelper

  def credentials_key
    network_lookup[:credentials_key]
  end

  def fog_client
    @fog_client ||= get_fog_client
  end

  def unfiltered_servers
    @unfiltered_servers ||= fog_client.servers.all(network_lookup[:ec2_server_lookup_filters])
  end

  def ec2_tags
    network_lookup[:ec2_tag_filter]
  end

  def servers
    all = unfiltered_servers
    filtered_by_tags = ec2_tags ? filter_by_tags(all) : all
    
    custom_filter_method = @meta_data[:network_lookup][:custom_post_process_filter_method]

    if custom_filter_method
      filter = ::Bcome::Filter::Ec2Filter.new(filtered_by_tags, self)
      raise "Custome filter method #{custom_filter_method} is missing. Make sure you've added it".failure unless filter.respond_to?(custom_filter_method.to_sym)
      return filter.send(custom_filter_method.to_sym) 
    else
      return filtered_by_tags
    end
  end

  def filter_by_tags(instances)
    return instances.select{|instance| instance_matches_tags?(instance)}
  end

  def instance_matches_tags?(instance)
    tags = instance.tags
    return ec2_tags.select{|key, value| tags[key.to_s] == value }.size == ec2_tags.keys.size
  end

  private
 
  def get_fog_client
    ::Fog.credential = credentials_key
    client = ::Fog::Compute.new(
      :provider => "AWS",
      :region => network_lookup[:provisioning_region]
    )
    return client
  end

end
