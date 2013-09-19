require 'spec_helper'

describe MemoryRepository do
  before(:each) do
    @existing_board = generate_board "Existing board"
    @existing_board = MemoryRepository::BoardRepository.new.create(@existing_board)
  end

  describe "BoardRepository" do
    it "should create a new unsaved Board domain" do
      board_name = "Brand new board"
      board = MemoryRepository::BoardRepository.new.new_board({name: board_name})
      board.name.should eq board_name
    end

    it "should save the new domain to memory with a new UUID" do
      board = generate_board("Board")
      board = MemoryRepository::BoardRepository.new.create(board)
      board.id.should_not eq nil
    end

    it "should timestamp the the new board's created_at" do
      board_name = "Brand new board"
      repo = MemoryRepository::BoardRepository.new
      board = repo.new_board({name: board_name})
      board = repo.create(board)
      board.created_at.should_not eq nil
    end

    it "should prevent saving a board with no name and not assign it a UUID" do
      board = Board.new
      board = MemoryRepository::BoardRepository.new.create(board)
      board.id.should eq nil
    end

    it "should update an existing board domain to memory, with the new name" do
      new_name = "New board name"
      @existing_board.name = new_name      
      @existing_board = MemoryRepository::BoardRepository.new.update(@existing_board)      
      @existing_board.name.should eq new_name
    end

    it "should timestamp the updated_at when saving a board" do
      @existing_board = MemoryRepository::BoardRepository.new.update(@existing_board)      
      @existing_board.updated_at.should_not eq nil
    end

    it "should return the one existing board" do
      boards = MemoryRepository::BoardRepository.new.all()
      boards.size.should eq 1
    end
  end
     
  describe "CardRepository" do
    it "should create a new unsaved Card domain" do
      card_title = "Card title"
      card = MemoryRepository::CardRepository.new.new_card({title: card_title})
      card.class.should eq Card
    end    

    it "should persist the new card" do
      card_title = "Card title"
      repo = MemoryRepository::CardRepository.new
      card = repo.new_card({title: card_title})
      card = repo.create(card)
      card.valid?.should eq true
      card.id.should_not eq nil
    end    
  end
  
  after(:each) do
    MemoryRepository.clear_memory
  end


  private
  def generate_board board_name=nil
    board_name = "#{board_name} #{Time.now.utc}"
    MemoryRepository::BoardRepository.new.new_board({name: board_name})      
  end  
end

