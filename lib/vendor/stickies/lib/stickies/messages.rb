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
  ################################################################################
  # The Stickies::Messages class holds the actual messages that need to be
  # displayed to the user
  class Messages

    ################################################################################
    # Add an error message to the current collection of messages.  Storage
    # should be a hash where all the messages can be stored, such as the Rails
    # session object. See Stickies::Messages#add for more details.
    def self.error (storage, message, options={})
      self.add(storage, :error, message, options)
    end
    
    ################################################################################
    # Add a warning message to the current collection of messages.  Storage
    # should be a hash where all the messages can be stored, such as the Rails
    # session object. See Stickies::Messages#add for more details.
    def self.warning (storage, message, options={})
      self.add(storage, :warning, message, options)
    end

    ################################################################################
    # Add a notice message to the current collection of messages.  Storage
    # should be a hash where all the messages can be stored, such as the Rails
    # session object. See Stickies::Messages#add for more details.
    def self.notice (storage, message, options={})
      self.add(storage, :notice, message, options)
    end

    ################################################################################
    # Add a debug message to the current collection of messages.  Debug
    # messages are ignored unless RAILS_ENV is development. Storage should be
    # a hash where all the messages can be stored, such as the Rails session
    # object. See Stickies::Messages#add for more details.
    def self.debug (storage, message, options={})
      if RAILS_ENV == 'development'
        self.add(storage, :debug, message, options)
      end
    end

    ################################################################################
    # Add a specific type of message to the current collection of messages.
    # Storage should be a hash where all the messages can be stored, such as
    # the Rails session object. See Stickies::Messages#add for more details.
    def self.add (storage, level, message, options={})
      fetch(storage) {|m| m.add(level, message, options)}
    end

    ################################################################################
    # Check to see if the user has seen the given message.  See
    # Stickies::Messages#seen? for more details.
    def self.seen? (storage, name, options={})
      m = fetch(storage)
      m.seen?(name, options)
    end

    ################################################################################
    # Get the message collection from the storage hash, or create a new one.
    def self.fetch (storage, key=:stickies)
      m = storage[key] || self.new

      if block_given?
        yield(m)
        store(m, storage, key)
      end

      m
    end

    ################################################################################
    # Place the message collection in the storage hash.
    def self.store (messages, storage, key=:stickies)
      storage[key] = messages
    end

    ################################################################################
    # Prepare a new Stickies::Messages object
    def initialize
      @messages = {}
      @by_id    = {}
      @seen_on  = {}
    end

    ################################################################################
    # Add a message to this collection of messages. The level can be any
    # symbol, but only :error, :warning, and :notice are supported by the
    # included view rendering code.
    #
    # The options hash can optionally include:
    #
    # +:flash+: Remove this message from the collection after it's displayed
    # +:remember+: Remember the last time the user saw this message
    # +:name+: An optional unique name for this message
    # +:seen_in+: Only add if seen?(m, :in => :seen_in) returns false
    # +:seen_since+: Only add if seen?(m, :since => :seen_since) returns false
    #
    # By default, the :flash option is set to true.  This means that after the
    # message has been displayed by the view layer, it will be removed from
    # the collection so it won't be seen again.
    #
    # If you have a message that you want to keep displaying until the user
    # dismisses it, set :flash to false.  
    #
    # Also, if you have a message that you want to prevent from being added
    # more than once, set the :name option to a unique name for the message.
    #
    # If you set the :remember option to true, the :flash option will be set
    # to false automatically.  In this case you can then check to see when was
    # the last time the user saw a specific message.  See the
    # Stickies::Messages#seen? method for more information.
    #
    # To prevent adding a message that the user might have already seen in the
    # past, you can use the Stickies::Messages#seen? method before calling
    # add, or pass one of the seen_* option to add.  Requires that :remember
    # is set to true.
    def add (level, message, options={})
      configuration = {
        :flash      => true,
        :name       => nil,
        :remember   => false,
        :seen_in    => nil,
        :seen_since => nil,
      }.update(options)

      # We'll need a valid name for a few different operations
      configuration[:name] = message.object_id if configuration[:name].nil?

      # force message names to be strings
      configuration[:name] = configuration[:name].to_s

      # Force :flash to false if :remember is true
      configuration[:flash] = false if configuration[:remember]
      
      # don't add if one of the see options was given, and it was already seen
      return if configuration[:seen_in] and seen?(configuration[:name], :in => configuration[:seen_in])
      return if configuration[:seen_since] and seen?(configuration[:name], :since => configuration[:seen_since])

      # If it already exists, delete the old one first
      destroy(configuration[:name], false)

      # Wow, we made it this far, I guess we better add the message
      message = OpenStruct.new({
        :name    => configuration[:name],
        :level   => level,
        :message => message, 
        :options => configuration,
      })

      (@messages[level] ||= [])  << message
      @by_id[configuration[:name]] = [message, level]
    end

    ################################################################################
    # Iterate over all the messages in the given order.  If you are using
    # custom message levels, you'll need to add them to the order array.
    def each (order=[:debug, :error, :warning, :notice], &block)
      order.each {|o| m = @messages[o] and m.each(&block)}
    end

    ################################################################################
    # Remove a message from the message collection based on its unique name.
    def destroy (name, update_seen_on=true)
      if where = exist?(name)
        @messages[where.last].delete(where.first)
        @by_id.delete(where.first.name)
        @seen_on[where.first.name] = Time.now.to_i if update_seen_on and where.first.options[:remember]
      end
    end

    ################################################################################
    # Remove all messages that have their :flash setting set to true.
    def flash 
      @messages.values.each {|v| v.delete_if {|m| m.options[:flash]}}
      @by_id.delete_if {|k, v| v.first.options[:flash]}
    end

    ################################################################################
    # Returns true if there is a message with the given unique name in the
    # message collection.
    def exist? (name)
      @by_id[name.to_s]
    end

    ################################################################################
    # Check to see if the user has seen a specific message within a given time
    # frame. Requires that the message was added with the :remember flag set
    # to true, and the :flash flag set to false.
    #
    # Examples:
    #
    # Has the user seen the browser warning message in the last 24 hours?
    #
    #  unless messages.seen?(:browser_warning, :in => 24.hours)
    #    messages.add(:warning, "Your browser sucks", :remember => true, :flash => false)
    #  end
    #
    # Has the user seen the most recent system message?
    #
    #  unless messages.seen?(:system_message, :since => system_message.updated_on)
    #    messages.add(:notice, "Hello", :remember => true, :flash => false)
    #  end
    def seen? (name, options={})
      configuration = {
        :in    => 24.hours,
        :since => nil,
      }.update(options)

      s_name = name.to_s
      return false if (seen = @seen_on[s_name]).nil?

      if configuration[:since].nil?
        configuration[:since] = Time.now - configuration[:in]
      end

      return seen >= configuration[:since].to_i
    end

  end
end
################################################################################
