class VideosSharingChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'videos_sharing_channel'
  end
end
