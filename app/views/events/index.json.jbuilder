josn.array!(@events) do |event|
  josn.extract! event, :id, :title, :description
  josn.start event.start_date
  json.end event.end_date
  json.url event_url(event, format: :html)
end