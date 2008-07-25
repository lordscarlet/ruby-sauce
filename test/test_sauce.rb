require "test/unit"
require "date"

require "sauce"

class TestSauce < Test::Unit::TestCase
  def setup
    @test_ansi = File.dirname(__FILE__) + '/sph_love.ans'
  end
  def teardown
  end
  
  def test_basic
    s = Sauce.new @test_ansi
    
    assert_equal 'sephiroth'     , s.author
    assert_equal '20051102'      , s.group
    assert_equal 'ansilove menu' , s.title
    assert_equal '00'            , s.version
    # assert_equal Date.parse('06/03/96',true), s.date
    
    assert_equal 0, s.comments
    assert_equal 1, s.datatype_id
    assert_equal '', s.filesize
    assert_equal '', s.filetype_id
    assert_equal '', s.filler
    assert_equal '', s.flags_id
    assert_equal '', s.sauce_id
    assert_equal '', s.tinfo1
    assert_equal '', s.tinfo2
    assert_equal '', s.tinfo3
    assert_equal '', s.tinfo4
  end
  
  def test_date
    s = Sauce.new @test_ansi
    assert_equal Date.parse('06/03/96',true), s.date
  end
end
