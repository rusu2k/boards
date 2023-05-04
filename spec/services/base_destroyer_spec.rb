require 'rails_helper'

RSpec.describe BaseDestroyer do
    let(:record) { double }
    let(:model_class) { double(name: "TestModel") }
    subject { described_class.new }

    before do
        allow(subject).to receive(:model).and_return(model_class)
    end

    describe "#call" do
        context "when the record is blank" do
            before { allow(record).to receive(:blank?).and_return(true) }

            it "adds an error to @errors" do
                expect { subject.call(record) }.to change { subject.errors }.from([]).to(["TestModel not found"])
            end

            it "does not call destroy_model" do
                expect(subject).not_to receive(:destroy_model)
                subject.call(record)
            end
        end

        context "when there are no errors" do
            before { allow(record).to receive(:blank?).and_return(false) }

            context "when destroy is successful" do
                before { allow(record).to receive(:destroy).and_return(true) }
                
                it "calls destroy_model" do
                    expect(subject).to receive(:destroy_model)
                    subject.call(record)
                end

                it "returns the destroyed record" do
                    destroyed_record = double
                    allow(subject).to receive(:destroy_model).and_return(destroyed_record)

                    expect(subject.call(record)).to eq(destroyed_record)
                end
            end


        end
    end
end