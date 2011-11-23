unless `grep vagrant /etc/passwd`.empty?
  add_to_groups "vagrant" do
    groups %w[admin]
  end
end
