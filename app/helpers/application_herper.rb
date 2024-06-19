module ApplicationHelper
    def demo_date_field(object, method, options = {})
        # フォームのフィールド名を生成
        field_name = "#{object}[#{method}]"
        
        # 日付フィールドのHTMLを生成
        input_html = "<input type='date' name='#{field_name}'"
        input_html += " id='#{object}_#{method}'" if options[:id]
        input_html += " class='#{options[:class]}'" if options[:class]
        input_html += " />"
        
        input_html.html_safe
    end
end