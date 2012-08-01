From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [06/10,V2] spi: Add SPI driver for mx233/mx28
Date: Tue, 31 Jul 2012 23:33:26 -0700
Message-ID: <20120801063326.GA2764@roeck-us.net>
References: <1341555449-17507-6-git-send-email-marex@denx.de>
	<20120801033559.GB2323@roeck-us.net>
	<20120801045010.GC1672@S2100-06.ap.freescale.net>
	<201208010700.54829.marex@denx.de>
	<20120801052947.GA2400@roeck-us.net>
	<20120801055854.GE1672@S2100-06.ap.freescale.net>
	<20120801054228.GA2645@roeck-us.net>
	<20120801062838.GF1672@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120801062838.GF1672-+NayF8gZjK2ctlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Aug 01, 2012 at 02:28:40PM +0800, Shawn Guo wrote:
> On Tue, Jul 31, 2012 at 10:42:28PM -0700, Guenter Roeck wrote:
> > On Wed, Aug 01, 2012 at 01:58:56PM +0800, Shawn Guo wrote:
> > > On Tue, Jul 31, 2012 at 10:29:47PM -0700, Guenter Roeck wrote:
> > > > Anyone up for writing some patches ? If not, I'll do it.
> > > > 
> > > Go ahead.
> > > 
> > Ok, will do. It isn't that simple, actually, since at least some of the drivers
> > also call spi_master_get(), and thus need two calls to spi_master_put() (or a
> > call to spi_master_put and a call to kfree).
> > 
> Hmm, are you saying that there must be a spi_master_put call matching
> spi_alloc_master?  I think we only need to have spi_master_get and
> spi_master_put matched.
> 
Yes, I think that may be so. Of course, I may be wrong, but ultimately that is
what almost all drivers do in the probe error path. Some of the drivers do it in
the remove path as well, though many don't. I suspect that all drivers using
spi_alloc_master() which do not call spi_master_put() in the remove function may
have a memory leak.

Someone who knows the spi infrastructure better than I should have a closer
look, though. The question is really quite simple: For example, in spi-atmel.c,
how is the allocated master freed in the _remove function ? If it doesn't need
the call to spi_master_put(), why do, for example, spi-stmp.c or spi-mpc52xx.c
call it ?

On the other side, I must admit I am getting more and more confused after
looking into the code. For example, the probe function error path in spi-mpc52xx.c
accesses the master's devdata after the call to spi_master_put(). If
spi_master_put() frees the memory as we think it does, the code would access
freed memory. The same happens in the remove path. And spi_master_put() is not
always called, meaning there is either a memory leak or I am completely confused.

Thanks,
Guenter

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
