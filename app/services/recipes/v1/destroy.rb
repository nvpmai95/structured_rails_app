module Recipes
  module V1
    class Destroy < Service
      require_authen!

      def process
        recipe = Recipe.find(params[:id])
        authorize_record!(recipe)
        recipe.destroy!
        {success: true}
      end
    end
  end
end