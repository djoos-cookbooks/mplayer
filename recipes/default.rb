#
# Cookbook Name:: mplayer
# Recipe:: default
#
# Copyright 2012-2014, Escape Studios
#

case node[:mplayer][:install_method]
when :source
  include_recipe 'mplayer::source'
when :package
  include_recipe 'mplayer::package'
end
