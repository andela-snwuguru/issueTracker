module Guru
  class MaterialHtml

    def self.input_field(type,name, label, value = '', html_options = {})
      icon = html_options['icon'] ? "<i class='material-icons prefix'>#{html_options['icon']}</i>" : ''
     %{
        <div class="row">
            <div class="input-field col s12">
              #{icon}
              <input id="#{name}" name="#{name}" type="#{type}" class="validate #{html_options['class']}" #{self.get_html_option(html_options)} value="#{value}">
              <label for="#{name}">#{label}</label>
            </div>
          </div>
      }

    end

    def self.text_area(name, label, value = '', html_options = {})
     %{
        <div class="row">
            <div class="input-field col s12">
            <textarea id="#{name}" name="#{name}" class="materialize-textarea #{html_options['class']}" #{self.get_html_option(html_options)}>#{value}</textarea>
              <label for="#{name}">#{label}</label>
            </div>
          </div>
      }

    end

    def self.select(name,label,select_options ,value = '', html_options = {})
      prompt = html_options['prompt'] ? html_options['prompt'] : 'Choose your option'
      options = self.get_select_option(select_options,value)
     %{
      <div class="input-field col s12">
        <select id="#{name}" name="#{name}" class="#{html_options['class']}" #{self.get_html_option(html_options)}>
          <option value="" disabled selected>#{prompt}</option>
          #{options}
        </select>
        <label>#{label}</label>
      </div>
      }

    end

    def self.submit(value, name = '', html_options = {})
     %{
      <div class="row">
        <div class="input-field col s12">
          <input type="submit" name="#{name}" class="btn #{html_options['class']}" value="#{value}" #{self.get_html_option(html_options)}>
        </div>
      </div>
      }

    end


    def self.get_html_option(html_options)
      response = '';
      html_options.each{|key,value|
        response << " #{key} = '#{value}'"
      }
      response
    end

    def self.get_select_option(select_options,default_value)
      response = '';
      select_options.each{|key,value|
        if(key == 'class')
          next
        end

        response << "<option value='#{key}'"
         if key == default_value
          response << ' selected'
        end
        response << "> #{value}</option>"
      }
      response
    end
  end
 
end