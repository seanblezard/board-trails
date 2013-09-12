class BoardCreator < Struct.new(:name, :repository)
  def perform(reporter)
  	board = repository.new ({name: name})
  	board = repository.create (board)

    if (board.valid?)
      reporter.board_created(board) if reporter
    else
      reporter.board_creation_problem(board.violations) if reporter
    end    
  end
end