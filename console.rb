require('pry-byebug')
require_relative('models/bounty.rb')



bounty1 = Bounty.new({
   'name' => 'Bert',
   'bounty_value' => '100',
   'last_known_location' =>'CodeClan',
   'collected_by' => 'Arthur'
   })

bounty2 = Bounty.new({
  'name' => 'Kishan',
  'bounty_value' => '1000',
  'last_known_location' =>'The Pub',
  'collected_by' => 'Verity'
    })

binding.pry

nil
