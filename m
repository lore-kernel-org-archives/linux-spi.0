From: "Ahmed, Suhail" <suhail.ahmed-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: SPI core support for Master
Date: Fri, 20 Jun 2008 09:42:57 -0700
Message-ID: <AF358A0C5B36EC4486D1A764A171904D037F233E@fmsmsx411.amr.corp.intel.com>
References: <AF358A0C5B36EC4486D1A764A171904D03701267@fmsmsx411.amr.corp.intel.com>
	<4849EDD5.8020800@whoi.edu>
	<AF358A0C5B36EC4486D1A764A171904D037400B6@fmsmsx411.amr.corp.intel.com>
	<4856C913.3020200@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Ned Forrester" <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <4856C913.3020200-/d+BM93fTQY@public.gmane.org>
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

Thanks! I got your files!

~Suhail

-----Original Message-----
From: Ned Forrester [mailto:nforrester-/d+BM93fTQY@public.gmane.org] 
Sent: Monday, June 16, 2008 1:12 PM
To: Ahmed, Suhail
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: Re: [spi-devel-general] SPI core support for Master

Ahmed, Suhail wrote:
> Thanks Ned for your response on this.

Sorry for the delay, I have been busy.

> You mention that you have written a slave data receiver by modifying
the
> master driver. A few questions on this:
> 
> 1. Can I get this code? Assuming that this is opensource under GPL.

I can send the modified master driver, pxa2xx_spi.c/pxa2xx_spi.h, by
private email (I don't think anyone would want me to post 160kb to the
list).  However, after talking on the phone, I don't think that this
will do you any good.  It implements high-speed data input from a single
master.  The primary changes from the distributed version of
pxa2xx_spi.c are:

1. enabling external clocks,

2. enabling alternate data protocols (I use TI synchronous),

3. enabling read-without-transmit (RWOT) mode (very hard, for a
continuous master source),

4, implementing chaining of transfers when the next transfer is similar
to the current transfer, and

5. implementing descriptor driven DMA (so that chained transfers can
continue, for a while, without processor intervention).

I think the distributed version of pxa2xx_spi.c will do what you want
with the exception of items 1 & 2 above, which are trivial.
Furthermore, the version I have written compiles on 2.6.20; you are on
your own for any other kernel version.

> 2. When I look at the SPI core code, it has support only for master
> structure and APIs such as
> spi_register_master(),spi_master_get_devdata(), and data structures
like
> struct spi_master, all master specific. So: In your modification to
the
> master driver, did you basically maintain the same apis/structs and
just
> "used" them as is for slave implementation? 

Of course you did not list the most important element of the API:
spi_async, which is called by the protocol driver and actually passes
messages/transfers to the master driver; this call and many others are
defined in include/linux/spi/spi.h.

I *exactly* maintained the APIs and structs defined in the SPI Core.
The only distributed files I changed are drivers/spi/pxa2xx_spi.c,
include/asm/arch/spi/pxa2xx_spi.h, added one bit definition to
include/asm/arch/spi/pxa_reg.h or regs_ssp.h (fixed an omission, patch
available in Linus' GIT tree: spi: pxa2xx_spi clock polarity fix), and
added my chip definitions to arch/arm/mach-pxa/gumstix.c.

Of course, I also wrote a protocol driver to link user space calls
(open, read, write, close) through pxa2xx_spi.c to my "chip", and user
space code to collect and forward the data from the "chip".  I am sorry
I cannot distribute those, but you can read the spi documentation in
Documentation/spi, and I recommend "Linux Device Drivers", Corbet, et
al. from O'Reilly.

> Btw: We are trying the add support for a modem connected to a Linux
> Host. The modem is in master mode.

Arbitrating switching of masters via an out-of-band method, as you
discussed on the phone, may present some additional challenges that I
have not thought about.

-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
