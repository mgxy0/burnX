require 'fileutils'
require 'open3'

def execute_command_for_os(command_macos, command_linux)
  if RUBY_PLATFORM =~ /darwin/
    system(command_macos)
  elsif RUBY_PLATFORM =~ /linux/
    system(command_linux)
  else
    puts "Operating system not supported."
  end
end

def copy_file(input_file, output_file)
  unless File.exist?(input_file)
    raise "Input file does not exist: #{input_file}"
  end
  FileUtils.cp(input_file, output_file)
  puts "File successfully copied from #{input_file} to #{output_file}"
rescue => e
  raise "Error during file copy: #{e.message}"
end

def create_iso(source_dir, output_file)
  unless Dir.exist?(source_dir)
    raise "Source directory does not exist: #{source_dir}"
  end
  cmd_macos = ["hdiutil", "makehybrid", "-o", output_file, source_dir, "-iso", "-joliet"]
  cmd_linux = ["genisoimage", "-o", output_file, source_dir]
  execute_command_for_os(cmd_macos.join(" "), cmd_linux.join(" "))
  puts "ISO successfully created: #{output_file}"
rescue => e
  raise "Error during ISO creation: #{e.message}"
end

def burn_cd_dvd(device, image_file)
  unless File.exist?(image_file)
    raise "Image file does not exist: #{image_file}"
  end
  cmd_macos = ["hdiutil", "burn", image_file, "-device", device]
  cmd_linux = ["wodim", "-v", "dev=#{device}", "speed=4", "-eject", "fs=8m", "padsize=63s", image_file]
  execute_command_for_os(cmd_macos.join(" "), cmd_linux.join(" "))
  puts "CD/DVD successfully burned on #{device}"
rescue => e
  raise "Error during CD/DVD burning: #{e.message}"
end

def burn_dmg(image_file, device)
  unless File.exist?(image_file)
    raise "DMG image file does not exist: #{image_file}"
  end
  cmd_macos = ["sudo", "dd", "if=#{image_file}", "of=#{device}", "bs=1m"]
  cmd_linux = ["sudo", "dd", "if=#{image_file}", "of=#{device}", "bs=1M", "status=progress"]
  execute_command_for_os(cmd_macos.join(" "), cmd_linux.join(" "))
  puts "DMG successfully burned on #{device}"
rescue => e
  raise "Error during DMG burning: #{e.message}"
end

def create_install_media(installer_path, volume)
  unless File.exist?(installer_path)
    raise "Installer path does not exist: #{installer_path}"
  end
  cmd_macos = ["sudo", installer_path, "--volume", volume, "--nointeraction"]
  cmd_linux = ["echo", "Linux does not support this installation function"]
  execute_command_for_os(cmd_macos.join(" "), cmd_linux.join(" "))
  puts "Installation media successfully created on #{volume}"
rescue => e
  raise "Error during installation media creation: #{e.message}"
end