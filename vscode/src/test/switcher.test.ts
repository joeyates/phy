import { Switcher } from '../switcher';
import { describe, expect, it, beforeEach } from '@jest/globals';

describe('Switcher', () => {
  let path: string = 'some/path';
  let languageId: string = 'ruby';
  let switcher: Switcher;

  beforeEach(() => {
    switcher = new Switcher(languageId, path);
  });

  describe('isKnownLanguage', () => {
    describe('when the language is not known', () => {
      beforeEach(() => { languageId = 'cobol'; });

      it('is false', () => {
        expect(switcher.isKnownLanguage()).toBeFalsy();
      });
    });
  });

  describe('other', () => {
    describe('when the language is not known', () => {
      beforeEach(() => { languageId = 'cobol'; });

      it('raises an error', () => {
        expect(switcher.other()).toThrow(/Unknown/);
      });
    });

    describe('when the path is a Ruby implementation file', () => {
      beforeEach(() => { path = '/home/user/foo/my_project/lib/some/path.rb'; });

      it('returns the test path', () => {
        expect(switcher.other()).toEqual('/home/user/foo/my_project/test/some/path_spec.rb');
      });
    });

    describe('when the path is a Ruby test file', () => {
      beforeEach(() => { path = '/home/user/foo/my_project/test/some/path_spec.rb'; });

      it('returns the implementation path', () => {
        expect(switcher.other()).toEqual('/home/user/foo/my_project/lib/some/path.rb');
      });
    });
  });
});