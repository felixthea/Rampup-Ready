# Rampup Ready
An Urban Dictionary clone for companies to create an internal dictionary, with domain- and company-specific terminology.

Once a company grows to a size where there are more email conversations than face-to-face conversations, the knowledge base becomes too dispersed that organizing that knowledge becomes overbearing.  Rampup Ready makes management of terminology that's used within your company and industry easily accessible to any employee.  Employees can also contribute to defining terms and to vote up the best definitions.  Employees can create curriculums for others, this becomes useful when preparing a new hire to hit the ground running and be rampup ready.

## Features
* Administrator can create users in bulk - sends user an email to log in
	* SendGrid API
* Add words
	* jQuery AJAX for creating words
* Add multiple definitions per word
	* Upvote/downvote definitions
	* Definitions can be tagged
* Curriculum Builder
	* jQueryUI for drag-and-drop
	* jQuery AJAX for creating curriculums
* Messaging system
	* Users can message each other and send definitions to each other
	* Pusher API to notify users when they received a message in real-time
* User and session authentication
* Search
	* User can search by words, definitions and tags
	
## Technologies
* SendGrid API
* Pusher API
* Faker and FactoryGirl for RSpec testing
* jQuery API
* jQuery AJAX
* jQuery UI
* PGSearch

## Future Todos
* Polymorphic notifications for new words, new definitions, and new curriculums
* Improved searching for curriculum builder so that words that are added to the curriculum do not reappear in a search
* Allow uploading of files for definitions
* Individual company pages