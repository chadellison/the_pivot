require 'spec_helper'

module FeatureHelper

  def drop_in_dropzone(file_path)
    page.execute_script <<-JS
      fakeFileInput = window.$('<input/>').attr(
        {id: 'fakeFileInput', type:'file'}
      ).appendTo('body');
    JS

    attach_file("fakeFileInput", file_path)

    page.execute_script("var FileList = [fakeFileInput.get(0).files[0]]")

    within '.upload' do
      page.execute_script <<-JS
        var e = jQuery.Event('drop', { dataTransfer : { files : [fakeFileInput.get(0).files[0]] } });
        $('.dropzone')[0].dropzone.listeners[0].events.drop(e);
      JS
    end

  end

end
