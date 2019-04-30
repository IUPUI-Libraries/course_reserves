module CoursesHelper
  include Pagy::Frontend

  def param_semester
    return '' unless params.has_key?(:q) && params[:q].has_key?(:semester_id_eq)

    params[:q][:semester_id_eq]
  end

  def param_library
    return '' unless params.has_key?(:q) && params[:q].has_key?(:library_id_eq)

    params[:q][:library_id_eq]
  end
end
