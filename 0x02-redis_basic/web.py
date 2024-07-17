#!/usr/bin/env python3
'''module '''
import requests
import redis
import functools
from time import time

# Initialize Redis client
cache = redis.Redis(host='localhost', port=6379, db=0)

def cache_result(expiration=10):
    """Decorator to cache the result of a function with a given expiration time."""
    def decorator(func):
        @functools.wraps(func)
        def wrapper(url, *args, **kwargs):
            cache_key = f"cache:{url}"
            cached_result = cache.get(cache_key)
            if cached_result:
                print("Returning cached result")
                return cached_result.decode('utf-8')

            result = func(url, *args, **kwargs)
            cache.setex(cache_key, expiration, result)
            return result
        return wrapper
    return decorator

def count_access(func):
    """Decorator to count how many times a particular URL was accessed."""
    @functools.wraps(func)
    def wrapper(url, *args, **kwargs):
        count_key = f"count:{url}"
        cache.incr(count_key)
        print(f"URL accessed {cache.get(count_key).decode('utf-8')} times")
        return func(url, *args, **kwargs)
    return wrapper

@count_access
@cache_result(expiration=10)
def get_page(url: str) -> str:
    response = requests.get(url)
    return response.text

if __name__ == "__main__":
    test_url = "http://slowwly.robertomurray.co.uk"
    print(get_page(test_url))
    print(get_page(test_url))
    print(get_page(test_url))

