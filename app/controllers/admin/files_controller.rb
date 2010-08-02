require 'fileutils'
require 'RMagick'	
class Admin::FilesController < Admin::BaseController
    before_filter :get_path

  def index
	get_files
  end

  def list
	get_files
	render :partial => 'list'
  end

  def delete_file
	thumb_path = File.join(File.dirname(@path), ".thumbnail/thumb_#{@name}")
	File.delete(@path) rescue nil
	File.delete(thumb_path) if File.exist?(thumb_path) rescue nil
	@path = File.dirname(@path) + "/"
	@user.dirty_space
	list
  end

  def delete_dir
	FileUtils.rm_r(@path)
	@path = File.dirname(@path) + "/"
	@user.dirty_space
	list
  end

  private

  def get_path
	@type = params[:type] || "Image"
	@folder = params[:folder] || ""
	@name = params[:name] || ""
	@path = File.join @user.base_dir, @type, @folder, @name
	raise "Access denied" unless File.expand_path(@path).start_with?(@user.base_dir)
  end

  def file_info(entry, path)
	info = {}
	info[:size] = (File.size(path)/1024).to_num(1)
	info[:name] = entry
	info[:url] = path.sub(/^#{Rails.root}\/public/,'')
	if entry =~ /\.(jpg|gif|png|jpeg)$/i
	    info[:is_pic] = true
	    info[:thumbnail] = get_thumbnail(entry, path)
	end
	info
  end

  def get_thumbnail(entry, path)
	thumb_dir = File.join(File.dirname(path), '.thumbnail')
	Dir.mkdir(thumb_dir) unless File.exist?(thumb_dir)
	thumb_file = File.join(thumb_dir, 'thumb_'+entry)
	unless File.exist?(thumb_file)
	    img = Magick::Image.read(path).first
	    thumb = thumb_no_bigger_than(img, 150, 80)
	    thumb.write(thumb_file)	
	end
	thumb_file.sub(/^#{Rails.root}\/public/,'')

	rescue
	   return "file.png" 
  end

  def thumb_no_bigger_than(img, width, height)
      img.change_geometry("#{width}x#{height}>") do |cols, rows, img|
        img.resize(cols, rows)
      end
  end

  def get_files
	@folders = []
	@files = []
	@used_space = @user.used_space/1024.0
	@precent = @used_space / @user.get_group.space.to_num(@used_space)  * 100
	Dir.mkdir(@path) unless File.exist?(@path)
	Dir.entries(@path).each do |entry|
	    next if entry =~ /^\./
	    path = @path + entry
	    @folders.push entry if FileTest.directory?(path)
	    @files.push file_info(entry, path) if FileTest.file?(path)
	end
  end

end
