From: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: Re: mmc_spi.c driver
Date: Wed, 7 May 2008 20:37:53 +0200
Message-ID: <20080507203753.44d18d4f@mjolnir.drzeus.cx>
References: <1CF6EDDF0820924DA43C9A52FE7325950A27D544@MI8NYCMAIL17.Mi8.com>
	<200804151137.00997.david-b@pacbell.net>
	<1CF6EDDF0820924DA43C9A52FE7325950A89D882@MI8NYCMAIL17.Mi8.com>
	<200804151204.19776.david-b@pacbell.net>
	<1CF6EDDF0820924DA43C9A52FE7325950A89DA47@MI8NYCMAIL17.Mi8.com>
	<20080424140541.773f6e6b@mjolnir.drzeus.cx>
	<1CF6EDDF0820924DA43C9A52FE7325950ADABC65@MI8NYCMAIL17.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "hartleys" <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1CF6EDDF0820924DA43C9A52FE7325950ADABC65-3jZfQB9DylyX6QUl2nWcdlaTQe2KTcn/@public.gmane.org>
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

I haven't had any time to try to reproduce this myself yet, but I can
at least comment on your logs...

On Thu, 24 Apr 2008 18:53:02 -0400
"hartleys" <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org> wrote:

> Hello Pierre,
> 
> I still have three issues with the mmc_spi.c driver:
> 
> 1) I still haven't tracked down why the ios.clock value is getting set to 0 then a transfer is attempted to the SD card.
> 2) I also haven't figured out why a SDIO card is found at power up when no card is installed.
> 3) When I insert or remove a card it is not detected (other than the first detect if I boot without a card installed).
> 

All of these things can be explained by a single bug, as explained
below...

> 
> Here's a snip of the output from boot without a card installed.
> 
> user.info kernel: ep93xx spi device registered in bit-bang mode
> user.info kernel: at25 spi0.0: 512 KByte 25LF040A eeprom, pagesize 4096
> ...
> user.err kernel: mmc_spi spi0.1: can't share SPI bus
> user.warn kernel: mmc_spi spi0.1: ASSUMING SPI bus stays unshared!
> user.info kernel: mmc_spi spi0.1: card detect on IRQ 79
> user.debug kernel: mmc0: clock 0Hz busmode 0 powermode 0 cs 0 Vdd 0 width 0 timing 0
> user.debug kernel: mmc0: clock 0Hz busmode 2 powermode 1 cs 1 Vdd 21 width 0 timing 0
> user.debug kernel: mmc_spi spi0.1: mmc_spi: power up (21)
> user.debug kernel: mmc0: clock 400000Hz busmode 2 powermode 2 cs 1 Vdd 21 width 0 timing 0
> user.debug kernel: mmc_spi spi0.1: mmc_spi: power on (21)
> user.info kernel: mmc_spi spi0.1: SD/MMC host mmc0, no DMA, no poweroff
> ...
> user.debug kernel: mmc_spi spi0.1: mmc_spi:  clock to 400000 Hz, 0
> user.debug kernel: mmc0: starting CMD0 arg 00000000 flags 000000c0
> user.debug kernel: mmc_spi spi0.1:   mmc_spi: CMD0, resp R1
> user.debug kernel: mmc0: req done (CMD0): 0: 00000000 00000000 00000000 00000000
> user.debug kernel: mmc0: starting CMD8 arg 000001aa flags 000002f5
> user.debug kernel: mmc_spi spi0.1:   mmc_spi: CMD8, resp R3/R4/R7
> user.debug kernel: mmc0: req done (CMD8): 0: 00000000 00000000 00000000 00000000
> user.debug kernel: mmc0: starting CMD5 arg 00000000 flags 000002e1
> user.debug kernel: mmc_spi spi0.1:   mmc_spi: CMD5, resp R3/R4/R7
> user.debug kernel: mmc0: req done (CMD5): 0: 00000000 00000000 00000000 00000000
> user.debug kernel: mmc0: clock 0Hz busmode 2 powermode 0 cs 1 Vdd 0 width 0 timing 0
> user.debug kernel: mmc_spi spi0.1: mmc_spi: power off (0)
> user.err kernel: mmc0: error -22 whilst initialising SDIO card
> user.debug kernel: mmc0: clock 0Hz busmode 2 powermode 0 cs 1 Vdd 0 width 0 timing 0
> ...
> 

The problem here is that your controller is giving us false data. So
the MMC core believes it is getting a valid response, hence it thinks
that a card is there and that it's a SDIO card (since that's the first
type probed).

Have you checked that you have proper pull-ups on the lines? And have
you disabled CRC checking in the mmc_spi host? I don't know all the
commands by heart, but some of these should be protected by a CRC.

> 
> Here's the debug info after inserting the card.
> 

*snip*

> user.debug kernel: mmc0: starting CMD51 arg 00000000 flags 000000b5
> user.debug kernel: mmc0:     blksz 8 blocks 1 flags 00000200 tsac 100 ms nsac 0
> user.debug kernel: mmc_spi spi0.1:   mmc_spi: CMD51, resp R1
> user.debug kernel: mmc_spi spi0.1:     mmc_spi: read block, 8 bytes
> user.debug kernel: mmc0: req done (CMD51): 0: 00000000 00000000 00000000 00000000
> user.debug kernel: mmc0:     8 bytes transferred: 0
> user.debug kernel: mmc0: clock 0Hz busmode 2 powermode 2 cs 1 Vdd 21 width 0 timing 0
> !!!

Basically the same problem, but with a card present. The command
returns garbage data, which tricks the MMC core into believing that the
maximum frequency supported by the card is 0 Hz.

> 
> If I then remove the card I get:
> 
> user.warn kernel: mmc_spi_detect_irq
> user.debug kernel: mmc0: starting CMD13 arg 00000000 flags 00000195
> user.debug kernel: mmc_spi spi0.1:   mmc_spi: CMD13, resp R2/R5
> user.debug kernel: mmc0: req done (CMD13): 0: 00000000 00000000 00000000 00000000
> 
> Re-inserting it gives:
> 
> user.warn kernel: mmc_spi_detect_irq
> user.debug kernel: mmc0: starting CMD13 arg 00000000 flags 00000195
> user.debug kernel: mmc_spi spi0.1:   mmc_spi: CMD13, resp R2/R5
> user.debug kernel: mmc0: req done (CMD13): 0: 00000000 00000000 00000000 00000000
> 
> Repeating the remove/insert generates the same debug messages.
> 

Same problem a third time. Because the core gets a reply, although
bogus, it believes the card is still there.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
