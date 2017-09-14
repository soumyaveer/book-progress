# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app.

      BookProgress is a Sinatra app to track your reading progress.
      
- [x] Use ActiveRecord for storing information in a database

      `ActiveRecord::Migration[5.1]` is used for creating migrations.
      
- [x] Include more than one model class (list of model class names e.g. User, Post, Category)
      
      Models : `Book`, `BookProgression` and `User`
      
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Posts)
     
      ```ruby
      User has_many Books through BookProgressions
      Books has_many Users through BookProgressions
      ```
- [x] Include user accounts
      
      User needs to login to his/her account in order to update progress.
      
- [x] Ensure that users can't modify content created by other users
     
      User can update only his/her progress, though viewing other's progress is allowed.
      Contains tests to ensure that user cannot modify another user's content.
      
- [x] Include user input validations
      
      Contain validations to check - 
      1. user gives a username and a password while logging in,
      2. user enters email in proper format during Signup,
      3. user does not create a blank field while creating a BookProgression
      4. the numbers entered by user is in integer format, not text format.
      
- [x] Display validation failures to user with error message (example form URL e.g. /posts/new)

      Contains flah messages for user in case of-
      1. failed Login
      2. failed Signup, 
      3. failed creation of Book in bookshelf
      4. failed update of book.
      
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code
      
      Contains LICENSE.md (MIT License)

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
