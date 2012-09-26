node[:bootstrap][:sysctls].each do |sysctl|
  bootstrap_sysctl sysctl[:name] do
    directives sysctl[:directives]
    action sysctl[:action]
  end
end
