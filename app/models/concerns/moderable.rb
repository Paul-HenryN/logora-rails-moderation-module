module Moderable
    extend ActiveSupport::Concern

    def moderate(fields)

        unless fields.is_a?(Array)
            raise ArgumentError, "Input must be an array"
        end

        self.update(is_accepted: true)
        
        fields.each do |field|
            prediction = fetch_prediction(field)
            if prediction < 0.5
                self.update(is_accepted: false)
            end
        end

    end

    def fetch_prediction(text)
        url = "https://moderation.logora.fr/predict"
        response = Faraday.get(url, {text: text})
        data = JSON.parse(response.body)
        prediction = data["prediction"]["0"].to_f

        return prediction
    end
end