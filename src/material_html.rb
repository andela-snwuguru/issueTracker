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

    def self.table(header, data, footer = [],action_buttons = {}, html_options = {})
      table = "<table class='#{html_options['class']}'>"
      table << self.get_table_header(header,action_buttons)
      table << self.get_table_data(data,action_buttons)
      table << self.get_table_footer(footer)
      table << "</table>"
    end


    def self.get_html_option(html_options)
      response = '';
      html_options.each{|key,value|
        response << " #{key} = '#{value}'"
      }
      response
    end

    def self.get_table_header(header,action_buttons)
      response = '<thead><tr>';
      header.each{|value|
        response << "<th>#{value.capitalize}</th>"
      }

      if !action_buttons.empty?
        response << '<th></th>'
      end

      response << '</tr></thead>'
    end

    def self.get_table_footer(footer)
     ''
    end

    def self.get_table_data(data,action_buttons)
      response = '<tbody>';
      
      data.each{|items|
        row = '<tr>'
        items.each{|key,value|
          if key == 'id'
            next
          end
          row << "<td>#{value}</td>"
        }
        if !action_buttons.empty?
          view_button = action_buttons['view'] ? "<a href='#{action_buttons['view']['url']}/#{items['id']}' title='View Item'><i class='material-icons'>visibility</i></a>" : ''
          update_button = action_buttons['update'] ? "<a href='#{action_buttons['update']['url']}/#{items['id']}' title='Update Item'><i class='material-icons'>input</i></a>" : ''
          delete_button = action_buttons['delete'] ? "<a href='#{action_buttons['delete']['url']}/#{items['id']}' title='Remove Item'><i class='material-icons'>delete</i></a>" : ''
          row << "<td>#{view_button} #{update_button} #{delete_button}</td>"
        end

        row << '</tr>'
        response << row
      }
      response << '</tbody>'
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