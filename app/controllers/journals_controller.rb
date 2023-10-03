class JournalsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = current_user
    @journals = @user.journals
  end

  def new
    @user = User.find(params[:user_id]) # Set @user so it's not nil
    @journal = @user.journals.new
  end

  def create
    @user = current_user
    @journal = @user.journals.new(journal_params)
    if @journal.save
      redirect_to user_journals_path(@user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @journal = @user.journals.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @journal = @user.journals.find(params[:id])
    if @journal.update(journal_params)
      redirect_to user_journal_path(@user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    user = current_user
    @journal = user.journals.find(params[:id])
    @journal.destroy
    redirect_to journals_path
  end

  private

  def journal_params
    params.require(:journal).permit(:title, :date, :content, :goals_today, :goals_tomorrow)
  end
end
