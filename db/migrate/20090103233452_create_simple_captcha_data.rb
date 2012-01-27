# Copyright (c) 2008 [Sur http://expressica.com]

class CreateSimpleCaptchaData < ActiveRecord::Migration
  def up
    create_table :simple_captcha_data do |t|
      t.string :key, :limit => 40
      t.string :value, :limit => 6
      t.timestamps
    end
  end

  def down
    drop_table :simple_captcha_data
  end
end
