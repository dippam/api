require 'rails_helper'

RSpec.describe EppiDocument, type: :model do
  describe '#volume_roman' do
    it 'converts volumes to roman numerals' do
      document = EppiDocument.new vol: 1900
      expect(document.vol_roman).to eq('MCM')

      document.vol = 1932
      expect(document.vol_roman).to eq('MCMXXXII')
    end
  end
end
