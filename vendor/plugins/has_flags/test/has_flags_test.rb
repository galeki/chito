require 'test/unit'
require 'active_record'
require File.expand_path(File.dirname(__FILE__) + "/../lib/has_flags")

#
# darryl.west@RainCitySoftware.com
# 
# test all methods and combinations of 'has_flags'.
#
class HasFlagsTest < Test::Unit::TestCase
  
  class ModelA < ActiveRecord::Base
    has_flags [ :active, true, :deleted, 7 ]
    attr_accessor :bit_flags
  end
  
  class ModelB < ActiveRecord::Base
    has_flags [ :active, true, :banned, 4, :deleted, 8, :archived, 10 ]
    attr_accessor :bit_flags
  end
  
  def test_class_methods
    assert_respond_to ModelA, 'flags', 'should understand flags method'
    assert_respond_to ModelA, 'mask', 'should understand mask method'
    assert_respond_to ModelA, 'bitflag_column'
    assert_respond_to ModelA, 'find_by_flags'
    
    a = ModelA.flags
    b = ModelB.flags
    
    assert_equal 2, a.size
    assert a.include?( 'active' )
    assert a.include?( 'deleted' )
    assert !a.include?( 'banned' ) # verify no cross-blead between classes
    assert !a.include?( 'archived' )
    
    assert_equal 4, b.size
    assert b.include?( 'active' )
    assert b.include?( 'banned' )
    assert b.include?( 'deleted' )
    assert b.include?( 'archived' )
    
    assert_equal 1, a['active']
    assert_equal 1, ModelA.mask( :active )
    assert_equal 128, ModelA.mask( :deleted )
    assert_equal 129, ModelA.mask( :active, :deleted )
    assert_equal 1, ModelB.mask( :active )
    assert_equal 16, ModelB.mask( :banned )
    assert_equal 256, ModelB.mask( :deleted )
    assert_equal 1024, ModelB.mask( :archived )
    assert_equal 1297, ModelB.mask( :active, :banned, :deleted, :archived )
  end
  
  def test_instance_methods
    # TODO figure out how to get a connection to the database, create model a & b tables in setup, drop in teardown
  end
     
  def test_options
    # test the good ones
    ActiveRecord::Base.has_flags [ :active, true, :deleted, 7 ], [ :column => 'my_column_name' ]
    
    # test the bad...
    assert_raise RuntimeError do
      ActiveRecord::Base.has_flags [ :active, true, :deleted, 7 ], [ :bad_option => false ]
    end
  end
end
