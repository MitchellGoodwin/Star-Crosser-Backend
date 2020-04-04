class SunSignsController < ApplicationController
    skip_before_action :authorized, only: [:show]
    
    def show
        sign = SunSign.find_by(id: params[:id])
        render json: sign.to_json()
    end
end
