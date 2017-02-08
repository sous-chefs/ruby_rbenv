source 'https://supermarket.chef.io'
metadata

group :integration do
  cookbook 'apt'
  cookbook 'yum'
  cookbook 'java'
  cookbook 'test', path: './test/cookbooks/test'
end

cookbook 'fixtures', path: 'test/unit/fixtures'
