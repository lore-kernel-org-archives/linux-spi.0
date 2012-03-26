From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi-imx: Remove duplicate spi_imx_data definition
Date: Tue, 27 Mar 2012 00:16:09 +0530
Message-ID: <CAM=Q2cvL+Dac=Q1XmSUOLZGqK2zVdYd6nzQc-Tgeywois8rrxQ@mail.gmail.com>
References: <1332785632-17799-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi Fabio,

On Mon, Mar 26, 2012 at 11:43 PM, Fabio Estevam
<fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
> Structure struct spi_imx_data is defined twice.
>
> Remove one of its definition.
>
> Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
> =A0drivers/spi/spi-imx.c | =A0 20 +++++++++-----------
> =A01 files changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 31054e3..f1f6700 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -68,17 +68,6 @@ enum spi_imx_devtype {
> =A0 =A0 =A0 =A0IMX51_ECSPI, =A0 =A0/* ECSPI on i.mx51 and later */
> =A0};
>
> -struct spi_imx_data;
> -
> -struct spi_imx_devtype_data {
> - =A0 =A0 =A0 void (*intctrl)(struct spi_imx_data *, int);
> - =A0 =A0 =A0 int (*config)(struct spi_imx_data *, struct spi_imx_config =
*);
> - =A0 =A0 =A0 void (*trigger)(struct spi_imx_data *);
> - =A0 =A0 =A0 int (*rx_available)(struct spi_imx_data *);
> - =A0 =A0 =A0 void (*reset)(struct spi_imx_data *);
> - =A0 =A0 =A0 enum spi_imx_devtype devtype;
> -};

Is this change intentional

> -
> =A0struct spi_imx_data {
> =A0 =A0 =A0 =A0struct spi_bitbang bitbang;
>
> @@ -99,6 +88,15 @@ struct spi_imx_data {
> =A0 =A0 =A0 =A0int chipselect[0];
> =A0};
>
> +struct spi_imx_devtype_data {
> + =A0 =A0 =A0 void (*intctrl)(struct spi_imx_data *, int);
> + =A0 =A0 =A0 int (*config)(struct spi_imx_data *, struct spi_imx_config =
*);
> + =A0 =A0 =A0 void (*trigger)(struct spi_imx_data *);
> + =A0 =A0 =A0 int (*rx_available)(struct spi_imx_data *);
> + =A0 =A0 =A0 void (*reset)(struct spi_imx_data *);
> + =A0 =A0 =A0 enum spi_imx_devtype devtype;
> +};
> +
> =A0static inline int is_imx27_cspi(struct spi_imx_data *d)
> =A0{
> =A0 =A0 =A0 =A0return d->devtype_data->devtype =3D=3D IMX27_CSPI;
> --
> 1.7.1
>
>
>
> -------------------------------------------------------------------------=
-----
> This SF email is sponsosred by:
> Try Windows Azure free for 90 days Click Here
> http://p.sf.net/sfu/sfd2d-msazure
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general

---------------------------------------------------------------------------=
---
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here =

http://p.sf.net/sfu/sfd2d-msazure
