class ReceiptsController < ApplicationController
	before_action :set_general_setting , only: [:new, :generate_receipt, :show, :receipt_creation, :index]
	def index
		@receipts = Receipt.all
	end

	def new
		@students = Student.all
	end

	def receipt_creation
		
	end

	def generate_receipt
		@receipt = Receipt.new
		@receipt.invoice_number = Receipt.set_invoice_no
		@student = Student.find(params[:id])
		@pending_payments = PendingPayment.all
	end

	def create
		@receipt = Receipt.new(receipt_params)
		@student = Student.load(params[:id])
	    if @receipt.save
	    @pending = PendingPayment.create!(student_id: @receipt.student_id, receipt_id: @receipt.id, fees_pending: @receipt.pending_payment, discount: @receipt.discount, fees_paid: @receipt.payment)
	    if @receipt.pending_payment == '0'
	    	@pending.update(payment_status: 'true')
	    end
	  	redirect_to @receipt
	  else
	  	redirect_to new_receipt_path
	  end
	end

	def show
	    @receipt = Receipt.find(params[:id])
	end

	def print_receipt
	    @receipt = Receipt.find(params[:id])
		 respond_to do |format|
	      format.html
	      format.pdf do
	          render pdf: "print_receipt.pdf.erb" 
	        end
	      end
	end

	private

	def receipt_params
		params.require(:receipt).permit(:place_of_supply,:taxable_value,:total_rate, :total_amt, :description_of_services, :gstin_no_of_customer, :cgst, :sgst, :igst, :invoice_number,:discount,:center_id, :received_from ,:gst_no, :date,:student_id, :amount, :towards, :payment_mode, :check_no, :bank_name, :transaction_id, :check_date,:pending_payment, :payment_paid, :payment, :payment_date)
	end

	def set_general_setting
		@general_setting = GeneralSetting.first
	end
end
