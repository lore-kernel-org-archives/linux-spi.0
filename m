From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 2/6] SPI: S3C64XX: Differentiate ip
	and rate clock
Date: Mon, 18 Jan 2010 10:58:00 -0700
Message-ID: <fa686aa41001180958l15df3a9dyfa5869b6f53c8fcb@mail.gmail.com>
References: <1263808215-16544-1-git-send-email-jassisinghbrar@gmail.com>
	<1263808215-16544-2-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	ben-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org
To: jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1263808215-16544-2-git-send-email-jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jan 18, 2010 at 2:50 AM,  <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> From: Jassi Brar <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>
> The instance of SPI clock for controller and that used for generating
> signals ought to be independently handled.
>
> Signed-off-by: Jassi Brar <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Will this patch break existing users of the driver that depend on the
sci->src_clk checks?

g.

> ---
> =A0drivers/spi/spi_s3c64xx.c | =A0 28 ++++++++--------------------
> =A01 files changed, 8 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/spi/spi_s3c64xx.c b/drivers/spi/spi_s3c64xx.c
> index ad93d5d..6d03d8f 100644
> --- a/drivers/spi/spi_s3c64xx.c
> +++ b/drivers/spi/spi_s3c64xx.c
> @@ -1000,10 +1000,7 @@ static int __init s3c64xx_spi_probe(struct platfor=
m_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err4;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (sci->src_clk_nr =3D=3D S3C64XX_SPI_SRCCLK_PCLK)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sci->src_clk =3D sdd->clk;
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sci->src_clk =3D clk_get(&pdev->dev, sci->s=
rc_clk_name);
> + =A0 =A0 =A0 sci->src_clk =3D clk_get(&pdev->dev, sci->src_clk_name);
> =A0 =A0 =A0 =A0if (IS_ERR(sci->src_clk)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&pdev->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Unable to acquire clock '=
%s'\n", sci->src_clk_name);
> @@ -1011,7 +1008,7 @@ static int __init s3c64xx_spi_probe(struct platform=
_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err5;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (sci->src_clk !=3D sdd->clk && clk_enable(sci->src_clk))=
 {
> + =A0 =A0 =A0 if (clk_enable(sci->src_clk)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&pdev->dev, "Couldn't enable clock=
 '%s'\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sci->src_clk_name);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -EBUSY;
> @@ -1053,11 +1050,9 @@ static int __init s3c64xx_spi_probe(struct platfor=
m_device *pdev)
> =A0err8:
> =A0 =A0 =A0 =A0destroy_workqueue(sdd->workqueue);
> =A0err7:
> - =A0 =A0 =A0 if (sci->src_clk !=3D sdd->clk)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(sci->src_clk);
> + =A0 =A0 =A0 clk_disable(sci->src_clk);
> =A0err6:
> - =A0 =A0 =A0 if (sci->src_clk !=3D sdd->clk)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_put(sci->src_clk);
> + =A0 =A0 =A0 clk_put(sci->src_clk);
> =A0err5:
> =A0 =A0 =A0 =A0clk_disable(sdd->clk);
> =A0err4:
> @@ -1093,11 +1088,8 @@ static int s3c64xx_spi_remove(struct platform_devi=
ce *pdev)
>
> =A0 =A0 =A0 =A0destroy_workqueue(sdd->workqueue);
>
> - =A0 =A0 =A0 if (sci->src_clk !=3D sdd->clk)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(sci->src_clk);
> -
> - =A0 =A0 =A0 if (sci->src_clk !=3D sdd->clk)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_put(sci->src_clk);
> + =A0 =A0 =A0 clk_disable(sci->src_clk);
> + =A0 =A0 =A0 clk_put(sci->src_clk);
>
> =A0 =A0 =A0 =A0clk_disable(sdd->clk);
> =A0 =A0 =A0 =A0clk_put(sdd->clk);
> @@ -1130,9 +1122,7 @@ static int s3c64xx_spi_suspend(struct platform_devi=
ce *pdev, pm_message_t state)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msleep(10);
>
> =A0 =A0 =A0 =A0/* Disable the clock */
> - =A0 =A0 =A0 if (sci->src_clk !=3D sdd->clk)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(sci->src_clk);
> -
> + =A0 =A0 =A0 clk_disable(sci->src_clk);
> =A0 =A0 =A0 =A0clk_disable(sdd->clk);
>
> =A0 =A0 =A0 =A0sdd->cur_speed =3D 0; /* Output Clock is stopped */
> @@ -1150,9 +1140,7 @@ static int s3c64xx_spi_resume(struct platform_devic=
e *pdev)
> =A0 =A0 =A0 =A0sci->cfg_gpio(pdev);
>
> =A0 =A0 =A0 =A0/* Enable the clock */
> - =A0 =A0 =A0 if (sci->src_clk !=3D sdd->clk)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(sci->src_clk);
> -
> + =A0 =A0 =A0 clk_enable(sci->src_clk);
> =A0 =A0 =A0 =A0clk_enable(sdd->clk);
>
> =A0 =A0 =A0 =A0s3c64xx_spi_hwinit(sdd, pdev->id);
> --
> 1.6.2.5
>
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Confere=
nce
attendees to learn about information security's most important issues throu=
gh
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
