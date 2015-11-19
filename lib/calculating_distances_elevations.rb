  module CalculatingDistancesElevations

    def calc_elevations_and_distances(traces)
      calculated_elevations = Elevation.bulk(get_trace_lan_lot(traces))
      start_point = traces[0]
      traces.each_with_index.map{ |trace,index|
        trace.distance =  measuring_distance(start_point['latitude'],start_point['longitude'],trace['latitude'],trace['longitude']) if trace.distance.nil?
        trace.elevation = calculated_elevations[index] if trace.elevation.nil?
        trace
      }
    end

    def assign_distance_and_elevation(trace)
      start_point = Trace.first if trace.distance.nil?
      trace.elevation  = Elevation.single(trace['latitude'],trace['longitude'])  if trace.elevation.nil?
      trace.distance  = measuring_distance(start_point['latitude'],start_point['longitude'],trace['latitude'],trace['longitude']) if trace.distance.nil?
      trace
    end
    def get_trace_lan_lot(traces)
      traces.collect { |trace| {:latitude => trace.latitude,:longitude=>trace.longitude}}
    end

    def measuring_distance(lat1, long1, lat2, long2)
      radius_of_earth = 6378.14
      rlat1, rlong1, rlat2, rlong2 = [lat1, long1, lat2, long2].map { |d| as_radians(d)}
      dlon = rlong1 - rlong2
      dlat = rlat1 - rlat2
      a = power(Math::sin(dlat/2), 2) + Math::cos(rlat1) * Math::cos(rlat2) * power(Math::sin(dlon/2), 2)
      great_circle_distance = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))
      c= radius_of_earth * great_circle_distance
      c =(c*1000).floor
    end
    def as_radians(degrees)
      degrees * Math::PI/180
    end
    def power(num, pow)
      num ** pow
    end
  end
