#
# Cookbook Name:: mplayer
# Recipe:: package
#
# Copyright 2012-2014, Escape Studios
#

mplayer_packages.each do |pkg|
  package pkg do
    action :upgrade
  end
end
