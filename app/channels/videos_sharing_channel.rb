class VideosSharingChannel < ApplicationCable::Channel
  def subscribed
    stream_from VIDEOS_SHARING_CHANNEL
  end
end
