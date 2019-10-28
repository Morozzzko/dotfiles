function hb_tag
  docker build .
  set image_id (docker images --format "{{.ID}}" | head -n 1)
  set cwd $PWD
  docker tag $image_id hexletbasics/exercises-ruby:latest
  docker tag $image_id gcr.io/hexlet-basics/exercises-ruby
  cd ../hexlet_basics
  make app-exercises-load-ruby
  cd $cwd
end

