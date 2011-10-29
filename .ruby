---
source:
- meta
authors:
- name: K. Kodama
- name: Ronald Butler
- name: Olivier Renaud
- name: Rick Bradley
- name: Thomas Sawyer
  email: transfire@gmail.com
copyrights:
- holder: K. Kodama
  year: '2001'
replacements: []
alternatives: []
requirements:
- name: detroit
  groups:
  - build
  development: true
- name: microtest
  groups:
  - test
  development: true
- name: ae
  groups:
  - test
  development: true
dependencies: []
conflicts: []
repositories:
- uri: git://github.com/rubyworks/pqueue.git
  scm: git
  name: upstream
resources:
  home: http://rubyworks.github.com/pqueue
  code: http://github.com/rubyworks/pqueue
  mail: http://groups.google.com/group/rubyworks-mailinglist
  bugs: http://github.com/rubyworks/pqueue/issues
extra: {}
load_path:
- lib
revision: 0
created: '2001-03-10'
summary: Queue of Prioritized Elements
title: PQueue
version: 2.0.2
name: pqueue
description: ! 'A priority queue is like a standard queue, except that each inserted
  elements

  is given a certain priority, based on the result of the comparison block given

  at instantiation time. Retrieving an element from the queue will always return

  the one with the highest priority.'
organization: rubyworks
date: '2011-10-29'
