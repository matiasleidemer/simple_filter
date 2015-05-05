require 'spec_helper'

describe SimpleFilter do
  it 'has a version number' do
    expect(SimpleFilter::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(ProductFilter).to_not be nil
    expect(Product).to_not be nil
  end
end
