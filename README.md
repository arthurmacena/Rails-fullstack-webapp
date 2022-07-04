# LocalLabs-Trial-Task
The company decided that for a Minimum Viable Product (MVP), the platform needs to
offer its clients (media outlets) the means to create text content in the form of story pieces,
with basic editing and publishing capabilities

## Versions

![ruby](https://img.shields.io/badge/Ruby-3.0.1-red.svg).
![rails](https://img.shields.io/badge/Rails-6.1.3-red.svg).

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
