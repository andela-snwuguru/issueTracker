module Guru
  class MaterialHtml

    def self.text_field(name, label, value = '', html_options = {})
     %{
        <div class="row">
            <div class="input-field col s12">
              <input id="#{name}" name="#{name}" type="text" class="validate #{html_options['class']}" self.get_option(html_options) value="#{value}">
              <label for="#{name}">#{label}</label>
            </div>
          </div>
      }

    end

    def self.text_area(name, label, value = '', html_options = {})
     %{
        <div class="row">
            <div class="input-field col s12">
            <textarea id="#{name}" name="#{name}" class="materialize-textarea #{html_options['class']}" self.get_option(html_options)>#{value}</textarea>
              <label for="#{name}">#{label}</label>
            </div>
          </div>
      }

    end

    def self.submit(value, name = '', html_options = {})
     %{
      <div class="row">
        <div class="input-field col s12">
          <input type="submit" name="#{name}" class="btn #{html_options['class']}" value="#{value}">
        </div>
      </div>
      }

    end


    def self.get_option(html_options)
      response = '';
      html_options.each{|key,value|
        response << " #{key} = '#{value}'"
      }
      response
    end
  end
 
end