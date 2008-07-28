class Sauce
  SAUCE_PACK = 'A5 A2 A35 A20 A20 A8 V C C v v v v C C A22'
  SAUCE_ID   = 'SAUCE'
  COMNT_ID   = 'COMNT'
  DATATYPES  = %w[None Character Graphics Vector Sound BinaryText XBin Archive Executable]
  FILETYPES  = {
    'None' => {
      :filetypes => [ 'Undefined' ],
      :flags     => [ 'None' ]
    },
    'Character' => {
      :filetypes => %w[ASCII ANSi ANSiMation RIP PCBoard Avatar HTML Source],
      :flags     => [ 'None', 'iCE Color' ],
      :tinfo     => [
        [ { :tinfo1 => 'Width', :tinfo2 => 'Height' } ] * 3,
          { :tinfo1 => 'Width', :tinfo2 => 'Height', :tinfo3 => 'Colors' },
        [ { :tinfo1 => 'Width', :tinfo2 => 'Height' } ] * 2
      ]
    },
    'Graphics' => {
      :filetypes => %w[GIF PCX LBM/IFF TGA FLI FLC BMP GL DL WPG PNG JPG MPG AVI],
      :flags     => [ 'None' ],
      :tinfo     => [
        {   :tinfo1 => 'Width',
            :tinfo2 => 'Height',
            :tinfo3 => 'Bits Per Pixel'
        }
      ] * 14
    },
    'Vector' => {
      :filetypes => %w[DXF DWG WPG 3DS],
      :flags     => [ 'None' ]
    },
    'Sound' => {
      :filetypes => %w[MOD 669 STM S3M MTM FAR ULT AMF DMF OKT ROL CMF MIDI SADT VOC WAV SMP8 SMP8S SMP16 SMP16S PATCH8 PATCH16 XM HSC IT],
      :flags     => [ 'None' ],
      :tinfo     => [ [ {} ] * 16, [ { :tinfo1 => 'Sampling Rate' } ] * 4 ]
    },
    'BinaryText' => {
      :filetypes => [ 'Undefined' ],
      :flags     => [ 'None', 'iCE Color' ]
    },
    'XBin' => {
      :filetypes => [ 'Undefined' ],
      :flags     => [ 'None' ],
      :tinfo     => [ { :tinfo1 => 'Width', :tinfo2 => 'Height' } ]
    },
    'Archive' => {
      :filetypes => %w[ZIP ARJ LZH ARC TAR ZOO RAR UC2 PAK SQZ],
      :flags     => [ 'None' ]
    },
    'Executable' => {
      :filetypes => [ 'Undefined' ],
      :flags     => [ 'None' ]
    }
  }
  
  def initialize(filename)
    @data         = []
    @comment_data = []
    @has_sauce    = false
    
    file = File.new(filename, "r")
    file.binmode
    
    raise if file.stat.size < 128
    
    file.seek(-128, IO::SEEK_END)
    raw_sauce = file.read(128)
    raise if raw_sauce !~ /^#{SAUCE_ID}/
    
    @data = raw_sauce.unpack(SAUCE_PACK)
    
    if @data[13] > 0 then
      comments_size = 5 + (64 * @data[13])
      file.seek( -128 - comments_size, IO::SEEK_END )
      raw_comments = file.read( comments_size )
      
      if raw_comments =~ /^#{COMNT_ID}/ then
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
    DATATYPES[ datatype_id ]  
  end
  
  def filetype_id
    @data[8]
  end
  
  def filetype
    FILETYPES[ datatype ][:filetypes][ filetype_id ]
  end

  def tinfo1
    @data[9]
  end

  def tinfo1_name
    FILETYPES[ datatype ][:tinfo][ filetype_id ][ :tinfo1 ]
  end   

  def tinfo2
    @data[10]
  end
  
  def tinfo2_name
    FILETYPES[ datatype ][:tinfo][ filetype_id ][ :tinfo2 ]
  end   

  def tinfo3
    @data[11]
  end
  
  def tinfo3_name
    FILETYPES[ datatype ][:tinfo][ filetype_id ][ :tinfo3 ]
  end   

  def tinfo4
    @data[12]
  end
  
  def tinfo4_name
    FILETYPES[ datatype ][:tinfo][ filetype_id ][ :tinfo4 ]
  end   

  def comments
    @data[13]
  end
  
  def flags_id 
    @data[14]
  end

  def flags
    FILETYPES[ datatype ][:flags][ flags_id ]
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
    result += @data.pack( SAUCE_PACK )
    
    return result
  end
end
