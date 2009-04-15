################################################################################
#
# Copyright (C) 2007 pmade inc. (Peter Jones pjones@pmade.com)
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
################################################################################
module Stickies
  module ControllerActions

    ################################################################################
    # Add some magic to ActionController::Base (and all controllers)
    def self.included (base)
      # The call_filter method was renamed to call_filters after version 1.2.3
      # was released, but the change is on the 1.2 stable branch.  This code
      # will insert a backwards compatibly layer for us
      if !base.public_instance_methods.include?("call_filter")
        class_eval("def call_filter (*a, &b) call_filters(*a, &b) end")
      end

      base.class_eval do
        alias_method_chain(:call_filter, :stickie_check)
      end
    end

    ################################################################################
    # Since the destroy_stickie action only changes the session object, don't
    # use any filters when calling it.  This might be a bit like smashing
    # a bug with a sledgehammer, but it's pretty effective.
    #
    # Without this magic, filters will interfere with this very simple action,
    # and users would have to use:
    #
    #  before_filter(x, :exclude => :destroy_stickie)
    #
    # Each time a filter is used.  So, I decided that this is a much better
    # option.  Let me know if you have a better idea.
    def call_filter_with_stickie_check (chain, index)
      if action_name == 'destroy_stickie'
        action_methods << 'destroy_stickie'
        perform_action_without_filters
      else
        call_filter_without_stickie_check(chain, index)
      end
    end

    ################################################################################
    # Remove a stickie message from the user's session
    def destroy_stickie
      Stickies::Messages.fetch(session) {|m| m.destroy(params[:id])}
      render(:nothing => true)
    end

  end
end
################################################################################
