require 'google/apis/youtube_v3'

class VideosSharingController < ApplicationController
  before_action :authenticate!, only: [:create]

  def get
    videos = Video.includes(:user).all.map do |video|
      {
        id: video.id,
        title: video.title,
        description: video.description,
        sharedBy: video.user.email,
        url: video.url
      }
    end
    render json: videos, status: :ok
  end

  def create
    begin
      video_info = get_youtube_video_info

      video = Video.new(video_params.merge(
        user: current_user,
        title: video_info.title,
        description: video_info.description
      ))
      if video.save
        ActionCable.server.broadcast(VIDEOS_SHARING_CHANNEL, { video: video.title, email: video.user.email })
        head :ok
      end
    rescue => e
      render json: { error: "Can not share video" }, status: :unprocessable_entity
    end
  end

  private

  def video_params
    params.permit(:url)
  end

  def extract_video_id(url)
    if url =~ /(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})/
      $1
    else
      nil
    end
  end

  def get_youtube_video_info
    youtube = Google::Apis::YoutubeV3::YouTubeService.new
    youtube.key = Rails.application.secrets.youtube_key

    video_id = extract_video_id(video_params[:url])
    youtube.list_videos('snippet', id: video_id).items.first.snippet
  end
end
