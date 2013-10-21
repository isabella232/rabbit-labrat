require "spec_helper"

require "lab_rat/health_checker"


describe LabRat::HealthChecker do
  context "with valid credentials" do
    let(:credentials) do
      {
        "uri"          => "amqp://guest:guest@127.0.0.1",
        "http_api_uri" => "http://guest:guest@127.0.0.1:15672/api"
      }
    end

    it "returns check results as a map" do
      m = subject.check(credentials)

      m[:uri].should == credentials["uri"]
      m[:connection].should be_connected

      m[:queue].should_not be_nil
      m[:consumed_message_payload].should_not be_nil

      m[:connection].close
    end
  end
end