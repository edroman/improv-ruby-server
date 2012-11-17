class Vote < ActiveRecord::Base
  belongs_to :story, :counter_cache => true
  belongs_to :user
end
