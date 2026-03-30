class SongsController < ApplicationController
  before_action :set_band, except: [:all]
  before_action :set_song, only: [:edit, :update, :destroy]

  def all
    @bands_with_songs = current_user.bands.includes(:songs).sort_by(&:name)
  end

  def index
    @songs = @band.songs
  end

  def new
    @song = @band.songs.build
  end

  def create
    @song = @band.songs.build(song_params)
    if @song.save
      redirect_to band_songs_path(@band), notice: "\"#{@song.title}\" added."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @song.update(song_params)
      redirect_to band_songs_path(@band), notice: "Song updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @song.destroy
    redirect_to band_songs_path(@band), notice: "Song deleted."
  end

  private

  def set_band
    @band = current_user.bands.find(params[:band_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to bands_path, alert: "Band not found."
  end

  def set_song
    @song = @band.songs.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to band_songs_path(@band), alert: "Song not found."
  end

  def song_params
    raw = params.require(:song).permit(:title, :duration_input).to_h
    raw['duration_seconds'] = Song.parse_duration(raw.delete('duration_input'))
    raw.compact
  end
end
