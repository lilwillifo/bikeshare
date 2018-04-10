require 'rails_helper'

describe 'As a Visitor' do
  describe 'When I visit the trips index' do
    scenario 'I see the first 30 trips along with a button to see more pages of trips' do
      trip = Trip.Create!(duratii)
