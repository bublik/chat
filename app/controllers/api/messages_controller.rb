class Api::MessagesController < ApplicationController
  include Auth
  skip_before_filter :signup_master
  skip_before_filter :verify_authenticity_token

  respond_to :xml, :json

  # {message: {to: '', body: ''}}
  def create
    client = JabberRest.new(message_params.merge(to: current_agent.selected_user.jabber_account))
    client.send!

    respond_to do |format|
      if client.success?
        format.xml { render text: {status: 'ok'}, status: :created }
        format.json { render json: {status: 'ok'}, status: :created }
      else
        format.xml { render text: {status: 'failed', message: client.response_body}, status: :unprocessable_entity }
        format.json { render json: {status: 'failed', message: client.response_body}, status: :unprocessable_entity }
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
