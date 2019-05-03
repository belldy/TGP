class StaticController < ApplicationController
  def index
  	@gossip = Gossip.all
  end

  def team
  end

  def contact
  end
end
