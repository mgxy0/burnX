require 'fileutils'
require 'open3'

def copy_file(input_file, output_file)
  unless File.exist?(input_file)
    raise "Input file does not exist."
  end
  FileUtils.cp(input_file, output_file)
rescue => e
  raise "Error copying file: #{e.message}"
end

def create_iso(source_dir, output_file)
  unless Dir.exist?(source_dir)
    raise "Source directory does not exist."
  end
  cmd = ["hdiutil", "makehybrid", "-o", output_file, source_dir, "-iso", "-joliet"]
  stdout, stderr, status = Open3.capture3(*cmd)
  raise "Error creating ISO: #{stderr}" unless status.success?
rescue => e
  raise "Error creating ISO: #{e.message}"
end

def burn_cd_dvd(device, image_file)
  unless File.exist?(image_file)
    raise "Image file does not exist."
  end
  cmd = ["hdiutil", "burn", image_file, "-device", device]
  stdout, stderr, status = Open3.capture3(*cmd)
  raise "Error burning CD/DVD: #{stderr}" unless status.success?
rescue => e
  raise "Error burning CD/DVD: #{e.message}"
end

def burn_dmg(image_file, device)
  unless File.exist?(image_file)
    raise "Image file does not exist."
  end
  cmd = ["sudo", "dd", "if=#{image_file}", "of=#{device}", "bs=1m"]
  stdout, stderr, status = Open3.capture3(*cmd)
  raise "Error burning DMG: #{stderr}" unless status.success?
rescue => e
  raise "Error burning DMG: #{e.message}"
end

def create_install_media(installer_path, volume)
  unless File.exist?(installer_path)
    raise "Installer path does not exist."
  end
  cmd = ["sudo", installer_path, "--volume", volume, "--nointeraction"]
  stdout, stderr, status = Open3.capture3(*cmd)
  raise "Error creating install media: #{stderr}" unless status.success?
rescue => e
  raise "Error creating install media: #{e.message}"
end
