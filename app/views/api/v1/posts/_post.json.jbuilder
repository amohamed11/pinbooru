json.id post.id
json.user do
  json.id post.user.id
  json.name post.user.name
end
json.images post.images do |image|
  json.id image.id
  json.path url_for(image)
end
json.created_at post.created_at
json.updated_at post.updated_at
