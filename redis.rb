class Redis

  def initialize
    @args = []
    @data = {}
    @output = []
    @transactions = []
  end

  def get_input(user_input)
    user_input.each {|arg| @args.push(arg)}
    evaluate_input
  end

  def evaluate_input
    case @args[0].upcase
    when "BEGIN"
      begin_transaction
    when "ROLLBACK"
      rollback
    when "COMMIT"
      @transactions = []
    when "END"
      exit
    when "SET"
      set_value
    when "GET"
      return_value
    when "UNSET"
      delete_value
    when "NUMEQUALTO"
      @output = [true, numequalto]
    else
      @output = [true, "Error, unrecognized command"]
    end 
    reset_args
  end

  def begin_transaction
    take_snapshot
    @output = [false]
  end

  def take_snapshot
    db_snaphsot = @data.clone
    @transactions << db_snaphsot
  end

  def rollback
    if @transactions.length == 0
      @output = [true, "NO TRANSACTION"]
    else
      @data = @transactions.pop
      @output = [false]
    end
  end

  def reset_args
    @args = []
    @output
  end

  def set_value
    @data[@args[1]] = @args[2]
    @output = [false]
  end

  def delete_value
    @data.delete(@args[1])
    @output = [false]
  end

  def return_value
    if @data[@args[1]] 
      @output = [true, @data[@args[1]]]
    else
      @output = [true, "NULL"]
    end
  end

  def numequalto
    values = @data.values.select {|value| value == @args[1]}
    values.count 
  end

end




