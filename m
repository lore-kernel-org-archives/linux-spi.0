From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [06/10,V2] spi: Add SPI driver for mx233/mx28
Date: Tue, 31 Jul 2012 23:39:36 -0700
Message-ID: <20120801063936.GC2764@roeck-us.net>
References: <1341555449-17507-6-git-send-email-marex@denx.de>
	<20120801054228.GA2645@roeck-us.net>
	<20120801062838.GF1672@S2100-06.ap.freescale.net>
	<201208010810.37652.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
	Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201208010810.37652.marex-ynQEQJNshbs@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Aug 01, 2012 at 08:10:37AM +0200, Marek Vasut wrote:
> Dear Shawn Guo,
> 
> > On Tue, Jul 31, 2012 at 10:42:28PM -0700, Guenter Roeck wrote:
> > > On Wed, Aug 01, 2012 at 01:58:56PM +0800, Shawn Guo wrote:
> > > > On Tue, Jul 31, 2012 at 10:29:47PM -0700, Guenter Roeck wrote:
> > > > > Anyone up for writing some patches ? If not, I'll do it.
> > > > 
> > > > Go ahead.
> > > 
> > > Ok, will do. It isn't that simple, actually, since at least some of the
> > > drivers also call spi_master_get(), and thus need two calls to
> > > spi_master_put() (or a call to spi_master_put and a call to kfree).
> > 
> > Hmm, are you saying that there must be a spi_master_put call matching
> > spi_alloc_master?  I think we only need to have spi_master_get and
> > spi_master_put matched.
> 
> Naw, spi_master_get() does refcounting, spi_alloc_master() doesnt. You don't 
> need to match spi_alloc_master() with spi_master_put()
> 
I must be missing something.  Why do almost all spi drivers call it in the error
path, even if there is no call to spi_master_get ?

Thanks,
Guenter

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
