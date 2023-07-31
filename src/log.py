import contextlib
from structlog import get_logger

LOGGER = get_logger()

@contextlib.contextmanager
def logger(*args, **kwargs):
    """
    Creates a new logger and makes it avaiable to the global context as LOGGER, once the context closes the previous logger is swapped back.
    This allows code to run patterns of swapping in context and out after the function ends.

    e.g 
    with logger(var=1,var2):
        LOGGER.info("test")
    """
    global LOGGER
    old_logger = LOGGER
    LOGGER = get_logger(*args, **kwargs)
    yield LOGGER
    LOGGER = old_logger
