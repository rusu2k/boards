require 'rails_helper'

RSpec.describe BaseUpdater do
    let(:record) { double }
    let(:params) { double }
    let(:model_class) { double(name: "TestModel") }
    subject { described_class.new }
    
    before do
      allow(subject).to receive(:model).and_return(model_class)
    end
    
    describe "#call" do
      context "when the record is blank" do
        before { allow(record).to receive(:blank?).and_return(true) }
        
        it "adds an error to @errors" do
          expect { subject.call(record, params) }.to change { subject.errors }.from([]).to(["TestModel not found"])
        end
        
        it "does not call update_model" do
          expect(subject).not_to receive(:update_model)
          subject.call(record, params)
        end
      end
      
      context "when the params are blank" do
        before { allow(params).to receive(:blank?).and_return(true) }
        
        it "adds an error to @errors" do
          expect { subject.call(record, params) }.to change { subject.errors }.from([]).to(["Update attributes missing"])
        end
        
        it "does not call update_model" do
          expect(subject).not_to receive(:update_model)
          subject.call(record, params)
        end
      end
      
      context "when there are no errors" do
        before do
          allow(record).to receive(:blank?).and_return(false)
          allow(params).to receive(:blank?).and_return(false)
        end
        
        context "when update is successful" do
          before { allow(record).to receive(:update).and_return(true) }
          
          it "calls update_model" do
            expect(subject).to receive(:update_model).with(params)
            subject.call(record, params)
          end
          
          it "returns the updated record" do
            updated_record = double
            allow(subject).to receive(:update_model).and_return(updated_record)
            expect(subject.call(record, params)).to eq(updated_record)
          end
        end
        
        context "when update fails" do
          before { allow(record).to receive(:update).and_return(false) }
          
          it "calls update_model" do
            expect(subject).to receive(:update_model).with(params)
            subject.call(record, params)
          end
          
          it "adds errors to @errors" do
            allow(record).to receive(:errors).and_return("error")
            expect { subject.call(record, params) }.to change { subject.errors }.from([]).to(["error"])
          end
          
          it "returns nil" do
            allow(record).to receive(:errors).and_return("error")
            expect(subject.call(record, params)).to be_nil
          end
        end
      end
    end
end