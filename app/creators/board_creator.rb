#
# Responsible for creating and persisting new boards - issuing a callback to a reporter
#

class BoardCreator < Struct.new(:name, :repository)
  def perform(reporter)
  	board = repository.create (Board.new({name:name}))

    if (board.valid?)
      reporter.board_created(board) if reporter
    else
      reporter.board_creation_problem(board.violations) if reporter
    end    
  end
end