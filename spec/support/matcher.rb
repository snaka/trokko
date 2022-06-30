# frozen_string_literal: true

RSpec::Matchers.define :be_a_file_with do |expected|
  match do |actual|
    File.read(actual).include?(expected)
  end
end
