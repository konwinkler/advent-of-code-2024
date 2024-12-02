# frozen_string_literal: true

require 'set'
require 'pry'
require 'pry-nav'
require 'json'
require 'matrix'

def read_file(file_name)
  File.read(file_name).split("\n")
end

def test_equals(actual, expected)
    if actual.class != expected.class
        raise "test failed due to classes not matching, actual: #{actual.class} expected: #{expected.class}" 
    end
    if actual != expected
        raise "test failed, actual: #{actual} expected: #{expected}"
    end
end

def add_distances(file_name)
    lines = read_file(file_name)
    left = []
    right = []
    lines.each do |line|
        x, y = line.split(' ')
        left << x.to_i
        right << y.to_i
    end
    left = left.sort
    right = right.sort
    distances = []
    left.each_with_index do |l, i|
        r = right[i]
        distances << (l - r).abs
    end
    sum = distances.sum
    return sum
end

test_equals add_distances('input.1.example.txt'), 11
puts add_distances('input.1.txt')

def find_occurences(arr, val)
    occurences = 0
    arr.each_with_index do |a|
        if a == val
            occurences += 1
        end
    end
    return occurences
end

def similiarity_score(file_name)
    lines = read_file(file_name)
    left = []
    right = []
    lines.each do |line|
        x, y = line.split(' ')
        left << x.to_i
        right << y.to_i
    end

    sum = 0
    left.each_with_index do |l, i|
        # find occurences of l in right
        occurences = find_occurences(right, l)
        sum += l * occurences
    end

    return sum
end

test_equals similiarity_score('input.1.example.txt'), 31
puts similiarity_score('input.1.txt')
