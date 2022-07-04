# LocalLabs-Trial-Task
The company decided that for a Minimum Viable Product (MVP), the platform needs to
offer its clients (media outlets) the means to create text content in the form of story pieces,
with basic editing and publishing capabilities

## Versions

![ruby](https://img.shields.io/badge/Ruby-3.0.1-red.svg). <br />
![rails](https://img.shields.io/badge/Rails-6.1.3-red.svg). <br />
![nodejs](https://img.shields.io/badge/Nodejs-14.15-red.svg). <br />

## Configuration

$ bundle install <br />
$ rails db:create db:migrate <br />
$ yarn install <br />
$ rails s 

## Creating organization and users for login

$ rails c <br />
irb(main)> organization = Organization.create!(name: "nameorganization") <br />
irb(main)> User.create!(name: "username", role: 'writer', email: "useremail0@email.com", password: "123123", organization_id: organization.id, slug: organization.slug) <br />
irb(main)> User.create!(name: "username", role: 'writer', email: "useremail1@email.com", password: "123123", organization_id: organization.id, slug: organization.slug) <br />
irb(main)> User.create!(name: "username", role: 'chief_editor', email: "useremail@email.com", password: "123123", organization_id: organization.id, slug: organization.slug) <br />
irb(main)> organization.slug #get the slug for login <br />
irb(main)> exit <br />

### Notes/Constraints:
Only the Chief Editor can create stories <br />
A story must follow the allowed steps above, for instance, it cannot go from DRAFT to APPROVED without going through the steps in between <br />
A story goes automatically from UNASSIGNED to DRAFT when the Chief Editor sets the Writer; <br />
A Writer can only set the status to FOR REVIEW <br />
A Reviewer can only set the status to IN REVIEW (start review), PENDING (request changes) and APPROVED (approve story); <br />
If a story has a PENDING status, it goes automatically from PENDING to DRAFT if the writer updates the body (content). <br />
A story is opened to comments only if no content hasn’t been written yet (fresh story) or if its status is IN REVIEW, other than that the comments section is blocked. <br />
A story goes automatically from APPROVED to PUBLISHED when the Chief Editor publishes the story. <br />
