require 'temporal/client/converter/base'
require 'temporal/json'

module Temporal
  module Client
    module Converter
      class Legacy < Base
        ENCODING = 'json/legacy'.freeze

        def encoding
          ENCODING
        end

        def from_payloads(payloads)
          return nil if payloads.nil?
          return *from_payload(payloads.payloads.first)
        end

        def from_payload(payload)
          Temporal::JSON.deserialize(payload.data)
        end

        def to_payloads(*data)
          Temporal::Api::Common::V1::Payloads.new(
            payloads: [to_payload(data)]
          )
        end

        def to_payload(data)
          Temporal::Api::Common::V1::Payload.new(
            metadata: { 'encoding' => ENCODING },
            data: Temporal::JSON.serialize(data).b
          )
        end
      end
    end
  end
end