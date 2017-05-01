class V1::Entities::User < Grape::Entity
  format_with(:timestamp, &:to_i)

  expose :id, documentation: { type: 'string', values: ['asjkfads89aadiof8'] }
  expose :first_name, documentation: { type: 'string', values: ['Jack'] }
  expose :last_name, documentation: { type: 'string', values: ['Shepard'] }
  expose :email, documentation: { type: 'string', values: ['jack@gmail.com'] }
  expose :birthday, documentation: { type: 'date', values: ['2000-01-01'] }
  expose :gender, documentation: { type: 'string', values: ['male'] }

  with_options(format_with: :timestamp, documentation: { type: 'integer', values: [1_493_204_586] }) do
    expose :created_at
    expose :updated_at
  end
end
