From: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] spi: Remove explictly set bus_num and num_chipselect
 to default setting
Date: Tue, 11 Feb 2014 10:28:08 -0800
Message-ID: <52FA6BB8.6030503@caviumnetworks.com>
References: <1392127819.9833.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chris Boot <bootc-1Slo4GeK4H1eoWH0uzbU5w@public.gmane.org>,
	=?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	"Thomas Langer" <thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org>,
	David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>,
	Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392127819.9833.3.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 02/11/2014 06:10 AM, Axel Lin wrote:
> The purpose of commit 1e8a52e18cfb
> "spi: By default setup spi_masters with 1 chipselect and dynamics bus=
 number"
> is to avoid setting default value for bus_num and num_chipselect in s=
pi master
> drivers. So let's remove the duplicate code.

It seems good to me, so ...

>
> Cc: Chris Boot <bootc-1Slo4GeK4H1eoWH0uzbU5w@public.gmane.org>
> Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Thomas Langer <thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org>
> Cc: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Cc: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
> ---
>   drivers/spi/spi-bcm2835.c        | 1 -
>   drivers/spi/spi-efm32.c          | 4 ----
>   drivers/spi/spi-falcon.c         | 2 --
>   drivers/spi/spi-octeon.c         | 2 --
>   drivers/spi/spi-sh-hspi.c        | 1 -
>   drivers/spi/spi-tegra114.c       | 1 -
>   drivers/spi/spi-tegra20-sflash.c | 1 -
>   drivers/spi/spi-tegra20-slink.c  | 1 -
>   drivers/spi/spi-ti-qspi.c        | 1 -
>   9 files changed, 14 deletions(-)
>
[...]
> diff --git a/drivers/spi/spi-octeon.c b/drivers/spi/spi-octeon.c
> index cf88974..a4805f2 100644
> --- a/drivers/spi/spi-octeon.c
> +++ b/drivers/spi/spi-octeon.c
> @@ -257,8 +257,6 @@ static int octeon_spi_probe(struct platform_devic=
e *pdev)
>   	p->register_base =3D (u64)devm_ioremap(&pdev->dev, res_mem->start,
>   					     resource_size(res_mem));
>
> -	/* Dynamic bus numbering */
> -	master->bus_num =3D -1;
>   	master->num_chipselect =3D 4;
>   	master->mode_bits =3D SPI_CPHA |
>   			    SPI_CPOL |

=2E.. this bit:

Acked-By: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
