require_relative 'redis'
require_relative 'view'

class Controller
  def initialize(redis, view)
    @redis = redis
    @view = view
  end

  def start_db
    db_output = get_input
    evaluate_db_output(db_output)
  end

  def get_input
    @redis.get_input(@view.get_input)
  end

  def evaluate_db_output(output)
    @view.display_output(output[1]) if output[0] 
    start_db
  end
  
end