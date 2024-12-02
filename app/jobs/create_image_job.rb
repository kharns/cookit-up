require "open-uri"

class CreateImageJob < ApplicationJob
  queue_as :default

  def perform(recipe)
    # Image generation prompt
    puts "starting photo generation"
    recipe_photo = client.images.generate(parameters:
                                            {
                                              prompt: "A recipe image of #{recipe.title}", size: "256x256"
                                            })
    # ATTACH RECIPE PHOTO
    photo_url = recipe_photo["data"][0]["url"]
    p recipe_photo
    file = URI.parse(photo_url).open
    p file
    recipe.photo.attach(io: file, filename: "AI #{recipe.title}.jpg", content_type: 'image/jpeg')
    recipe.save
    puts "Terminated"

    Turbo::StreamsChannel.broadcast_update_to(
      "recipe_#{recipe.id}",
      target: "recipe_#{recipe.id}",
      partial: "recipes/recipe_card_index",
      locals: { recipe: }
    )
  end

  private

  def client
    @client ||= OpenAI::Client.new
  end
end
