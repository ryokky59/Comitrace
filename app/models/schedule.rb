class Schedule < ApplicationRecord
  belongs_to :user
  has_many :schedule_plans, dependent: :destroy
  accepts_nested_attributes_for :schedule_plans
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
end