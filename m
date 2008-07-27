From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Need Help: mmc over spi
Date: Sun, 27 Jul 2008 16:50:04 -0700
Message-ID: <200807271650.04236.david-b@pacbell.net>
References: <63553.216.207.242.34.1216158963.squirrel@www.texascellnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <63553.216.207.242.34.1216158963.squirrel-9hn5j+WQJqK63hpG0/mJ51aTQe2KTcn/@public.gmane.org>
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

On Tuesday 15 July 2008, kbb-DU79CLUmun8xNU+NZBVoVw@public.gmane.org wrote:
> 
> Hopefully a better formed set of questions:
> 
> I am trying to get
> MMC over SPI working in the 2.4.26 kernel.

Good luck with that.  I'd suggest instead 2.6.26 ...

I don't think many folk will be keen on supporting
backports.  In this case, you'd have to back port
both the MMC and the SPI stacks, plus enough driver
model stuff to make it work.  Much easier to just
use a current kernel.


> 
> the .config has
> configured:
> 
> CONFIG_SPI=y
> CONFIG_SPI_MASTER=y
> 
> #
> # SPI Master Controller Drivers
> #
> CONFIG_SPI_BITBANG=y
> # CONFIG_SPI_PXA2XX is not set

You need some SPI master controller though ... presumably
one that uses the bitbang infrastructure, like:

  http://www.spinics.net/lists/arm-kernel/msg45840.html

ISTR using an earlier version of that to debug a bunch
of the original mmc-over-spi code.  :)


> 
> CONFIG_MMC=y
> CONFIG_MMC_DEBUG=y
> CONFIG_MMC_UNSAFE_RESUME=y
> 
> #
> # MMC/SD Card Drivers
> #
> CONFIG_MMC_BLOCK=y
> CONFIG_MMC_BLOCK_BOUNCE=y
> # CONFIG_SDIO_UART is not set
> 
> #
> # MMC/SD Host Controller Drivers
> #
> CONFIG_MMC_SPI=m
> 
> I have added a the pxi_platform_data struct/code to the init
> file.

I take it there's a reason you can't use the PXA MMC controller?
There was a driver for that in some 2.4 kernel versions.


>	...
> 
> I build the mmc_spi driver and I can not get the card detect to
> work at all.
> 
> the interrupt should be GPIO12 w/ either direction
> picked.
> 
> My question is what should be the next step to get this
> going?

The rule of thumb is unfortunate for you:  if you're doing
new ARM work, don't use a 2.4 kernel since otherwise you
won't be getting community support.  In fact, that's a FAQ
sent out weekly on the ARM list.  Last Tuesday's copy:

  2.11. I'm using this 2.4 kernel, and...
	[27 July 2006 - [45]erikm]

	2.4 support has been abandoned. Don't ask questions
	about 2.4 on these lists, use the latest 2.6 kernel,
	and try to recreate the problem. If it still persists,
	then ask on the list.


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
