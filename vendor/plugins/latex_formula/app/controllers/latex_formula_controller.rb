class LatexFormulaController < ActionController::Base

  def make_png
    if session[:user_name]
	@l = LatexFormulaToPng.new(params[:latex], params[:size], %Q=#{Rails.root}/public/user_files/#{session[:user_name]}/epics=)
	pic_name = @l.make_png
	render :text => %Q{<img src="/user_files/#{session[:user_name]}/epics/#{pic_name}" align="absmiddle" alt="#{params[:latex]}" title="#{params[:latex]}"/>}
    else
	render :text => %Q{}
    end
  end

end
