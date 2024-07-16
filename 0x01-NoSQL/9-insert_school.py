#!/usr/bin/env python3
''' insert new document'''


def insert_school(mongo_collection, **kwargs):
    ''' insert new document'''
    result = mongo_collection.insert_one(kwargs)
    return result.inserted_id
