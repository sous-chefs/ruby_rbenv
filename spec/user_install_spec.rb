require 'chefspec'
require 'chefspec/berkshelf'

describe 'ruby_rbenv::user_install' do
  let(:chef_run) do
    runner = ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04').converge(described_recipe)
  end

  it 'converges successfully' do
    expect { chef_run }.to_not raise_error
  end
end
