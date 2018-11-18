# Zendesk Coding Challenge 2018

This is my solution to the Zendesk Seach CLI coding challenge. It uses Ruby, as this is currently the language I'm most familiar with.

## Usage

After cloning the repo you can run `bundle install` to install dependencies. You will also need Ruby 2.5.3 installed.

From your project directory run

```
ruby 'bin/search_cli.rb'
```

and follow the prompts.

## Running Tests

To run the test suite you can run this line from the project directory:

```
  ruby test/test_all.rb
```

## Assumptions
- It's unlikely Zendesk is giving out sensitive customer data to candidates, so the `data` folder has been committed.
- We can rely on the user to specify the type of resource and the specific field they're looking for.
- We don't need to return all the data of the associated resources, just a name/subject and ID so that the user can easily find more information if they need it.
- The user may or may not be technical


## What to Expect

When you run this program you should expect to see this welcome message. The tool will also let you know it is reading your data.

![welcome message](https://user-images.githubusercontent.com/16496109/48670896-1cfee280-eb74-11e8-8a75-dca00294bcff.png)


You will then be asked which dataset you would like to search:

![resource request](https://user-images.githubusercontent.com/16496109/48670918-867ef100-eb74-11e8-9902-732e1c9d9b45.png)

Once you specify a resource and hit enter you will be shown field options based on which resource you have selected.

![field options](https://user-images.githubusercontent.com/16496109/48670925-c7770580-eb74-11e8-856f-3653eb67b043.png)

Once you select a valid field option you will be asked to input a search term:

![image](https://user-images.githubusercontent.com/16496109/48670950-33f20480-eb75-11e8-9b3b-3d17739594c5.png)

What your results look like will depened on the resource you're searching. Examples are shown below.

### Tickets

```
Name: Harper Sandoval
Signature: Don't Worry Be Happy!
Contact: schroedersandoval@flotonic.com | 9594-242-912
Organization: Bitrex
Role: admin
Id: 45
Tags: Hemlock, Stewart, Barrelville, Martinsville
Time Zone: Zaire
Url: http://initech.zendesk.com/api/v2/users/45.json
External Id: 6c1ee6e7-060b-4ceb-8729-e80cc6dcab66
Active: true
Verified: false
Shared: false
Locale: en-AU
Suspended: false
Created At: Wednesday, 27 Apr 2016 12:43 PM
Last Login At: Monday, 26 Nov 2012  3:11 AM
Assigned Tickets:
  - A Problem in Reunion | Id: 0f0868ba-518c-4e1b-b286-41e0937c4e7c
Submitted Tickets:
  - A Nuisance in Poland | Id: 31e7f6d7-f6cb-4781-b4e7-2f552941e1f5
  - A Nuisance in Macedonia | Id: 140e0cd4-c31b-4e90-833d-c42a12d4b713
```

### Users

```
Subject: A Drama in Burundi
Id: 59d803f6-a9cd-448c-a6bd-91ce9f044305
Status: open
Priority: normal
Description: Commodo aute amet eu irure sunt deserunt nulla excepteur minim tempor cupidatat do. Fugiat magna Lorem Lorem ullamco.
Submitted by: Key Mendez | Id: 59
Assigned to: Jeri Estrada | Id: 15
Organization: Comtext | Id: 117
External Id: 46d3d5d7-e6f1-4b30-94c7-06a5ee46a5a1
Url: http://initech.zendesk.com/api/v2/tickets/59d803f6-a9cd-448c-a6bd-91ce9f044305.json
Tags: Kentucky, North Carolina, South Carolina, Indiana
Due at: Sunday, 14 Aug 2016  8:05 AM
Has Incidents: true
Via: web
```

### Organizations

```
Name: Bitrex
Id: 124
Details: Non profit
Created at: Wednesday, 11 May 2016 12:16 PM
Domain Names: unisure.com, boink.com, quinex.com, poochies.com
Shared Tickets: true
Tags: Lott, Hunter, Beasley, Glass
Users:
  - Francis Rodrigüez | Id: 19
  - Russo Vincent | Id: 22
  - Jennifer Gaines | Id: 39
  - Harper Sandoval | Id: 45
  - Spence Tate | Id: 54
Tickets:
  - A Nuisance in Egypt | Id: 01731a8f-7c00-40ca-94a1-6b874abd1d17
  - A Drama in Georgia | Id: 31ec2df9-edaf-496e-b05a-ca6a75ddcc67
  - A Drama in Germany | Id: 774765fe-7123-4131-8822-e855d3cad14c
  - A Catastrophe in Sierra Leone | Id: 8ea53283-5b36-4328-9a78-f261ee90f44b
  - A Catastrophe in Central African Republic | Id: 5315f036-2bdd-4d6e-a356-fc6759c74351
  - A Catastrophe in Belize | Id: ba4feaec-47ac-483f-bc3d-2604f797e6f0
  - A Problem in Marshall Islands | Id: 9216c7b3-9a7b-40cb-8f96-56fca79520eb
  - A Catastrophe in Tuvalu | Id: 10378588-afec-443e-a0a5-6c707eb1c2e4
  - A Problem in Saint Kitts and Nevis | Id: a7b16a5c-76d9-4e60-aadc-33653b828173
  - A Catastrophe in Netherlands Antilles | Id: 7ef6cf9f-121d-41e7-832c-68d811da9379
```



