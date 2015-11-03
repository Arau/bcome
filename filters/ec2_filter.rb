module ::Bcome::Filter
  class Ec2Filter < ::Bcome::Filter::Base

    def by_group_on_environment
      env_string = @environment.meta_data[:environment]
      return @resources.select{|resource|
        resource.groups.first == env_string
      } 
    end

  end
end
