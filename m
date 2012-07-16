From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: Linux SPI slave support
Date: Mon, 16 Jul 2012 02:26:19 +0200
Message-ID: <201207160226.19409.marex@denx.de>
References: <201206300515.41575.marex@denx.de>
	<CAM=Q2cs8zGTMu+Du1E8aLkiLpyB6mVH=Omt7pJRe1iFBb+Zqaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CAM=Q2cs8zGTMu+Du1E8aLkiLpyB6mVH=Omt7pJRe1iFBb+Zqaw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Dear Shubhrajyoti Datta,

> Hello,
> 
> On Sat, Jun 30, 2012 at 8:45 AM, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org> wrote:
> > Hello,
> > 
> > is there currently any ongoing effort to support SPI slave mode in Linux?
> > 
> > If there is none, could you please share any hints that might help me
> > better choose and go in the direction of implementing the SPI slave
> > support?
> 
> May be you may want to check the archives.
> You may want to see below before designing.
> 
> http://permalink.gmane.org/gmane.linux.kernel.spi.devel/7495
[...]

So, idea V2:

1) Separate out common parts from struct spi_master
2) Create struct spi_slave
2a) Implement spi_slave_send_message for spi_slave
2b) Implement <?> netlink interface to push and pull messages to/from userland ?

The protocol won't be done in kernel, but completely in userland.

Is this good approach to take? Or maybe 2b can be replaced by blocking read on 
character device? I think netlink interface might actually be suited quite well 
for this task.

Best regards,
Marek Vasut

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
