module XML
  class Error < StandardError
  end

  class ParsingError < Error
    attr_reader :line, :column

    def initialize(msg = nil, line = nil, column = nil)
      super(msg)
      @line = line
      @column = column
    end

    def to_s
      msg = super
      unless @line.nil?
        line = "at #{@line}"
        line << ":#{@column}" unless @column.nil?
        msg << " (#{line})"
      end
      msg
    end
  end

  class RenderingError < Error
  end
end