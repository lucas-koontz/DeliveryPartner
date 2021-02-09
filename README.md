# Delivery Partner

[![Actions Status](https://github.com/lucasfernand-es/DeliveryPartner/workflows/Ruby/badge.svg)](https://github.com/lucasfernand-es/DeliveryPartner/actions)

## Table of Contents
  - [Scenario](#scenario)
  - [Installation](#installation)
  - [How to Run](#how-to-run)
  - [Usage](#usage)
    - [DealerRater](#dealerrater)
  - [Examples](#examples)
  - [Test](#test)
  - [Contributing](#contributing)
  - [License](#license)
  - [Code of Conduct](#code-of-conduct)


banco de dados

rake db:create
rake db:gis:setup
rake db:migrate


Pontos ilha não permitidos

 empty polygon withing a polygon.

 pede pro usuário

# square_with_hole.valid?
# check if polygon is valid

# RGeo::Error::InvalidGeometry (LinearRing failed ring test)


 ENV VAR  LENIENT_ASSERTIONS
[
  -38.52955,
  -3.76631
],
[
  -38.53093,
  -3.76639
],
[
  -38.51856,
  -3.76537
],



ID is UUID

Document is unique

TODO 

Validar document?


RGeo::GeoJSON takes care of invalid values



## Challenge

This API was developed using  _GraphQL_, thus all features (available through `queries` and `mutations`) can be accesses through `http://localhost:3000/graphql`.


Alternativaly, you can use `http://localhost:3000/graphiql` as a _GraphQL_ IDE.

### 1.1. Create a partner:

Save in a database a partner defined by **all** the fields represented by the JSON and rules below:
```json
{
  "id": 1, 
  "tradingName": "Adega da Cerveja - Pinheiros",
  "ownerName": "Zé da Silva",
  "document": "1432132123891/0001",
  "coverageArea": { 
    "type": "MultiPolygon", 
    "coordinates": [
      [[[30, 20], [45, 40], [10, 40], [30, 20]]], 
      [[[15, 5], [40, 10], [10, 20], [5, 10], [15, 5]]]
    ]
  },
  "address": { 
    "type": "Point",
    "coordinates": [-46.57421, -21.785741]
  }
}
```

1. The `address` field follows the `GeoJSON Point` format (https://en.wikipedia.org/wiki/GeoJSON);
2. The `coverageArea` field follows the `GeoJSON MultiPolygon` format (https://en.wikipedia.org/wiki/GeoJSON);
3. The `document` must be a unique field;
4. The `id` must be a unique field, but not necessarily an integer;


#### Solution 

In order to create a new partner, you

```graphql
mutation {
  createPartner(input: {partner: {tradingName: "Adega da Cerveja - Pinheiros", ownerName: "Zé da Silva", document: "1432132123891/0001", coverageArea: {type: "MultiPolygon", coordinates: [[[[30, 20], [45, 40], [10, 40], [30, 20]]], [[[15, 5], [40, 10], [10, 20], [5, 10], [15, 5]]]]}, address: {type: "Point", coordinates: [-46.57421, -21.785741]}}}) {
    partner {
      id
      tradingName
      ownerName
      document
      address {
        type
        coordinates
      }
      coverageArea {
        type
        coordinates
      }
    }
  }
}
```


### 1.2. Load partner by id:
Return a specific partner by its `id` with all the fields presented above.
#### Solution
### 1.3. Search partner:
Given a specific location (coordinates `long` and `lat`), search the **nearest** partner **which the coverage area includes** the location.
#### Solution
### 1.4. Technical Requirements:
* The programming language and the database engine are entirely up to you;
#### Solution

* Your project must be **cross-platform**;
#### Solution

* Provide a documentation (README.md) file explaining how to execute your service **locally** and how to deploy it (*focus on simplicity, and don't forget that we should test your service on our own, without further assistance*).
#### Solution

# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
