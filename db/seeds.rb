# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Character.create(
  {
    name: 'Alladin',
    weight: 72,
    story: 'When Aladdin is initially introduced, he is eighteen years old.
            He never received a formal education, and has only learned by living on the streets
            of Agrabah. He has to steal food in the local market in order to survive.
            He was born to Cassim and his wife. When Aladdin was only an infant, his father
            left him and his mother in order to find a better life for his family.',
    age: 18
  }
)

Character.create(
  {
    name: 'Mickey Mouse',
    weight: 'unknown',
    story: "Mickey Mouse is a cartoon character created in 1928 by The Walt Disney Company,
            who also serves as the brand's mascot. An anthropomorphic mouse who typically
            wears red shorts, large yellow shoes, and white gloves, Mickey is one of
            the world's most recognizable fictional characters.",
    age: 'unknown'
  }
)