class ColumnsController < ApplicationController
    before_action :authenticate_user!
    
    def index
        render json: Column.all, status: :ok # to be changed
    end
    
    def show
    
    end
    
    def create

    end
    
    def update
 
    end

    def destroy

    end
    
    
end
