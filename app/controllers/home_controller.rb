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
        @fromparam = params[:fromcurrency]
        @toparam = params[:tocurrency]

        if params[:fromcurrency] && params[:tocurrency] == ""
            @fromparam && @toparam = "N/A"
        elsif params[:fromcurrency] && params[:tocurrency]
            require 'net/http'
            require 'json'
        
            currency_to = "usd"
            currency_from = "eur"
            
            @url = "https://api.apilayer.com/fixer/convert?to=#{@fromparam}&from=#{@toparam}&amount=100&apikey=JFkntXPV2tLSXgKBFUdYra5ZHtLlzKF3"
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

    end
end
