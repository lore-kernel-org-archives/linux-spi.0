From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: New bug?
Date: Wed, 19 Feb 2014 13:06:33 +0100
Message-ID: <CAMuHMdVBY7M=dkegw_3pQ7yFSLLEe2T6pXidY=eL7oiYAXXoPQ@mail.gmail.com>
References: <1392795133.984411895@f316.i.mail.ru>
	<CAMuHMdUTVAey=9rmU0xRomEomBk1erMoH-jnu8Szg=OcZWbLog@mail.gmail.com>
	<1392808849.211941090@f415.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392808849.211941090-PR9Oqn8FVc1sdVUOrk1QfQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Feb 19, 2014 at 12:20 PM, Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org> wrote:
> Mark, Is any chances to put these two patches to 3.13-stable?
> (spi: core: Fix transfer failure when master->transfer_one returns positive value),
> (spi: Fix crash with double message finalisation on error handling)

The second one should not need backporting, as the patch it reverts
is not in v3.13.

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
