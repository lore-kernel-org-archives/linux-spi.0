From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH V2 4/8] spi: rspi: Add support for 8-bit Data Register access
Date: Mon, 13 Jan 2014 14:29:28 +0100
Message-ID: <CAMuHMdViLJD9O4gnovR6x7RTWor9GYPBZuzP5X7JmVw5g=o4kw@mail.gmail.com>
References: <1389522464-1569-1-git-send-email-geert@linux-m68k.org>
	<1389522464-1569-5-git-send-email-geert@linux-m68k.org>
	<20140113122912.GT29039@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140113122912.GT29039-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Jan 13, 2014 at 1:29 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> +static int rspi_parse_platform_data(struct rspi_data *rspi,
>> +                                 const struct rspi_plat_data *rspi_pd)
>> +{
>> +     if (rspi_pd && rspi_pd->data_width) {
>> +             rspi->data_width = rspi_pd->data_width;
>> +             switch (rspi_pd->data_width) {
>> +             case 8:
>> +                     rspi->spdcr = SPDCR_SPLBYTE;
>> +                     break;
>> +             case 16:
>> +                     rspi->spdcr = SPDCR_SPLWORD;
>> +                     break;
>> +             default:
>> +                     return -EINVAL;
>> +             }
>> +     } else {
>> +             /*
>> +              * Use legacy 16-bit width data access if a data_width value
>> +              * isn't defined in the platform data.
>> +              */
>> +             rspi->data_width = 16;
>> +             rspi->spdcr = 0;
>> +     }
>
> This looks very strange - if no platform data is specified the value set
> for spdcr is one that can't be arrived at via platform data.  What's
> going on here?  It'd seem more idiomatic to treat missing platform data
> and a zero data_width identically too.

The else branch is also taken when platform data is specified, but
data_width is zero. So you can indicate legacy 16-bit data width through
platform data.
It's unfortunate that the bits inside spdcr to configure the data width are
different for RSPI on SH and RSPI on ARM.

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
