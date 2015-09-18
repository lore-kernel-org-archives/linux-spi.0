From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] spi: atmel: remove warning when !CONFIG_PM_SLEEP
Date: Fri, 18 Sep 2015 16:34:34 +0200
Message-ID: <55FC20FA.1000405@atmel.com>
References: <1441873192-18511-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-arm-kernel@lists.infradead.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441873192-18511-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Le 10/09/2015 10:19, Alexandre Belloni a =C3=A9crit :
> When CONFIG_PM is defined but not CONFIG_PM_SLEEP (this happens when
> CONFIG_SUSPEND is not defined), there is the following warning:
>=20
> drivers/spi/spi-atmel.c:1723:12: warning: =E2=80=98atmel_spi_suspend=E2=
=80=99 defined but not used [-Wunused-function]
> drivers/spi/spi-atmel.c:1741:12: warning: =E2=80=98atmel_spi_resume=E2=
=80=99 defined but not used [-Wunused-function]
>=20
> Enclose both atmel_spi_suspend and atmel_spi_resume in #ifdef
> CONFIG_PM_SLEEP/#endif to solve that.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.co=
m>

No problem on my side:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>


> ---
>  drivers/spi/spi-atmel.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index bf9ed380bb1c..63318e2afba1 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -1720,6 +1720,7 @@ static int atmel_spi_runtime_resume(struct devi=
ce *dev)
>  	return clk_prepare_enable(as->clk);
>  }
> =20
> +#ifdef CONFIG_PM_SLEEP
>  static int atmel_spi_suspend(struct device *dev)
>  {
>  	struct spi_master *master =3D dev_get_drvdata(dev);
> @@ -1756,6 +1757,7 @@ static int atmel_spi_resume(struct device *dev)
> =20
>  	return ret;
>  }
> +#endif
> =20
>  static const struct dev_pm_ops atmel_spi_pm_ops =3D {
>  	SET_SYSTEM_SLEEP_PM_OPS(atmel_spi_suspend, atmel_spi_resume)
>=20


--=20
Nicolas Ferre
