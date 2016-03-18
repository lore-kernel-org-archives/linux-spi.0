From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] spi: don't lock the bus in __spi_pump_messages if it is
 already locked
Date: Fri, 18 Mar 2016 10:53:07 +0530
Message-ID: <56EB90BB.3070802@ti.com>
References: <1848110.TJtF6nar8z@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>,
	Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	"linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1848110.TJtF6nar8z@diego>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



On 03/18/2016 04:48 AM, Heiko St=FCbner wrote:
> External users may use spi_bus_lock to get exclusive access. This wil=
l
> also grab the bus_lock_mutex and may therefore result in a deadlock i=
f
> __spi_pump_messages also tries to get the mutex.

I suggest bus_locked flag passed to __spi_pump_messages() by
__spi_sync() be updated to take care of the fact that spi_bus_lock() ma=
y
have acquired the mutex, so that below changes in __spi_pump_messages()
are not needed.

>=20
> Fixes: 49023d2e4ead ("spi: core: Fix deadlock when sending messages")
> Signed-off-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
> ---
>  drivers/spi/spi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index de2f2f9..62f962b 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1160,7 +1160,7 @@ static void __spi_pump_messages(struct spi_mast=
er *master, bool in_kthread,
>  		}
>  	}
> =20
> -	if (!bus_locked)
> +	if (!bus_locked && !master->bus_lock_flag)
>  		mutex_lock(&master->bus_lock_mutex);
> =20
>  	trace_spi_message_start(master->cur_msg);
> @@ -1192,7 +1192,7 @@ static void __spi_pump_messages(struct spi_mast=
er *master, bool in_kthread,
>  	}
> =20
>  out:
> -	if (!bus_locked)
> +	if (!bus_locked && !master->bus_lock_flag)
>  		mutex_unlock(&master->bus_lock_mutex);
> =20
>  	/* Prod the scheduler in case transfer_one() was busy waiting */
>=20

--=20
Regards
Vignesh
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
