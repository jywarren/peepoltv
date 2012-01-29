class VideosController < ApplicationController

	def index
		@videos = Video.find(:all, :limit => 30, :order => "created_at DESC")
	end

	def new

	end

	def search
		@videos = Video.find(:all,:conditions => ['title LIKE ?',"%"+params[:q]+"%"])
	end

	def create
		if params[:location] == ''
			@video = Video.new
			@video.errors.add :location, 'You must name a location. You may also enter a latitude and longitude instead.'
			new
			render :action => "new", :controller => "videos"
		else 
			begin
				location = GeoKit::GeoLoc.geocode(params[:location])
				@video = Video.new(params[:video])
				@video.latitude = location.lat
				@video.longitude = location.lon
			rescue
				@video = Video.new(params[:video])
			end
			@video.save
			params[:tags].split(',').each do |tag|
				tag = Tag.new({:video_id => @video.id,:name => tag})
				tag.save
			end
			redirect_to "/videos/"
		end
	end

	def bounds
		maxlat,minlat,maxlon,minlon = params[:bbox].split(",")
		@videos = Video.find(:all,:conditions => ['latitude < ? AND latitude > ? AND longitude < ? AND longitude > ?',maxlat,minlat,maxlon,minlon])
		
		respond_to do |format|
			format.html { render :template => "videos/search" }
			format.xml  { render :xml => @videos }
			format.json  { render :json => @videos }
		end

	end

	def geolocate
		#begin
			@location = GeoKit::GeoLoc.geocode(params[:q])
			render :layout => false
		#rescue
		#	render :text => "No results"
		#end
	end

end
