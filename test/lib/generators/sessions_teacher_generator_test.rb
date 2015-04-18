require 'test_helper'
require 'generators/sessions_teacher/sessions_teacher_generator'

class SessionsTeacherGeneratorTest < Rails::Generators::TestCase
  tests SessionsTeacherGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
