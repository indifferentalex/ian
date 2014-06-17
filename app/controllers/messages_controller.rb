class MessagesController < ApplicationController
	def index
		@message = Message.new
		@messages = Message.find(:all, :order => "created_at desc", :limit => 6).reverse
	end

	def create
		@message = Message.new(message_params)

		if @message.save
			@response = @message.response

			redirect_to root_url
		else
			redirect_to root_url
		end
	end

	private
		def message_params
			params.require(:message).permit(:author, :content)
		end
end
