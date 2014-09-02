From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 2/4] spi: atmel: remove unnecessary #if defined(CONFIG_OF)
Date: Tue, 2 Sep 2014 14:15:09 +0200
Message-ID: <CAMuHMdU2S_vwv3=CUtgGjqnq-nbh=up42gDWzR35ai6s4ZVaWQ@mail.gmail.com>
References: <002a01cfc65d$2dc86640$895932c0$%han@samsung.com>
	<002b01cfc65d$569ef570$03dce050$%han@samsung.com>
	<20140902105018.GR29327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140902105018.GR29327-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Sep 2, 2014 at 12:50 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Sep 02, 2014 at 12:24:00PM +0900, Jingoo Han wrote:
>> Remove unnecessary  #if defined(CONFIG_OF), because this is
>> already handled by the of_match_ptr macro.
>
> Applied, thanks.

If CONFIG_OF is not set, binary size is increased, as the OF match
table is still emitted, while it's no longer in use:

m68k allmodconfig:

   text   data    bss    dec    hex filename
   7318    373      0   7691   1e0b drivers/spi/spi-atmel.o.old
   7710    373      0   8083   1f93 drivers/spi/spi-atmel.o.new
  10037    781      0  10818   2a42 drivers/spi/spi-atmel.ko.old
  10465    781      0  11246   2bee drivers/spi/spi-atmel.ko.new

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
