require 'google/apis/youtube_v3'

class VideosSharingController < ApplicationController

  def get
    videos = Video.includes(:user).all.map do |video|
      {
        id: video.id,
        title: video.title,
        description: video.description,
        shared_by: video.user.username
      }
    end
    render json: videos, status: :ok
  end

  def share
    youtube = Google::Apis::YoutubeV3::YouTubeService.new
    youtube.key = Rails.application.config.youtube_key

    video_id = extract_video_id(video_params[:url])
    video_info = youtube.list_videos('snippet', id: video_id).items.first

    video = Video.new(video_params)
    video.user = current_user
    video.title = video_info.snippet.title
    video.description = video_info.snippet.description
    if video.save
      # ActionCable.server.broadcast 'videos',
      #   video: video.title,
      #   user: video.user.username
      head :ok
    end
  end

  private

  def video_params
    params.require(:video).permit(:url)
  end

  def extract_video_id(url)
    if url =~ /(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})/
      return $1
    else
      return nil
    end
  end
end
