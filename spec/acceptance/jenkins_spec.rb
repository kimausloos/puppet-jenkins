require 'spec_helper_acceptance'

describe 'jenkins' do

  describe 'running puppet code' do
    it 'should work with no errors' do
      repo = <<-EOS
        include cegekarepos::cegeka
        Yum::Repo <| title == 'cegeka-custom-noarch' |>
        package { 'java-1.8.0-openjdk': ensure => installed }
      EOS
      pp = <<-EOS
        include ::jenkins
      EOS

      apply_manifest(repo)
      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe file '/data/jenkins' do
      it { is_expected.to be_directory }
    end

  end
end
