class JournalsController < ApplicationController
  load_and_authorize_resource :user
  load_and_authorize_resource :journal, through: :user

  def index
    @journals = @user.journals
  end

  def create
    if @journal.save
      redirect_to user_journals_path(@user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @journal.update(journal_params)
      redirect_to user_journal_path(@user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @journal.destroy
      flash[:alert] = t('alerts.delete_successful')
    else
      flash[:alert] = t('alerts.delete_failed')
    end
    redirect_to user_journals_path(@user)
  end

  def download
    pdf = Prawn::Document.new
    pdf.font 'Helvetica'
    pdf.text @journal.date.strftime('%Y-%m-%d'), align: :right
    pdf.text @journal.title, align: :center, size: 14, style: :bold
    pdf.font 'Helvetica', size: 12, style: :normal
    pdf.move_down 20
    pdf.text 'Content:', style: :bold
    pdf.text @journal.content
    pdf.move_down 10
    pdf.text 'Goals Today:', style: :bold
    pdf.text @journal.goals_today
    pdf.move_down 10
    pdf.text 'Goals Tomorrow:', style: :bold
    pdf.text @journal.goals_tomorrow
    filename = "#{@user.first_name}_#{@journal.title.parameterize(separator: '_')}.pdf"
    send_data(pdf.render,
              filename: filename,
              type: 'application/pdf',
              disposition: 'inline')
  end

  private

  def journal_params
    params.require(:journal).permit(:title, :date, :content, :goals_today, :goals_tomorrow)
  end
end
