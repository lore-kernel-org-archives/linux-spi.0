From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] spi: fix possible deadlock between internal bus locks
 and bus_lock_flag
Date: Fri, 18 Mar 2016 10:40:46 +0000
Message-ID: <56EBDB2E.2010702@nvidia.com>
References: <1603558.KZbpLAQA15@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>,
	<linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1603558.KZbpLAQA15@diego>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


On 18/03/16 10:15, Heiko St=FCbner wrote:
> External users may use spi_bus_lock to get exclusive access. This wil=
l
> also grab the bus_lock_mutex and may therefore result in a deadlock i=
f
> __spi_pump_messages also tries to get the mutex.
>=20
> Therefore adapt spi_pump_messages as well as spi_sync to preset the
> bus_locked parameter according to the master->bus_lock_flag.
>=20
> Fixes: 49023d2e4ead ("spi: core: Fix deadlock when sending messages")
> Signed-off-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
> ---
> changes in v2:
> - move the second check from __spi_pump_messages to its calling funct=
ions
>   spi_pump_messages and __spi_sync as suggested by Vignesh
>=20
>  drivers/spi/spi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index de2f2f9..0239b45 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1209,7 +1209,7 @@ static void spi_pump_messages(struct kthread_wo=
rk *work)
>  	struct spi_master *master =3D
>  		container_of(work, struct spi_master, pump_messages);
> =20
> -	__spi_pump_messages(master, true, false);
> +	__spi_pump_messages(master, true, master->bus_lock_flag);
>  }
> =20
>  static int spi_init_queue(struct spi_master *master)
> @@ -2853,7 +2853,7 @@ static int __spi_sync(struct spi_device *spi, s=
truct spi_message *message,
>   */
>  int spi_sync(struct spi_device *spi, struct spi_message *message)
>  {
> -	return __spi_sync(spi, message, 0);
> +	return __spi_sync(spi, message, spi->master->bus_lock_flag);
>  }
>  EXPORT_SYMBOL_GPL(spi_sync);

Acked-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Thanks for the report and fixing this!

Jon
-----------------------------------------------------------------------=
------------
This email message is for the sole use of the intended recipient(s) and=
 may contain
confidential information.  Any unauthorized review, use, disclosure or =
distribution
is prohibited.  If you are not the intended recipient, please contact t=
he sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------=
------------
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
