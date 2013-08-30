class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  ## Relations
  belongs_to :talk, index: true
  belongs_to :user, index: true
  embedded_in :message

  ## Fields
  field :content
  field :locale

  delegate :full_name, to: :user
  delegate :avatar_path, to: :user

  # is used for show message time in user time zone without any convertation
  mattr_accessor :time_at
  accepts_nested_attributes_for :user, reject_if: :all_blank

  def to_publish
    # see doc http://apidock.com/rails/ActiveRecord/Serialization/to_json
    self.user ||= User.new
    {full_name: user.full_name,
     avatar_path: user.avatar_path,
     content: content,
     time_at: time_at
    }
  end


end
