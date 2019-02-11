# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Populate Semester table
Semester.destroy_all

Semester.create(semester: '2018-2019 Fall', active: false)
Semester.create(semester: '2018-2019 Spring', active: true)
Semester.create(semester: '2018-2019 Summer', active: true)
Semester.create(semester: '2019-2020 Fall', active: false)
