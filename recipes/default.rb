#
# Cookbook Name:: chef-mplayer
# Recipe:: default
#
# Copyright 2012, Escape Studios
#

case node[:mplayer][:install_method]
	when :source
		include_recipe "chef-mplayer::source"
	when :package
		include_recipe "chef-mplayer::package"
end