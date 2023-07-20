function current_project
  ruby -e "print Dir.pwd.gsub(/\/Users\/\w+\/projects\//, '').split('/').first"
end
