From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: atmel: fix handling of cs_change set on non-last
 xfer
Date: Tue, 26 Jan 2016 18:01:01 +0100
Message-ID: <56A7A64D.1070601@atmel.com>
References: <1453080351-29593-1-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mans Rullgard <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>,
	"Yang, Wenyou" <Wenyou.Yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1453080351-29593-1-git-send-email-mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Le 18/01/2016 02:25, Mans Rullgard a =E9crit :
> The driver does the wrong thing when cs_change is set on a non-last
> xfer in a message.  When cs_change is set, the driver deactivates the
> CS and leaves it off until a later xfer again has cs_change set where=
as
> it should be briefly toggling CS off and on again.
>=20
> This patch brings the behaviour of the driver back in line with the
> documentation and common sense.  The delay of 10 us is the same as is
> used by the default spi_transfer_one_message() function in spi.c.
>=20
> Fixes: 8090d6d1a415 ("spi: atmel: Refactor spi-atmel to use SPI frame=
work queue")
> Signed-off-by: Mans Rullgard <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>

Hi Mans,

Yes, it seems to be a sensible thing to do:
Acked-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Thanks, best regards.

> ---
>  drivers/spi/spi-atmel.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index aebad36391c9..4b8ccf1f897e 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -315,7 +315,6 @@ struct atmel_spi {
>  	struct atmel_spi_dma	dma;
> =20
>  	bool			keep_cs;
> -	bool			cs_active;
> =20
>  	u32			fifo_size;
>  };
> @@ -1406,11 +1405,9 @@ static int atmel_spi_one_transfer(struct spi_m=
aster *master,
>  				 &msg->transfers)) {
>  			as->keep_cs =3D true;
>  		} else {
> -			as->cs_active =3D !as->cs_active;
> -			if (as->cs_active)
> -				cs_activate(as, msg->spi);
> -			else
> -				cs_deactivate(as, msg->spi);
> +			cs_deactivate(as, msg->spi);
> +			udelay(10);
> +			cs_activate(as, msg->spi);
>  		}
>  	}
> =20
> @@ -1433,7 +1430,6 @@ static int atmel_spi_transfer_one_message(struc=
t spi_master *master,
>  	atmel_spi_lock(as);
>  	cs_activate(as, spi);
> =20
> -	as->cs_active =3D true;
>  	as->keep_cs =3D false;
> =20
>  	msg->status =3D 0;
>=20


--=20
Nicolas Ferre
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
