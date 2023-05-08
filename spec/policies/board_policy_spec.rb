require 'rails_helper'

RSpec.describe BoardPolicy do
  
  let(:user1) { User.create(id: 1) } 
  let(:user2) { User.create(id: 2) } 
  let(:user3) { User.create(id: 3) } 
  
  
  let(:developer_role) { Role.create(name: "developer", id: 1) } 
  let(:manager_role) { Role.create(name: "manager", id: 2) } 
  let(:admin_role) { Role.create(name: "admin", id: 3) } 

  let(:board) { Board.create(title: "Board") }

  subject { described_class }
  #subject1 { described_class.new(user1, board) }
  
  before do 
    # UserRole.create(user_id: 1, role_id: 1)
    # UserRole.create(user_id: 2, role_id: 2)
    # UserRole.create(user_id: 3, role_id: 3)

    # Action.create(name: "index_board", id: 1)
    # Action.create(name: "show_board", id: 2)
    # Action.create(name: "create_board", id: 3)
    # Action.create(name: "update_board", id: 4)
    # Action.create(name: "destroy_board", id: 5)

    # AccessControl.create(role_id: 3, action_id: 1)
    # AccessControl.create(role_id: 3, action_id: 2)
    # AccessControl.create(role_id: 3, action_id: 3)
    # AccessControl.create(role_id: 3, action_id: 4)
    # AccessControl.create(role_id: 3, action_id: 5)

    # admin_role.update(user_id: user1.id)
    # manager_role.update(user_id: user2.id)
    # developer_role.update(user_id: user3.id)

    user3.roles << admin_role
    user2.roles << manager_role
    user1.roles << developer_role
  end

  # describe "#update?" do
  #   context "when user is admin" do
  #     it "grants access" do
  #       expect(subject).to receive(:has_access?).with("update_board").and_return(true)#(user3, board)
  #       subject.has_access
  #     end
  #   end
  # end

  permissions :update?, :destroy? do
    # it "denies access if user is not an admin" do
    #   puts "ROLES TEST:"
    #   puts user1.roles
    #   expect(subject).not_to permit(user1, board)
    # end

    it "grants access if user is an admin" do
      puts "UserRole ALL:"
      puts UserRole.all
      allow(user3).to receive(:roles).and_return(admin_role)
      expect(subject).to permit(user3, board)
    end

  end
end