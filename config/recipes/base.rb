def template_sudo(from, to)
  erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
  put_sudo ERB.new(erb).result(binding), to
end

def put_sudo(data, to)
  filename = File.basename(to)
  to_directory = File.dirname(to)
  put data, "/tmp/#{filename}"
  run "#{sudo} mv /tmp/#{filename} #{to_directory}"
end