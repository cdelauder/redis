require_relative 'controller'

controller = Controller.new(Redis.new, View.new)
controller.start_db