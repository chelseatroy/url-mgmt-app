require 'rails_helper'

RSpec.describe Link, :type => :model do
  it 'should standardize target_url by removing http://' do
    link = Link.new(:slug => 'example', :target_url => 'http://example.com')
    link.standardize_target_url!

    expect(link.target_url).to eq('example.com')
  end

  it 'should standardize target_url by removing https://' do
    link = Link.new(:slug => 'example', :target_url => 'https://example.com')
    link.standardize_target_url!

    expect(link.target_url).to eq('example.com')
  end

  it 'should not alter target_url without http?://' do
    link = Link.new(:slug => 'example', :target_url => 'example.com')
    link.standardize_target_url!

    expect(link.target_url).to eq('example.com')
  end

  it 'should start a link\'s visit count at zero' do
    link = Link.new(:slug => 'example', :target_url => 'example.com')
    
    expect(link.visit_count).to eq(0)
  end

  it 'should count the number of visits to a link' do
    link = Link.new(:slug => 'example', :target_url => 'example.com')
    # visit "http://#{link.target_url}"
    5.times do
      link.visits.create
    end

    expect(link.visit_count).to eq(5)
  end
end
