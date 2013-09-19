require 'ostruct'

desc 'Creates a non-digest version of all the digest assets'
task fix_assets: :environment do
  require 'fileutils'
  regexp = /(-{1}[a-z0-9]{32}*\.{1}){1}/

  assets = File.join(Rails.root, 'public', Chat::Application.config.assets.prefix, "**/*")
  Dir.glob(assets).each do |file|
    next if File.directory?(file)
    next unless file =~ regexp

    source = file.split('/')
    puts 'FILE ' + file
    source1 = source.last.gsub(regexp, '.')
    non_digest = File.join(source[0...-1], source1)
    puts 'non_digest' + non_digest
    File.delete(non_digest) if File.file?(non_digest)
    FileUtils.cp(file, non_digest)
  end
end
