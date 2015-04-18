Rails.application.routes.draw do

  resources :sessions
  resources :student_ui
  resources :teacher_ui

  #root :to => 'sessions#index'

  get ':controller(/:action(/:id))(.:format)'
  post ':controller(/:action(/:id(.:format)))'

  get 'index', :to => 'sessions#index'
  post 'index', :to => 'sessions#index'

  get 'login', :to => 'sessions#login'
  post 'login', :to => 'sessions#login'

  get 'login_control', :to => 'sessions#login_control'
  post 'login_control', :to => 'sessions#login_control'

  get 'signup', :to => 'sessions#signup'
  post 'signup', :to => 'sessions#signup'

  get 'signup_control', :to => 'sessions#signup_control'
  post 'signup_control', :to => 'sessions#signup_control'

  get 'login_teacher', :to => 'sessions_teacher#login_teacher'
  post 'login_teacher', :to => 'sessions_teacher#login_teacher'

  get 'login_teacher_control', :to => 'sessions_teacher#login_teacher_control'
  post 'login_teacher_control', :to => 'sessions_teacher#login_teacher_control'

  get 'signup_teacher', :to => 'sessions_teacher#signup_teacher'
  post 'signup_teacher', :to => 'sessions_teacher#signup_teacher'

  get 'signup_teacher_control', :to => 'sessions_teacher#signup_teacher_control'
  post 'signup_teacher_control', :to => 'sessions_teacher#signup_teacher_control'

  get 'logout', :to => 'sessions#logout'
  post 'logout', :to => 'sessions#logout'

  get 'logout_teacher', :to => 'sessions_teacher#logout_teacher'
  post 'logout_teacher', :to => 'sessions_teacher#logout_teacher'


  get 'Home', :to => 'student_ui#index'
  post 'Home', :to => 'student_ui#index'

  get 'MyCourses', :to => 'student_ui#my_courses'
  post 'MyCourses', :to => 'student_ui#my_courses'

  get 'AllCourses', :to => 'student_ui#all_courses'
  post 'AllCourses', :to => 'student_ui#all_courses'

  get 'MyProfile', :to => 'student_ui#my_profile'
  post 'MyProfile', :to => 'student_ui#my_profile'

  get 'EditProfile', :to => 'student_ui#edit_profile'
  post 'EditProfile', :to => 'student_ui#edit_profile'

  get 'Grades', :to => 'student_ui#grades'
  post 'Grades', :to => 'student_ui#grades'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
