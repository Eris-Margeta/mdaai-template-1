"""Release-review regressions for declarative contracts, not runtime enforcement."""
import json
import unittest
from pathlib import Path
from jsonschema import Draft202012Validator
ROOT = Path(__file__).resolve().parents[1]

class ReleaseReviewTests(unittest.TestCase):
    def test_registry_active_transition_matrix(self):
        functions = json.loads((ROOT/'PROJECT-INTERNAL/AI/functions/registry.json').read_text())['functions']
        schema = next(f['parameters'] for f in functions if f['name']=='updateWorkOrderRegistry')
        validator = Draft202012Validator(schema)
        allowed = {'PENDING': {'PENDING','IN PROGRESS'}, 'IN PROGRESS': {'IN PROGRESS','BLOCKED'}, 'BLOCKED': {'BLOCKED','IN PROGRESS'}}
        for before in allowed:
            for after in ['PENDING','IN PROGRESS','BLOCKED']:
                payload = {'workOrderId':'WO-2026-001','previousStatus':before,'status':after,'updatedAt':'2026-10-05T12:00:00Z'}
                with self.subTest(before=before,after=after):
                    self.assertEqual(validator.is_valid(payload),after in allowed[before])

    def test_checkpoint_create_only(self):
        text = (ROOT/'AGENTS.md').read_text()
        self.assertIn('| CHECKPOINTS/*.md | Yes | **NO after creation** |',text)

    def test_estimate_not_actual_expenditure(self):
        text = (ROOT/'PROJECT-INTERNAL/GOVERNANCE/AI-INSTRUCTIONS.md').read_text()
        self.assertIn('optional estimate',text)
        self.assertIn('actual expenditure on closure',text)

if __name__ == '__main__':
    unittest.main()
