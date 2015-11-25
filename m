From: lei liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 4/4] spi: mediatek: revise mtk_spi_probe() failure flow
Date: Wed, 25 Nov 2015 17:17:53 +0800
Message-ID: <1448443073.27169.7.camel@mhfsdcap03>
References: <1447986080-31410-1-git-send-email-leilk.liu@mediatek.com>
	 <1447986080-31410-4-git-send-email-leilk.liu@mediatek.com>
	 <20151121133949.GH26072@sirena.org.uk>
	 <1448332404.27169.4.camel@mhfsdcap03> <20151124130426.GL1929@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Sascha Hauer" <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"Matthias Brugger" <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151124130426.GL1929-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, 2015-11-24 at 13:04 +0000, Mark Brown wrote:
> On Tue, Nov 24, 2015 at 10:33:24AM +0800, lei liu wrote:
> > On Sat, 2015-11-21 at 13:39 +0000, Mark Brown wrote:
> > > On Fri, Nov 20, 2015 at 10:21:19AM +0800, Leilk Liu wrote:
> 
> > > > This patch revises failure flow while pm_runtime_enable().
> 
> > > Why?  This also doesn't apply against current code, please check and
> > > resend.
> 
> > I don't know. I can git am this patch to spi/for-next. I will resend it,
> > please help to apply it again, thanks.
> 
> If you don't know why we should make this change then we may as well
> just not make it?

OK. I will write a proper commit message to explain what this patch
does. Thanks.

> _________________
> ______________________________
> Linux-mediatek mailing list
> Linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
