import unittest
from scripts.validate_template import validate
class TemplateTests(unittest.TestCase):
 def test_integrity(self): self.assertGreater(validate(),0)

 def test_no_provider_entry_payload(self):
  from scripts.validate_template import validate_payload_name
  for name in ('CLAUDE.md', 'nested/claude.MD', 'nested/ClAuDe.Md'):
   with self.subTest(name=name), self.assertRaises(ValueError):
    validate_payload_name(name)
  validate_payload_name('AGENTS.md')
  validate_payload_name('docs/claude-notes.md')

 def test_listed_provider_entry_rejected_with_valid_hash(self):
  import hashlib,json,shutil,tempfile
  from pathlib import Path
  from unittest.mock import patch
  import scripts.validate_template as validator
  with tempfile.TemporaryDirectory() as d:
   root=Path(d)
   shutil.copytree(validator.ROOT, root, dirs_exist_ok=True, ignore=shutil.ignore_patterns('.git', '__pycache__'))
   payload=b'AGENTS.md is the entry point\n'
   (root/'cLaUdE.mD').write_bytes(payload)
   p=root/'export-manifest.json';m=json.loads(p.read_text())
   m['files'].append({'path':'cLaUdE.mD','sha256':hashlib.sha256(payload).hexdigest(),'size':len(payload)})
   p.write_text(json.dumps(m))
   with patch.object(validator, 'ROOT', root), self.assertRaises(ValueError):validator.validate()

 def test_unlisted_provider_entry_rejected(self):
  import shutil,tempfile
  from pathlib import Path
  from unittest.mock import patch
  import scripts.validate_template as validator
  with tempfile.TemporaryDirectory() as d:
   root=Path(d)
   shutil.copytree(validator.ROOT, root, dirs_exist_ok=True, ignore=shutil.ignore_patterns('.git', '__pycache__'))
   (root/'cLaUdE.mD').write_text('obsolete entry')
   with patch.object(validator, 'ROOT', root), self.assertRaises(ValueError):validator.validate()

 def test_theme_aware_original_logos(self):
  import json,xml.etree.ElementTree as ET
  from scripts.validate_template import ROOT
  readme=(ROOT/'README.md').read_text()
  entries={e['path']:e for e in json.loads((ROOT/'export-manifest.json').read_text())['files']}
  for color,theme,fill in [('black','light','#000'),('white','dark','#fff')]:
   path='assets/brand/logo-'+color+'.svg'
   self.assertIn('media="(prefers-color-scheme: '+theme+')" srcset="'+path+'"',readme)
   svg=ET.fromstring((ROOT/path).read_bytes())
   self.assertEqual(svg.attrib,{'viewBox':'0 0 512 512','fill':fill})
   self.assertEqual([e.tag.rsplit('}',1)[-1] for e in svg],['title','path','path'])
   self.assertIsNone(entries[path]['sourceRevision'])
   self.assertEqual(entries[path]['sourceSha256'],entries[path]['sha256'])
  self.assertIn('src="assets/brand/logo-black.svg"',readme)
