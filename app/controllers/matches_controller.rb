class MatchesController < ApplicationController

    def destroy
        match = Match.find_by(id: params[:id])
        render json: match.destroy().to_json()
    end
end
