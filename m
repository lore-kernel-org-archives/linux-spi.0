From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: rspi: Fix leaking of unused DMA descriptors
Date: Tue, 5 Aug 2014 16:34:40 +0200
Message-ID: <CAMuHMdX4bDMogeSwmd3bxm_fKpjouxZJFT_dd5ErxgJkZ2U=cA@mail.gmail.com>
References: <1405094802-14401-1-git-send-email-geert+renesas@glider.be>
	<20140714185830.GE6800@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	Laurent Pinchart <Laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140714185830.GE6800-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On Mon, Jul 14, 2014 at 8:58 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, Jul 11, 2014 at 06:06:41PM +0200, Geert Uytterhoeven wrote:
>> If dmaengine_prep_slave_sg() or dmaengine_submit() fail, we may leak
>> unused DMA descriptors.
>
> This doesn't apply, I guess it may depend on some of your other DMA
> related patches but it's not immediately obvious and it's not been sent
> as part of a series.  Can you please check and/or clarify?

Indeed, this (and the rspi one) depended on the two "Handle
dmaengine_prep_slave_single() failures gracefully" patches.

Unless you recover them from e.g. patchwork, I'll resend them with my
next batch.

Sorry for the fuzz.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
