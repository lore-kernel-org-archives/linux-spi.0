From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: am335x: spi driver and two chip select
Date: Tue, 12 Apr 2016 15:50:21 +0200
Message-ID: <CAMuHMdWtHYNLcbX65HzuV6fyPENMR75XrVQ8RkW=y_T=hN44+g@mail.gmail.com>
References: <CAF+MRt=ZJP2fssLHRUoR9T9EPfWEPN1LC0CLxZ0CgJQy01S3Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Micka <mickamusset-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAF+MRt=ZJP2fssLHRUoR9T9EPfWEPN1LC0CLxZ0CgJQy01S3Rw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Micka,

On Tue, Apr 12, 2016 at 3:42 PM, Micka <mickamusset-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> I've two MAX3107 connected to the spi 1 line. ( chip select 0 and 1 )
>
> The problem is that when the spi driver start the probe function of
> the driver, the chip select of the second max3107 is set to low .....
>
> During the first call of the probe function, the driver try to read a
> register on the first device, but because of the second chip select
> set to low, the two device answer at the same time .... I don't really
> understand why ?
>
> I've correctly configured the CS1 and CS0 to be set as an output with
> a pull up ....
>
>
> &spi1{
> #address-cells = <1>;
> #size-cells = <0>;
> pinctrl-names = "default";
> pinctrl-0 = <&bb_spi1_pins>;
> status = "okay";
> ti,pindir-d0-out-d1-in;

Guessing from the DT, you're using "ti,omap4-mcspi"?

AFAIU, spi_master.setup() should not modify registers immediately when
supporting more than a single CS signal, while omap2_mcspi_setup_transfer()
seems to do that.

Probably the second SPI slave is set up while performing a transfer to
the first SPI slave.

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
