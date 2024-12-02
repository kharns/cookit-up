class CreateImageJob < ApplicationJob
  queue_as :default

  def perform(recipe)
    # Image generation prompt
    recipe_photo = client.images.generate(parameters:
                                            {
                                              prompt: "A recipe image of #{recipe.title}", size: "256x256"
                                            })
    # ATTACH RECIPE PHOTO
    photo_url = recipe_photo["data"][0]["url"]
    file = URI.parse(photo_url).open
    recipe.photo.attach(io: file, filename: "AI #{recipe.title}.jpg", content_type: 'image/jpeg')
    recipe.save
  end

  private

  def client
    @client ||= OpenAI::Client.new
  end
end
