From: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2] spi: fix possible deadlock between internal bus locks and bus_lock_flag
Date: Fri, 18 Mar 2016 09:22:20 -0700
Message-ID: <7hoaabsqmb.fsf@baylibre.com>
References: <1603558.KZbpLAQA15@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>,
	Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiko =?utf-8?Q?St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1603558.KZbpLAQA15@diego> ("Heiko =?utf-8?Q?St=C3=BCbner=22'?=
 =?utf-8?Q?s?= message of "Fri, 18
	Mar 2016 11:15:11 +0100")
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Heiko St=C3=BCbner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org> writes:

> External users may use spi_bus_lock to get exclusive access. This wil=
l
> also grab the bus_lock_mutex and may therefore result in a deadlock i=
f
> __spi_pump_messages also tries to get the mutex.
>
> Therefore adapt spi_pump_messages as well as spi_sync to preset the
> bus_locked parameter according to the master->bus_lock_flag.
>
> Fixes: 49023d2e4ead ("spi: core: Fix deadlock when sending messages")
> Signed-off-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>

Tested on rk3288-veyron-jerry and verified that it fixes the boot
failure I reported.

Tested-by: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
