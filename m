From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] spi: pl022: Fix broken spidev when DMA is enabled
Date: Thu, 9 Oct 2014 15:59:05 +0200
Message-ID: <CAMuHMdUyP-caZxTNWTTF1Z84+=RWzi673LdRbmd_Bovr_G0kqA@mail.gmail.com>
References: <rjui@broadcom.com>
	<1412743127-4523-1-git-send-email-rjui@broadcom.com>
	<20141008112143.GT4609@sirena.org.uk>
	<543562EB.8060300@broadcom.com>
	<20141008182123.GH4609@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	JD Zheng <jdzheng-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141008182123.GH4609-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Oct 8, 2014 at 8:21 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Oct 08, 2014 at 09:14:35AM -0700, Ray Jui wrote:
>> Thanks for the reply. It looks like you are also the maintainer of spidev.
>> In this case, could you please help to confirm that you expect spidev to use
>> separate buffers for TX and RX? If so, I can go ahead and make the change in
>> spidev.
>
> Yes, that would be my expectation for maximum robustness (or if it is
> going to use one buffer it explicitly maps it for mixed use but I'd
> expect that to be asking for trouble).

Having two separate buffers avoids false successes when running
"spidev_test --loop" on a buggy SPI master driver.
Been there, done that ;-)

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
