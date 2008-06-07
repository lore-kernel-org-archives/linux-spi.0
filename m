From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: SPI core support for Master
Date: Fri, 06 Jun 2008 22:09:25 -0400
Message-ID: <4849EDD5.8020800@whoi.edu>
References: <AF358A0C5B36EC4486D1A764A171904D03701267@fmsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Ahmed, Suhail" <suhail.ahmed-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AF358A0C5B36EC4486D1A764A171904D03701267-6O2ePOu3Gqekrb+BlOpmy7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
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

Ahmed, Suhail wrote:
> Hello,
> 
> I am newbie on SPI, and subscribed to the mailing list just today!
> 
> I did some reading on the linux SPI support and here is my
> understanding:
> 
> 1.       The controller drivers manages the SPI controller on the host

Yes.

> 2.       The protocol driver manages the SPI devices on the other side
> of the SPI link.

Yes.

> 3.       Currently, there is support only for SPI master mode on the
> host with devices connected as Slaves. 

Yes.

> This essentially means,
> currently, we can have Master controller driver(s) and protocol slave
> drivers

I would not phrase it that way.  The protocol drivers are also operating
as masters with respect to the chips they are controlling.  That might
just be semantics.

> Is the above correct understanding? I will appreciate any correction. 
> 
> Now, if I have a need to support Slave mode on the host with device
> connected in Master mode:
> 
> 1.       Is there any plan to support this configuration?

None that I know of, except in very limited cases, such as when only one
chip is connected to the SPI bus and it only does one thing, such as
always inking data or always sourcing data, without needing to interact
with the Linux slave in an unpredictable way.  That is to say, slave
mode is possible only if the next transfer from the external master is
completely predictable.  An exception might be possible in the case of
very slow clocks.

> 2.       If not, how much work would it be? Can the existing core be
> extended to accommodate this, or is it a re-design?

This has been discussed recently on this mailing list.  I did not hear
any opinions that differed from above.  The problem, as I understand it,
 is that SPI generally expects the slave to respond within one or a few
clocks to requests by the master.  Unless those requests are so
predictable that the Linux slave has preloaded the correct response in
the transmit FIFO, then a timely response is not possible; the interrupt
latency would be too long (except for very slow clocks).

That said, there are examples of predictable slave devices, such as
streaming data, where the next action is always to transfer the next
word.  I have built such a slave data receiver by changing only the
master driver, writing a suitable protocol driver, and NOT touching
anything else in the SPI core.  The protocol driver maintains a queue of
transfer requests (to fetch the next data buffer); the SPI core does not
have to know that it is acting as slave.  The changes I made to the
master driver were extensive (doubling the size of the driver), but that
was mainly because of the high data rate; conceptually I just had to
enable the use of external clocks.

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
