# encoding: utf-8

require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  test "interval helper: 22 марта 2012" do
    assert_equal "22 марта, <span class=\"year\">2012</span>", event_interval("2012-03-22T00:00:00+07:00", "2012-03-22T00:00:00+07:00")
  end

  test "interval helper: 01 июня 2012 (00:00 - 23:59)" do
    assert_equal "01 июня, <span class=\"year\">2012</span>", event_interval("2012-06-01T00:00:00+07:00", "2012-06-01T23:59:00+07:00")
  end

  test "interval helper: 08:00 22 марта, 2012" do
    assert_equal "08:00 22 марта, <span class=\"year\">2012</span>", event_interval("2012-03-22T08:00:00+07:00", "2012-03-22T08:00:00+07:00")
  end

  test "interval helper: 08:00 - 12:00 22 марта, 2012" do
    assert_equal "08:00 &mdash;<br /> 12:00 22 марта, <span class=\"year\">2012</span>", event_interval("2012-03-22T08:00:00+07:00", "2012-03-22T12:00:00+07:00")
  end

  test "interval helper: 08:00 22 марта - 08:00 23 марта, 2012" do
    assert_equal "08:00 22 марта &mdash;<br /> 08:00 23 марта, <span class=\"year\">2012</span>", event_interval("2012-03-22T08:00:00+07:00", "2012-03-23T08:00:00+07:00")
  end

  test "interval helper: 08:00 22 марта - 12:00 23 марта, 2012" do
    assert_equal "08:00 22 марта &mdash;<br /> 12:00 23 марта, <span class=\"year\">2012</span>", event_interval("2012-03-22T08:00:00+07:00", "2012-03-23T12:00:00+07:00")
  end

  test "interval helper: 08:00 22 марта - 23 марта, 2012" do
    assert_equal "08:00 22 марта &mdash;<br /> 23 марта, <span class=\"year\">2012</span>", event_interval("2012-03-22T08:00:00+07:00", "2012-03-23T00:00:00+07:00")
  end

  test "interval helper: 22 марта - 24 марта, 2012" do
    assert_equal "22 марта &mdash;<br /> 24 марта, <span class=\"year\">2012</span>", event_interval("2012-03-22T00:00:00+07:00", "2012-03-24T00:00:00+07:00")
  end

  test "interval helper: 22 марта - 24 марта, 2012 (with 23:59)" do
    assert_equal "22 марта &mdash;<br /> 24 марта, <span class=\"year\">2012</span>", event_interval("2012-03-22T00:00:00+07:00", "2012-03-24T23:59:00+07:00")
  end

  test "interval helper: 22 марта - 12:00 22 апреля, 2012" do
    assert_equal "22 марта &mdash;<br /> 10:00 22 апреля, <span class=\"year\">2012</span>", event_interval("2012-03-22T00:00:00+07:00", "2012-04-22T10:00:00+07:00")
  end

  test "interval helper: 22 марта - 22 апреля, 2012 (with 23:59)" do
    assert_equal "22 марта &mdash;<br /> 22 апреля, <span class=\"year\">2012</span>", event_interval("2012-03-22T00:00:00+07:00", "2012-04-22T23:59:00+07:00")
  end

end
