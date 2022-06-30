class HomeController < ApplicationController
    def index

        require 'net/http'
        require 'json'

        currency_to = "usd"
        currency_from = "eur"
    
        @url = "https://api.apilayer.com/fixer/convert?to=#{currency_to}&from=#{currency_from}&amount=100&apikey=aySd4XJBlaFfw1Z31bKPP8aPX0UrO7LY"
        @uri = URI(@url)
    
        @response = Net::HTTP.get(@uri)
        @currency = JSON.parse(@response)

        # Check for empty inputs

        if @currency.empty?
            @from_output = "N/A (You need to enter a pair to calculate rate"
            @to_output = "N/A (You need to enter a pair to calculate rate"
            @rate_output = "N/A (You need to enter a pair to calculate rate"
        elsif !@currency
            @from_output = "N/A (You need to enter a pair to calculate rate"
            @to_output = "N/A (You need to enter a pair to calculate rate"
            @rate_output = "N/A (You need to enter a pair to calculate rate"
        else
            @from_output = @currency["query"]["from"]
            @to_output = @currency["query"]["to"]
            @rate_output = @currency["info"]["rate"]
        end
    end

    def manage
        @fromparam = params[:fromcurrency].to_s
        @toparam = params[:tocurrency].to_s

        if params[:fromcurrency] && params[:tocurrency] == ""
            @from_output = "N/A"
            @to_output = "N/A"
            @rate_output = "N/A"
        elsif params[:fromcurrency] && params[:tocurrency]
            require 'net/http'
            require 'json'
            
            @url = "https://api.apilayer.com/fixer/convert?to=#{@toparam}&from=#{@fromparam}&amount=100&apikey=aySd4XJBlaFfw1Z31bKPP8aPX0UrO7LY"
            @uri = URI(@url)
            
            @response = Net::HTTP.get(@uri)
            @currency = JSON.parse(@response)
    
            @from_output = @currency["query"]["from"]
            @to_output = @currency["query"]["to"]
            @rate_output = @currency["info"]["rate"]
        end

    end
end
