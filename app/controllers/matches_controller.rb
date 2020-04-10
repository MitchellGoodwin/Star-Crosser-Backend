class MatchesController < ApplicationController

    def destroy
        match = Match.find_by(id: params[:id])
        secondmatch = Match.find_by(user: current_user, matched_user: match.user)
        secondmatch.destroy()
        render json: match.destroy().to_json()
    end
end
