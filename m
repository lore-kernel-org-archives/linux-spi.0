From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.22-git5 0/4] MMC-over-SPI
Date: Mon, 16 Jul 2007 11:54:54 -0700
Message-ID: <200707161154.54728.david-b@pacbell.net>
References: <200707141504.51950.david-b@pacbell.net>
	<20070716164837.GA18707@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
To: avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070716164837.GA18707-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
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

On Monday 16 July 2007, Anton Vorontsov wrote:
> Hello David,
> 
> On Sat, Jul 14, 2007 at 03:04:51PM -0700, David Brownell wrote:
> > Here's an updated version of the MMC-over-SPI patches, reworked to
> > address most of Pierre's issues (moving even more code into the MMC
> > core) and to clean up the I/O paths.
> > 
> > ...
> 
> Much thanks for the patches!
> 
> Though, I still have some troubles with getting MMC(SD)-over-SPI to
> work.
> 
> I'm using slightly patched spi_mpc83xx.c driver + these four mmc
> patches.
> 
> spi_mpc83xx.c tested only in loopback mode and using oscilloscope.
> It _seem_ to work fine, but as I didn't tested it on real hardware
> (other than MMC/SD), I can't say if it's fault of spi_mpc83xx or
> mmc_spi.

I can't say either, but my first thought is that it might be a
card-specific quirk.  I already found one in that particular place,
and the messages below look fine until the very end.


> David, can you see anything helpful in these debug messages?
> 
> - - - -
> mmc_spi spi1.0: ASSUMING unshared SPI bus!
> mmc_spi spi1.0: ASSUMING 3.2-3.4 V slot power

You should provide an ocr_mask in your platform data, saying what
voltage range you can supply ... even if it's only 3V3 !!


> mmc0: clock 0Hz busmode 0 powermode 0 cs 0 Vdd 0 width 0 timing 0
> mmc_spi spi1.0: SD/MMC host mmc0, no DMA, no WP, no poweroff
> mmc0: clock 0Hz busmode 2 powermode 1 cs 1 Vdd 21 width 0 timing 0
> mmc_spi spi1.0: mmc_spi: power up (21)
> mmc0: clock 400000Hz busmode 2 powermode 2 cs 1 Vdd 21 width 0 timing 0
> mmc_spi spi1.0: mmc_spi: power on (21)
> mmc_spi spi1.0: mmc_spi:  clock to 400000 Hz, 0
> mmc0: starting CMD0 arg 00000000 flags 000000c0
> mmc_spi spi1.0:   mmc_spi: CMD0, MMC_SPI_R1
> mmc0: req done (CMD0): 0/0/0: 00000001 00000000 00000000 00000000

Looks fine:  reset card, R1_SPI_IDLE status is set in
the status word (00000001) ... it'll be resetting for
some time.


> mmc0: starting CMD8 arg 000001aa flags 000002f5
> mmc_spi spi1.0:   mmc_spi: CMD8, MMC_SPI_R3/R7
> mmc_spi spi1.0:   ... CMD8 response SPI_R3/R7: resp 0005 00000000
> mmc0: req done (CMD8): 5/0/0: 00000005 00000000 00000000 00000000

OK, it doesn't handle SEND_EXT_CSD at all (status R1_SPI_ILLEGAL_COMMAND
in addition to the idle status), so it comes as MMC_ERR_INVALID.
(Or SEND_IF_COND, if this were an SD 2.0+ card...)


> mmc0: starting CMD55 arg 00000000 flags 000000f5
> mmc_spi spi1.0:   mmc_spi: CMD55, MMC_SPI_R1
> mmc0: req done (CMD55): 0/0/0: 00000001 00000000 00000000 00000000
> mmc0: starting CMD41 arg 00000000 flags 000000e1
> mmc_spi spi1.0:   mmc_spi: CMD41, MMC_SPI_R1
> mmc0: req done (CMD41): 0/0/0: 00000001 00000000 00000000 00000000

ACMD41 == SD_SEND_OP_COND, it's still resetting.  Repeats..

> mmc0: starting CMD55 arg 00000000 flags 000000f5
> mmc_spi spi1.0:   mmc_spi: CMD55, MMC_SPI_R1
> mmc0: req done (CMD55): 0/0/0: 00000001 00000000 00000000 00000000
> mmc0: starting CMD41 arg 00000000 flags 000000e1
> mmc_spi spi1.0:   mmc_spi: CMD41, MMC_SPI_R1
> mmc0: req done (CMD41): 0/0/0: 00000001 00000000 00000000 00000000

> mmc0: starting CMD55 arg 00000000 flags 000000f5
> mmc_spi spi1.0:   mmc_spi: CMD55, MMC_SPI_R1
> mmc0: req done (CMD55): 0/0/0: 00000001 00000000 00000000 00000000
> mmc0: starting CMD41 arg 00000000 flags 000000e1
> mmc_spi spi1.0:   mmc_spi: CMD41, MMC_SPI_R1
> mmc0: req done (CMD41): 0/0/0: 00000001 00000000 00000000 00000000

> mmc0: starting CMD55 arg 00000000 flags 000000f5
> mmc_spi spi1.0:   mmc_spi: CMD55, MMC_SPI_R1
> mmc0: req done (CMD55): 0/0/0: 00000001 00000000 00000000 00000000
> mmc0: starting CMD41 arg 00000000 flags 000000e1
> mmc_spi spi1.0:   mmc_spi: CMD41, MMC_SPI_R1
> mmc0: req done (CMD41): 0/0/0: 00000001 00000000 00000000 00000000

> mmc0: starting CMD55 arg 00000000 flags 000000f5
> mmc_spi spi1.0:   mmc_spi: CMD55, MMC_SPI_R1
> mmc0: req done (CMD55): 0/0/0: 00000001 00000000 00000000 00000000
> mmc0: starting CMD41 arg 00000000 flags 000000e1
> mmc_spi spi1.0:   mmc_spi: CMD41, MMC_SPI_R1
> mmc0: req done (CMD41): 0/0/0: 00000001 00000000 00000000 00000000

> mmc0: starting CMD55 arg 00000000 flags 000000f5
> mmc_spi spi1.0:   mmc_spi: CMD55, MMC_SPI_R1
> mmc0: req done (CMD55): 0/0/0: 00000001 00000000 00000000 00000000
> mmc0: starting CMD41 arg 00000000 flags 000000e1
> mmc_spi spi1.0:   mmc_spi: CMD41, MMC_SPI_R1
> mmc0: req done (CMD41): 0/0/0: 00000001 00000000 00000000 00000000

> mmc0: starting CMD55 arg 00000000 flags 000000f5
> mmc_spi spi1.0:   mmc_spi: CMD55, MMC_SPI_R1
> mmc0: req done (CMD55): 0/0/0: 00000001 00000000 00000000 00000000
> mmc0: starting CMD41 arg 00000000 flags 000000e1
> mmc_spi spi1.0:   mmc_spi: CMD41, MMC_SPI_R1
> mmc0: req done (CMD41): 0/0/0: 00000001 00000000 00000000 00000000

> mmc0: starting CMD55 arg 00000000 flags 000000f5
> mmc_spi spi1.0:   mmc_spi: CMD55, MMC_SPI_R1
> mmc0: req done (CMD55): 0/0/0: 00000001 00000000 00000000 00000000
> mmc0: starting CMD41 arg 00000000 flags 000000e1
> mmc_spi spi1.0:   mmc_spi: CMD41, MMC_SPI_R1
> mmc0: req done (CMD41): 0/0/0: 00000001 00000000 00000000 00000000

> mmc0: starting CMD55 arg 00000000 flags 000000f5
> mmc_spi spi1.0:   mmc_spi: CMD55, MMC_SPI_R1
> mmc0: req done (CMD55): 0/0/0: 00000001 00000000 00000000 00000000
> mmc0: starting CMD41 arg 00000000 flags 000000e1
> mmc_spi spi1.0:   mmc_spi: CMD41, MMC_SPI_R1
> mmc0: req done (CMD41): 0/0/0: 00000001 00000000 00000000 00000000

> mmc0: starting CMD55 arg 00000000 flags 000000f5
> mmc_spi spi1.0:   mmc_spi: CMD55, MMC_SPI_R1
> mmc0: req done (CMD55): 0/0/0: 00000001 00000000 00000000 00000000
> mmc0: starting CMD41 arg 00000000 flags 000000e1
> mmc_spi spi1.0:   mmc_spi: CMD41, MMC_SPI_R1
> mmc0: req done (CMD41): 0/0/0: 00000001 00000000 00000000 00000000

> mmc0: starting CMD55 arg 00000000 flags 000000f5
> mmc_spi spi1.0:   mmc_spi: CMD55, MMC_SPI_R1
> mmc0: req done (CMD55): 0/0/0: 00000001 00000000 00000000 00000000
> mmc0: starting CMD41 arg 00000000 flags 000000e1
> mmc_spi spi1.0:   mmc_spi: CMD41, MMC_SPI_R1
> mmc0: req done (CMD41): 0/0/0: 00000001 00000000 00000000 00000000

> mmc0: starting CMD55 arg 00000000 flags 000000f5
> mmc_spi spi1.0:   mmc_spi: CMD55, MMC_SPI_R1
> mmc0: req done (CMD55): 0/0/0: 00000001 00000000 00000000 00000000
> mmc0: starting CMD41 arg 00000000 flags 000000e1
> mmc_spi spi1.0:   mmc_spi: CMD41, MMC_SPI_R1
> mmc0: req done (CMD41): 0/0/0: 00000001 00000000 00000000 00000000

> mmc0: starting CMD55 arg 00000000 flags 000000f5
> mmc_spi spi1.0:   mmc_spi: CMD55, MMC_SPI_R1
> mmc0: req done (CMD55): 0/0/0: 00000001 00000000 00000000 00000000
> mmc0: starting CMD41 arg 00000000 flags 000000e1
> mmc_spi spi1.0:   mmc_spi: CMD41, MMC_SPI_R1
> mmc0: req done (CMD41): 0/0/0: 00000001 00000000 00000000 00000000

> mmc0: starting CMD55 arg 00000000 flags 000000f5
> mmc_spi spi1.0:   mmc_spi: CMD55, MMC_SPI_R1
> mmc0: req done (CMD55): 0/0/0: 00000001 00000000 00000000 00000000
> mmc0: starting CMD41 arg 00000000 flags 000000e1
> mmc_spi spi1.0:   mmc_spi: CMD41, MMC_SPI_R1
> mmc0: req done (CMD41): 0/0/0: 00000000 00000000 00000000 00000000

Finally the reset completed, R1_SPI_IDLE bit clears.


> mmc0: starting CMD58 arg 00000000 flags 00000280
> mmc_spi spi1.0:   mmc_spi: CMD58, MMC_SPI_R3/R7
> mmc0: req done (CMD58): 0/0/0: 00000000 80ff8000 00000000 00000000

Reads the OCR, fine.

> mmc0: clock 400000Hz busmode 2 powermode 2 cs 1 Vdd 20 width 0 timing 0
> mmc0: starting CMD0 arg 00000000 flags 000000c0
> mmc_spi spi1.0:   mmc_spi: CMD0, MMC_SPI_R1
> mmc0: req done (CMD0): 0/0/0: 00000001 00000000 00000000 00000000

Restarts the enumeration, now knowing it's an SD card.

> mmc0: starting CMD8 arg 000001aa flags 000002f5
> mmc_spi spi1.0:   mmc_spi: CMD8, MMC_SPI_R3/R7
> mmc_spi spi1.0:   ... CMD8 response SPI_R3/R7: resp 0005 00000000
> mmc0: req done (CMD8): 5/0/0: 00000005 00000000 00000000 00000000

... so here it's trying SEND_IF_COND (still failing) ...

> mmc0: starting CMD55 arg 00000000 flags 000000f5
> mmc_spi spi1.0:   mmc_spi: CMD55, MMC_SPI_R1
> mmc0: req done (CMD55): 0/0/0: 00000001 00000000 00000000 00000000
> mmc0: starting CMD41 arg 00300000 flags 000000e1
> mmc_spi spi1.0:   mmc_spi: CMD41, MMC_SPI_R1
> mmc0: req done (CMD41): 0/0/0: 00000001 00000000 00000000 00000000

> mmc0: starting CMD55 arg 00000000 flags 000000f5
> mmc_spi spi1.0:   mmc_spi: CMD55, MMC_SPI_R1
> mmc0: req done (CMD55): 0/0/0: 00000001 00000000 00000000 00000000
> mmc0: starting CMD41 arg 00300000 flags 000000e1
> mmc_spi spi1.0:   mmc_spi: CMD41, MMC_SPI_R1
> mmc0: req done (CMD41): 0/0/0: 00000001 00000000 00000000 00000000

> mmc0: starting CMD55 arg 00000000 flags 000000f5
> mmc_spi spi1.0:   mmc_spi: CMD55, MMC_SPI_R1
> mmc0: req done (CMD55): 0/0/0: 00000001 00000000 00000000 00000000
> mmc0: starting CMD41 arg 00300000 flags 000000e1
> mmc_spi spi1.0:   mmc_spi: CMD41, MMC_SPI_R1
> mmc0: req done (CMD41): 0/0/0: 00000001 00000000 00000000 00000000

> mmc0: starting CMD55 arg 00000000 flags 000000f5
> mmc_spi spi1.0:   mmc_spi: CMD55, MMC_SPI_R1
> mmc0: req done (CMD55): 0/0/0: 00000001 00000000 00000000 00000000
> mmc0: starting CMD41 arg 00300000 flags 000000e1
> mmc_spi spi1.0:   mmc_spi: CMD41, MMC_SPI_R1
> mmc0: req done (CMD41): 0/0/0: 00000001 00000000 00000000 00000000

> mmc0: starting CMD55 arg 00000000 flags 000000f5
> mmc_spi spi1.0:   mmc_spi: CMD55, MMC_SPI_R1
> mmc0: req done (CMD55): 0/0/0: 00000001 00000000 00000000 00000000
> mmc0: starting CMD41 arg 00300000 flags 000000e1
> mmc_spi spi1.0:   mmc_spi: CMD41, MMC_SPI_R1
> mmc0: req done (CMD41): 0/0/0: 00000001 00000000 00000000 00000000

> mmc0: starting CMD55 arg 00000000 flags 000000f5
> mmc_spi spi1.0:   mmc_spi: CMD55, MMC_SPI_R1
> mmc0: req done (CMD55): 0/0/0: 00000001 00000000 00000000 00000000
> mmc0: starting CMD41 arg 00300000 flags 000000e1
> mmc_spi spi1.0:   mmc_spi: CMD41, MMC_SPI_R1
> mmc0: req done (CMD41): 0/0/0: 00000001 00000000 00000000 00000000

> mmc0: starting CMD55 arg 00000000 flags 000000f5
> mmc_spi spi1.0:   mmc_spi: CMD55, MMC_SPI_R1
> mmc0: req done (CMD55): 0/0/0: 00000001 00000000 00000000 00000000
> mmc0: starting CMD41 arg 00300000 flags 000000e1
> mmc_spi spi1.0:   mmc_spi: CMD41, MMC_SPI_R1
> mmc0: req done (CMD41): 0/0/0: 00000001 00000000 00000000 00000000

> mmc0: starting CMD55 arg 00000000 flags 000000f5
> mmc_spi spi1.0:   mmc_spi: CMD55, MMC_SPI_R1
> mmc0: req done (CMD55): 0/0/0: 00000001 00000000 00000000 00000000
> mmc0: starting CMD41 arg 00300000 flags 000000e1
> mmc_spi spi1.0:   mmc_spi: CMD41, MMC_SPI_R1
> mmc0: req done (CMD41): 0/0/0: 00000001 00000000 00000000 00000000

> mmc0: starting CMD55 arg 00000000 flags 000000f5
> mmc_spi spi1.0:   mmc_spi: CMD55, MMC_SPI_R1
> mmc0: req done (CMD55): 0/0/0: 00000001 00000000 00000000 00000000
> mmc0: starting CMD41 arg 00300000 flags 000000e1
> mmc_spi spi1.0:   mmc_spi: CMD41, MMC_SPI_R1
> mmc0: req done (CMD41): 0/0/0: 00000001 00000000 00000000 00000000

> mmc0: starting CMD55 arg 00000000 flags 000000f5
> mmc_spi spi1.0:   mmc_spi: CMD55, MMC_SPI_R1
> mmc0: req done (CMD55): 0/0/0: 00000001 00000000 00000000 00000000
> mmc0: starting CMD41 arg 00300000 flags 000000e1
> mmc_spi spi1.0:   mmc_spi: CMD41, MMC_SPI_R1
> mmc0: req done (CMD41): 0/0/0: 00000001 00000000 00000000 00000000

> mmc0: starting CMD55 arg 00000000 flags 000000f5
> mmc_spi spi1.0:   mmc_spi: CMD55, MMC_SPI_R1
> mmc0: req done (CMD55): 0/0/0: 00000001 00000000 00000000 00000000
> mmc0: starting CMD41 arg 00300000 flags 000000e1
> mmc_spi spi1.0:   mmc_spi: CMD41, MMC_SPI_R1
> mmc0: req done (CMD41): 0/0/0: 00000001 00000000 00000000 00000000

> mmc0: starting CMD55 arg 00000000 flags 000000f5
> mmc_spi spi1.0:   mmc_spi: CMD55, MMC_SPI_R1
> mmc0: req done (CMD55): 0/0/0: 00000001 00000000 00000000 00000000
> mmc0: starting CMD41 arg 00300000 flags 000000e1
> mmc_spi spi1.0:   mmc_spi: CMD41, MMC_SPI_R1
> mmc0: req done (CMD41): 0/0/0: 00000001 00000000 00000000 00000000

> mmc0: starting CMD55 arg 00000000 flags 000000f5
> mmc_spi spi1.0:   mmc_spi: CMD55, MMC_SPI_R1
> mmc0: req done (CMD55): 0/0/0: 00000001 00000000 00000000 00000000
> mmc0: starting CMD41 arg 00300000 flags 000000e1
> mmc_spi spi1.0:   mmc_spi: CMD41, MMC_SPI_R1
> mmc0: req done (CMD41): 0/0/0: 00000001 00000000 00000000 00000000

> mmc0: starting CMD55 arg 00000000 flags 000000f5
> mmc_spi spi1.0:   mmc_spi: CMD55, MMC_SPI_R1
> mmc0: req done (CMD55): 0/0/0: 00000001 00000000 00000000 00000000
> mmc0: starting CMD41 arg 00300000 flags 000000e1
> mmc_spi spi1.0:   mmc_spi: CMD41, MMC_SPI_R1
> mmc0: req done (CMD41): 0/0/0: 00000001 00000000 00000000 00000000

> mmc0: starting CMD55 arg 00000000 flags 000000f5
> mmc_spi spi1.0:   mmc_spi: CMD55, MMC_SPI_R1
> mmc0: req done (CMD55): 0/0/0: 00000001 00000000 00000000 00000000
> mmc0: starting CMD41 arg 00300000 flags 000000e1
> mmc_spi spi1.0:   mmc_spi: CMD41, MMC_SPI_R1
> mmc0: req done (CMD41): 0/0/0: 00000000 00000000 00000000 00000000

Reset finished, IDLE status is no longer set ...

> mmc0: starting CMD59 arg 00000001 flags 00000080
> mmc_spi spi1.0:   mmc_spi: CMD59, MMC_SPI_R1
> mmc0: req done (CMD59): 0/0/0: 00000000 00000000 00000000 00000000

Enables CRC mode (arg == 1).

> mmc0: starting CMD10 arg 00000000 flags 000000b5
> mmc_spi spi1.0:   mmc_spi: CMD10, MMC_SPI_R1
> mmc_spi spi1.0:     mmc_spi: read block, 16 bytes
> mmc_spi spi1.0: read error f8 (248)

Hmm, the data block in the MMC_SEND_CID command didn't start
with a valid token ... it saw 0xf8, not 0xfe, which is a
lowlevel protocol error.

Maybe your scope can show whether or not this was the actual
data sent by the card... or you can otherwise verify that the
input data (from start of CMD10) was a bunch of 0xff values
then an 0xf8...


> mmc_spi spi1.0: read status -5
> mmc0: req done (CMD10): 0/4/0: 00000001 00000000 00000000 00000000
> mmc0: clock 0Hz busmode 2 powermode 0 cs 1 Vdd 0 width 0 timing 0
> mmc_spi spi1.0: mmc_spi: power off (0)

Rather than retrying that command, everything shuts down.
Which is annoying, but seems to be the intended behavior;
if that's bug, it's not a bug in the SPI support.


> - - - -
> 
> 
> SD card is Kingston 1GB, 3.3V.

I didn't try Kingston cards.  Since everything worked fine until
that last command, maybe a different card will behave better.

The driver does handle one protocol quirk.  A SanDisk SD card
would issue an 0x00 byte right after issuing the command, in
that SEND_CID case as well as the SEND_CSD case.  That should
be an 0xff byte ... depending on exactly where that 0xf8 showed
up, maybe the mmc_spi_readblock() code should be changed to skip
not just 0x00 but *ANY* non-{0xff,0xfe} byte in that slot.

- Dave

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
