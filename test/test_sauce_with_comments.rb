require "test/unit"
require "date"

require "sauce"

class TestSauce < Test::Unit::TestCase
  def setup
    @test_ansi = File.dirname(__FILE__) + '/wt-r666.ans'
    @sauce = Sauce.new @test_ansi
  end
  def teardown
  end
  
  def test_basic
    assert_equal '00'               , @sauce.version
    assert_equal 'Route 666'        , @sauce.title
    assert_equal 'White Trash'      , @sauce.author
    assert_equal 'ACiD Productions' , @sauce.group
    
    assert_equal 4       , @sauce.comments
    assert_equal 42990   , @sauce.filesize
    assert_equal ''      , @sauce.filler
    
    assert_equal 1       , @sauce.datatype_id
    assert_equal 1       , @sauce.filetype_id
    assert_equal 0       , @sauce.flags_id
    assert_equal 'SAUCE' , @sauce.sauce_id
    
    assert_equal 80      , @sauce.tinfo1
    assert_equal 180     , @sauce.tinfo2
    assert_equal 0       , @sauce.tinfo3
    assert_equal 0       , @sauce.tinfo4
  end

  def test_comments
    assert_equal 'COMNT', @sauce.comment_data[ 0 ]
    assert_equal 'To purchase your white trash ansi:  send cash/check to'     , @sauce.comment_data[ 1 ]
    assert_equal 'keith nadolny / 41 loretto drive / cheektowaga, ny / 14225' , @sauce.comment_data[ 2 ]
    assert_equal 'make checks payable to keith nadolny/us funds only'         , @sauce.comment_data[ 3 ]
    assert_equal '5 dollars = 100 lines - 10 dollars = 200 lines'             , @sauce.comment_data[ 4 ]
  end

  def test_date
    assert_equal '19970401', @sauce.date_raw
    assert_equal Date.parse('1997-04-01'), @sauce.date
  end
  
end
