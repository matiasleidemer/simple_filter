require 'spec_helper'

class ProductFilter < SimpleFilter::Base
  filter :active
  filter :with_name, value_param: true
  filter :date_range, bypass: true

  def date_range
    return unless params[:start_at].present?
    scope.where('start_at >= ? and end_at <= ?', params[:start_at], params[:end_at])
  end
end

describe SimpleFilter do
  def search(params = {})
    ProductFilter.new(params).scoping(Product.all).search
  end

  it 'has a version number' do
    expect(SimpleFilter::VERSION).not_to be nil
  end

  it 'filters a simple param' do
    expect(search(active: true).count).to eql 3
    expect(search.count).to eql 4
  end

  it 'filters a value param' do
    expect(search(with_name: 'pen').count).to eql 1
  end

  it 'filters a bypass param' do
    expect(search(start_at: DateTime.now - 1, end_at: DateTime.now + 5)
      .map(&:name)).to include('Notebook', 'Mouse')
  end

  it 'filters multiple params' do
    expect(search(with_name: 'pen', active: true).count).to eql 0
  end
end
