json.posts @posts, partial: 'api/v1/posts/post', as: :post

json.pagination do
  json.count @pagy.count
  json.page @pagy.page
  json.next @pagy.next
  json.prev @pagy.prev
  json.last @pagy.last
end
