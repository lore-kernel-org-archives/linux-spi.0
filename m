From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi: tegra: don't treat NULL clk as an error
Date: Mon, 10 Jan 2011 13:58:12 -0700
Message-ID: <AANLkTikd7AZv+-aVf4=jwF+xjvq+1k_kAwLPz-+yP6=Q@mail.gmail.com>
References: <1294657506-27510-1-git-send-email-jamie@jamieiles.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Erik Gilling <konkers-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jamie Iles <jamie-wmLquQDDieKakBO8gow8eQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1294657506-27510-1-git-send-email-jamie-wmLquQDDieKakBO8gow8eQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jan 10, 2011 at 4:05 AM, Jamie Iles <jamie-wmLquQDDieKakBO8gow8eQ@public.gmane.org> wrote:
> Some platforms have been known to return NULL from clk_get() if they
> support only a single struct clk. =A0Whilst tegra doesn't do this, make
> the drivers consistent with others.
>
> Cc: Erik Gilling <konkers-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Jamie Iles <jamie-wmLquQDDieKakBO8gow8eQ@public.gmane.org>

Hi James,

If NULL does get returned, say due to a future change to the clock
code, then this change causes the driver to oops.  I'm not going to
apply this patch.

g.

> ---
>
> =A0drivers/spi/spi_tegra.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/spi/spi_tegra.c b/drivers/spi/spi_tegra.c
> index bb7df02..891e590 100644
> --- a/drivers/spi/spi_tegra.c
> +++ b/drivers/spi/spi_tegra.c
> @@ -513,7 +513,7 @@ static int __init spi_tegra_probe(struct platform_dev=
ice *pdev)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0tspi->clk =3D clk_get(&pdev->dev, NULL);
> - =A0 =A0 =A0 if (IS_ERR_OR_NULL(tspi->clk)) {
> + =A0 =A0 =A0 if (IS_ERR(tspi->clk)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&pdev->dev, "can not get clock\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D PTR_ERR(tspi->clk);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err2;
> --
> 1.7.3.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
Gaining the trust of online customers is vital for the success of any compa=
ny
that requires sensitive data to be transmitted over the Web.   Learn how to =

best implement a security strategy that keeps consumers' information secure =

and instills the confidence they need to proceed with transactions.
http://p.sf.net/sfu/oracle-sfdevnl =
