class Sauce
  DATATYPES = %w[None Character Graphics Vector Sound BinaryText XBin Archive Executable]
  
  def initialize(filename)
    @data         = []
    @comment_data = []
    @has_sauce    = false
    
    file = File.new(filename, "r")
    file.binmode
    
    raise if file.stat.size < 128
    
    file.seek(-128, IO::SEEK_END)
    raw_sauce = file.read(128)
    raise if raw_sauce !~ /^SAUCE/
    
    @data = raw_sauce.unpack("A5 A2 A35 A20 A20 A8 V C C v v v v C C A22")
    
    if @data[13] > 0 then
      comments_size = 5 + (64 * @data[13])
      file.seek( -128 - comments_size, IO::SEEK_END )
      raw_comments = file.read( comments_size )
      
      if raw_comments =~ /^COMNT/ then
        @comment_data = raw_comments.unpack("A5 " + ("A64" * @data[13]))
      end
    end
    
    file.close
    
    @has_sauce = true
  rescue => err
    
  end
  
  def sauce_id
    @data[0]
  end
  
  def version
    @data[1]
  end
  
  def title
    @data[2]
  end
  
  def author
    @data[3]
  end
  
  def group
    @data[4]
  end
  
  def date
    Date.parse(date_raw)
  end
  
  def date_raw
    @data[5]
  end
  
  def filesize
    @data[6]
  end
  
  def datatype_id
    @data[7]
  end
  
  def datatype
    DATATYPES[ @data[7] ]  
  end
  
  def filetype_id
    @data[8]
  end
  
  def tinfo1
    @data[9]
  end
  
  def tinfo2
    @data[10]
  end
  
  def tinfo3
    @data[11]
  end
  
  def tinfo4
    @data[12]
  end
  
  def comments
    @data[13]
  end
  
  def flags_id 
    @data[14]
  end
  
  def filler
    @data[15]
  end
  
  def comment_data
    @comment_data
  end
  
  def to_s
    result = ''
    result += @comment_data.pack( "A5 " + ("A64" * @data[13]) ) if @data[13] > 0
    result += @data.pack( "A5 A2 A35 A20 A20 A8 V C C v v v v C C A22" )
    
    return result
  end
end
