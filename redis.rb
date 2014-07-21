class Redis

  def initialize
    @args = []
    @data = {}
    @output = []
  end

  def get_input(user_input)
    user_input.each {|arg| @args.push(arg)}
    evaluate_input
  end

  def evaluate_input
    case @args[0].upcase
    when "END"
      exit
    when "SET"
      set_value
    when "GET"
      return_value
    when "UNSET"
      delete_value
    when "NUMEQUALTO"
      @output[0] = true
      @output[1] = numequalto
    else
      @output[0] = true
      @output[1] = "Error, unrecognized command"
    end 
    reset_args
  end

  def reset_args
    @args = []
    @output
  end

  def set_value
    @data[@args[1]] = @args[2]
    @output[0] = false
  end

  def delete_value
    @data.delete(@args[1])
    @output[0] = false
  end

  def return_value
    @output[0] = true
    if @data[@args[1]] 
      @output[1] = @data[@args[1]] 
    else
      @output[1] = "NULL"
    end
  end

  def numequalto
    values = @data.values.select {|value| value == @args[1]}
    values.count 
  end

end