import hashlib,json,re,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
def validate_payload_name(name):
 if Path(name).name.casefold() == 'claude.md':
  raise ValueError('provider-specific entry payload is not allowed')

def validate():
 m=json.loads((ROOT/'export-manifest.json').read_text());seen=set()
 assert sys.version_info[:3]==(3,13,14)
 assert (ROOT/'.python-version').read_text().strip()=='3.13.14'
 for e in m['files']:
  name=e['path'];validate_payload_name(name);p=Path(name)
  assert not p.is_absolute() and '..' not in p.parts and name not in seen
  seen.add(name);f=ROOT/p;assert not f.is_symlink()
  b=f.read_bytes();assert len(b)==e['size'] and hashlib.sha256(b).hexdigest()==e['sha256']
  assert not re.search(rb'/(?:Users|home)/[^\s/]+/|gh[pousr]_[A-Za-z0-9]{20,}|-----BEGIN [^-]*PRIVATE KEY',b)
 for p in ROOT.rglob('*'):
  if '.git' not in p.parts and p.is_file():validate_payload_name(p.name)
 assert 'Apache License' in (ROOT/'LICENSE').read_text()
 return len(seen)
if __name__=='__main__':print(validate())
