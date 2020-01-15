---
title: P2Pcollab
subtitle: protocols for peer-to-peer collaboration
image: img/cover.png
lang: en-GB
---

# About

This project is an effort towards
 creating decentralized, privacy-preserving, asynchronous
  peer-to-peer collaboration protocols
 that allow us ownership and control over our data,
 and enable us to publish and subscribe to content
 and collaborate with others
  without censorship and opaque algorithmic bias,
 as well as to disseminate and discover relevant content
  using decentralized collaborative filtering techniques,
 while allowing offline search of all subscribed and discovered content.

We aim to shift the paradigm
 from centralized services providing limited access to locked-up data silos
 to open, decentralized protocols allowing full access to data stores
 that facilitate collaboration, offline search and backup.

This is realized through the research and development of peer-to-peer network protocols
and their implementation as composable libraries and lightweight [uni­kernels](#unikernels).

# Design principles

We design networks & systems that empower & respect users,
and ensure sustainability of hardware, software, and human resources.

Minimalism
:   Minimize hardware resources and software dependencies
    to reduce complexity and trusted computing base of systems
    while increasing their security, robustness, and scalability.

Composability
:   Design software as composable and reusable libraries, sans I/O[^sans-io].

Self-*
:   Self-organization, self-optimization, self-repair
    of networks and systems.

Data ownership
:   Users should have full access to, and control over their own
    data and should be able to determine with whom they share it with.

Privacy
:   Protocols should respect user privacy and minimize the amount of
    information shared about users, the bare minimum that is
    required for them to function.

End-to-end security
:   Only the intended recipients should be able to read any piece of
    content stored or transmitted in the network,
    intermediaries may facilitate communication
    only by storing & forwarding encrypted data.

Offline first
:   Reading, editing, and searching previously accessed content
    should be possible offline.

[^sans-io]:
    Implementing network protocols
    without assumptions on I/O, transport, or wire format
    enable reusability of these components.
    For more details see [Writing I/O-Free (Sans-I/O) Protocol Implementations](https://sans-io.readthedocs.io/).

# Architecture

## Unikernels

[Unikernels](http://unikernel.org/) are specialized, single-address-space 
machine images constructed by library operating systems. Reducing attack 
surface by [Principle of least privilege](https://en.wikipedia.org/wiki/Principle_of_least_privilege).
They can be run as virtual machines on a hypervisor, or as sandboxed processes.

In addition to the security benefits, their design aligns well with our
[design principles](#design-principles) of *Minimalism*, and *Composability*,
altogether making them well-suited for constructing self-organized P2P systems.

### Related software

 - [Solo5](https://github.com/Solo5/solo5)
   is a sandboxed execution environment for unikernels.
 - [MirageOS](https://mirage.io/)
   is a library operating system that constructs unikernels
   using the [OCaml](https://ocaml.org/) language.
 - [Irmin](https://github.com/mirage/irmin)
   is a distributed mergeable data structure store
   built on the same principles as Git.

## P2P network

A two-tier P2P architecture combines a stable core network
with intermittently connected edge networks.

Core network
:   Stable, always-on nodes in data centres and homes
    interact using P2P protocols among each other,
    and also act as proxies for end-user devices.

Edge networks
:   End-user devices with limited resources interact with each other directly on the local network,
    whereas with remote nodes indirectly via proxies in the core network.

A proxy acts on behalf of a user in the P2P core network.
It collects subscriptions and facilitates publishing,
search, and discovery of content.
One may use multiple proxies for redundancy and separating identities.

Setting up a proxy is a matter of running a unikernel
with access to network and storage.
One may set up their own, or obtain access to one from a
community or commercial provider.

## Data stores

The most important building blocks of our decentralized collaboration protocol
are mergeable data structures stored in replicated data repositories[^mpds].
A publish-subscribe protocol takes care of replication of subscribed content,
while [Conflict-free replicated data types](https://en.wikipedia.org/wiki/Conflict-free_replicated_data_type) (CRDT)
enable conflict-free merges on these data structures.
Applications render content from these data repositories and perform
operations on them.

[^mpds]:
    See the paper
    [Mergeable persistent data structures](https://hal.inria.fr/hal-01099136).

## Search & discovery

TODO

# Modules

The following modules are a curated list of protocols,
which, when combined, result in a protocol suite that facilitates
P2P collaboration according to our [vision](#about) and [design principles](#design-principles).

## P2P gossip-based protocols

PolderCast
:   P2P topic-based pub/sub
    ([paper](https://hal.inria.fr/hal-01555561),
    [code](https://github.com/p2pcollab/ocaml-p2p)) \
    Privacy enhancements:
    instead of transmitting node profiles
    with full subscription sets in the clear,
    randomized Bloom filters using BLIP are employed
    together with a Bloom filter-based Private Set
    Intersection (BFPSI) protocol

RingCast
:   P2P hybrid dissemination
    ([paper](https://www.distributed-systems.net/my-data/papers/2007.mw.pdf),
     [code](https://github.com/p2pcollab/ocaml-p2p))

VICINITY
:   P2P clustering & topology management
    ([paper](https://hal.inria.fr/hal-01480790/document),
     [code](https://github.com/p2pcollab/ocaml-p2p))

CYCLON
:   Random Peer Sampling
    ([paper](https://www.distributed-systems.net/my-data/papers/2005.jnsm.pdf),
     [code](https://github.com/p2pcollab/ocaml-p2p)) \
    To ensure uniformity of peer sampling, URPS is used together with
    CYCLON.

## P2P data structures

URPS
:   Uniform Random Peer Sampler
    ([paper](https://hal.archives-ouvertes.fr/hal-00804430),
     [code](https://github.com/p2pcollab/ocaml-urps))

BLIP
:   Non-interactive differentially-private similarity computation on
    Bloom filters
    ([paper](https://scholar.google.com/scholar?cluster=16665581281970888&hl=en),
     [slides](https://malaggan.com/AGK2012.pdf),
     [code](https://github.com/p2pcollab/ocaml-blip))

BFPSI
:   Private Set Intersection based on Bloom filters
    ([paper](https://eprint.iacr.org/2013/620),
     [code](https://github.com/p2pcollab/ocaml-psi))

## Transport

NoiseSocket
:   Encoding layer for the Noise Protocol Framework
    ([spec](https://noisesocket.org/spec/noisesocket/),
     [code](https://github.com/p2pcollab/ocaml-noise-socket))

# Further reading

- [Source code](https://github.com/p2pcollab)
- [OCaml package documentation](https://p2pcollab.net/doc/ocaml/)
- [Cover image](https://tg-x.net/lsys/#?i=30&r=L%20%3A%20S%0AS%20%3A%20F%2B%5BF-Y%5BS%5D%5DF%29G%0AY%20%3A--%5B%7CF-F-%29-F%3EY%5D-%0AG%3A%20FGF%5B%2BF%5D%2B%3CY&p.size=11,0&p.angle=54.891,2.072051145&offsets=0,0,0&s.size=8.6,6.7&s.angle=7.6,4&play=0&anim=return%20%7B%0A%20angle%3A%20t%2F100%2C%0A%20angleG%3A%20t%2F1000%2C%0A%20size%3A%20null%2C%0A%20sizeG%3A%20null%2C%0A%20offsetX%3A%20null%2C%0A%20offsetY%3A%20null%2C%0A%20rotation%3A%20null%0A%20%7D&name=dream%20catcher)
