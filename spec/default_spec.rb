require 'spec_helper'

describe 'auto-patch::default' do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end
end
