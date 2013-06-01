module Refinery
  module Superinquiries
    class SuperForm


      attr_accessor :id, :title, :name, :form_type, :required, :default_value


      def initialize args
        args.each do |key, value|
          instance_variable_set("@#{key}", value) unless value.nil?
        end
      end

      SUPERFORMS =
      {
        name:     self.new(id: 1, title: "Jméno a Příjmení", name: "name",     form_type: "text_field",  required: true,   default_value: ""),
        email:    self.new(id: 2, title: "E-mail",           name: "email",    form_type: "text_field",  required: true,   default_value: ""),
        phone:    self.new(id: 3, title: "Telefon",          name: "phone",    form_type: "text_field",  required: false,  default_value: ""),
        message:  self.new(id: 4, title: "Poznámka",         name: "message",  form_type: "text_area",   required: true,   default_value: ""),
        inq_type: self.new(id: 5, title: "Druh dotazu",      name: "inq_type", form_type: "select",      required: false,  default_value: ""),
        validity: self.new(id: 6, title: "Validity",         name: "validity", form_type: "hidden_field",required: false,  default_value: ""),
      }

      def self.options_for_select
        options = []
        SUPERFORMS.each do |key, value|
          options << {id: key, title: value.title , form_type: value.form_type, required: value.required  }
        end
        options
      end

    end
  end
end