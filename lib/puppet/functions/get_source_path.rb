# Made with chatgpt, returns puppet modules path
Puppet::Functions.create_function(:'get_source_path') do
    dispatch :get_source_path do
      param 'String', :module_name
      param 'String', :file_name
    end
  
    def get_source_path(module_name, file_name)
      "puppet:///modules/#{module_name}/#{file_name}"
    end
  end
  