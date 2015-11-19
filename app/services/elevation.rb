require 'openssl'
require 'httparty'
class Elevation
  include HTTParty
  base_uri 'https://codingcontest.runtastic.com/api/elevations'


  def self.single(lat,lon)
    response = get("/#{lat}/#{lon}")
    if response.success?
      response.parsed_response
    else
      raise response.response
    end
  end

  def self.bulk(array)
    response = post('/bulk',{:body=>array.to_json, :headers => { 'Content-Type' => 'application/json'}})
    if response.success?
      response.parsed_response
    else
      raise response.response
    end
  end


end