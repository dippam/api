# DIPPAM API

This project exposes a read-only HTTP API to existing resources and search.

It tries to follow the layout of the existing application.  Any changes from 
the existing structure should be scripted and replicable, supported by tests.

## Search

Provide search results identical to current, even though content is indexed 
and served from a different location.

Specifically:

- Pages and transcripts are not stored in a SQL database, but are gzipped 
  text files.

## Content

### Summary Documents

- [ ] Text transcripts

### EPPI

- [x] Documents
- [x] Pages

### IED

- [x] Records

### VMR

- [x] Interviews
- [ ] Tracks
