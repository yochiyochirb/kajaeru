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

  test 'in_session? shouls return true if current time is in session' do
    Timecop.freeze(Time.zone.parse('2016-04-01'))
    event = Event.new(name: 'Crazy Sexy Event',
                      starts_at: Time.zone.parse('2016-03-01'),
                      ends_at: Time.zone.parse('2016-04-30'))
    assert event.in_session?
    Timecop.return
  end

  test 'in_session? shouls return false if current time is not in session' do
    Timecop.freeze(Time.zone.parse('2016-04-01'))
    event = Event.new(name: 'Crazy Sexy Event',
                      starts_at: Time.zone.parse('2016-04-02'),
                      ends_at: Time.zone.parse('2016-04-30'))
    refute event.in_session?
    event = Event.new(name: 'Crazy Sexy Event',
                      starts_at: Time.zone.parse('2016-03-01'),
                      ends_at: Time.zone.parse('2016-03-31'))
    refute event.in_session?
    Timecop.return
  end
end
