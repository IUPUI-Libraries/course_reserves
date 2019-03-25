require 'rails_helper'

RSpec.describe ItemsHelper, type: :helper do
  describe '#iucat_link' do
    it 'returns link if iucat record id exists for item' do
      iucat_id = 123
      item = double('item', iucat_id: iucat_id)
      expect(helper.iucat_link(item)).to eq("https://iucat.iu.edu/catalog/#{iucat_id}")
    end
    it 'returns nil if no iucat record id exists for item' do
      item = double('item', iucat_id: nil)
      expect(helper.iucat_link(item)).to eq(nil)
    end
  end
end
