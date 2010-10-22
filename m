From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: fixed some core weirdness
Date: Fri, 22 Oct 2010 12:55:47 +0200
Message-ID: <AANLkTikK5ZokuzvSSx=-xfUxsYcTY3WiyGg-UP930_Y_@mail.gmail.com>
References: <1287688004-27410-1-git-send-email-linus.walleij@stericsson.com>
	<1287700080.2038.121.camel@helium>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1287700080.2038.121.camel@helium>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

2010/10/22 David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>:

>> and then two hardcoded
>> strings passed in as parameters.
>
> Which reduced the text space used by the driver, by sharing parts
> of the message that were not variable.

When I look at it, it doesn't. Quite the reverse.

I was curious on how much this would save/cost on this ARM system
so I compiled with and without these two lines altered. i.e. just:

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b5a78a1..8de6083 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -300,16 +300,16 @@ int spi_add_device(struct spi_device *spi)
         */
        status = spi_setup(spi);
        if (status < 0) {
-               dev_err(dev, "can't %s %s, status %d\n",
-                               "setup", dev_name(&spi->dev), status);
+               dev_err(dev, "can't setup %s, status %d\n",
+                               dev_name(&spi->dev), status);
                goto done;
        }

        /* Device may be bound to an active driver when this returns */
        status = device_add(&spi->dev);
        if (status < 0)
-               dev_err(dev, "can't %s %s, status %d\n",
-                               "add", dev_name(&spi->dev), status);
+               dev_err(dev, "can't add %s, status %d\n",
+                               dev_name(&spi->dev), status);
        else
                dev_dbg(dev, "registered child %s\n", dev_name(&spi->dev));


Simple size measurement gives:

$ size vmlinux-before
   text	   data	    bss	    dec	    hex	filename
8554532	  73120	 102740	8730392	 853718	vmlinux-before
$ size vmlinux-after
   text	   data	    bss	    dec	    hex	filename
8554530	  73120	 102740	8730390	 853716	vmlinux-after

So this patch actually shrinks the size of the kernel, not the reverse
as could be assumed from the above argument.

But the plain .text size includes several subsections and probably
a number of alignment pecularities, so to get the details out, I diff:ed the
output from readelf -S on before and after:

 Section Headers:
   [Nr] Name              Type            Addr     Off    Size   ES
Flg Lk Inf Al
   [ 0]                   NULL            00000000 000000 000000 00
  0   0  0
   [ 1] .note.gnu.build-i NOTE            00000000 008000 000024 00
A  0   0  4
   [ 2] .init             PROGBITS        c0008000 010000 663325 00
WAX  0   0 32
-  [ 3] .text             PROGBITS        c066c000 674000 1a3f33 00
AX  0   0 1024
+  [ 3] .text             PROGBITS        c066c000 674000 1a3f39 00
AX  0   0 1024
   [ 4] __ksymtab         PROGBITS        c0810000 818000 0036e0 00
A  0   0  4
   [ 5] __ksymtab_gpl     PROGBITS        c08136e0 81b6e0 0016b0 00
A  0   0  4
   [ 6] __ksymtab_strings PROGBITS        c0814d90 81cd90 00a73c 00
A  0   0  1
   [ 7] __init_rodata     PROGBITS        c081f4cc 8274cc 00001c 00
A  0   0  4
   [ 8] __param           PROGBITS        c081f4e8 8274e8 000b18 00
A  0   0  4
-  [ 9] .ARM.unwind_idx   ARM_EXIDX       c0820000 828000 00e170 00
AL  2   0  4
-  [10] .ARM.unwind_tab   PROGBITS        c082e170 836170 003438 00
A  0   0  4
+  [ 9] .ARM.unwind_idx   ARM_EXIDX       c0820000 828000 00e168 00
AL  2   0  4
+  [10] .ARM.unwind_tab   PROGBITS        c082e168 836168 003438 00
A  0   0  4
   [11] .data             PROGBITS        c0832000 83a000 011da0 00
WA  0   0 32
   [12] .tcm_start        NOBITS          c0843da0 84bda0 000260 00
WA  0   0  1
   [13] .bss              NOBITS          c0844000 84bda0 018ef4 00
WA  0   0 32
@@ -25,11 +25,11 @@
   [20] .debug_ranges     PROGBITS        00000000 1687620 03a6b0 00
   0   0  8
   [21] .debug_pubnames   PROGBITS        00000000 16c1cd0 01a3ad 00
   0   0  1
   [22] .debug_str        PROGBITS        00000000 16dc07d 06e07c 01
MS  0   0  1
-  [23] .debug_frame      PROGBITS        00000000 174a0fc 047134 00
   0   0  4
-  [24] .debug_loc        PROGBITS        00000000 1791230 131f13 00
   0   0  1
-  [25] .shstrtab         STRTAB          00000000 18c3143 00013f 00
   0   0  1
-  [26] .symtab           SYMTAB          00000000 18c36e4 078800 10
  27 25795  4
-  [27] .strtab           STRTAB          00000000 193bee4 053a5b 00
   0   0  1
+  [23] .debug_frame      PROGBITS        00000000 174a0fc 04712c 00
   0   0  4
+  [24] .debug_loc        PROGBITS        00000000 1791228 131f08 00
   0   0  1
+  [25] .shstrtab         STRTAB          00000000 18c3130 00013f 00
   0   0  1
+  [26] .symtab           SYMTAB          00000000 18c36d0 078800 10
  27 25795  4
+  [27] .strtab           STRTAB          00000000 193bed0 053a5b 00
   0   0  1

So this patch cost 6 bytes of .text, saves 2 bytes of .ARM.unwind_idx,
saves 11 bytes in .debug_loc, saves 8 bytes in .debug_frame.

.ARM.unwind_idx is and architecture oddity, but the rest is rather general,
so in net total this patch actually ends up saving 19 bytes on this kernel.
We don't see it because of the way the tables are aligned probably,
maybe they are aligned upward to the next page or so and this
effect totally drowns in that.

Looking at it from a general view I find it hard to figure out how deferring
a string like "setup" or "add" to a string table could save memory,
each will be replaced with "%s" respectively saving 3 and 1 byte,
but inevitably at the cost of requiring to keep an address-bus-sized
pointer around somewhere, 4 bytes on the 32bit archs, meaning it is
expected to end up not saving space with this but rather the reverse.

Theoretically, in my book, you would loose 4-3 + 4-1 = 4 bytes,
with some secondary index for a string table (I guess these are the 8
bytes in .debug_frame) yet more, so something
like these 19 bytes net win are expected IMHO.

I don't know if it's typical for other archs though. What case are you
considering when you claim that the old way of doing things would
reduce text space? Can I reproduce it and learn something useful
about reducing the size of also this system?

Yours,
Linus Walleij

------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
