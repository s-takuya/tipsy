require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { create(:post) }

  describe '#validates' do
    context 'with body' do
      let(:post) { build(:post, body: '#test') }
      it { expect(post).to be_valid }
    end

    context 'without body' do
      let(:post) { build(:post, body: '') }
      it { expect(post).to be_invalid }
    end

    context 'without tags' do
      let(:post) { build(:post, body: 'test') }
      it { expect(post).to be_invalid }
    end
  end

  describe '#delete_post_relation' do
    it do
      expect(post.tag_posts.count).to eq 3
      post.delete_post_relation
      expect(post.tag_posts.count).to eq 0
    end
  end

  describe '#scan_tag_names' do
    it { expect(post.scan_tag_names).to eq ['花', 'hoge', 'test'] }
    it do
      post.update_attribute(:body, '#test1 #test2 test')
      expect(post.scan_tag_names).to eq ['test1', 'test2']
    end
  end

  describe '#save_tags' do
    it { expect(post.tags.pluck(:name)).to eq ['花', 'hoge', 'test'] }
    it do
      post.update_attributes(body: '#test1 #test2 test')
      expect(post.tags.pluck(:name)).to eq ['test1', 'test2']
    end
  end
end
