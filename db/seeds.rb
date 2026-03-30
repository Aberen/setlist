# frozen_string_literal: true

puts "Clearing data..."
SetlistSongNote.destroy_all
SetlistItem.destroy_all
Setlist.destroy_all
Song.destroy_all
Invitation.destroy_all
Membership.destroy_all
Band.destroy_all
User.destroy_all

puts "Creating demo user..."
user = User.create!(email: 'demo@example.com', password: 'password123', password_confirmation: 'password123')

puts "Creating band..."
band = Band.create!(name: 'The Rocking Stones', owner: user)
Membership.create!(user: user, band: band, role: 'owner')

puts "Creating songs..."
songs = ['Gimme Shelter', 'Paint It Black', 'Sympathy for the Devil', 'Start Me Up', "Jumpin' Jack Flash", 'Wild Horses', 'Tumbling Dice', 'Brown Sugar'].map do |title|
  Song.create!(band: band, title: title)
end

puts "Creating setlist..."
setlist = Setlist.create!(band: band, name: 'World Tour 2024 - Night 1')
SetlistItem.create!(setlist: setlist, song: songs[0], item_type: 'song',    position: 1)
SetlistItem.create!(setlist: setlist, song: songs[1], item_type: 'song',    position: 2)
SetlistItem.create!(setlist: setlist, song: songs[2], item_type: 'song',    position: 3)
SetlistItem.create!(setlist: setlist, item_type: 'comment', content: '-- INTERMISSION --', position: 4)
SetlistItem.create!(setlist: setlist, song: songs[3], item_type: 'song',    position: 5)
SetlistItem.create!(setlist: setlist, song: songs[4], item_type: 'song',    position: 6)
SetlistItem.create!(setlist: setlist, item_type: 'comment', content: '-- ENCORE --', position: 7)
SetlistItem.create!(setlist: setlist, song: songs[5], item_type: 'song',    position: 8)

SetlistSongNote.create!(setlist: setlist, song: songs[0], content: 'Start slow, build to the bridge')
SetlistSongNote.create!(setlist: setlist, song: songs[2], content: 'Extended outro tonight')

puts "✅ Done! Login: demo@example.com / password123"
