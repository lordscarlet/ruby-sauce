class Sauce
  #SAUCE_ID      = "SAUCE"
  #SAUCE_VERSION = "00"
  #SAUCE_FILLER  = " " x 22
  #COMNT_ID      = "COMNT"
  
  
  def initialize(filename)
    @data = Array.new
    i = 1
    begin
      file = File.new(filename, "r")
      file.seek(-128, IO::SEEK_END)
      raw_sauce = file.read(128)
      @data = raw_sauce.unpack("A5 A2 A35 A20 A20 A8 V C C v v v v C C A22")
      @has_sauce = true
    rescue => err
      
      @has_sauce = false
    end  
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
  
  def group
    @data[5]
  end
  
  def date
    @data[6]
  end
  
  def filesize
    @data[7]
  end
  
  def datatype_id
    @data[8]
  end
  
  def filetype_id
    @data[9]
  end
  
  def tinfo1
    @data[10]
  end
  
  def tinfo2
    @data[11]
  end
  
  def tinfo3
    @data[12]
  end
  
  def tinfo4
    @data[13]
  end
  
  def comments
    @data[14]
  end
  
  def flags_id 
    @data[15]
  end
  
  def filler
    @data[16]
  end
end
