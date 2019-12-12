class Event < ApplicationRecord
  belongs_to :group
  belongs_to :user
  validates :title, presence: true

  def start_time
    self.start
  end

  def end_time
    self.end
  end
end
