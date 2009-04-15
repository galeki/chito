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
  module AccessHelpers

    ################################################################################
    # Add an error message.  See Stickies::Messages#add for full details.
    def error_stickie (message, options={})
      Stickies::Messages.error(session, message, options)
    end

    ################################################################################
    # Add a warning message.  See Stickies::Messages#add for full details.
    def warning_stickie (message, options={})
      Stickies::Messages.warning(session, message, options)
    end

    ################################################################################
    # Add a notice message.  See Stickies::Messages#add for full details.
    def notice_stickie (message, options={})
      Stickies::Messages.notice(session, message, options)
    end

    ################################################################################
    # Add a debug message.  See Stickies::Messages#add for full details.
    def debug_stickie (message, options={})
      Stickies::Messages.debug(session, message, options)
    end

    ################################################################################
    # Check to see if a message has been seen by the user.  See
    # Stickies::Messages#seen? for full details.
    def stickie_seen? (name, options={})
      Stickies::Messages.seen?(session, name, options)
    end
    
  end
end
################################################################################
