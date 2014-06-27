#!/usr/bin/env python
# -*- coding: utf-8 -*- 

# bug in pylint leading to unfound some arguments of a function
# pylint: disable=E1120 
# line too long
# pylint: disable=C0301
# too many lines in module
# pylint: disable=C0302

class ClassObject(object):

    def __init__(self):
        """
        Class constructor
        """
        pass 


if __name__ == '__main__':

    CLASS = ClassObject()

