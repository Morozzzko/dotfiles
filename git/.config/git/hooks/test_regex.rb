#!/usr/bin/env ruby
# frozen_string_literal: true

# regex = /((?<type>[[:alpha:]]{3,})(?<delimiter>[-\/]+))?(?<ticket>((?<source>[[:alpha:]]*)-?)\d+)\(delimiter)(?<description>.*)/

CONVENTIONAL_TYPES = [
  'build',
  'chore',
  'ci',
  'docs',
  'feat',
  'fix',
  'perf',
  'refactor',
  'revert',
  'style',
  'test'
].join('|')

REGEX_CONVENTIONAL = /^((?<type>#{CONVENTIONAL_TYPES}{3,})(?<delimiter>[-\/]+))?(?<ticket>((?<source>[[:alpha:]]*)-?)\d+)\k<delimiter>(?<description>.*)$/

REGEX_NORMAL = /^(?<ticket>((?<source>[[:alpha:]]*)-?)\d+)(?<delimiter>[-\/]+)(?<description>.*)$/

def parse_branch(branch_name)
  REGEX_CONVENTIONAL.match(branch_name) || REGEX_NORMAL.match(branch_name)
end

expectations = {
  '233-fix-this-error' => { type: nil, delimiter: '-', ticket: '233', source: '', description: 'fix-this-error' },
  '233/fix-this-error' => { type: nil, delimiter: '/', ticket: '233', source: '', description: 'fix-this-error' },
  'feat-233-fix-this-error' => { type: 'feat', delimiter: '-', ticket: '233', source: '', description: 'fix-this-error' },
  'feat/233/fix-this-error' => { type: 'feat', delimiter: '/', ticket: '233', source: '', description: 'fix-this-error' },
  'feat/mp-233/fix-this-error' => { type: 'feat', delimiter: '/', ticket: 'mp-233', source: 'mp', description: 'fix-this-error' },
  'feat-mp-233-fix-this-error' => { type: 'feat', delimiter: '-', ticket: 'mp-233', source: 'mp', description: 'fix-this-error' },
  'mp-233-fix-this-error' => { type: nil, delimiter: '-', ticket: 'mp-233', source: 'mp', description: 'fix-this-error' },
  'mp-233/fix-this-error' => { type: nil, delimiter: '/', ticket: 'mp-233', source: 'mp', description: 'fix-this-error' },
  'bmp-233/fix-this-error' => { type: nil, delimiter: '/', ticket: 'bmp-233', source: 'bmp', description: 'fix-this-error' },
  'bmp-233-fix-this-error' => { type: nil, delimiter: '-', ticket: 'bmp-233', source: 'bmp', description: 'fix-this-error' },
}


def deep_diff(a, b)
  (a.keys | b.keys).inject({}) do |diff, k|
    if a[k] != b[k]
      if a[k].respond_to?(:deep_diff) && b[k].respond_to?(:deep_diff)
        diff[k] = a[k].deep_diff(b[k])
      else
        diff[k] = [a[k], b[k]]
      end
    end
    diff
  end
end

expectations.each do |branch_name, expected|
  match = parse_branch(branch_name)

  if match
    diff = deep_diff(match.named_captures.transform_keys(&:to_sym), expected)

    puts "Doesn't match! #{branch_name}, #{diff.inspect}" unless diff.empty?
  else
    puts "Doesn't match at all! #{branch_name}"
  end
end
