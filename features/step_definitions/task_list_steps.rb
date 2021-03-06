Given /^there is a task list called "([^\"]*)"$/ do |name|
  TaskList.find_by_name(name) || Factory(:task_list, :name => name)
end

Given /^the following task lists? with associations exists?:?$/ do |table|
  table.hashes.each do |hash|
    Factory(:task_list,
      :name => hash[:name],
      :project => Project.find_by_name(hash[:project])
    )
  end
end

Given /^the task list called "([^\"]*)" belongs to the project called "([^\"]*)"$/ do |task_list_name, project_name|
  Given %(there is a task list called "#{task_list_name}")
  Given %(there is a project called "#{project_name}")
  project = Project.find_by_name(project_name)
  TaskList.find_by_name(task_list_name).update_attribute(:project, project)
end

When /^I follow "([^\"]*)" in the "([^\"]*)" task list panel$/ do |link_text, task_list_name|
  task_list = TaskList.find_by_name(task_list_name)
  project = task_list.project
  When %(I follow "#{link_text}" within "#project_#{project.id}_task_list_#{task_list.id}_with_tasks")
end
