node[:remove_packages].each do |pkg|
  package pkg do
    action :remove
  end
end
