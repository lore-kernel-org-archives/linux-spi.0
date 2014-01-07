From: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Subject: Re: [PATCH v2 0/8] SoC and board integration for RSPI on RZ/A1H
Date: Tue, 7 Jan 2014 17:52:34 +0900
Message-ID: <20140107085231.GA26477@verge.net.au>
References: <1388175362-17132-1-git-send-email-geert@linux-m68k.org>
 <20140107012628.GD2196@verge.net.au>
 <CAMuHMdW5e74keNhRkSG6q6crGWZ0Gqtb5-hntbCUNm7Md78Bcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdW5e74keNhRkSG6q6crGWZ0Gqtb5-hntbCUNm7Md78Bcw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Jan 07, 2014 at 09:31:17AM +0100, Geert Uytterhoeven wrote:
> On Tue, Jan 7, 2014 at 2:26 AM, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org> wrote:
> >>     [1/8] pinctrl: sh-pfc: r7s72100: Add RSPI support
> >
> > I believe that Laurent should handle this.
> 
> Don't you mean Magnus? This is RZ/A1H, not R-Car.
> 
> >>     [2/8] ARM: shmobile: r7s72100: Add RSPI clocks
> >
> > This seems fine and independent of the other patches.
> > But unfortunately it no longer applies.
> >
> > Feel free to rebase it if you would like me to queue it up sooner
> > than later.
> 
> Will do.
> 
> >>     [3/8] ARM: shmobile: r7s72100: Add RSPI platform devices
> >
> > I assume this depends on 1/3.
> 
> 1/8? Or are you mixing up with 1/3 for Koelsch?

1/8

> Nevertheless, this just adds platform devices, so it should be fairly
> independent.

Ok, thanks. It sounds like I will be able to queue it up
once you repost the series.

> 
> > Please add a patch to update the koelsch defconfig.
> 
> Genmai defconfig, not koelsch.
> 
> >>     [4/8] ARM: shmobile: genmai: Add RSPI children (NEW)
> >
> > This seems reasonable but I assume it depends on earlier patches.
> 
> Yes, it's useless without 3/8. But I guess it will just fail to find the
> SPI bus.

Useless is ok. Its just breakage that I'm concerned about these days :^)

> > Please add a patch to update the koelsch defconfig or Kconfig.
> 
> Genmai ;-) Will do.

Yes, Genmai :)
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
