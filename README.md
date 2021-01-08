Usage

   bsp [ -noreject ] [-factor nn ] [ -q ] [ -picknode { traditional |
   visplane } ] [ -blockmap { old | comp } ] inwad [ [ -o ] outwad ]

   Where:

   -noreject
          Causes any existing REJECT lump in the WAD file not to be
          replaced.

   -factor nn
          Used for tuning the node builder. The number supplied is the
          weighting applied when a choice of nodeline requires other
          lines to be split. Increasing this value from the default of 17
          will reduce the number of extra line splits, but this will
          generally cause a less balanced node tree. The default is
          usually fine.

   -q
          Causes BSP to run quietly, only printing output if there are
          errors or warnings.

   -picknode
          Determines the nodeline selection algorithm. The "traditional"
          option is best for most Doom levels. For levels which are
          intended for the original doom2.exe and suffer from some
          marginal visplane overflows, the "visplane" algorithm is
          designed to minimise these and may help in some cases. See the
          included visplane.txt for more information.

   -blockmap
          Selects the blockmap generation algorithm. The default "old"
          algorithm generates a simple and correct blockmap. The newer
          "comp" version produces a compressed blockmap, by reusing
          identical blocks which should be equivalent in actual use. The
          "comp" version is therefore better but it relatively untested
          so is not yet enabled by default.

   inwad is the input WAD file. This may contain any number of levels and
   other lumps. The nodes and associated data resources will be built for
   every level in this WAD. Any other data present in the WAD will be
   copied to the output WAD unchanged.

   outwad is the output WAD file. If the output file already exists, BSP
   will write it's output to a temporary file while it is working, and
   will only overwrite the output file once it is finished. In
   particular, it is safe for outwad to be the same as inwad, although
   this is not recommended unless you keep other backups :-).

   Either inwad or outwad can be pipes or special files. On most UNIX
   systems, you can have BSP read from STDIN and write to STDOUT by using
   it as follows: bsp -q /dev/stdin /dev/stdout

What are Nodes?

   Before you can play a level that you have created, you must use a node
   builder to create the data that Doom will use to render the level.
   Doom uses a rendering algorithm based on a binary space partition,
   otherwise known as a BSP tree. This is stored in a data lump called
   NODES in the WAD file. This data structure must be precalculated and
   stored in the WAD file befor the level can be played; the tool that
   does this is called a node builder.

   BSP is one of several node builders that can do this. There are
   others: idbsp is the original node builder that id Software used on
   the original Doom levels, for instance. BSP was the best known and
   most widely used node builder throughout the height of the Doom
   editing craze in the mid 1990s.

Features

     * Fast Doom node builder.
     * Supports a number of special effects.
     * Supports multi-level WADs. Preserves non-level data in WADs.
     * Includes an optional alternative algorithm for choosing the nodes
       which reduces the chance of visplane overflows.
     * Optional support for compressing the blockmap.
     * Compiles on DOS, Win32, Linux, UNIX.
     * Supports big endian & 64-bit systems.

Special Effects

     * HOM-free transparent doors:
       Simply make the sector referenced by the doortracks have a sector
       tag of >= 900. No need to remember sector numbers and type them in
       on a command line -- just use any sector tag >= 900 to permanently
       mark the sector special.
       See TRANSDOR.WAD for an example of sector tags in the 900's being
       used to create HOM-free transparent door effects.
     * Precious lines:
       If a linedef has a sector tag >= 900, then it is treated as
       "precious" and will not be split unless absolutely necessary. This
       is good to use around borders of deep water, invisible stairs,
       etc.
       Furthermore, just for grins, if the linedef's tag is 999, then the
       sidedefs' x-offsets set an angle adjustment in degrees to be
       applied -- you can look straight at a wall, but it might come
       right at you on both sides and "stretch".
---
Content-Style: text/css
generator: 'groff -Thtml, see www.gnu.org'
title: bsp
---

bsp {#bsp align="center"}
===

[NAME](#NAME)\
[SYNOPSIS](#SYNOPSIS)\
[DESCRIPTION](#DESCRIPTION)\
[OPTIONS](#OPTIONS)\
[SPECIAL EFFECTS](#SPECIAL%20EFFECTS)\
[SUPPORTED GAMES](#SUPPORTED%20GAMES)\
[EXIT STATUS](#EXIT%20STATUS)\
[BUGS/LIMITATIONS](#BUGS/LIMITATIONS)\
[AUTHORS](#AUTHORS)\
[SEE ALSO](#SEE%20ALSO)\

------------------------------------------------------------------------

NAME []{#NAME}
--------------

bsp - node builder for WAD files

SYNOPSIS []{#SYNOPSIS}
----------------------

**bsp** \[ **-blockmap** {**old**\|**comp**} \] \[ **-factor** *n* \] \[
**-noreject** \] \[ **-o** *file* \] \[ **-picknode**
{**traditional**\|**visplane**} \] \[ **-q** \] *file*

DESCRIPTION []{#DESCRIPTION}
----------------------------

BSP builds the nodes and blockmap resources for all the levels in a WAD
file. Levels created with level editors won't run without these
resources.

OPTIONS []{#OPTIONS}
--------------------

**-blockmap** {**old**\|**comp**}

This selects the algorithm used for generating the blockmap resource.
The **old** algorithm (currently the default, but this might change in
future) produces a complete blockmap which contains some redundancy. The
**comp** algorithm generates an equivalent blockmap, but which
eliminates this redundancy, making a smaller resulting WAD file.

**-factor** *n*

Changes the cost assigned to seg splits. Factor *n* can be any positive
integer, and the larger the factor, the more costly seg splits are. A
factor of 17 is the default and behaves just like earlier versions of
BSP. Most people do not need or want to change the default. Changing the
factor can sometimes prevent visplane overflows in WAD's; but then
again, some WAD's have just too many visplane overflows, experiment with
the **-factor** option before giving up.

**-noreject**

Normally, BSP creates a zero-ed reject map, which is sub-optimal but
sufficient for Doom to play the level. Other tools are available to
build an optimal reject map. If a level already has an optimised reject
map, this option should be used to stop BSP replacing it.

**-picknode** {**traditional**\|**visplane**}

In **traditional** mode (the default), BSP aims to produce a balanced
node tree that minimises the number of lines that must be split in this
process. **visplane** mode causes the node line picker to choose node
lines in a way that is empirically known to reduce or eliminate visplane
overflows. This is an old bug that affected the original Doom engine but
does not affect newer engines - if you don't know what this option is
and have no problems without it, you do not need it.

**-o** *file*

Sets the name of the WAD file for output. Should not be the same as the
input! As with the input filename, it can be a **-** to indicate that
standard input/output should be used. Without this option, output is
written to **tmp.wad**.

  -- -------- -- ---------------------------------------------------------------------------
     **-q**      Does not show program banners or progress, for usage from other programs.
  -- -------- -- ---------------------------------------------------------------------------

SPECIAL EFFECTS []{#SPECIAL EFFECTS}
------------------------------------

BSP has some special effect features:

If a linedef has a sector tag ≥ 900, then it is treated as \"precious\"
and will not be split unless absolutely necessary. This is good to use
around borders of deep water, invisible stairs, etc.

Furthermore, just for a grin, if the lindef's tag is 999, then the
sidedef's x-offset sets an angle adjustment in degrees to be applied ---
you can look straight at a wall, but it might come right at you on both
sides and \"stretch\".

BSP supports HOM-free transparent doors. Simply make the sector
referenced by the doortracks have a sector tag of ≥ 900. The doortracks
must the lowest numbered of all the linedefs that form the door. No need
to remember sector numbers and type them in on a command line --- just
use any sector tag ≥ 900 to permanently mark the sector special. The
special tag is not strictly necessary; it just prevents a flash of HOM
at the top of the door when it opens or closes. See
**test-wads/transdor.wad** for an example.

SUPPORTED GAMES []{#SUPPORTED GAMES}
------------------------------------

Doom, Ultimate Doom, Doom \]\[, Final Doom, Heretic and Strife.

EXIT STATUS []{#EXIT STATUS}
----------------------------

**0** OK **\
\>0** Errors occurred

BUGS/LIMITATIONS []{#BUGS/LIMITATIONS}
--------------------------------------

This program will *not* build a good reject map, it will (unless
**-noreject** is used) build a zero-ed one, where every sector is
visible from any other sector. For the final release of a level, a
reject map should be built using a suitable tool, such as RMB.

The Hexen level format is not supported.

AUTHORS []{#AUTHORS}
--------------------

BSP was written by Colin Reed and Lee Killough (killough\@rsn.hp.com),
based on an algorithm by Raphaël Quinet.

Contributors include Simon \"fraggle\" Howard (compressed blockmap
code), Oliver Kraus (endianness fixes), André Majorel (Unix port, man
page) and Udo Munk (Unix port, man page, assorted hacks).

BSP is currently maintained by Colin Phipps \<cph\@moria.org.uk\>.
