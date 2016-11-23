module Recipes
  module V1
    class AddDirections < Service
      require_authen!

      def process
        authorize_record!(recipe)
        validate!
        do_transaction
        {success: true}
      end

      private
      def recipe
        @recipe ||= Recipe.find(params[:id])
      end

      def do_transaction
        ActiveRecord::Base.transaction do
          Direction.import(build_directions)
          recipe.update!(status: Recipes::Status::DONE)
        end
      end

      def build_directions
        params[:directions].reduce([]) do |result, content|
          result << recipe.directions.build(content: content)
        end
      end
    end
  end
end