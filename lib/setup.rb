class Setup
  #setup accessable methods/classes and getters/setters
  require_relative 'csv_reader'
  require_relative 'area'
  attr_accessor :areas

  def initialize
    csv = CSVReader.new("./zipcode-db.csv")

    @areas = []
    csv.read do |item|
      @areas << Area.new(item)
    end
    self

  end

  def read
    f = File.new(@fname, 'r')

    # Grab the headers
    self.headers = f.readline
  
    # Loop over the lines
    while (!f.eof? && next_line = f.readline)
      values = next_line.split(',')
      hash = create_hash(values)
      yield(hash)
    end
  end


end