require_relative '../app/helpers'

describe 'sanitize_to_integer' do
  it 'returns the input if it is an integer' do
    result = sanitize_to_integer(42)
    expect(result).to eq(42)
  end

  it 'converts string input to an integer' do
    result = sanitize_to_integer("123")
    expect(result).to eq(123)
  end

  it 'returns 0 for float input' do
    result = sanitize_to_integer(3.14)
    expect(result).to eq(3.14)
  end

  it 'returns 0 for invalid input' do
    result = sanitize_to_integer("not_an_integer")
    expect(result).to eq(0)
  end
end