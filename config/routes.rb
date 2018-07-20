Rails.application.routes.draw do
 
   get 'documents/new'
  get 'documents/show'

  post 'documents/create'

 

  resources :emails do
    collection do
    delete 'destroy_multiple'
  end
    member do
      get :new1
    end
  end
  resources :status_updates
  resources :subadmins
  resources :selected_courses
  resources :medical_colleges
  get 'activities/index'

  resources :budgets
  resources :colleges do
    collection do
      get :new1
      post :find_budget
    end
  end
  resources :student_details do
    member do
      post :save_test
      get :student_answer
      patch :stoptime
    end
    collection do
      get :search
      post :disp_time
    end
    resources :comments
  end
  get 'email_settings/new'

  get 'bulk_sms_settings/new'

  resources :refarences
  resources :receipts do 
    member do
    get :generate_receipt
    get :print_receipt
  end
  collection do
    get :receipt_creation
  end
  end
  resources :enquiries do 
    member do
      get :remark
      patch :update_remark
    end
  end

  resources :caste_categories
  resources :students do 
    collection do 
      get :view_all
    
    end
    member do
      get :show_student,:admission_receipt,:student_status
    end
  end
  resources :courses
  resources :course_types
  resources :unversity_attachments
  resources :universities
  resources :employees 
  

  resources :centers do
    collection do
      get :update_center
      get :center_vise_empl
      end
    member do
      get :empl
    end
  end
  devise_for :users, controllers: { registrations: 'registrations' }
  as :user do
  get '/users/sign_out' => 'devise/sessions#destroy'
end

  root 'home#dashboard'
  resources :general_settings
  
  resources :home do
    collection do 
    get :dashboard
    get :dash
    end
    member do
      get :user_activity
    end
  end

  resources :users do
     member do
      get :change_password
      patch :update_password
    end
  end

  resources :envelopes do
    collection do
      get :select
      post :create_envelopes
    end
    member do 
       get :show_envelope
     end
  end

  resources :bulk_sms_settings do
    collection do
    get :select
    end
  end 

  resources :email_settings do
    collection do
    get :select
    end
  end 

  resources :sms_settings
  resources :reports do 
    collection do 
    get :general_report, :select_center, :reference_report, :select_employee, :university_report, :select_university, :course_report, :select_course, :payment_status
    get :export_payment_status
    get :export_center
    get :export_daily
    get :export_university
    get :export_course_report
    end
  end 
  resources :questions do
  member do
    get :question
  end
end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end