# PQueue

[Source Code](https://github.com/rubyworks/pqueue) |
[Report Issue](https://github.com/rubyworks/pqueue/issues)

[![Gem Version](https://img.shields.io/gem/v/pqueue.svg?style=flat)](https://rubygems.org/gems/pqueue)
[![Build Status](https://github.com/rubyworks/pqueue/actions/workflows/test.yml/badge.svg)](https://github.com/rubyworks/pqueue/actions/workflows/test.yml)


## About

PQueue is a priority queue with array based heap.
A priority queue is like a standard queue, except that each inserted
element is given a certain priority, based on the result of the
comparison block given at instantiation time. Also, retrieving an element
from the queue will always return the one with the highest priority
(see #pop and #top).

The default is to compare the elements in respect to their #<=> method.
For example, Numeric elements with higher values will have higher
priorities.

This library is  a rewrite of the original PQueue.rb by K. Kodama and
Heap.rb by Ronald Butler. The two libraries were later merged
and generally improved by Olivier Renaud. Then the whole library 
rewritten by Trans using the original as a functional reference.


## Usage

Usage is simple enough. Think of it as an array that takes a block, where
the block decides which element of the array goes first.

    require 'pqueue'

    pq = PQueue.new([2,3,1]){ |a,b| a > b }

    pq.pop  #=> 3


## Install

Using RubyGems:

    gem install pqueue
  

## Acknowledgements

Although the library has been completely rewritten since, we still would
like to acknowledge the efforts of the original PQueue authors and
contributors.

* Olivier Renaud (2007)
* Rick Bradley (2003)
* Ronald Butler (2002)
* K Kodama (2001, original library)


## License & Copyrights

Copyright (c) 2011 Rubyworks

PQueue is distributable in accordance with the *BSD-2-Clause* license.

PQueue is based on the original PQueue library (c) 2001 by K. Kodama.

See the LICENSE.txt file for details.
