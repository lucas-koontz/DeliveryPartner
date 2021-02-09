# Delivery Partner

[![Actions Status](https://github.com/lucasfernand-es/DeliveryPartner/workflows/Docker/badge.svg)](https://github.com/lucasfernand-es/DeliveryPartner/actions)


API to search nearest partner to a location.

## Table of Contents

- [Delivery Partner](#delivery-partner)
  - [Table of Contents](#table-of-contents)
  - [Scenario](#scenario)
  - [Challenge](#challenge)
    - [1.1. Create a partner:](#11-create-a-partner)
      - [Solution](#solution)
    - [1.2. Load partner by id:](#12-load-partner-by-id)
      - [Solution](#solution-1)
    - [1.3. Search partner:](#13-search-partner)
      - [Solution](#solution-2)
    - [1.4. Technical Requirements:](#14-technical-requirements)
      - [Solution](#solution-3)
      - [Solution](#solution-4)
      - [Solution](#solution-5)
  - [Contributing](#contributing)
  - [License](#license)
  - [Code of Conduct](#code-of-conduct)
  - [TODO](#todo)


## Scenario

In Zé we thrive to find our best partner to deliver beverages to our customers, providing the best and fastest service. To achieve this our compute fleet deals with GIS objects all the time.
## Challenge

This API was developed using  _GraphQL_, thus all features (available through `queries` and `mutations`) can be accesses through `http://localhost:3000/graphql`.

Alternativaly, you can use `http://localhost:3000/graphiql` as a _GraphQL_ IDE.

Due to the fact some polygons included in `spec/fixtures/pdvs.json` fails the ring test, this project is configures [RGeo](https://github.com/rgeo/rgeo) to use lenient assertions by default. This can be changed by modifying a environment variable (`LENIENT_ASSERTIONS`).

To run this API, follow these instructions:
- Build a image:
```bash
$ docker network create local-network
$ docker-compose build
$ docker-compose run delivery-partner rake db:create db:gis:setup db:migrate
```

- Setup database
```
$ docker-compose run delivery-partner rake db:create db:gis:setup db:migrate
```

- Start container:
```bash
$ docker-compose up
```

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
   1. This project does not verify document or assume its type at this moment. (TODO)
4. The `id` must be a unique field, but not necessarily an integer;
   1. ID is a UUID by default.

#### Solution 

In order to create a new partner, you can use `createPartner` mutation.

*Example*:

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

In order to retrieve an existing partner, you can use `retrievePartner` query.

*Example*:

```graphql
query {
  retrievePartner(id: "1") {
    id
    tradingName
    ownerName
    document
    coverageArea {
      type
      coordinates
    }
    address {
      type
      coordinates
    }
  }
}
```

### 1.3. Search partner:
Given a specific location (coordinates `long` and `lat`), search the **nearest** partner **which the coverage area includes** the location.
#### Solution

In order to retrieve the nearest existing partner that its coverage area covers a location, you can use `searchNearestPartner` query.

*Example*:

```graphql
query { 
  searchNearestPartner(lat: -21.785741, long: -46.57421) {
    id
    tradingName
    ownerName
    document
    coverageArea {
      type
      coordinates
    }
    address {
      type
      coordinates
    }
  }
}
```

Our search service uses [PostGIS](https://postgis.net/) commands to use geographic functions.
- `ST_DISTANCE` to measure distance between two geographic points.
- `ST_Intersects` to verify a intersection. In this case, we use to verify if a coverage area intersects a location.

### 1.4. Technical Requirements:
* The programming language and the database engine are entirely up to you;
#### Solution
This API uses Ruby on Rails.

* Your project must be **cross-platform**;
#### Solution
`Dockerfile` and `docker-compose.yml` specifies a Docker container version for this project. This API can be used in any plataform that offers Docker.


* Provide a documentation (README.md) file explaining how to execute your service **locally** and how to deploy it (*focus on simplicity, and don't forget that we should test your service on our own, without further assistance*).
#### Solution

Instructions to run and deploy **locally**: 

First, need to build a image and setup database,
```bash
$ docker network create local-network
$ docker-compose build
$ docker-compose run delivery-partner rake db:create db:gis:setup db:migrate
```
Then, just need to start a container
```bash
$ docker-compose up
```

This application will be available in `http://localhost:3000/`.

Since this API uses _GraphQL_, its only route is `http://localhost:3000/graphql`.

Alternativaly, you can use `http://localhost:3000/graphiql` as a _GraphQL_ IDE.

Other commands:

- Linter: 
```bash
$ docker-compose run delivery-partner rubocop
```
- Tests:
```bash
$ docker-compose run delivery-partner rspec
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lucasfernand-es/deliverypartner. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/lucasfernand-es/deliverypartner/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ReviewScraper project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/deliverypartner/blob/master/CODE_OF_CONDUCT.md).


## TODO

- Define document and add validation.
- Add test scenarios.
