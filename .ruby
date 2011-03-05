--- 
name: pqueue
spec_version: 1.0.0
title: PQueue
contact: Trans <transfire@gmail.com>
requires: 
- group: 
  - build
  name: syckle
  version: 0+
suite: rubyworks
manifest: 
- .ruby
- lib/pqueue.rb
- test/test_pqueue.rb
- HISTORY.rdoc
- LICENSE
- README.rdoc
- VERSION
version: 1.0.0
licenses: 
- LGPLv3
copyright: Copyright (c) 2001 K. Kodama
description: A priority queue is like a standard queue, except that each inserted elements is given a certain priority, based on the result of the comparison block given at instantiation time. Retrieving an element from the queue will always return the one with the highest priority.
summary: Queue with prioritized elements
authors: 
- K. Kodama
- Ronald Butler
- Olivier Renaud
- Rick Bradley
- Thomas Sawyer
created: 2001-03-10
