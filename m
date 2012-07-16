From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 04/10 RESEND] mmc: spi: Pull out parts shared between MMC
	and SPI
Date: Mon, 16 Jul 2012 12:59:14 +0200
Message-ID: <201207161259.15034.marex@denx.de>
References: <1341555449-17507-1-git-send-email-marex@denx.de>
	<1341555449-17507-4-git-send-email-marex@denx.de>
	<20120716095741.85d959fc81ab759b10adcf25@kinali.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>,
	Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>,
	Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Attila Kinali <attila-HB9FjVmMKa7tRgLqZ5aouw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120716095741.85d959fc81ab759b10adcf25-HB9FjVmMKa7tRgLqZ5aouw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Dear Attila Kinali,

> Moin,
> 
> I just wanted to try out this patchset as i have a use for proper spi
> support on i.mx23. But this patch (4/10) fails to apply at line 635
> 
[...]

> > +	struct mxs_ssp *ssp;
> > 
> >  	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	dmares = platform_get_resource(pdev, IORESOURCE_DMA, 0);
> 
> The function variables do not match.
> 
> Also a 3way merge didnt work as the comit on which this patchset was
> based on wasnt found. I tried linux, linux-next, and the imx repos
> from pengutronix and Shawn, to no avail.
> 
> Is there any other repo around that i'm not aware of?
> 
> 			Attila Kinali

Well I have it rebased on top of current -next, but ... will some of the SPI 
maintainers possibly apply it to their -next tree any soon? Or why are these 
patches stuck as they are without much review ?

It seems Shawn is OK with the latest version, so can these be applied? I'll post 
the rebased version again if necessary.

Best regards,
Marek Vasut

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
