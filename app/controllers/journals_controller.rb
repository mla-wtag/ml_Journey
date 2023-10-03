class JournalsController < ApplicationController
  load_and_authorize_resource :user
  load_and_authorize_resource :journal, through: :user

  def index
    @user = current_user
  end

  def create
    @user = current_user
    if @journal.save
      redirect_to user_journals_path(@user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @user = current_user
    if @journal.update(journal_params)
      redirect_to user_journal_path(@user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = current_user
    @journal.destroy
    redirect_to user_journals_path(@user)
  end

  private

  def journal_params
    params.require(:journal).permit(:title, :date, :content, :goals_today, :goals_tomorrow)
  end
end
