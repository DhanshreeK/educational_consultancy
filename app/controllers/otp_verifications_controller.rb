class OtpVerificationsController < ApplicationController

	 def index
    @otp_verifications = OtpVerification.all
  end

  def show
    @otp_verification = OtpVerification.find(params[:id])
  end

  def new
	 @otp_verification = OtpVerification.new
  end  


  def new1
  	
	

  end

def update
	
	 @otp_verification = OtpVerification.find(params[:id])
	#  @otp_verification.otp_code
	 #sleep 180
	
	 if @otp_verification.otp_code ==  params[:otp_verification][:code]

	 	@otp_verification.update(otp_verification_params)
	 	redirect_to new_otp_verification_path
	 end
	end

	def create
      @otp_verification = OtpVerification.new(otp_verification_params)
 
  @otp_verification.save
    redirect_to new1_otp_verifications_path 

 end

 def destroy
    @otp_verification = OtpVerification.find(params[:id])
    @otp_verification.destroy
 
  redirect_to otp_verifications_path
end

  private
  def otp_verification_params
    params.require(:otp_verification).permit(:code, :contact_no, :otp_secret_key)
  end

  end
