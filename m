From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2 1/3] mfd: mc13xxx-core: Prepare for separate spi and
 i2c backends.
Date: Sun, 11 Mar 2012 10:33:21 +0100
Message-ID: <20120311093321.GK14173@pengutronix.de>
References: <1331429402-9639-1-git-send-email-marc@cpdesign.com.au>
 <1331429402-9639-2-git-send-email-marc@cpdesign.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	oskar-fYPSZ7JpQqsAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1331429402-9639-2-git-send-email-marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, Mar 11, 2012 at 12:30:00PM +1100, Marc Reilly wrote:
> This patch abstracts the bus specific operations from the driver core=
=2E
> Read and write handlers are introduced and generic initialization is
> consolidated into mc13xxx_comon_init. The irq member is removed becau=
se
s/_comon_/_common_/

one minor nitpick below.

> it is unused.
>=20
> Signed-off-by: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
> ---
>  drivers/mfd/mc13xxx-core.c |  162 ++++++++++++++++++++++++++--------=
----------
>  1 files changed, 97 insertions(+), 65 deletions(-)
>=20
> diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
> index 7122386..19d94a1 100644
> --- a/drivers/mfd/mc13xxx-core.c
> +++ b/drivers/mfd/mc13xxx-core.c
> @@ -235,6 +234,34 @@ int mc13xxx_reg_write(struct mc13xxx *mc13xxx, u=
nsigned int offset, u32 val)
> =20
>  	return 0;
>  }
> +
> +int mc13xxx_reg_read(struct mc13xxx *mc13xxx, unsigned int offset, u=
32 *val)
> +{
> +	int ret;
> +
> +	BUG_ON(!mutex_is_locked(&mc13xxx->lock));
> +
> +	if (offset > MC13XXX_NUMREGS)
> +		return -EINVAL;
> +
> +	ret =3D mc13xxx->read_dev(mc13xxx, offset, val);
> +	dev_vdbg(mc13xxx->dev, "[0x%02x] -> 0x%06x\n", offset, *val);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(mc13xxx_reg_read);
> +
> +int mc13xxx_reg_write(struct mc13xxx *mc13xxx, unsigned int offset, =
u32 val)
> +{
> +	BUG_ON(!mutex_is_locked(&mc13xxx->lock));
> +
> +	dev_vdbg(mc13xxx->dev, "[0x%02x] <- 0x%06x\n", offset, val);
> +
> +	if (offset > MC13XXX_NUMREGS || val > 0xffffff)
> +		return -EINVAL;
> +
> +	return mc13xxx->write_dev(mc13xxx, offset, val);
> +}
>  EXPORT_SYMBOL(mc13xxx_reg_write);
> =20
>  int mc13xxx_reg_rmw(struct mc13xxx *mc13xxx, unsigned int offset,
> @@ -439,7 +466,7 @@ static int mc13xxx_irq_handle(struct mc13xxx *mc1=
3xxx,
>  			if (handled =3D=3D IRQ_HANDLED)
>  				num_handled++;
>  		} else {
> -			dev_err(&mc13xxx->spidev->dev,
> +			dev_err(mc13xxx->dev,
>  					"BUG: irq %u but no handler\n",
Without having counted I think you can join these two lines.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
