# -*- coding: utf-8 -*-
import sys

# My model
import model

if __name__ == '__main__':
    model.serialize(model.finder(sys.argv[1]))
