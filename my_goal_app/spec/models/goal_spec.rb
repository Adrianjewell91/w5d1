require 'rails_helper'

RSpec.describe Goal, type: :model do

  it {should belong_to(:user)}
  
end
