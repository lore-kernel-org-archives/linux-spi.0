From: Harini Katakam <harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: linux-4.2-rc1/drivers/spi/spi-zynqmp-gqspi.c:215: possible
 missing break ?
Date: Thu, 9 Jul 2015 17:28:14 +0530
Message-ID: <CAFcVECKw+TKTaDhPu+9SFGmTJd0RF78BhoSoh8ixsHRnyy1pxQ@mail.gmail.com>
References: <DUB128-W25045AFECC31BCFA9FC1D59C920@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: David Binderman <dcb314-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <DUB128-W25045AFECC31BCFA9FC1D59C920-MsuGFMq8XAE@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi David,

On Tue, Jul 7, 2015 at 4:43 PM, David Binderman <dcb314-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org> wrote:
> Hello there,
>
> [linux-4.2-rc1/drivers/spi/spi-zynqmp-gqspi.c:218]: (warning) Variable 'genfifocs' is reassigned a value before the old one has been used. 'break;' missing?
>

Yes, thanks.
Dan Carpenter sent this patch to fix it:
 spi: zynq: missing break statement

Regards,
Harini

> Source code is
>
>     case GQSPI_SELECT_FLASH_CS_BOTH:
>         instanceptr->genfifocs = GQSPI_GENFIFO_CS_LOWER |
>             GQSPI_GENFIFO_CS_UPPER;
>     case GQSPI_SELECT_FLASH_CS_UPPER:
>
> Regards
>
> David Binderman
>
>                                           --
> To unsubscribe from this list: send the line "unsubscribe linux-spi" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
