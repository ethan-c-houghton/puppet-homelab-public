# Converts a string to a deterministic port number within a specified range
Puppet::Functions.create_function(:'string_to_port') do
    dispatch :string_to_port do
      param 'String', :input_string
      optional_param 'Integer', :start_port
      optional_param 'Integer', :end_port
    end
  
    def string_to_port(input_string, start_port = 1024, end_port = 65535)
      hash_val = 0
      
      input_string.each_char.with_index do |char, i|
        # Use position, character value, and prime multipliers
        hash_val = (hash_val * 37 + char.ord * (i + 1)) % (2**31 - 1)
      end
      
      range_size = end_port - start_port + 1
      (hash_val % range_size) + start_port
    end
  end