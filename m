From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH v2 2/3] Doc: spi: document the transfer_one spi_master callback
Date: Fri, 24 Jan 2014 09:47:10 +0100
Message-ID: <CAMuHMdVrNcs0uWfVNdXGw+HTuGHy2nGXR=tMqdzz236LGFHVoQ@mail.gmail.com>
References: <cover.1390552232.git.baruch@tkos.co.il>
	<1abe062855111800754477d1340635b5a69d5635.1390552232.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1abe062855111800754477d1340635b5a69d5635.1390552232.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Jan 24, 2014 at 9:36 AM, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org> wrote:
> +++ b/Documentation/spi/spi-summary
> @@ -545,6 +545,16 @@ SPI MASTER METHODS
>         spi_finalize_current_message() so the subsystem can issue the next
>         transfer. This may sleep.
>
> +    master->transfer_one(struct spi_master *master, struct spi_device *spi,
> +                        struct spi_transfer *transfer)
> +       The subsystem calls the driver to transfer a single transfer while
> +       queuing transfers that arrive in the meantime. When the driver is
> +       finished with this message, it must call
> +       spi_finalize_current_transfer() so the subsystem can issue the next
> +       transfer. This may sleep. Note: transfer_one and transfer_one_message
> +       are mutually exclusive; when both are set, the generic subsystem does
> +       not call your transfer_one callback.

You still forgot the updates I made in
http://lkml.indiana.edu/hypermail/linux/kernel/1401.2/02465.html

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
