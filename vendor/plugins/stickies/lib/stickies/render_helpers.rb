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
  module RenderHelpers

    ################################################################################
    # Render the stickie messages, returning the resulting HTML.  Options are:
    #
    # +:close+: Close link HTML, or nil to not include a close link
    # +:effect+: A visual effect to use when closing a message
    # +:effect_options+: Options passed to the visual effect
    # +:id+: The HTML ID to use on the outer div
    # +:key+: The session key to use to access the messages object
    # +:link_html+: HTML options passed to the link generation functions
    #
    # The defaults are pretty decent.
    def render_stickies (options={})
      configuration = {
        :close          => 'Close',
        :effect         => nil,
        :effect_options => {},
        :id             => 'stickies',
        :key            => :stickies,
        :link_html      => {},
      }.update(options)

      html = %Q(<div id="#{configuration[:id]}">)
      
      Stickies::Messages.fetch(session, configuration[:key]) do |messages|
        messages.each do |m|
          html << %Q(<div class="#{m.level}_stickie" id="stickie_#{m.options[:name]}">)
          html << render_stickie_close_area(m, configuration)
          html << m.message.to_s
          html << %Q(<br style="clear:all;"/>)
          html << %Q(</div>)
	  if configuration[:effect] && configuration[:close].nil?
	    html <<  javascript_tag(visual_effect(configuration[:effect], "stickie_#{m.options[:name]}", configuration[:effect_options]))
	  end
        end

        messages.flash
      end

      html << %Q(</div>)
      html
    end

    ################################################################################
    # Helper method to generate the close button for a message.
    def render_stickie_close_area (message, options)
      return "" unless options[:close]

      div_id = "stickie_#{message.options[:name]}"
      html = %Q(<div class="stickies_close_area">)

      undisplay = 
        if options[:effect]
          lambda {|p| p.visual_effect(options[:effect], div_id, options[:effect_options])}
        else
          lambda {|p| p.hide(div_id)}
        end

      if message.options[:flash]
        html << link_to_function(options[:close], nil, options[:link_html], &undisplay)
      else
        html << link_to_remote(options[:close], {
          :url => {:action => 'destroy_stickie', :id => message.options[:name]},
          :before => update_page(&undisplay),
        }, options[:link_html])
      end

      html << %Q(</div>)
      html
    end

  end
end
################################################################################
