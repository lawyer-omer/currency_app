class HomeController < ApplicationController
    def index

        require 'net/http'
        require 'json'

        currency_to = "usd"
        currency_from = "eur"
    
        @url = "https://api.apilayer.com/fixer/convert?to=#{currency_to}&from=#{currency_from}&amount=100&apikey=JFkntXPV2tLSXgKBFUdYra5ZHtLlzKF3"
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
        @fromparam = @fromparam.upcase
        @toparam = @toparam.upcase

        if params[:fromcurrency] && params[:tocurrency] == ""
            @from_output = "N/A"
            @to_output = "N/A"
            @rate_output = "N/A"
        elsif params[:fromcurrency] && params[:tocurrency]
            require 'net/http'
            require 'json'
            
            @url = "https://api.apilayer.com/fixer/convert?to=#{@toparam}&from=#{@fromparam}&amount=100&apikey=JFkntXPV2tLSXgKBFUdYra5ZHtLlzKF3"
            @uri = URI(@url)
            
            @response = Net::HTTP.get(@uri)
            @currency = JSON.parse(@response)
    
            @from_output = @currency["query"]["from"]
            @to_output = @currency["query"]["to"]

            if  @fromparam == @from_output && @toparam == @to_output

                @from_output = @currency["query"]["from"]
                @to_output = @currency["query"]["to"]
                @rate_output = @currency["info"]["rate"]
                
            end


        end

    end
end
