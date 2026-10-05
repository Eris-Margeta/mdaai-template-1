"""Documentary/schema consistency checks, not a runtime WO enforcement engine."""
import json
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def functions(name):
    doc = json.loads((ROOT / 'PROJECT-INTERNAL/AI/functions' / name).read_text())
    return {f['name']: f for f in doc['functions']}


class LifecycleContractTests(unittest.TestCase):
    def test_open_before_work_does_not_require_finished_results(self):
        create = functions('work-orders.json')['createWorkOrder']['parameters']
        self.assertTrue({'authorization', 'objective', 'technicalSpecification',
                         'verificationSteps', 'expectedOutcome', 'status'} <= set(create['required']))
        self.assertFalse({'filesChanged', 'tests', 'verification', 'timeExpenditure'} & set(create['required']))
        self.assertEqual(create['properties']['status']['enum'], ['PENDING', 'IN PROGRESS'])
        prose = (ROOT / 'PROJECT-INTERNAL/GOVERNANCE/AI-INSTRUCTIONS.md').read_text()
        self.assertLess(prose.index('Work Order Creation Phase'), prose.index('Execution Phase'))
        self.assertIn('registered BEFORE implementation', prose)

    def test_active_update_then_close_requires_actual_evidence(self):
        fs = functions('work-orders.json')
        self.assertIn('updateWorkOrder', fs)
        update = fs['updateWorkOrder']['parameters']
        self.assertEqual(update['properties']['previousStatus']['enum'],
                         ['PENDING', 'IN PROGRESS', 'BLOCKED'])
        self.assertEqual(update['properties']['status']['enum'],
                         ['IN PROGRESS', 'BLOCKED'])
        close = fs['closeWorkOrder']['parameters']
        self.assertTrue({'filesChanged', 'verificationResults', 'acceptanceCriteria',
                         'timeActual', 'completedAt', 'elaborationReview'} <= set(close['required']))
        self.assertEqual(close['properties']['previousStatus']['enum'], ['IN PROGRESS'])
        self.assertEqual(close['properties']['verificationResults']['items']['properties']['outcome']['enum'],
                         ['PASS', 'NOT APPLICABLE'])
        self.assertEqual(close['properties']['acceptanceCriteria']['items']['properties']['satisfied']['const'], True)

    def test_terminal_correction_preserves_result_and_updates_current_status(self):
        reg = functions('registry.json')
        self.assertIn('linkCorrectiveOrder', reg)
        link = reg['linkCorrectiveOrder']['parameters']
        self.assertEqual(link['properties']['currentStatus']['enum'], ['CORRECTION REQUIRED', 'CORRECTED'])
        self.assertNotIn('status', link['properties'])
        self.assertTrue({'originalWorkOrderId', 'correctiveWorkOrderId', 'currentStatus'} <= set(link['required']))
        prose = (ROOT / 'PROJECT-INTERNAL/GOVERNANCE/WORK-ORDER-PROTOCOL.md').read_text()
        self.assertIn('terminal result is preserved', prose)
        self.assertIn('IN PROGRESS', prose)
        self.assertNotIn('Once created, a Work Order CANNOT be modified', prose)

    def test_direct_authority_and_scoped_permissions_are_consistent(self):
        for name in ['AGENTS.md', 'PROJECT-INTERNAL/AGENTS.md',
                     'PROJECT-INTERNAL/WORK-ORDERS/AGENTS.md', 'PROJECT-INTERNAL/AI/AGENTS.md',
                     'PROJECT-INTERNAL/MANAGEMENT/AGENTS.md']:
            with self.subTest(name=name):
                text = (ROOT / name).read_text()
                self.assertIn('direct explicit operator request', text)
                self.assertNotIn('IMMUTABLE after creation', text)
                self.assertNotIn('not modify existing', text)
        rules = (ROOT / '.template/agent-rules.yaml').read_text()
        self.assertNotIn('protocol_version: "2.0"', rules)
        self.assertIn('editable_active', rules)
        self.assertIn('preserved_terminal', rules)
        self.assertIn('register_before_implementation', rules)
        register = functions('registry.json')['registerWorkOrder']['parameters']['properties']['metadata']
        self.assertEqual(register['properties']['status']['enum'], ['PENDING', 'IN PROGRESS'])
        self.assertEqual(register['properties']['type']['enum'], ['standard', 'corrective', 'diagnostic'])
        self.assertIn('taskRef', register['required'])

    def test_real_authority_paths_and_independent_identity(self):
        import re
        for name in ['PROJECT-INTERNAL/GOVERNANCE/AI-INSTRUCTIONS.md',
                     'PROJECT-INTERNAL/WORK-ORDERS/work-order-template.md',
                     'PROJECT-INTERNAL/WORK-ORDERS/CORRECTIVE/corrective-work-order-template.md']:
            text = (ROOT / name).read_text()
            self.assertNotIn('PROJECT-DEVELOPMENT-ELABORATION.md', text)
            self.assertNotIn('PROJECT-INTERNAL/GUIDES/CHECKPOINT-PROTOCOL.md', text)
        pattern = functions('registry.json')['registerWorkOrder']['parameters']['properties']['metadata']['properties']['filePath']['pattern']
        for path in ['PROJECT-INTERNAL/WORK-ORDERS/WO-2026-001-example.md',
                     'PROJECT-INTERNAL/WORK-ORDERS/CORRECTIVE/CWO-2026-002-example.md',
                     'PROJECT-INTERNAL/WORK-ORDERS/DIAGNOSTIC/DWO-2026-003-example.md']:
            self.assertRegex(path, pattern)
        for path in ['../WORK-ORDERS/WO-2026-001-example.md',
                     'PROJECT-INTERNAL/WORK-ORDERS/CWO-2026-002-example.md',
                     'PROJECT-INTERNAL/WORK-ORDERS/DWO-2026-003-example.md']:
            self.assertIsNone(re.fullmatch(pattern, path))
        identity = json.loads((ROOT / 'TEMPLATE-IDENTITY.json').read_text())
        self.assertEqual(identity['templateName'], 'MDAAI 1.0')
        self.assertEqual(identity['releaseVersion'], (ROOT / 'VERSION').read_text().strip())
        self.assertEqual(identity['releaseStatus'], 'RELEASE')
        self.assertIsNone(identity['protocolVersion'])
        self.assertNotEqual(identity['releaseVersion'], identity['constitutionRevision'])
        self.assertEqual(identity['origin']['constitutionRevision'], '1.7')


if __name__ == '__main__':
    unittest.main()
