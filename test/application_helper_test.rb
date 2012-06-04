# encoding: utf-8

require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  def setup
    @event = Hashie::Mash.new
  end

  test "interval helper: 22 марта 2011" do
    @event.since = "2011-03-22T00:00:00+07:00"
    @event.until = "2011-03-22T00:00:00+07:00"
    assert_equal "<span class=\"nobr\">22 марта 2011</span>", interval_for(@event)
  end

  test "interval helper: 01 июня 2011 (00:00 - 23:59)" do
    @event.since = "2011-06-01T00:00:00+07:00"
    @event.until = "2011-06-01T23:59:00+07:00"
    assert_equal "<span class=\"nobr\">01 июня 2011</span>", interval_for(@event)
  end

  test "interval helper: 22 марта 2011, 08:00" do
    @event.since = "2011-03-22T08:00:00+07:00"
    @event.until = "2011-03-22T08:00:00+07:00"
    assert_equal "<span class=\"nobr\">22 марта 2011</span>, 08:00", interval_for(@event)
  end

  test "interval helper: 22 марта 2011, 08:00 - 12:00" do
    @event.since = "2011-03-22T08:00:00+07:00"
    @event.until = "2011-03-22T12:00:00+07:00"
    assert_equal "<span class=\"nobr\">22 марта 2011</span>, 08:00 &mdash; 12:00", interval_for(@event)
  end

  test "interval helper: 22 марта 2011, 08:00 - 23 марта 2011, 08:00" do
    @event.since = "2011-03-22T08:00:00+07:00"
    @event.until = "2011-03-23T08:00:00+07:00"
    assert_equal "<span class=\"nobr\">22 марта 2011</span>, 08:00 &mdash; <span class=\"nobr\">23 марта 2011</span>, 08:00", interval_for(@event)
  end

  test "interval helper: 22 марта 2011, 08:00 - 23 марта 2011, 12:00" do
    @event.since = "2011-03-22T08:00:00+07:00"
    @event.until = "2011-03-23T12:00:00+07:00"
    assert_equal "<span class=\"nobr\">22 марта 2011</span>, 08:00 &mdash; <span class=\"nobr\">23 марта 2011</span>, 12:00", interval_for(@event)
  end

  test "interval helper: 22 марта 2011, 08:00 - 23 марта 2011" do
    @event.since = "2011-03-22T08:00:00+07:00"
    @event.until = "2011-03-23T00:00:00+07:00"
    assert_equal "<span class=\"nobr\">22 марта 2011</span>, 08:00 &mdash; <span class=\"nobr\">23 марта 2011</span>", interval_for(@event)
  end

  test "interval helper: 22 марта 2011 - 24 марта 2012" do
    @event.since = "2011-03-22T00:00:00+07:00"
    @event.until = "2011-03-24T00:00:00+07:00"
    assert_equal "<span class=\"nobr\">22 марта 2011</span> &mdash; <span class=\"nobr\">24 марта 2011</span>", interval_for(@event)
  end

  test "interval helper: 22 марта 2011 - 24 марта 2012 (with 23:59)" do
    @event.since = "2011-03-22T00:00:00+07:00"
    @event.until = "2011-03-24T23:59:00+07:00"
    assert_equal "<span class=\"nobr\">22 марта 2011</span> &mdash; <span class=\"nobr\">24 марта 2011</span>", interval_for(@event)
  end

  test "interval helper: 22 марта 2011 - 22 апреля 2011, 10:00" do
    @event.since = "2011-03-22T00:00:00+07:00"
    @event.until = "2011-04-22T10:00:00+07:00"
    assert_equal "<span class=\"nobr\">22 марта 2011</span> &mdash; <span class=\"nobr\">22 апреля 2011</span>, 10:00", interval_for(@event)
  end

  test "interval helper: 22 марта - 22 апреля, 2012 (with 23:59)" do
    @event.since = "2011-03-22T00:00:00+07:00"
    @event.until = "2011-04-22T23:59:00+07:00"
    assert_equal "<span class=\"nobr\">22 марта 2011</span> &mdash; <span class=\"nobr\">22 апреля 2011</span>", interval_for(@event)
  end

end
