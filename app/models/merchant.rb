class Merchant < ActiveRecord::Base
	attr_accessible :name, :address, :city, :state, :zip_code, :account_id, :current_song_id,  :previous_song_id, :previous_song, :current_song
	has_many :ratings, :foreign_key => "merchant_id", :inverse_of => :merchant, :dependent => :destroy
	# The following indicate which song is currently playing in an establishment and what was being played before the current.
  belongs_to :previous_song, :class_name => "Song", :inverse_of => :previous_merchants
	belongs_to :current_song, :class_name => "Song", :inverse_of => :current_merchants
	has_many :listeners, :foreign_key => "merchant_id"
  # The relation below helps assing an owner to each buisness and decide which businesses a user can manage.
	belongs_to :owner, :class_name => "User", :inverse_of => :businesses
	belongs_to :owner_rating, :class_name => "Rating", :dependent => :destroy

	def make_address
		full_address = [address.gsub(" ", "+"), city, state, zip_code.to_s]
		return full_address.join("+")
	end

  # This method calculates an estimate of the number of meters in a longitudinal or latitudinal degree based on "r", or the
  # average radius of the earth, and the latitude (north vs. south) at which the user is located.
	def deg_per_met
		r = 6371000
		latrad = lat.abs * (2*Math::PI/360) # Converts latitudinal degrees into radians for the sake of sake of Ruby's sin function.
		rprime = r * Math.sin(latrad) # Using SOHCAHTOA to get the horizontal cross-sectional radius of the earth at the user's latitude.
		return 360 / (rprime*2*Math::PI) # Takes this radius and uses it to get the cross-sectional circumference at that point in meters
    # and return 360 degrees by this circumferences to get degrees per meter.
	end


  # This used to counteract the fact that the int class drops un-necessary zeroes at the beginning of a number.
  def format_zip
  	zeroes = 0
  	zip = self.zip_code
  	line = zip.to_s
  	if line.length < 5
  		zeroes = 5 - line.length
  		parts = Array.new
  		zeroes.times { parts << "0" }
  		addition = parts.join("")
  		line = addition + line
  	else
  		line = line
  	end
  	return line
  end

end
