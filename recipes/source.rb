#
# Cookbook Name:: chef-mplayer
# Recipe:: source
#
# Copyright 2012, Escape Studios
#

include_recipe "build-essential"
#include_recipe "subversion"

#install subversion
package "subversion" do
	action :install
end

#purge potentially existing package install
mplayer_packages.each do |pkg|
	package pkg do
		action :purge
	end
end

subversion "mplayer" do
	repository node[:mplayer][:svn_repository]
	revision node[:mplayer][:svn_revision]
	destination "#{Chef::Config[:file_cache_path]}/mplayer"
	action :sync
	notifies :run, "bash[compile_mplayer]"
end

#Write the flags used to compile the application to disk. If the flags
#do not match those that are in the compiled_flags attribute - we recompile
template "#{Chef::Config[:file_cache_path]}/mplayer-compiled_with_flags" do
	source "compiled_with_flags.erb"
	owner "root"
	group "root"
	mode 0600
	variables(
		:compile_flags => node[:mplayer][:compile_flags]
	)
	notifies :run, "bash[compile_mplayer]"
end

bash "compile_mplayer" do
	cwd "#{Chef::Config[:file_cache_path]}/mplayer"
	code <<-EOH
		./configure --prefix=#{node[:mplayer][:prefix]} #{node[:mplayer][:compile_flags].join(' ')}
		make clean && make && make install
	EOH
	creates "#{node[:mplayer][:prefix]}/bin/mplayer"
	notifies :run, "bash[copy_midentify]"
end

#copy midentify.sh to a location within the executable path
execute "copy_midentify" do
	command "cp #{Chef::Config[:file_cache_path]}/mplayer/TOOLS/midentify.sh /usr/local/bin/"
	action :nothing
end