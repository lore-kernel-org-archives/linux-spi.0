From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [06/10,V2] spi: Add SPI driver for mx233/mx28
Date: Tue, 31 Jul 2012 23:36:39 -0700
Message-ID: <20120801063639.GB2764@roeck-us.net>
References: <1341555449-17507-6-git-send-email-marex@denx.de>
	<20120801033559.GB2323@roeck-us.net>
	<20120801045010.GC1672@S2100-06.ap.freescale.net>
	<201208010700.54829.marex@denx.de>
	<20120801052947.GA2400@roeck-us.net>
	<CAM=Q2csm1m8DCd8__NAUCmk6AN=Czg_=nm4c3ervAgOhOtoMTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
To: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAM=Q2csm1m8DCd8__NAUCmk6AN=Czg_=nm4c3ervAgOhOtoMTw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Aug 01, 2012 at 11:16:15AM +0530, Shubhrajyoti Datta wrote:
> On Wed, Aug 1, 2012 at 10:59 AM, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org> wrote:
> > On Wed, Aug 01, 2012 at 07:00:54AM +0200, Marek Vasut wrote:
> >> Dear Shawn Guo,
> >>
> >> > On Tue, Jul 31, 2012 at 08:35:59PM -0700, Guenter Roeck wrote:
> >> > > I think the call to spi_master_put() triggers the call to
> >> > > spi_master_release(). If so, kfree() would not be needed at all, and the
> >> > > documentation is wrong.
> >> >
> >> > Also those drivers calling kfree in probe.
> >>
> >> Looks like that to me ...
> >>
> > Doesn't seem to be far spread, fortunately. Only spi-davinci.c, spi-imx.c, and
> > spi-omap2-mcspi.c
> 
> I have a  omapsdp I could patch spi-omap2-mcspi.c  file thanks for the catch.
>
For that it would be good to determine if there is a memory leak when removing
the driver (I don't see where the memory allocated with spi_alloc_master is
removed).

Thanks,
Guenter

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
