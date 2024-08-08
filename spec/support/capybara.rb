# Capybaraテストフレームワークを使用した自動テスト用の新しいドライバーを登録 (system specを使用するためのコード）
Capybara.register_driver :remote_chrome do |app|
  url = "http://chrome:4444/wd/hub"
  caps = ::Selenium::WebDriver::Remote::Capabilities.chrome(
    "goog:chromeOptions" => {
      "args" => [
        "no-sandbox",
        "headless",
        "disable-gpu",
        # ディスクのメモリスペースを使用。
        'disable-dev-shm-usage',
        'remote-debugging-port=9222',
      ],
    }
  )
  Capybara::Selenium::Driver.new(app, browser: :remote, url: url, desired_capabilities: caps, timeout: 120)
end

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end
end
