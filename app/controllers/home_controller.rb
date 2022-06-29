class HomeController < ApplicationController
    def index

        require 'net/http'
        require 'json'
    
        @url = 'https://api.apilayer.com/fixer/convert?to=usd&from=eur&amount=100&apikey=B9hzo2vxHrbvTcrNpgJg3z8jGaMxS0UC'
        @uri = URI(@url)
    
        @response = Net::HTTP.get(@uri)
        @currency = JSON.parse(@response)

        
    end
end
