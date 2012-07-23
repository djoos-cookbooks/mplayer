#
# Cookbook Name:: mplayer
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

#install yasm
package "yasm" do
	action :install
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
		./configure #{node[:mplayer][:compile_flags].join(' ')}
		make clean && make && make install
	EOH
	notifies :run, "bash[copy_midentify]"
end

bash "copy_midentify" do
	cwd "#{Chef::Config[:file_cache_path]}/mplayer/TOOLS"
	code <<-EOH
		cp midentify.sh /usr/local/bin
	EOH
end