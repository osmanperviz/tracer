class Trace

  include Mongoid::Document
  field :latitude, type: Float
  field :longitude, type: Float
  field :distance, type: Integer
  field :elevation, type: Integer




  validates :latitude,:presence => true,
            :numericality => {:only_float=> true}
  validates :longitude,:presence => true,
            :numericality => {:only_float=> true}

  index({ longitude: 1})
  index({ latitude:1})


  # def distance
  #   start_point = Trace.first()
  #   measuring_distance(start_point['latitude'],start_point['longitude'],self.latitude,self.longitude)
  #
  # end
  #
  # def measuring_distance(lat1, long1, lat2, long2)
  #   radius_of_earth = 6378.14
  #   rlat1, rlong1, rlat2, rlong2 = [lat1, long1, lat2, long2].map { |d| as_radians(d)}
  #   dlon = rlong1 - rlong2
  #   dlat = rlat1 - rlat2
  #   a = power(Math::sin(dlat/2), 2) + Math::cos(rlat1) * Math::cos(rlat2) * power(Math::sin(dlon/2), 2)
  #   great_circle_distance = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))
  #   c= radius_of_earth * great_circle_distance
  #   c =(c*1000).floor
  # end
  # def as_radians(degrees)
  #   degrees * Math::PI/180
  # end
  # def power(num, pow)
  #   num ** pow
  # end



end
