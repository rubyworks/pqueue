--- 
name: pqueue
title: PQueue
contact: Trans <transfire@gmail.com>
requires: 
- group: 
  - build
  name: syckle
  version: 0+
pom_verison: 1.0.0
manifest: 
- .ruby
- lib/pqueue.rb
- test/test_pqueue.rb
- HISTORY.rdoc
- LICENSE
- README.rdoc
- VERSION
version: 1.0.0
suite: rubyworks
copyright: Copyright (c) 2001 K. Kodama
licenses: 
- LGPLv3
description: A priority queue is like a standard queue, except that each inserted elements is given a certain priority, based on the result of the comparison block given at instantiation time. Retrieving an element from the queue will always return the one with the highest priority.
summary: Queue with prioritized elements
authors: 
- K. Kodama
- Ronald Butler
- Olivier Renaud
- Rick Bradley
- Thomas Sawyer
created: 2001-03-10
