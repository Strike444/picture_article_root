# coding: utf-8
require 'fileutils'

# Копирую нужные файлы в папку picture_article
def copy(src, dst)
  FileUtils.cp(src, dst)
end

files = Dir.entries("/media/sf_temp")
doc_arr = Array.new
files.each do |x| 
  if x =~ /doc$/ or x=~ /jpg$/ or x=~ /Jpg$/ or x=~ /JPG$/
    puts "Работаю с файлом: " + x
    doc_arr.push(x)
    src = "/media/sf_temp/#{x}"
    dst = "/home/strike/picture_article/#{x}"
    copy(src,dst)
    FileUtils.chown 'strike', 'strike', "/home/strike/picture_article/#{x}"
  end
end

# Очищаю папку sf_temp
FileUtils.rm_r Dir.glob('/media/sf_temp/*')

# Передаю управление джаве
system ("sudo -u strike java -jar /home/strike/IdeaProjects/picture_article/out/artifacts/picture_article_jar/picture_article.jar")

puts "Java отработала"

# Копирую файды которые вадала джава в папку sf_temp
FileUtils.copy_entry("/home/strike/picture_article", "/media/sf_temp")

puts "копирование сработало"

# Подчищаю папку picture_article
FileUtils.rm_r Dir.glob('/home/strike/picture_article/*')

puts "Работа завершена."
