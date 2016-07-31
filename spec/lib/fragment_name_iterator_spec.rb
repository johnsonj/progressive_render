require 'spec_helper'
require 'progressive_render/fragment_name_iterator'

describe ProgressiveRender::FragmentNameIterator do
  let(:iter) { ProgressiveRender::FragmentNameIterator.new }

  it 'produces new values' do
    expect(iter.next!).to_not be iter.next!
  end

  describe 'with multiple iterators' do
    let(:iter1) { ProgressiveRender::FragmentNameIterator.new }
    let(:iter2) { ProgressiveRender::FragmentNameIterator.new }

    it 'produces equal values' do
      10.times do
        expect(iter1.next!).to eq(iter2.next!)
      end
    end
  end
end
