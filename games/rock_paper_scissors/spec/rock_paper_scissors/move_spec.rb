require 'spec_helper'
require 'move'

describe Move do
  def move(value)
    Move.new(player, reporter).result(value)
  end
  
  let(:player)   { mock('player').as_null_object   }
  let(:reporter) { mock('reporter').as_null_object }
  
  context "rock" do
    subject { move("rock") }

    it { should be < move("paper") }
    it { should be > move("scissors") }
    it { should be == move("ROCK") }
  
    it "is greater than a move that failed" do
      other_move = Move.new(player, reporter).fail("badness")
      subject.should be > other_move
    end
    
    it "is greater than an invalid move" do
      subject.should be > move("nonsense")
    end
  end
  
  context "paper" do
    subject { move("paper") }
    it { should be < move("scissors") }
    it { should be < move("sciSSors") }
    it { should be > move("rock") }
    it { should be > move("nonsense") }
  end

  context "scissors" do
    subject { move("scissors") }
    it { should be < move("rock") }
    it { should be > move("paper") }
    it { should be > move("PAPER") }
    it { should be > move("nonsense") }
  end
  
  context "an invalid move" do
    it "tells the reporter" do
      reporter.should_receive(:invalid).with(player.name)
      move("silly")
    end
    
    it "loses to a valid move" do
      move("silly").should be < move("rock")
    end
  end
end
