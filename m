From: "J. Scott Merritt" <merrij3-IL7dBOYR4Vg@public.gmane.org>
Subject: PXA270 SSPSFRM gates chip select ?
Date: Mon, 11 Feb 2008 17:43:39 -0500
Message-ID: <20080211174339.73ca7ed5.merrij3@rpi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	stephen-nl6u4wocdmy51APUEpUfAkEOCMrvLtNR@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Reposted from linux-arm-kernel mailing list ... at the suggestion
of David Brownell.

Using pxa2xx_spi from Kernel 2.6.21.  PXA270 is SSP Master in
SPI_MODE_3 (SPO=1, SPH=1) with internal clock and GPIO's used as
external chip selects.

On the very first message after boot, I am receiving an extra clock
pulse at the slave device (causing the whole message to be "shifted").

It appears that on the first message, the Chip Select is activated
before the SPO=1/SPH=1 is fully established in the PXA's SSP hardware,
resulting in an extra, positive-going transition of SSPSCLK as it
attempts to establish the proper (high) clock level for the SPH=1
setting.

Testing was performed on Kernal 2.6.21, but it appears that 2.6.24
also performs the chip select call before updating SSCR0 & SSCR1.
Slave device is NXP LPC2366.

I have tried setting the "default" in pxa2xx_spi.c to SPO=1, SPH=1;
but still have the clock riding low before the first chip select.

... David Brownell responds:

Actually, the SPI_CPOL mode bit controls the clock polarity
before the chip select coes active:  CPOL=0 should mean it's
forced low (if it isn't already low).

So if that driver is doing chipselect *then* clock setup,
it's doing the wrong thing.  A patch would be appreciated...

...
Thanks, Scott.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
