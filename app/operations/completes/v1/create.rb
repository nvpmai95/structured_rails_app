module Completes
  module V1
    class Create < Operation
      require_authen!

      def process
        authorize!(recipe, Completes::OwnerError)
        check_has_completed!
        complete = user.completes.create(recipe_id: recipe.id)
        Completes::Serializer.new(complete)
      end

      private
      def recipe
        @recipe ||= Recipe.find(params[:recipe_id])
      end

      def check_has_completed!
        complete = Complete.find_by(recipe_id: recipe.id, user_id: user.id)
        raise Completes::CompleteTwiceError if complete
      end
    end
  end
end
