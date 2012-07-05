From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 6/8] mmc: spi: Add SPI driver for mx233/mx28
Date: Thu, 5 Jul 2012 07:39:49 +0200
Message-ID: <201207050739.49912.marex@denx.de>
References: <1340958180-2291-1-git-send-email-marex@denx.de>
	<1340958180-2291-6-git-send-email-marex@denx.de>
	<20120705005143.GF2595@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>,
	Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
	Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120705005143.GF2595-rvtDTF3kK1ictlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Dear Shawn Guo,

> On Fri, Jun 29, 2012 at 10:22:58AM +0200, Marek Vasut wrote:
> > +config SPI_MXS
> > +	tristate "Freescale MXS SPI controller"
> > +	depends on ARCH_MXS
> > +	help
> > +	  SPI driver for Freescale MXS devices.
> > +
> 
> ...
> 
> > +	stmp_reset_block(ssp->base);
> > +
> 
> So SPI_MXS may need to select STMP_DEVICE.

Ok, fixed in my tree. But, where's the meteor shower of nitpicks and such stuff? 
Or is the driver so good you have nothing to pick on? ;-)

Best regards,
Marek Vasut

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
