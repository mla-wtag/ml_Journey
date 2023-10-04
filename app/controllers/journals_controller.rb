class JournalsController < ApplicationController
  load_and_authorize_resource :user
  load_and_authorize_resource :journal, through: :user

  def index
    @journals = @user.journals
  end

  def create
    @user = User.find(params[:user_id])
    if @journal.save
      redirect_to user_journals_path(@user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:user_id])
    if @journal.update(journal_params)
      redirect_to user_journal_path(@user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:user_id]) #check if i need this code line, because last time i think didn't need it
    if @journal.destroy
      flash[:alert] = t('alerts.delete_successful')
    else
      flash[:alert] = t('alerts.delete_failed')
    end
    redirect_to user_journals_path(@user)
  end

  private

  def journal_params
    params.require(:journal).permit(:title, :date, :content, :goals_today, :goals_tomorrow)
  end
end
