# CHANGE HISTORY

## 2.0.2 / 2011-10-29

It's been one of those days. I went to to get a wash cloth for the shower,
on my way through the kitchen realized the chilling cookie dough needed to
be put in the oven, but I forgot to put flower in the batter, so they burnt
up in minutes and made a mess that took a half-hour to clean-up. Then I discover
the shower still running, hot water was all but gone, and my bedroom felt like
a suana. To top it all off, it was at this moment I realized PQueue's binary
search algrithm didn't work. Sigh. And fuck if my grandmother won't stop making
me food I don't want to eat. Yea, one of those days!

Changes:

* Fixed #reheap search algorithm.


## 2.0.1 / 2011-10-29

Quick fix to remove old legacy library that was supposed to be 
removed in previous release. No big deal, it just confused the 
YARD documentation.

Changes:

* Remove legacy version of library.


## 2.0.0 / 2011-10-29

This is a complete rewrite to simplify the design and use more
of Ruby's internal methods.  Overall performance should be markedly
improved. A few method names have changed to be more consistent with
Ruby's other data structure. Note that the internal heap is now in reverse
order from the previous version. If using #to_a be aware that the priority
order will be reversed. This release also switches the library to 
distribution under the BSD-2-Clause license.

Changes:

* Rewrite library.
* Modernize build configuration.
* Switch to BSD-2-Clause license.


## 1.0.0 / 2009-07-05

This is the initial standalone release of PQueue, spun-off from the
Ruby Facets and originally written by K. Komada.

Changes:

* Happy New Birthday!

