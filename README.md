DenBou_phone_interviewer
========================

An application built for job seekers to practice answering interview questions over the phone.  The app utlizes the Twilio API to record answers and allows users to publish recordings for comment by other users. 

Tech: Ruby on Rails, PostgreSQL, JavaScript, Angular, RSepc, Capybara 

### To get this application up and running on your machine

* fork, clone, bundle
* $ rake db:create db:migrate db:seed
* set up Twilio account
* create app on LinkedIn
* add LinkedIn API key and API secret key to .env file (see .env.example)

### link
* Staging URL - [http://phone-interviewer-staging.herokuapp.com/](http://phone-interviewer-staging.herokuapp.com/)
* Production URL - [http://phone-interview-me.herokuapp.com/](http://phone-interview-me.herokuapp.com/)
