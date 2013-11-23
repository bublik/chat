#require 'spec_helper'
#
#describe ArchiveMessagesController do
#
#  # This should return the minimal set of attributes required to create a valid
#  # ArchiveMessage. As you add validations to ArchiveMessage, be sure to
#  # adjust the attributes here as well.
#  let(:valid_attributes) { { "utc" => "2013-09-22 19:18:27" } }
#
#  # This should return the minimal set of values that should be in the session
#  # in order to pass any filters (e.g. authentication) defined in
#  # ArchiveMessagesController. Be sure to keep this updated too.
#  let(:valid_session) { {} }
#
#  describe "GET index" do
#    it "assigns all archive_messages as @archive_messages" do
#      archive_message = ArchiveMessage.create! valid_attributes
#      get :index, {}, valid_session
#      assigns(:archive_messages).should eq([archive_message])
#    end
#  end
#
#  describe "GET show" do
#    it "assigns the requested archive_message as @archive_message" do
#      archive_message = ArchiveMessage.create! valid_attributes
#      get :show, {:id => archive_message.to_param}, valid_session
#      assigns(:archive_message).should eq(archive_message)
#    end
#  end
#
#  describe "DELETE destroy" do
#    it "destroys the requested archive_message" do
#      archive_message = ArchiveMessage.create! valid_attributes
#      expect {
#        delete :destroy, {:id => archive_message.to_param}, valid_session
#      }.to change(ArchiveMessage, :count).by(-1)
#    end
#
#    it "redirects to the archive_messages list" do
#      archive_message = ArchiveMessage.create! valid_attributes
#      delete :destroy, {:id => archive_message.to_param}, valid_session
#      response.should redirect_to(archive_messages_url)
#    end
#  end
#
#end
