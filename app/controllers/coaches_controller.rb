# frozen_string_literal: true

class CoachesController < ApplicationController
  def index
    @coaches = Coach.where(active: true)
  end
end
