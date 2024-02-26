class MessagesController < ApplicationController
    def index
        @messages = Message.all
    end

    def show
        @message = Message.find(params[:id])
    end

    def new
        @message = Message.new
    end
    
    def create
        @message = Message.new(message_params)
        
        if @message.save
            @message.perform_moderation
            redirect_to messages_path
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @message = Message.find(params[:id])
    end
    
    def update
        @message = Message.find(params[:id])

        if @message.update(message_params)
            @message.perform_moderation
            redirect_to @message
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @message = Message.find(params[:id])
        @message.destroy

        redirect_to messages_path, status: :see_other
    end

    private 
        def message_params
            params.require(:message).permit(:body)
        end
end
