class RecommendationsController < ApplicationController
  def new
    @recommendation = Recommendation.new
  end
end
