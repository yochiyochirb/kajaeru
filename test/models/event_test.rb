require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test 'should not save without name' do
    event = Event.new
    refute event.valid?
    assert_equal [I18n.t('errors.messages.blank')], event.errors.messages[:name]
  end

  test 'should not save with non-unique name' do
    event_1 = Event.new(name: 'Crazy Sexy Event')
    assert event_1.save
    event_2 = Event.new(name: 'Crazy Sexy Event')
    refute event_2.valid?
    assert_equal [I18n.t('errors.messages.taken')], event_2.errors.messages[:name]
  end

  test 'should not save with too long name' do
    event = Event.new(name: 'a' * 256)
    refute event.valid?
    assert_equal [I18n.t('errors.messages.too_long')[:other].gsub('%{count}', '255')],
                 event.errors.messages[:name]
  end

  test 'voting_in_session? should return true if current time is in session' do
    Timecop.freeze(Time.zone.parse('2016-04-01 12:34:56'))
    event = Event.new(name: 'Crazy Sexy Event',
                      voting_starts_at: Time.zone.parse('2016-03-01 00:00:00'),
                      voting_ends_at: Time.zone.parse('2016-04-30 00:00:00'))
    assert event.voting_in_session?
    event = Event.new(name: 'Crazy Sexy Event',
                      voting_starts_at: Time.zone.parse('2016-04-01 12:34:56'),
                      voting_ends_at: Time.zone.parse('2016-04-30 00:00:00'))
    assert event.voting_in_session?
    event = Event.new(name: 'Crazy Sexy Event',
                      voting_starts_at: Time.zone.parse('2016-03-01 00:00:00'),
                      voting_ends_at: Time.zone.parse('2016-04-01 12:34:56'))
    assert event.voting_in_session?
    Timecop.return
  end

  test 'voting_in_session? should return false if current time is not in session' do
    Timecop.freeze(Time.zone.parse('2016-04-01 12:34:56'))
    event = Event.new(name: 'Crazy Sexy Event',
                      voting_starts_at: Time.zone.parse('2016-04-01 12:34:57'),
                      voting_ends_at: Time.zone.parse('2016-04-30 00:00:00'))
    refute event.voting_in_session?
    event = Event.new(name: 'Crazy Sexy Event',
                      voting_starts_at: Time.zone.parse('2016-03-01 00:00:00'),
                      voting_ends_at: Time.zone.parse('2016-04-01 12:34:55'))
    refute event.voting_in_session?
    Timecop.return
  end
end
