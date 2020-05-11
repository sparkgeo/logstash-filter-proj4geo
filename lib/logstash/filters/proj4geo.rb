# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"
# require 'json'
require 'rgeo'
require 'rgeo-proj4'

class LogStash::Filters::Proj4Geo < LogStash::Filters::Base

  config_name "proj4geo"

  config :source, :validate => :string, :required => true
  config :target, :validate => :string, :default => 'proj4geo'
  config :tag_on_failure, :validate => :array, :default => [ '_proj4_failure' ]

  public
  def register
  end # def register

  public
  def filter(event)

    geom = event.get(@source)

    begin
      # factory = GeoRuby::SimpleFeatures::GeometryFactory::new()
      # ewkt_parser = GeoRuby::SimpleFeatures::EWKTParser::new(factory)
      # ewkt_parser.parse(wkt)

      # if (factory.geometry.nil?)
      #   raise "Failed to parse to SimpleFeature"
      # end

      # if (! @bbox.nil?)
      #   bbox = factory.geometry.bounding_box
      #   event.set(@bbox, ([ bbox[0].x, bbox[0].y, bbox[1].x, bbox[1].y ]).to_json)
      # end

      factory = RGeo::Geographic.projected_factory(:projection_proj4 =>
        '+proj=merc +lon_0=0 +k=1 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs')
      point = factory.point(-122.3, 47.6)

      # Project the point to mercator projection coordinates.
      # The coordinates are in "meters" at the equator.
      point.projection.as_text   # => "POINT (-13614373.724017357 6008996.432357133)"

      event.set(@target, point)

    rescue Exception => e
      @logger.error('Proj4 Error', :geom => geom, :exception => e)
      @tag_on_failure.each { |tag| event.tag(tag) }
    end # begin

    # filter_matched should go in the last line of our successful code
    filter_matched(event)
  end # def filter
end # class LogStash::Filters::Proj4Geo
