gs = GeneralSetting.create!(registered_name: 'Vishwa Vidya consultancy Pvt. Ltd.')
sms = SmsSetting.create!(body: 'Dear Student, you are requested to submit the admission form along with the registration fees to confirm your admission.
Dear student, you are requested to submit documents for further process.')
email = EmailSetting.create!(body: 'Dear Students,
 
Your admission,
                     Your admission in ____________ University is confirmed and your enrolment number for the same is ___________.
 
You can check you admission on (website)
 
Regards,
Vishwa Education
7030306611')
user = User.create!(:email => 'edu@admin.in', :password => '123456789', :password_confirmation => '123456789', general_setting_id: gs.id, role: 'SuperAdmin',sms_setting_id: sms.id, email_setting_id: email.id)