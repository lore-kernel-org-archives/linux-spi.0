From: H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH 0/3] spi: driver for Cirrus EP93xx
 SPI	controller
Date: Mon, 15 Mar 2010 13:22:51 -0500
Message-ID: <0D753D10438DA54287A00B0270842697636853334B@AUSP01VMBX24.collaborationhost.net>
References: <cover.1268669236.git.mika.westerberg@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <cover.1268669236.git.mika.westerberg-X3B1VOXEql0@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Monday, March 15, 2010 9:26 AM, Mika Westerberg wrote:
> Hello,
> 
> This series provides SPI master controller driver implementation for
> Cirrus Logic EP93xx controllers.
> 
> I've tested this on my TS-7260 board with SPI EEPROM (through at25 driver)
> and with few SD/MMC cards that I own (through mmc_spi driver). Unfortunately
> I don't have other SPI devices so if someone wants to try this, it would be
> great (see [1] for example code that I used with MMC cards).
> 
> This series applies on top of Linus' 2.6.34-rc1.
> 
> Please review.
> 
> Thanks,
> MW

Hello Mika,

I also have a SPI driver (originally from Bluewater Systems) that I have been
sitting on.  Your's has the advantage of using interrupts and is already
coded for 16-bit targets, mine is currently polled and only handles 8-bit
targets.

Based on that I'll try to help you get yours merged instead.

I already responded to patch 2/3.  Overall it's fine I would just like
the code moved a bit in the source files.  Please review the comments.

Patch 3/3 looks ok initially.  I think you are hindering the chip-select
options but I will work that out when I go through the patch 1/3.

Patch 1/3 looks good for a start.  The only problem I see is your
limitation to only using built-in gpio's for chipselects.

I will try to get your patches merged into my tree this week and test
them.  At that point I will provide more feedback and try to address
the chipselect limitation.

Thanks for the submission.

Regards,
Hartley

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
