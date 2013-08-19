class DocumentAttachmentsController < ApplicationController
  def destroy
    @attachment = DocumentAttachment.find(params[:id])
    @attachment.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end
end
