require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe '#validates' do
    context 'with unique name' do
      let(:tag) { build(:tag) }
      it { expect(tag).to be_valid }
    end

    context 'with "" name' do
      let(:tag) { build(:tag, name: '') }
      it { expect(tag).to be_invalid }
    end

    context 'without name' do
      let(:tag) { build(:tag, name: nil) }
      it { expect(tag).to be_invalid }
    end

    context 'with not unique name' do
      before { create(:tag) }
      let(:tag) { build(:tag) }
      it { expect(tag).to be_invalid }
    end
  end

  describe '#where_or_create_by_names' do
    before { create(:tag, name: '花') }

    context 'unique names' do
      before { Tag.where_or_create_by_names(%w(test1 test2 test3)) }
      it { expect(Tag.count).to eq 4 }
    end

    context 'not unique names' do
      before { Tag.where_or_create_by_names(%w(花 test2 test3)) }
      it { expect(Tag.count).to eq 3 }
    end
  end
end
