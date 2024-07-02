require 'fileutils'
require 'open3'

def execute_command_for_os(command_macos, command_linux)
  if RUBY_PLATFORM =~ /darwin/
    system(command_macos)
  elsif RUBY_PLATFORM =~ /linux/
    system(command_linux)
  else
    puts "Sistema operativo non supportato."
  end
end

def copy_file(input_file, output_file)
  unless File.exist?(input_file)
    raise "Il file di input non esiste: #{input_file}"
  end
  FileUtils.cp(input_file, output_file)
  puts "File copiato con successo da #{input_file} a #{output_file}"
rescue => e
  raise "Errore durante la copia del file: #{e.message}"
end

def create_iso(source_dir, output_file)
  unless Dir.exist?(source_dir)
    raise "La directory di origine non esiste: #{source_dir}"
  end
  cmd_macos = ["hdiutil", "makehybrid", "-o", output_file, source_dir, "-iso", "-joliet"]
  cmd_linux = ["genisoimage", "-o", output_file, source_dir]
  execute_command_for_os(cmd_macos.join(" "), cmd_linux.join(" "))
  puts "ISO creato con successo: #{output_file}"
rescue => e
  raise "Errore durante la creazione dell'ISO: #{e.message}"
end

def burn_cd_dvd(device, image_file)
  unless File.exist?(image_file)
    raise "Il file immagine non esiste: #{image_file}"
  end
  cmd_macos = ["hdiutil", "burn", image_file, "-device", device]
  cmd_linux = ["wodim", "-v", "dev=#{device}", "speed=4", "-eject", "fs=8m", "padsize=63s", image_file]
  execute_command_for_os(cmd_macos.join(" "), cmd_linux.join(" "))
  puts "CD/DVD masterizzato con successo su #{device}"
rescue => e
  raise "Errore durante la masterizzazione del CD/DVD: #{e.message}"
end

def burn_dmg(image_file, device)
  unless File.exist?(image_file)
    raise "Il file immagine DMG non esiste: #{image_file}"
  end
  cmd_macos = ["sudo", "dd", "if=#{image_file}", "of=#{device}", "bs=1m"]
  cmd_linux = ["sudo", "dd", "if=#{image_file}", "of=#{device}", "bs=1M", "status=progress"]
  execute_command_for_os(cmd_macos.join(" "), cmd_linux.join(" "))
  puts "DMG masterizzato con successo su #{device}"
rescue => e
  raise "Errore durante la masterizzazione del DMG: #{e.message}"
end

def create_install_media(installer_path, volume)
  unless File.exist?(installer_path)
    raise "Il percorso dell'installer non esiste: #{installer_path}"
  end
  cmd_macos = ["sudo", installer_path, "--volume", volume, "--nointeraction"]
  cmd_linux = ["echo", "Linux non supporta questa funzione di installazione"]
  execute_command_for_os(cmd_macos.join(" "), cmd_linux.join(" "))
  puts "Media di installazione creato con successo su #{volume}"
rescue => e
  raise "Errore durante la creazione del media di installazione: #{e.message}"
end
