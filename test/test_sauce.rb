require "test/unit"
require "date"

require "sauce"

class TestSauce < Test::Unit::TestCase
  def setup
    @test_ansi = File.dirname(__FILE__) + '/sph_love.ans'
    @sauce = Sauce.new @test_ansi
  end
  def teardown
  end
  
  def test_basic
    assert_equal '00'            , @sauce.version
    assert_equal 'ansilove menu' , @sauce.title
    assert_equal 'sephiroth'     , @sauce.author
    assert_equal ''              , @sauce.group
    
    assert_equal 0       , @sauce.comments
    assert_equal 6396    , @sauce.filesize
    assert_equal ''      , @sauce.filler
    
    assert_equal 1       , @sauce.datatype_id
    assert_equal 1       , @sauce.filetype_id
    assert_equal 0       , @sauce.flags_id
    assert_equal 'SAUCE' , @sauce.sauce_id
    
    assert_equal 80      , @sauce.tinfo1
    assert_equal 25      , @sauce.tinfo2
    assert_equal 0       , @sauce.tinfo3
    assert_equal 0       , @sauce.tinfo4
  end
  
  def test_date
    assert_equal '20051102', @sauce.date_raw
    assert_equal Date.parse('2005-11-02'), @sauce.date
  end
  
end
