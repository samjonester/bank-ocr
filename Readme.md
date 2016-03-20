# Bank OCR

http://codingdojo.org/cgi-bin/index.pl?KataBankOCR

## Goals
- Practice the following
  - Single Responsibility
  - Clean public API
  - Short simple methods
  - Clarity through temporary variables (since this involves a lot of text munging)
- Document development process
- Create talking points for discussing continuing the kata

### Install and Run
`bundle install`  
`rspec`  

## Process
1. Create first naive test for OCR parsing account line 000000000
  - Tests plumbing and defines public API
2. Create passing test for OCR parsing account line 123456789
  - Actually implement OCR parsing
3. Extract Account domain object from OCR parsing
  - OCR should know how to parse text into accounts.
  - Account should know about its validity, legibility, and presentation.
4. Implement checksum validity in Account
5. Implement legibility check in Account

## Talking points
- Importance of working from outside in to define the public API
- Separation of concerns between OCR and Account
- Running tests in VIM and feedback loops

## What's next
- Refactoring bloat and removing overuse of [].each in account_spec.rb
- Analyzing growing method signature and responsibilities of Account, and deciding whether things should be extracted out.
- Coding step 4, finding ambiguous account numbers
  - Ambiguity will most likely require a deeper coupling between account and OCR, so decide if that domain modeling is appropriate.
