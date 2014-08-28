json.array!(@tasks) do |task|
  json.extract! task, :id, :project_id_id, :title, :description
  json.url task_url(task, format: :json)
end
