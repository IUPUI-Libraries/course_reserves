# Seed file for course reserves semester table
Semester.destroy_all

Semester.create(semester: '2018-2019 Fall', active: false)
Semester.create(semester: '2018-2019 Spring', active: true)
Semester.create(semester: '2018-2019 Summer', active: true)
Semester.create(semester: '2019-2020 Fall', active: false)
