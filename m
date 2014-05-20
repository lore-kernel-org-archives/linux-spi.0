From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] spi: atmel: fix typo in dev_err
Date: Tue, 20 May 2014 10:23:57 +0200
Message-ID: <537B111D.20808@atmel.com>
References: <1400571711-13137-1-git-send-email-poggi.raph@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-kernel@vger.kernel.org>
To: =?UTF-8?B?UmFwaGHDq2wgUG9nZ2k=?= <poggi.raph@gmail.com>,
	<linux-spi@vger.kernel.org>, Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400571711-13137-1-git-send-email-poggi.raph@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 20/05/2014 09:41, Rapha=C3=ABl Poggi :
> Fix typo in dev_err.
>=20
> Signed-off-by: Rapha=C3=ABl Poggi <poggi.raph@gmail.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  drivers/spi/spi-atmel.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 079e6b1..7a1788b 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -1122,7 +1122,7 @@ static int atmel_spi_one_transfer(struct spi_ma=
ster *master,
>  		atmel_spi_lock(as);
>  		if (WARN_ON(ret =3D=3D 0)) {
>  			dev_err(&spi->dev,
> -				"spi trasfer timeout, err %d\n", ret);
> +				"spi transfer timeout, err %d\n", ret);
>  			as->done_status =3D -EIO;
>  		} else {
>  			ret =3D 0;
>=20


--=20
Nicolas Ferre
