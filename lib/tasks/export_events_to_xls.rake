require 'spreadsheet'

desc 'Export events to xls'
task export_events_to_xls: :environment do
  Spreadsheet.client_encoding = 'UTF-8'
  book = Spreadsheet::Workbook.new
  sheet = book.create_worksheet name: 'Мероприятия дорожной карты'
  sheet.row(0).concat [
    'Наименование мероприятия',
    'Срок',
    'Статус',
    'Перевести в статус'
  ]
  bold = Spreadsheet::Format.new weight: :bold
  4.times { |x| sheet.row(0).set_format(x, bold) }

  Event.all.each_with_index do |event, index|
    sheet.row(index + 1).concat [
      event.title.squish,
      human_term(event),
      event.state_text,
      '-'
    ]
  end

  ap Rails.root.join('events.xls').to_s
  book.write Rails.root.join('events.xls').to_s
end

def human_term(event)
  if event.term_type == 'quarter'
    "#{event.quarter} #{I18n.t('time_period.quarter')} #{event.end_year}"
  elsif event.term_type == 'period' && event.start_year != event.end_year
    "#{I18n.t('time_period.annually')} (#{event.start_year} - #{event.end_year})"
  elsif event.term_type == 'period' && !event.start_year && !event.end_year
    "#{I18n.t('time_period.annually')}"
  else
    event.start_year.to_s
  end
end
