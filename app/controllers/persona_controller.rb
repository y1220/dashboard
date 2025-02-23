require 'csv'
require 'net/http'
require 'uri'
require 'json'

class PersonaController < ApplicationController
  API_ENDPOINT = 'http://127.0.0.1:5000/predict'
  def upload
    # This action will render the upload form
  end

  def result
    # This action will render the result page
    @persona_type = params[:persona_type]
  end

  def import
    return redirect_to upload_persona_path, flash: { error: 'No file uploaded' } unless params[:file]

    begin
      csv_data = parse_csv_file(params[:file])

      response = call_persona_api(csv_data)

      if response && response['persona_type']
        @persona_type = response['persona_type']
        flash[:success] = 'Successfully processed the CSV file'
      else
        flash[:error] = 'Failed to get persona type from API'
      end

    rescue StandardError => e
      flash[:error] = "Error processing file: #{e.message}"
    end

    redirect_to result_persona_path(persona_type: @persona_type)
  end

  private

  def parse_csv_file(file)
    raise 'Invalid file format' unless file.content_type == 'text/csv'

    content = file.read
    # Parse CSV and get the first row as integers
    values = CSV.parse(content).first&.map(&:strip)&.map(&:to_i)

    raise 'Invalid CSV format: Expected array of integers' if values.nil? || values.empty?

    values
  end

  def call_persona_api(data)
    uri = URI(API_ENDPOINT)

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = false

    request = Net::HTTP::Post.new(uri.path, {
      'Content-Type' => 'application/json'
    })

    request.body = { test_data: data }.to_json

    begin
      response = http.request(request)

      if response.is_a?(Net::HTTPSuccess)
        JSON.parse(response.body)
      else
        raise "API call failed with status: #{response.code}, body: #{response.body}"
      end
    rescue StandardError => e
      raise "API call error: #{e.message}"
    end
  end
end
