"""Packaging provenance checks; not adoption or runtime enforcement."""
import json
import unittest
from pathlib import Path
ROOT = Path(__file__).resolve().parents[1]

class CandidateExportTests(unittest.TestCase):
    def test_dirty_source_not_attributed_to_historical_head(self):
        manifest = json.loads((ROOT / 'export-manifest.json').read_text())
        self.assertIsNone(manifest['sourceRevision'])
        self.assertEqual(manifest['releaseIdentity']['releaseStatus'], 'RELEASE')
        self.assertEqual(manifest['releaseIdentity'], json.loads((ROOT / 'TEMPLATE-IDENTITY.json').read_text()))
        entries = {e['path']:e for e in manifest['files']}
        for path in ['AGENTS.md', 'PROJECT-INTERNAL/GOVERNANCE/AI-INSTRUCTIONS.md',
                     'PROJECT-INTERNAL/AI/functions/work-orders.json', '.template/agent-rules.yaml',
                     'TEMPLATE-IDENTITY.json']:
            with self.subTest(path=path):
                e = entries[path]
                self.assertIsNone(e['sourceRevision'])
                self.assertTrue(e['sourceSha256'] == e['sha256'] or e.get('publicReleaseAdaptation'))
                self.assertEqual(e['sourceBaseRevision'], manifest['sourceBaseRevision'])
        self.assertEqual(json.loads((ROOT / 'PROJECT-INTERNAL/WORK-ORDERS/registry.json').read_text())['workOrders'], [])
        self.assertFalse(any('/WO-2026-' in e['path'] or '/CWO-2026-' in e['path'] for e in entries.values()))
        self.assertNotEqual(entries['README.md']['sourceSha256'], entries['README.md']['sha256'])

if __name__ == '__main__':
    unittest.main()
