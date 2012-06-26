From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 7/7] ARM: mxs: Add SPI driver for mx233/mx28
Date: Tue, 26 Jun 2012 14:50:27 +0200
Message-ID: <201206261450.27543.marex@denx.de>
References: <1340477033-2761-1-git-send-email-marex@denx.de>
	<201206261422.55005.marex@denx.de>
	<20120626123141.GH8858@S2101-09.ap.freescale.net>
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
In-Reply-To: <20120626123141.GH8858-rvtDTF3kK1ictlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
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

> On Tue, Jun 26, 2012 at 02:22:54PM +0200, Marek Vasut wrote:
> > > > +static int __devexit mxs_spi_remove(struct platform_device *pdev)
> > > > +{
> > > > +	struct spi_master *host;
> > > > +	struct mxs_ssp *ssp;
> > > > +
> > > > +	host = platform_get_drvdata(pdev);
> > > > +	if (host)
> > > > +		return 0;
> > > 
> > > Hmm, why the check and return here?
> > 
> > If it's not set, things went _very_ wrong somewhere. Maybe BUG_ON() might
> > be better?
> 
> So shouldn't it be "if (!host)"?
> 
> And I still do not understand how that could happen.  I think
> mxs_spi_remove will only be called in case that mxs_spi_probe
> succeeds, which means platform_set_drvdata must have been called
> already?

Ok, we can remove that altogether then.

Best regards,
Marek Vasut

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
