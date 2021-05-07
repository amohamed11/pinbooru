# Pinbooru

[![test](https://github.com/amohamed11/pinbooru/actions/workflows/integration.yml/badge.svg)](https://github.com/amohamed11/pinbooru/actions/workflows/integration.yml)  

## Overview

Pinbooru is a dead-simple image board, which allows for users to create posts with multiple images attached. 
This is my submission for Shopify 2021 fall internship (backend) challenge.  
I utilized this Rails+Tailwindcss [template](https://github.com/justalever/kickoff_tailwind) by Andy Leverenz.  

## Running it locally

### Requirments

- Redis >= 4.0
- Ruby == 2.7.3

- First make sure your ruby version matches that in `.ruby-version`. And if you don't already use it, check out [rbenv](https://github.com/rbenv/rbenv), it has saved me from headaches multiple times.
- In the project root, use `bundle install` to install the gems needed.
- To get the database all setup, use `bin/rails db:setup`
- Next, install the required node modules with `yarn install`.
- Run redis in a separate terminal `redis-server`, or in daemon mode using `redis-server --daemonize yes`
- Run sidekiq in a separate terminal with `bundle exec sidekiq`
- (Optional) start webpack development server for compiling assets with `bin/webpack-dev-server`
- Finally, you can start the server with `bin/rails s`

## Technologies

- Pinbooru is built using Ruby on Rails, and utilizes the Rails' ERB templates for views with StimulusJS & Tailwind CSS to spruce it up.  
- Currently Pinbooru is deployed on **Heroku** on a hobby dyno here: [https://pinbooru.amohamed.io/](https://pinbooru.amohamed.io/)  
- For storing the images, I used Active Storage connected to an **AWS S3** bucket as its service.  
- Lastly, to handle background processes, such as generating thumbnails for uploaded images, [Sidekiq](https://github.com/mperham/sidekiq) was used.

Note-worthy Gems used:
- [devise](https://github.com/heartcombo/devise): for authentication
- [image_processing](https://github.com/janko/image_processing/): for image resizing for thumbnails
- [pagy](https://github.com/ddnexus/pagy): for pagination on index page
- [aws-sdk-s3](https://github.com/aws/aws-sdk-ruby/): for connecting to  the S3 bucket used for image storage.

## Authentication & Permisions

Pinbooru utilizes Devise for handling authentication.  
Currently a non-signed-in user can:  
- View index page with all the Posts  
- View individual Posts  
A signed-in user can above alongside:  
- Creating a new Post with 1 or more images.  
- Edit their own Posts by  
  - Updating the caption  
  - Removing individual images from a Post  
  - Add more images to a Post  
- Delete their own Posts  

## Testing

For testing, I settled with Rails' built-in testing `minitest` as it satisfies all of Pinbooru's simple needs.  
To test with actual images, there are a couple of fixture images, these can be found at `test/fixtures/files/`.  
All of the tests for the Posts can be found in `test/controllers/posts_controller_test.rb`.  
Lastly for CI, I setup a Github Actions workflow to run tests on every push before deployment (auto-deployment is setup through Heroku).

## Also an API

Out of interest, I also looked into adding an API to an existing Rails app. Since it turned out to me simple, I create an API for Posts which can be found at `app/controllers/api/v1/posts_controller.rb`. This was mostly out of pure curiosity and to learn more about Rails, so there are not separate tests for this API.