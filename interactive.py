
from utils.core import reduce

def run():
    v = reduce(lambda a, b: a + b, range(10), 0)
    print(f"Result {v}")
