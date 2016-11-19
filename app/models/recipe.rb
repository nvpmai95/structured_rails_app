# == Schema Information
#
# Table name: recipes
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :text
#  image        :string
#  prepare_time :integer
#  cook_time    :integer
#  ready_time   :integer
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Recipe < ApplicationRecord
  belongs_to :user
  has_many :ingredients, dependent: :destroy
  has_many :directions, dependent: :destroy
end