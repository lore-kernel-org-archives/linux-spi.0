From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: DSPI slave linux driver
Date: Mon, 02 Mar 2009 13:41:03 -0500
Message-ID: <49AC283F.2000708@whoi.edu>
References: <5a775e870903020620k56f84f7cwfa6c11cbb4a9277a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: sivakumar borela <borelaskumar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <5a775e870903020620k56f84f7cwfa6c11cbb4a9277a-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

sivakumar borela wrote:
> Hi,
> 
> My selef, SivaKumar working as Embedded software engineer. One of our
> products is based on MCF5485 coldfire processor. We are using Embedded linux
> from Freescale on our board. The BSP does have DSPI(DMA enabled SPI) master
> driver. But our requirement is to configure MCF5485 as DSPI slave to
> communicate with the external master which is 68332 processor board. The
> protocol demands request/response model to communicate with the master. We
> could not able to succeed in making the DSPI slave to work.
> 
> "Changed the chip control register from master to salve by modifying the bit
> in mode control register"
> 
> We are not getting any interrupts from the processor to call read and write
> functions.
> 
> Freescale has done customization of coldfire_spi driver for MCF5485.
> 
> First of all my query is
> 1) is there any piece of linux spi slave driver till now?
> 2) If you have any slave driver implementation , could you please provide
> the code for me to implement the SPI slave?

There is no support for a Linux host slave.  This has been discussed
several times before.  I suggest you search the archives of this mailing
list, and read the previous discussion. The official archive of
spi-devel-general is at:

http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general

but I don't find that very searchable.  Try this thread:

http://www.mail-archive.com/spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org/msg00306.html

which I found by googling these four key words:

spi-devel-general spi slave support

And another thread is here...

http://www.mail-archive.com/spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org/msg01123.html

--

The most serious problem for generalized slave support is the response
time of the kernel to external requests; this is discussed in the
threads above.  Some limited slave support can be created, where
applications are transmit-only or receive-only, but not both, or any
other situation in which the communication sequence is completely
predictable and thus the response data can be queued in advance.  All of
these possibilities are probably limited to configurations where there
is only one device attached to the SPI bus.

-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079


------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
