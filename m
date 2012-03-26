From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] spi-imx: Remove duplicate spi_imx_data definition
Date: Mon, 26 Mar 2012 22:59:40 +0200
Message-ID: <20120326205940.GM15647@pengutronix.de>
References: <1332785632-17799-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1332785632-17799-1-git-send-email-fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Mar 26, 2012 at 03:13:52PM -0300, Fabio Estevam wrote:
> Structure struct spi_imx_data is defined twice.
> =

> Remove one of its definition.
In my version of drivers/spi/spi-imx.c struct spi_imx_data is only
defined once. I guess you wanted to say "forward declaration".

> Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
>  drivers/spi/spi-imx.c |   20 +++++++++-----------
>  1 files changed, 9 insertions(+), 11 deletions(-)
> =

> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 31054e3..f1f6700 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -68,17 +68,6 @@ enum spi_imx_devtype {
>  	IMX51_ECSPI,	/* ECSPI on i.mx51 and later */
>  };
>  =

> -struct spi_imx_data;
> -
> -struct spi_imx_devtype_data {
> -	void (*intctrl)(struct spi_imx_data *, int);
> -	int (*config)(struct spi_imx_data *, struct spi_imx_config *);
> -	void (*trigger)(struct spi_imx_data *);
> -	int (*rx_available)(struct spi_imx_data *);
> -	void (*reset)(struct spi_imx_data *);
> -	enum spi_imx_devtype devtype;
> -};
> -
>  struct spi_imx_data {
>  	struct spi_bitbang bitbang;
>  =

> @@ -99,6 +88,15 @@ struct spi_imx_data {
>  	int chipselect[0];
>  };
>  =

> +struct spi_imx_devtype_data {
> +	void (*intctrl)(struct spi_imx_data *, int);
> +	int (*config)(struct spi_imx_data *, struct spi_imx_config *);
> +	void (*trigger)(struct spi_imx_data *);
> +	int (*rx_available)(struct spi_imx_data *);
> +	void (*reset)(struct spi_imx_data *);
> +	enum spi_imx_devtype devtype;
> +};
> +
Does this really work? struct spi_imx_data has a member

	struct spi_imx_devtype_data *devtype_data;

. So when reordering you can drop the forward definition of
spi_imx_data, but don't you need another one for spi_imx_devtype_data?

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

---------------------------------------------------------------------------=
---
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here =

http://p.sf.net/sfu/sfd2d-msazure
