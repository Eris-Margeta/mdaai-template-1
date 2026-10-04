import hashlib,json,re,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
def validate():
 m=json.loads((ROOT/'export-manifest.json').read_text());seen=set()
 assert sys.version_info[:3]==(3,13,14)
 assert (ROOT/'.python-version').read_text().strip()=='3.13.14'
 for e in m['files']:
  name=e['path'];p=Path(name)
  assert not p.is_absolute() and '..' not in p.parts and name not in seen
  seen.add(name);f=ROOT/p;assert not f.is_symlink()
  b=f.read_bytes();assert len(b)==e['size'] and hashlib.sha256(b).hexdigest()==e['sha256']
  assert not re.search(rb'/(?:Users|home)/[^\s/]+/|gh[pousr]_[A-Za-z0-9]{20,}|-----BEGIN [^-]*PRIVATE KEY',b)
 assert 'Apache License' in (ROOT/'LICENSE').read_text()
 return len(seen)
if __name__=='__main__':print(validate())
