if node[:platform_family].include?("rhel")
  include_recipe "apache_rhel7::apache_config"
else
  puts "########### PLEASE RUN THIS COOKBOOK ONLY ON RHEL 7 MACHINES ########## "
end
