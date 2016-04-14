class SnacksController < ApplicationController

  # AM: Since you're using Angular + Rails, I would encourage you to create a separate page/route/controller-action that handles the root page.
  # AM: Having your main index serve both HTML and JSON could be problematic if the primary purpose of Rails here is to act as an API.
  # AM: Not sure yet, but I have a hunch the inability to POST in your current application might be because you are forced to include `.json` in your $resource URL.
  # AM: I'll need to play around with this some more. Let's talk about it during our group meeting on Friday.
  def index
    respond_to do |format|
      format.html
      # AM: Look into using "include:" so that you can include comments in your Snack API response. Neat trick that makes your API "MEAN"-er.
      format.json{ render json: Snack.all }
    end
  end

  def show
    @snack = Snack.find(params[:id])
    render json: @snack.to_json, status: :ok
  end

  # AM: Plz remove commented-out code from the master branch of your project submission!
  # AM: If you really want to keep it, consider keeping it in a separate branch (e.g., code-with-comments).

  # do we need this??? I think this is just in case we want a 'new' rails view --Cam
  # new page
  # def new
  #   @snack = Snack.new
  # end

  # actually makes the new thing
  def create
    @snack = Snack.create(snack_params)
    render json: @snack, status: :ok
  end

  # edit page
  def edit
    @snack = Snack.find(params[:id])
  end

  # actually updates the thing
  def update
    @snack = Snack.find(params[:id])
    @snack.update!(snack_params)
    render json: @snack, status: :ok
  end

  def destroy
    @snack = Snack.find(params[:id])
    @snack.destroy
    render json: {message: "success"}, status: :ok
  end

  private
  def snack_params
    params.require(:snack).permit(:name, :image_url, :country, :description, :mood, :taste, :nutrition_level, :seller_url, :video_url)
  end

end
