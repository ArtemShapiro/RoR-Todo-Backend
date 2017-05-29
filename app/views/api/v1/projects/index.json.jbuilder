json.array! @projects do |project|
  json.id project.id
  json.name project.name

  json.tasks project.tasks, :id, :name, :done, :deadline, :priority, :project_id
end
