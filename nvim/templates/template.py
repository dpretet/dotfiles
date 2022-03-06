#!/usr/bin/env python3
# coding: utf-8

# distributed under the mit license
# https://opensource.org/licenses/mit-license.php

"""
Doc string to describe the module
"""


class Template:

    """ Describe the class

        Attributes:

        Returns:

    """

    def __init__(self, verbose=0):
        """ Class constructor """

        self.verbose = verbose

    def print_value(self, val):
        """ Function description

            Args:
                val (int): the description of a

            Returns:
                bool: 0 always
        """

        print(val)

        return 0


if __name__ == '__main__':

    temp = Template()
    temp.print_value(5)
