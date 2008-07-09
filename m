From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: Problems with latency
Date: Wed, 09 Jul 2008 10:22:30 -0400
Message-ID: <4874C9A6.8020009@whoi.edu>
References: <33e9dd1c0806242302y4e39b869n4a64f4955cc71dd5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Zik Saleeba <zik-fsgeVU6Z5FysTnJN9+BGXg@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <33e9dd1c0806242302y4e39b869n4a64f4955cc71dd5-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

Zik Saleeba wrote:
> I'm writing a driver for the NXP sc16is752 serial chip. This chip is
> accessed via SPI. I've actually had a working driver for quite some time now
> but I've been having problems with it since I changed from 2.6.16 to
> 2.6.24.Occasionally the driver fails due to its 64 byte receive buffer
> overflowing
> before I can get the data.
> 
> I've set the serial chip's receive buffer interrupt level to 16 bytes - so
> after I've received 16 bytes I have to get the data before the buffer
> overflows its 64 byte limit. This isn't too demanding - I need to have it
> done within 8ms of getting the interrupt at 57600bps. The tricky part is
> that I need to do three separate register reads to get status before I can
> do the final buffer read so it's actually four SPI transactions. And what's
> more the chip has two serial ports so I need to check both - which makes it
> up to eight SPI transactions.
> 
> Normally this is absolutely no problem - the bottom half work queue fires up
> and the SPI subsystem on my pxa2xx romps it in. Once in a while however the
> latency between the interrupt and removing the data is much, much longer and
> the chip's receive buffer overflows. This happens enough that it makes the
> driver unusable at higher bit rates.
> 
> Does anyone have any suggestions what might be causing these random latency
> jumps, and also whether it might be related to work queue latency or to
> pxa2xx spi delays?

Perhaps you have found a solution by now.  I have been away.

The only suggestion I have is a general one, not specifically related to
the driver.  In my application, I read from an SPI device at 11MBit/sec,
and write the data to an NFS server elsewhere on the network.  I found
that if I did not do frequent fdatasync() calls on the NFS file from my
user-space code, then Linux would simply queue huge amounts of data in
the PXA255's 64MB RAM, and would not actually write to the network until
the RAM was nearly full.  When it did finally write to the network,
there were huge latencies (nearly a second) in interrupt service to the
SPI.  By forcing it to write in smaller chunks, the latency problem
disappeared.  I have no idea whether this could be related to your problem.

-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079


-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
