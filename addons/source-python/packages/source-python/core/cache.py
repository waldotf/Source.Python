# ../core/cache.py

"""Provides caching functionality."""

# =============================================================================
# >> IMPORTS
# =============================================================================
# Python Imports
#   FuncTools
from functools import wraps
#   Inspect
from inspect import isdatadescriptor
#   Types
from types import MethodType


# =============================================================================
# >> FORWARD IMPORTS
# =============================================================================
# Source.Python Imports
#   Core
from _core._cache import CachedProperty


# =============================================================================
# >> ALL DECLARATION
# =============================================================================
__all__ = [
    'CachedProperty',
    'cached_property',
    'cached_result'
]


# =============================================================================
# >> FUNCTIONS
# =============================================================================
def cached_property(fget=None, *args, **kwargs):
    """Decorator used to register or wrap a cached property."""
    return (CachedProperty
        if not isdatadescriptor(fget)
        else CachedProperty.wrap_descriptor
    )(fget, *args, **kwargs)


def cached_result(fget):
    """Decorator used to register a cached method.

    :param function fget:
        Method that is only called once and its result cached for subsequent
        calls.
    :rtype: CachedProperty
    """
    # Get a dummy object as default cache, so that we can cache None
    NONE = object()

    def getter(self):
        """Getter function that generates the cached method."""
        # Set our cache to the default value
        cache = NONE

        # Wrap the decorated method as the inner function
        @wraps(fget)
        def wrapper(self, *args, **kwargs):
            """Calls the decorated method and cache the result."""
            nonlocal cache

            # Did we cache a result already?
            if cache is NONE:

                # No cache, let's call the wrapped method and cache the result
                cache = fget(self, *args, **kwargs)

            # Return the cached result
            return cache

        # Bind the wrapper function to the passed instance and return it
        return MethodType(wrapper, self)

    # Return a cached property bound to the getter function
    return CachedProperty(getter, doc=fget.__doc__)
