From: "Matt Gessner" <mgessner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Need help w/ SPI dataflash AT45DB011B on
	AT91RM9200 linux 2.6.20
Date: Tue, 29 Jan 2008 10:50:37 -0500
Message-ID: <85a5c2010801290750j624ffe3bt3d30f5fb7d5df020@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello,

I've got what seems to be a very odd problem.  There's a specific word
(offset 0x20000) in my dataflash that for some reason I can't change.

I wrote a simple program that does the following:
http://rafb.net/p/RU5LPy71.html
     a) open the dataflash via /dev/mtdblock/0, seek, read a 32-bit value, close
     b) open the dataflash via /dev/mtdblock/0, seek, write a 32-bit
value, close
     c) open the dataflash via /dev/mtdblock/0, seek, read a 32-bit value, close

The value in c) is the same value as from a), not that which was
written in b), which is horribly wrong.

If I try to change other words in the dataflash, it succeeds (I know
this because I've modified parts of other pages).

I've gone down into mtdblock, and it appears to be doing everything
correctly.  I added a little bit of debugging, to show that the data
from userspace is accurate:  http://rafb.net/p/KlocsG98.html

As you can see on lines 10 and 30, from different points in the
debugging, the data that the program is writing is being seen by the
kernel, yet the write isn't happening.

I've posted my modified modblock.c at http://rafb.net/p/RU5LPy71.html

The issue I'm facing is that 0x20000 is the start of the u-boot
environment (no, it's not page aligned with the erasesize, which is
why i'm having to go through this exercise, and I can't change the
structure because I don't have control over all parts of the system.
So I'm booting a modified copy of linux with a different partition
table to allow me to do all of this.) and when I try to write the CRC
back to the environment table, I can update the environment table but
the CRC won't change.

Thanks in advance,

Matt Gessner

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
