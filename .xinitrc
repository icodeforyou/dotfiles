#!/bin/sh

xrdb -merge ~/.Xresources

export GDK_SCALE=2
export GDK_DPI_SCALE=0.6

exec awesome
