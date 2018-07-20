class ReportsController < ApplicationController
	def general_report
		@centers = Center.all
		@general_setting = GeneralSetting.first
		#@pnbs = Pnb.all
   # respond_to do |format|
    #  format.html
     # format.csv { send_data @pnbs.to_csv }
      #format.xls { send_data @pnbs.to_csv(col_sep: "\t"), filename: 'center_report.xls'}
    #end
	end

	def select_center
		@center = Center.load(params[:center_id])

		@center_name = @center.center_name
		@center_students = @center.students
		@student_count = @center.students.count
	end

	def new
		@general_setting = GeneralSetting.first
	end

	def create
		@results = Student.all
		if current_user.role == "Center"
			@results = Student.where(center_id: current_user.center_id)
		end
		@general_setting = GeneralSetting.first
		@start_date = params[:report][:start_date].to_date
	    @end_date = params[:report][:end_date].to_date
	    if @start_date.nil? || @end_date.nil?
         flash[:alert] = 'Done'
         render 'new'
      end
	end

	def index
		@pending_payments = PendingPayment.all
		if current_user.role == "Center"

			@pending_payments = PendingPayment.where(center_id: current_user.center_id)
		end
	end


  	def export_payment_status
  			if current_user.role == "Center"

			@pending_payments = PendingPayment.where(center_id: current_user.center_id)
		
			else
  			@pending_payments = PendingPayment.all
  			end
  			respond_to do |format|
				format.xlsx {
 						 		response.headers['Content-Disposition'] = 'attachment;' "filename= Payment_Status_Report\"#{Date.today}\".xlsx"
							}
			end
	end
  			
    



    def export_center
    	if current_user.role == "Center"

    		@center_students = Student.where(center_id: @current_user.center_id)
    		@center_name = @current_user.center.center_name
    	else
    	@center_id = params[:center_id]

    	
    	@center_students = Student.where(center_id: @center_id)

    	@center_name = Center.find(@center_id).center_name
    end

    	respond_to do |format|
			format.xlsx {
 							 response.headers['Content-Disposition'] = 'attachment;' "filename= Center_Student_Report(\"#{@center_name}\")\"#{Date.today}\".xlsx"
						}
		end
	end
	


	def export_university
		@university = University.load(params[:university_id])
		@university_students = @university.students
		if current_user.role == "Center"
			@university_students = @university.students.where(center_id: current_user.center_id)
		end

		respond_to do |format|
			format.xlsx {
 							 response.headers['Content-Disposition'] = 'attachment;' "filename= University_Student_Report\"#{Date.today}\".xlsx"
						}
		end
	end

	def export_course_report
		@course = Course.load(params[:course_id])

		@course_students = @course.students
		if current_user.role == "Center"
			@course_students = @course.students.where(center_id: current_user.center_id)
		end
		respond_to do |format|
			format.xlsx {
 							 response.headers['Content-Disposition'] = 'attachment;' "filename= Course_Student_Report\"#{Date.today}\".xlsx"
						}
		end

	end
    	
    	
    	
   

    def export_daily
    	
    	@start_date = params[:start_date]
    	
    	@end_date = params[:end_date]
    	if current_user.role == "Center"
		@results = Student.where(center_id: current_user.center_id)
		else
    	@results = Student.all
    	end
    	respond_to do |format|
				format.xlsx {
 					 response.headers['Content-Disposition'] = 'attachment;' "filename= Student_Daily_Report\"#{Date.today}\".xlsx"
							}
		end

    end
	def reference_report
		@general_setting = GeneralSetting.first
	end

	def select_employee
		@student = Student.load(params[:student_id])
		@students = @student.reference_student
	end

	def university_report
		@general_setting = GeneralSetting.first
	end

	def select_university
		@university = University.load(params[:university_id])
		@university_students = @university.students
		if current_user.role == "Center"
			@university_students = @university.students.where(center_id: current_user.center_id)
		end

		@student_count = @university.students.count
	end

	def course_report
		@general_setting = GeneralSetting.first
	end

	def select_course
		@course = Course.load(params[:course_id])
		@course_students = @course.students
		if current_user.role == "Center"
			@course_students = @course.students.where(center_id: current_user.center_id)
		end

		@student_count = @course.students.count
	end

end
