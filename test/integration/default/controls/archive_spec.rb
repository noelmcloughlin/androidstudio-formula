# frozen_string_literal: true

title 'androidstudio archives profile'

control 'androidstudio binary archive' do
  impact 1.0
  title 'should be installed'

  describe file('/usr/local/android-studio-ide-3.6.2.0-linux/bin') do
    it { should exist }
  end
end
