From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 09/13] spi: atmel: use endian agnostic IO
Date: Thu, 19 Mar 2015 09:53:55 +0100
Message-ID: <550A8EA3.4000903@atmel.com>
References: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk> <1426693992-31163-10-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, open list:
	SPI SUBSYSTEM <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	"Yang, Wenyou" <Wenyou.Yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, ;
To: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426693992-31163-10-git-send-email-ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Le 18/03/2015 16:53, Ben Dooks a =E9crit :
> Use the endian agnositc IO functions instead of the __raw ones for wh=
en
> the driver is in use on big-endian systems.
>=20
> Signed-off-by: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>

Looks good to me:
Acked-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Mark,
There is no dependency on the series, so you can take this one right no=
w.

Bye.

> --
> CC: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> (supporter:ATMEL SPI DRIV=
ER)
> CC: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> (maintainer:SPI SUBSYSTEM)
> CC: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list:SPI SUBSYSTEM)
> ---
>  drivers/spi/spi-atmel.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 06de340..a2f40b1 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -180,11 +180,17 @@
>  	  | SPI_BF(name, value))
> =20
>  /* Register access macros */
> +#ifdef CONFIG_AVR32
>  #define spi_readl(port, reg) \
>  	__raw_readl((port)->regs + SPI_##reg)
>  #define spi_writel(port, reg, value) \
>  	__raw_writel((value), (port)->regs + SPI_##reg)
> -
> +#else
> +#define spi_readl(port, reg) \
> +	readl_relaxed((port)->regs + SPI_##reg)
> +#define spi_writel(port, reg, value) \
> +	writel_relaxed((value), (port)->regs + SPI_##reg)
> +#endif
>  /* use PIO for small transfers, avoiding DMA setup/teardown overhead=
 and
>   * cache operations; better heuristics consider wordsize and bitrate=
=2E
>   */
>=20


--=20
Nicolas Ferre
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
