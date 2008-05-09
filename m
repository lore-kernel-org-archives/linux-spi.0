From: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: Re: mmc_spi.c driver
Date: Fri, 9 May 2008 21:28:58 +0200
Message-ID: <20080509212858.7220f665@mjolnir.drzeus.cx>
References: <1CF6EDDF0820924DA43C9A52FE7325950A27D544@MI8NYCMAIL17.Mi8.com>
	<200804151137.00997.david-b@pacbell.net>
	<1CF6EDDF0820924DA43C9A52FE7325950A89D882@MI8NYCMAIL17.Mi8.com>
	<200804151204.19776.david-b@pacbell.net>
	<1CF6EDDF0820924DA43C9A52FE7325950A89DA47@MI8NYCMAIL17.Mi8.com>
	<20080424140541.773f6e6b@mjolnir.drzeus.cx>
	<1CF6EDDF0820924DA43C9A52FE7325950ADABC65@MI8NYCMAIL17.Mi8.com>
	<20080507203753.44d18d4f@mjolnir.drzeus.cx>
	<1CF6EDDF0820924DA43C9A52FE7325950B4DAA8C@MI8NYCMAIL17.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "hartleys" <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1CF6EDDF0820924DA43C9A52FE7325950B4DAA8C-3jZfQB9DylyX6QUl2nWcdlaTQe2KTcn/@public.gmane.org>
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

On Thu, 8 May 2008 19:56:10 -0400
"hartleys" <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org> wrote:

> On Wednesday, May 07, 2008 11:38 AM, Pierre Ossman wrote:
> >
> > Have you checked that you have proper pull-ups on the lines? And have
> > you disabled CRC checking in the mmc_spi host? I don't know all the
> > commands by heart, but some of these should be protected by a CRC.
> 
> Figured that was the problem. If I understand the driver layering
> correctly, my setup has this configuration:
> 
> MMC core <-> mmc_spi.c host driver <-> SPI core <-> ep93xx spi bus
> driver <-> card socket <-> the actual mmc/sd-card
> 

That's correct, yes.

> Unfortunately, with no card inserted in the socket when the card is
> probed by the SPI bus driver it will return zero's for all data. I have
> tried installing pull-ups on the MOSI/MISO (txd/rxd) signals of the SPI
> bus but I still always get zero's. I'm not sure if this a an artifact
> (i.e. "bug") of the ep93xx SPI port or if this is what would happen on
> another platform.

I'd recommend double checking your wiring. That's the culprit in 9 out
of 10 cases.

For reference, here's how it is supposed to look:

mmc0: clock 0Hz busmode 0 powermode 0 cs 0 Vdd 0 width 0 timing 0
mmc_spi spi1.0: SD/MMC host mmc0, no WP, no poweroff
mmc0: clock 0Hz busmode 2 powermode 1 cs 1 Vdd 21 width 0 timing 0
mmc_spi spi1.0: mmc_spi: power up (21)
mmc0: clock 400000Hz busmode 2 powermode 2 cs 1 Vdd 21 width 0 timing 0
mmc_spi spi1.0: mmc_spi: power on (21)
mmc_spi spi1.0: mmc_spi:  clock to 400000 Hz, 0
mmc0: starting CMD0 arg 00000000 flags 000000c0
mmc_spi spi1.0:   mmc_spi: CMD0, resp R1
mmc0: req done (CMD0): -110: 00000000 00000000 00000000 00000000
mmc0: starting CMD8 arg 000001aa flags 000002f5
mmc_spi spi1.0:   mmc_spi: CMD8, resp R3/R4/R7
mmc0: req done (CMD8): -110: 00000000 00000000 00000000 00000000

The -110 is the result of mmc_spi seeing all ones in the data. This was
tested with a 2.6.26-rc1 kernel on a Atmel NGW100 board.

> 
> As far as disabling the CRC checking. I know that sending CMD59 to the
> card will turn on/off the CRC checking but I'm not sure where/how you
> enable that feature. Anyway, I don't think this will help for the
> situation where a card is not inserted to receive the command.
> 

If you haven't touched anything then it should be on.

> > Basically the same problem, but with a card present. The command
> > returns garbage data, which tricks the MMC core into believing that
> > the maximum frequency supported by the card is 0 Hz.
> 
> What exactly is the garbage data? As far as I know CMD51 is an optional
> command and is reserved when a mmc/sd-card is used in SPI mode. In that
> situation the data returned would be garbage anyway. Correct?
> 

Not quite, the command is actually ACMD51, not CMD51. The controller
doesn't know this though.

As for the contents, no idea. It it not printed out to dmesg. But it
seems you have a general case of shoddy communication between the card
and the controller.

> 
> I submitted a patch (last week?) that added hardware card detect switch
> sensing to the MMC core and the mmc_spi.c driver. That did fix my
> problems for issues 2 and 3. Has anyone had a chance to look at it?
> 

Just briefly and it is not really acceptable as a solution here. Adding
support for controllers that know if a card is present or not is merely
an optimisation. The core should work just fine without this
information, so your patch would only hide the problem.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  rdesktop, core developer          http://www.rdesktop.org

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
