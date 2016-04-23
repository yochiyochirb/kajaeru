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
end
