class UserController < ApplicationController
  skip_before_action :authenticate_request, only: [:login, :create]

  before_action :set_user, only: [:show, :update, :destroy]

  def index
    unless @current_user.admin?
      render json: { message: 'patient or doctor cannot get all users!!' }, status: 403
      return
    end
    @users = User.all
    render json: @users.map(&:new_attr), status: :ok
  end

  def create
    user_params.role = 0
    @user = User.new(user_params)
    unless @user.save
      render json: @schuser.errors, status: :unprocessable_entity
      return
    end
    render json: @user.new_attr, status: :ok
  end

  def show
    render json: @user.new_attr
  end

  def update
    unless @user.update(user_params)
      render json: @user.errors, status: :unprocessable_entity
      return
    end
    render json: @user.new_attr, status: :ok
  end

  def destroy
    if @user.id != current_user.id && !current_user.admin?
      render json: { message: 'action not allowed!!' }, status: :forbidden
      return
    end
    unless @user.destroy
      render json: @user.errors, status: :unprocessable_entity
      return
    end
    render json: @user.new_attr, status: :ok
  end

  def doctor
    @doctors = User.doctor
    render json: @doctors.map(&:doc_attr), status: :ok
  end

  def login
    @user = User.find_by(username: params[:username])
    # return render json: @user
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      render json: {
        user: @user.new_attr,
        token: token
      }
    else
      render json: { error: "Invalid username or password" }, status: :unauthorized
    end
  end

  private

  def set_user
    @user = User.find_by_id(params[:id])
    return render json: { message: 'User not found' }, status: :not_found if @user.nil?
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :name, :dob, :gender, :phone_number, :role, :department_id)
  end
end
