From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: MPC5200-SPI: Where to search
Date: Thu, 11 Oct 2007 09:30:02 -0700
Message-ID: <200710110930.02693.david-b@pacbell.net>
References: <200710111254.47316.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200710111254.47316.jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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

On Thursday 11 October 2007, Juergen Beisert wrote:
> Hi,
> 
> the following error happens on my system:
> 
> --------------------------------
> Oops: Kernel access of bad area, sig: 11 [#1]
> PREEMPT
> Modules linked in: cam_spi_driver
> NIP: 00000000 LR: C30626C4 CTR: 00000000
> REGS: c0329a30 TRAP: 0400   Not tainted  (2.6.20-rt3-pcm030-3CAM-1)

You might try more recent kernel code, with bugfixes etc...


> MSR: 20009032 <EE,ME,IR,DR>  CR: 24008222  XER: 20000000
> TASK = c030abf0[216] 'insmod' THREAD: c0328000
> GPR00: 00000000 C0329AE0 C030ABF0 C1F01CC0 00000002 00000000 00000000 00000000
> GPR08: 00000000 FFFFFF8D 00000000 C0329B24 22008282 10069448 C3060714 C0791840
> GPR16: C305F03C C305F064 00000000 00000124 C305EB3E C305F08C C0230000 C0329C19
> GPR24: C0322800 C0329C18 C0240000 C1F01D14 C0329B68 C1F01CC0 C0329B68 00000000
> NIP [00000000] _start+0x40000000/0xc
> LR [C30626C4] mpc52xx_psc_spi_transfer+0x44/0x94 [cam_spi_driver]

Whatis this "cam_spi_driver" thing?  Looks like a module,
but that driver should be in a "mpc52xx_psc_spi" module.

And what does the code at that address look like?  That's
the very first thing to check.  It's your primary clue about
exactly what's going wrong.


> Call Trace:
> [C0329AE0] [0000001C] 0x1c (unreliable)
> [C0329B00] [C0130DEC] spi_sync+0x90/0xbc
> [C0329B60] [C01315B0] spi_write_then_read+0x104/0x188
> [C0329C10] [C01305C8] dataflash_probe+0x30/0x178
> 	...
> --- Exception: c01 at 0xff21a7c
>     LR = 0x1001d38c
> --------------------------------
> 
> Its an RT preempt patched kernel. This happens most of the time when:
> 
> - Running from JFFS2 flash
> - when insmod the SPI based MTD dataflash driver

So there are probably at least two different MTD devices then?
Some NOR or NAND flash, and the DataFlash...


> It happens always, when the JFFS2 is a fresh one (whole area was erased and 
> the new jffs2 image was written at the beginning of this flash area) and the 
> kernel boots the first time into it. It happens *not always*, if this jffs2 
> filesystem was at least one times mounted and modified ($ touch <anything>; 
> sync; reboot).

That would be one a NOR or NAND partition, not the DataFlash one?


> It never happens if I'm using NFS root instead.
> 
> SPI related? MTD related? JFFS2 related? Any hints where to start the search?

See above ... as you observe, something about JFFS2 seems to be
triggering the problem.  That doesn't mean the issue is in JFFS2
itself, of course.

I've not had the best luck with jffs2 recently.  Even on fairly
generic NOR flash it's crapped out quickly ... so I run NFS root
more often than I'd really like.  Where "crapping out" means the
JFFS partition turns itself to garbage, constantly spewing error
messages, loses data, and so on.  (FWIW I've observed that most
recently on big-endian hardware.)

Not that I can read PowerPC stack traces, but from a quick look at
the mpc52xx_psc_spi.c code the mpc52xx_psc_spi_transfer() routine
mosty accesses fields in heap memory.  So one possibility is that
something's trashing your heap.  Turn on slab poisoning and see if
that reports anything interesting.

- Dave


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
