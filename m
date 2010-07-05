From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi/mpc5121: change annotations for
	probe and remove functions
Date: Mon, 5 Jul 2010 11:35:56 -0600
Message-ID: <AANLkTinE0ZWo6X7WPWpYlMP-rZ1pEabfKSnk5ufprNK7@mail.gmail.com>
References: <1278325071-28809-1-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1278325071-28809-1-git-send-email-agust-ynQEQJNshbs@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jul 5, 2010 at 4:17 AM, Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org> wrote:
> Change annotations from __init/__exit to __devinit/__devexit
> to get rid of section mismatch warning.
>
> Signed-off-by: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>

Applied, thank you.

> ---
> =A0drivers/spi/mpc512x_psc_spi.c | =A0 16 ++++++++--------
> =A01 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/spi/mpc512x_psc_spi.c b/drivers/spi/mpc512x_psc_spi.c
> index 2534b1e..c8d69fc 100644
> --- a/drivers/spi/mpc512x_psc_spi.c
> +++ b/drivers/spi/mpc512x_psc_spi.c
> @@ -405,9 +405,9 @@ static irqreturn_t mpc512x_psc_spi_isr(int irq, void =
*dev_id)
> =A0}
>
> =A0/* bus_num is used only for the case dev->platform_data =3D=3D NULL */
> -static int __init mpc512x_psc_spi_do_probe(struct device *dev, u32 regad=
dr,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0u32 size, unsigned int irq,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0s16 bus_num)
> +static int __devinit mpc512x_psc_spi_do_probe(struct device *dev, u32 re=
gaddr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 u32 size, unsigned int irq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 s16 bus_num)
> =A0{
> =A0 =A0 =A0 =A0struct fsl_spi_platform_data *pdata =3D dev->platform_data;
> =A0 =A0 =A0 =A0struct mpc512x_psc_spi *mps;
> @@ -490,7 +490,7 @@ free_master:
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> -static int __exit mpc512x_psc_spi_do_remove(struct device *dev)
> +static int __devexit mpc512x_psc_spi_do_remove(struct device *dev)
> =A0{
> =A0 =A0 =A0 =A0struct spi_master *master =3D dev_get_drvdata(dev);
> =A0 =A0 =A0 =A0struct mpc512x_psc_spi *mps =3D spi_master_get_devdata(mas=
ter);
> @@ -505,8 +505,8 @@ static int __exit mpc512x_psc_spi_do_remove(struct de=
vice *dev)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static int __init mpc512x_psc_spi_of_probe(struct of_device *op,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0const struct of_device_id *match)
> +static int __devinit mpc512x_psc_spi_of_probe(struct of_device *op,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 const struct of_device_id *match)
> =A0{
> =A0 =A0 =A0 =A0const u32 *regaddr_p;
> =A0 =A0 =A0 =A0u64 regaddr64, size64;
> @@ -537,7 +537,7 @@ static int __init mpc512x_psc_spi_of_probe(struct of_=
device *op,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0irq_of_par=
se_and_map(op->dev.of_node, 0), id);
> =A0}
>
> -static int __exit mpc512x_psc_spi_of_remove(struct of_device *op)
> +static int __devexit mpc512x_psc_spi_of_remove(struct of_device *op)
> =A0{
> =A0 =A0 =A0 =A0return mpc512x_psc_spi_do_remove(&op->dev);
> =A0}
> @@ -551,7 +551,7 @@ MODULE_DEVICE_TABLE(of, mpc512x_psc_spi_of_match);
>
> =A0static struct of_platform_driver mpc512x_psc_spi_of_driver =3D {
> =A0 =A0 =A0 =A0.probe =3D mpc512x_psc_spi_of_probe,
> - =A0 =A0 =A0 .remove =3D __exit_p(mpc512x_psc_spi_of_remove),
> + =A0 =A0 =A0 .remove =3D __devexit_p(mpc512x_psc_spi_of_remove),
> =A0 =A0 =A0 =A0.driver =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D "mpc512x-psc-spi",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =3D THIS_MODULE,
> --
> 1.7.0.4
>
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
