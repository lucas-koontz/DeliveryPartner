# frozen_string_literal: true

FactoryBot.define do
  factory :partner do
    id { Faker::Internet.uuid }
    trading_name { Faker::Movies::HarryPotter.location }
    owner_name { Faker::Movies::HarryPotter.character }
    document { CNPJ.generate }
    coverage_area do
      GeoJsonHelper.decode(json:
      {
        type: 'MultiPolygon',
        coordinates: [
          [
            [
              [
                -43.36556,
                -22.99669
              ],
              [
                -43.26583,
                -23.01802
              ],
              [
                -43.33427,
                -22.96402
              ],
              [
                -43.36556,
                -22.99669
              ]
            ]
          ]
        ]
      }.to_json)
    end

    address do
      GeoJsonHelper.decode(json:
        {
          type: 'Point',
          coordinates: [
            -43.297337,
            -23.013538
          ]
        }.to_json)
    end
  end
end
