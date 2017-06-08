From: lei liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: mediatek: support adjust register define
Date: Thu, 8 Jun 2017 09:41:03 +0800
Message-ID: <1496886063.30249.1.camel@mhfsdcap03>
References: <1496387923-31674-1-git-send-email-leilk.liu@mediatek.com>
         <1496387923-31674-3-git-send-email-leilk.liu@mediatek.com>
         <20170606185730.mrvgvp4hynftwahx@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170606185730.mrvgvp4hynftwahx-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, 2017-06-06 at 19:57 +0100, Mark Brown wrote:
> On Fri, Jun 02, 2017 at 03:18:42PM +0800, Leilk Liu wrote:
> 
> > +	/* some IC design adjust register define */
> > +	bool adjust_reg;
> 
> Can we have a name that's more specific to the particular quirk please?
> The current name will get confusing if some future chip also needs
> slightly different register settings.
> 
thanks for your suggestion, I'll fix it.

> Otherwise this looks good.


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
