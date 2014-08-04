#
# Cookbook Name:: mplayer
# Library:: helpers
#
# Copyright 2012-2014, Escape Studios
#

# MPLAYER module
module MPLAYER
  # helpers module
  module Helpers
    # Returns an array of package names that will install MPLAYER on a node.
    # Package names returned are determined by the platform running this recipe.
    def mplayer_packages
      value_for_platform(
        ['ubuntu'] => { 'default' => ['mplayer'] },
        'default' => ['mplayer']
      )
    end
  end
end

# Chef class
class Chef
  # Recipe class
  class Recipe
    include MPLAYER::Helpers
  end
end
