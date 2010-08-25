require 'fileutils'
require 'RMagick'	
class Admin::FilesController < Admin::BaseController
    before_filter :get_path
    before_filter :get_user_limit, :only => [:create_file, :create_file_iframe]

  def index
    get_files(:sort_by => "name")
  end

  def list
    get_files(:sort_by => params[:sort_by])
    if params[:editor]
        render :template => 'admin/files/_list', :layout => 'files'
    else
        render :partial => 'list'
    end
  end

  def create_file_iframe
    if request.post?
        create_file
        get_files(:sort_by => "ctime")
        @notice_message = t(:upload_success, :scope => [:txt, :controller, :admin, :files]) unless @error_message
    end
    render :layout => false
  end

  def create_file
    @new_file = params[:upload]
    if @new_file.nil?
        @error_message = t(:no_file, :scope => [:txt, :controller, :admin, :files])
    elsif params[:type] == "Image" && !is_img(@new_file)
        @error_message = t(:file_must_be_img, :scope => [:txt, :controller, :admin, :files])
    elsif @new_file.length > @file_size_limit.megabytes
        @error_message = t(:file_too_large, :scope => [:txt, :controller, :admin, :files], :size => @file_size_limit)
    elsif (@user.used_space.kilobytes + @new_file.length) > (@space_limit.megabytes)
        @error_message = t(:no_space, :scope => [:txt, :controller, :admin, :files])
    else
        new_file_path = File.join(@path, @new_file.original_filename)
        file_name = @new_file.original_filename
        if File.exist?(new_file_path)
            file_name = File.basename(file_name, ".*") + "_" + Time.now.strftime("%Y%m%d%H%M%S") + File.extname(file_name)
            new_file_path =  File.join(@path, file_name)
        end
        check_path(new_file_path)
        File.open(new_file_path,"wb",0664) do |fp|
          FileUtils.copy_stream(@new_file, fp)
        end
        @new_file_url = get_url_from_path(new_file_path)
        @new_file_url = @new_file_url.to_s.force_encoding('UTF-8') if RUBY_VERSION > "1.9"
        @user.dirty_space
    end
  end

  def create_dir
    @new_dir = params[:dir]
    new_dir_path = File.join(@path, @new_dir.to_s)
    if @new_dir.blank?
        @error_message = t(:no_dir_name, :scope => [:txt, :controller, :admin, :files])
    elsif File.exist?(new_dir_path)
        @error_message = t(:dir_exist, :scope => [:txt, :controller, :admin, :files])
    else
        check_path(new_dir_path)
        Dir.mkdir(new_dir_path,0775) 
        @notice_message = t(:create_dir_success, :scope => [:txt, :controller, :admin, :files])
    end
    get_files(:sort_by => "ctime")
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
  
  def is_img(new_file)
    new_file.content_type =~ /^image/
  end

  def check_path(path)
    raise "Access denied" unless File.expand_path(path).start_with?(@user.base_dir)
  end

  def get_path
    @type = params[:type] || "Image"
    @folder = params[:folder] || ""
    @name = params[:name] || ""
    @path = File.join @user.base_dir, @type, @folder, @name
    check_path(@path)
  end

  def file_info(entry, path)
    info = {}
    info[:size] = (File.size(path)/1024).to_num(1)
    info[:name] = entry
    info[:url] = get_url_from_path(path)
    info[:ctime] = File.ctime(path)
    if entry =~ /\.(jpg|gif|png|jpeg)$/i
        info[:is_pic] = true
        info[:thumbnail] = get_thumbnail(entry, path)
    end
    info
  end

  def dir_info(entry, path)
    info = {}
    info[:name] = entry
    info[:ctime] = File.ctime(path)
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

  def get_files(options={})
    @folders = []
    @files = []
    @used_space = @user.used_space/1024.0
    @precent = @used_space / @user.get_group.space.to_num(@used_space)  * 100
    Dir.mkdir(@path) unless File.exist?(@path)
    Dir.entries(@path).each do |entry|
        next if entry =~ /^\./
        path = @path + entry
        @folders.push file_info(entry, path) if FileTest.directory?(path)
        @files.push file_info(entry, path) if FileTest.file?(path)
    end
    if options[:sort_by] == "ctime"
        @sort_by = "ctime"
        @folders = @folders.sort_by {|f| f[:ctime]}.reverse
        @files = @files.sort_by {|f| f[:ctime]}.reverse
    end
  end

  def get_user_limit
    group = @user.get_group
    @file_size_limit = group.file_size_limit
    @space_limit = group.space
  end

  def get_url_from_path(path)
    path.sub(/^#{Rails.root}\/public/,'')
  end
end
