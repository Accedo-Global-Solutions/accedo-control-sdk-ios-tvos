#!/usr/bin/env ruby

require 'xcodeproj'
puts "Add Sources to Project"

project = Xcodeproj::Project.open("AccedoOneiOS/AccedoOneiOS.xcodeproj");

target = project.targets.first

sources_group_name = 'AFNetworking'
sources_group = project.groups.find do |group|
  group.name == sources_group_name
end
if (!sources_group)
  sources_group = project.new_group(sources_group_name)
end

imported_sources_count = 0;
Dir.glob("AccedoOneiOS/Libraries/AFNetworking/*.m") do |file|
  file_reference  = sources_group.files.find do |ref|
    ref.path == file
  end
  if (!file_reference)
    imported_sources_count+=1
    file_reference = sources_group.new_file(file)
  end
  target.add_file_references([file_reference])
end

Dir.glob("AccedoOneiOS/Libraries/AFNetworking/*.h") do |file|
  file_reference  = sources_group.files.find do |ref|
    ref.path == file
  end
  if (!file_reference)
    imported_sources_count+=1
    file_reference = sources_group.new_file(file)
  end
end

sources_group_name = 'PINCache'
sources_group = project.groups.find do |group|
  group.name == sources_group_name
end
if (!sources_group)
  sources_group = project.new_group(sources_group_name)
end

imported_sources_count = 0;
Dir.glob("AccedoOneiOS/Libraries/PINCache/*.m") do |file|
  file_reference  = sources_group.files.find do |ref|
    ref.path == file
  end
  if (!file_reference)
    imported_sources_count+=1
    file_reference = sources_group.new_file(file)
  end
  target.add_file_references([file_reference])
end

Dir.glob("AccedoOneiOS/Libraries/PINCache/*.h") do |file|
  file_reference  = sources_group.files.find do |ref|
    ref.path == file
  end
  if (!file_reference)
    imported_sources_count+=1
    file_reference = sources_group.new_file(file)
  end
end



sources_group_name = 'Symbols'
sources_group = project.groups.find do |group|
  group.name == sources_group_name
end
if (!sources_group)
  sources_group = project.new_group(sources_group_name)
end

imported_sources_count = 0;
Dir.glob("AccedoOneiOS/Libraries/Symbols/*.h") do |file|
  
  file_reference  = sources_group.files.find do |ref|
    ref.path == file
  end
  if (!file_reference)
    imported_sources_count+=1
    file_reference = sources_group.new_file(file)
  end
end

puts "Symbols #{imported_sources_count}"



project.save








project = Xcodeproj::Project.open("AccedoOnetvOS/AccedoOnetvOS.xcodeproj");

target = project.targets.first

sources_group_name = 'AFNetworking'
sources_group = project.groups.find do |group|
  group.name == sources_group_name
end
if (!sources_group)
  sources_group = project.new_group(sources_group_name)
end

imported_sources_count = 0;
Dir.glob("AccedoOnetvOS/Libraries/AFNetworking/*.m") do |file|
  file_reference  = sources_group.files.find do |ref|
    ref.path == file
  end
  if (!file_reference)
    imported_sources_count+=1
    file_reference = sources_group.new_file(file)
  end
  target.add_file_references([file_reference])
end

Dir.glob("AccedoOnetvOS/Libraries/AFNetworking/*.h") do |file|
  file_reference  = sources_group.files.find do |ref|
    ref.path == file
  end
  if (!file_reference)
    imported_sources_count+=1
    file_reference = sources_group.new_file(file)
  end
end

sources_group_name = 'PINCache'
sources_group = project.groups.find do |group|
  group.name == sources_group_name
end
if (!sources_group)
  sources_group = project.new_group(sources_group_name)
end

imported_sources_count = 0;
Dir.glob("AccedoOnetvOS/Libraries/PINCache/*.m") do |file|
  file_reference  = sources_group.files.find do |ref|
    ref.path == file
  end
  if (!file_reference)
    imported_sources_count+=1
    file_reference = sources_group.new_file(file)
  end
  target.add_file_references([file_reference])
end

Dir.glob("AccedoOnetvOS/Libraries/PINCache/*.h") do |file|
  file_reference  = sources_group.files.find do |ref|
    ref.path == file
  end
  if (!file_reference)
    imported_sources_count+=1
    file_reference = sources_group.new_file(file)
  end
end



sources_group_name = 'Symbols'
sources_group = project.groups.find do |group|
  group.name == sources_group_name
end
if (!sources_group)
  sources_group = project.new_group(sources_group_name)
end

imported_sources_count = 0;
Dir.glob("AccedoOnetvOS/Libraries/Symbols/*.h") do |file|
  
  file_reference  = sources_group.files.find do |ref|
    ref.path == file
  end
  if (!file_reference)
    imported_sources_count+=1
    file_reference = sources_group.new_file(file)
  end
end

puts "Symbols #{imported_sources_count}"



project.save

