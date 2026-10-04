import unittest
from scripts.validate_template import validate
class TemplateTests(unittest.TestCase):
 def test_integrity(self): self.assertGreater(validate(),0)
