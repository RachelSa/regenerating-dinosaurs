# regenerating-dinosaurs

1. ```rails new regenerating-dinosaurs``` postgres
2. ```cd regenerating-dinosaurs```
3. echo "# regenerating-dinosaurs" >> README.md
4. git init
5. git add .
6.  git commit -m "first commit"
7. git remote add origin git@github.com:RachelSa/regenerating-dinosaurs.git
8. git push -u origin master
9. rails generate scaffold Dinosaur species:string health:integer happiness:integer radiating_positivity:integer
10. rake db:migrate
11. seed database
12. render json for all dinosaurs

////

1. create scheduler.rake file


- what is a rake task?
