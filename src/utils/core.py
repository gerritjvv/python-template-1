# Helper functions that are not worth importing a whole library for it
# or doesn't really have a good implementation out there
from collections.abc import Iterable


def first(iterable, default=None):
    """
    Get the first element or default. 
    iterable can be null or empty
    """
    if not iterable:
        return default
    
    it = iter(iterable)
    v = next(it)
    return v if v else default


def reduce(function, iterable, initializer=None):
    """
    Simple reduce
    Supports a None or empty iterable
    """
    if iterable is None:
        return initializer
    
    it = iter(iterable)
    if initializer is None:
        value = next(it)
    else:
        value = initializer
    
    for element in it:
        value = function(value, element)
    
    return value


def flatten(xs):
    """
    Lazy flatten a sequence but do not flatten dictionaries. 
    Supports xs being None
    """
    if xs is None:
        return None
    
    for x in xs:
        if isinstance(x, Iterable) and not isinstance(x, (str, bytes)) and not isinstance(x, dict):
            yield from flatten(x)
        else:
            yield x


def write_file(file, content, append=False):
    """
    Write content to a file
    """
    options = "wa" if append else "w"

    with open(file, options) as f_io:
        f_io.write(content)


def read_file(file):
    """
    Read all the contents of a text file and return
    """
    with open(file) as f_io:
        return f_io.read()
