# frozen_string_literal: true

User.delete_all
user = User.create(name: 'admin',
                   email: 'admin@gmail.com',
                   password: '123456',
                   password_confirmation: '123456',
                   user_type: 'admin')
user.avatar.attach(io: File.open(Rails.root.join('app/assets/images/map-location-icon.png')),
                   filename: 'cat.jpg')

user1 = User.create(name: 'Shah',
                    email: 'buyer1@gmail.com',
                    password: '090078601',
                    password_confirmation: '090078601',
                    user_type: 'buyer')
user1.avatar.attach(io: File.open(Rails.root.join('app/assets/images/gravatar.png')),
                    filename: 'cat.jpg')

user2 = User.create(name: 'Tech',
                    email: 'buyer2@gmail.com',
                    password: '090078601',
                    password_confirmation: '090078601',
                    user_type: 'buyer')
user2.avatar.attach(io: File.open(Rails.root.join('app/assets/images/gravatar.png')),
                    filename: 'cat.jpg')
