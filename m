From: Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [06/10,V2] spi: Add SPI driver for mx233/mx28
Date: Wed, 1 Aug 2012 08:41:34 +0200
Message-ID: <201208010841.34805.marex@denx.de>
References: <1341555449-17507-6-git-send-email-marex@denx.de>
	<CAM=Q2csm1m8DCd8__NAUCmk6AN=Czg_=nm4c3ervAgOhOtoMTw@mail.gmail.com>
	<20120801063639.GB2764@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>,
	Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
	Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120801063639.GB2764-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Dear Guenter Roeck,

> On Wed, Aug 01, 2012 at 11:16:15AM +0530, Shubhrajyoti Datta wrote:
> > On Wed, Aug 1, 2012 at 10:59 AM, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org> wrote:
> > > On Wed, Aug 01, 2012 at 07:00:54AM +0200, Marek Vasut wrote:
> > >> Dear Shawn Guo,
> > >> 
> > >> > On Tue, Jul 31, 2012 at 08:35:59PM -0700, Guenter Roeck wrote:
> > >> > > I think the call to spi_master_put() triggers the call to
> > >> > > spi_master_release(). If so, kfree() would not be needed at all,
> > >> > > and the documentation is wrong.
> > >> > 
> > >> > Also those drivers calling kfree in probe.
> > >> 
> > >> Looks like that to me ...
> > > 
> > > Doesn't seem to be far spread, fortunately. Only spi-davinci.c,
> > > spi-imx.c, and spi-omap2-mcspi.c
> > 
> > I have a  omapsdp I could patch spi-omap2-mcspi.c  file thanks for the
> > catch.
> 
> For that it would be good to determine if there is a memory leak when
> removing the driver (I don't see where the memory allocated with
> spi_alloc_master is removed).

When the refcounting for the device reaches 0, it's deallocated. (Aka _put long 
enough and it'll disappear)

> Thanks,
> Guenter

Best regards,
Marek Vasut

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
