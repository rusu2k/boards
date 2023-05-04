require 'rails_helper'
require 'active_support'
require 'active_support/core_ext'
#require '../app/services/base_common.rb'

RSpec.describe BaseCommon do
    describe "#check_record" do
      let(:record) { double(errors: []) }
      let(:subject) { described_class.new }
      puts "here"

      context "when the record has no errors" do
        it "does not add errors to @errors" do
          expect { subject.check_record(record) }.not_to change { subject.errors }
        end
      end
      
      context "when the record has errors" do
        before { allow(record).to receive(:errors).and_return("error") }
        
        it "adds errors to @errors" do
          expect { subject.check_record(record) }.to change { subject.errors }.from([]).to(["error"])
        end
      end
    end
    
    describe "#call" do
      it "raises an error" do
        expect { described_class.new.call }.to raise_error("Must be implemented in inheriting class")
      end
    end
    
    describe "#model" do
      it "raises a NotImplementedError" do
        expect { described_class.new.model }.to raise_error(NotImplementedError, "model method must be implemented in child class")
      end
    end
    
    describe "#successful?" do
      let(:record) { double(errors: []) }
      subject { described_class.new }
      
      context "when there are no errors" do
        before { allow(subject).to receive(:errors).and_return([]) }
        
        it "returns true" do
          expect(subject.successful?).to be true
        end
      end
      
      context "when there are errors" do
        before do
          allow(subject).to receive(:errors).and_return(["error"])
          allow(record).to receive(:errors).and_return("error") 
        end
        
        it "returns false" do
          subject.check_record(record)
          expect(subject.successful?).to be false
        end
      end
    end
end