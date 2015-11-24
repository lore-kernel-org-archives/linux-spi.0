From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] mfd: cros ec: Lock the SPI bus while holding
 chipselect
Date: Tue, 24 Nov 2015 17:00:20 +0000
Message-ID: <20151124170020.GE12874@x1>
References: <1447043150-4806-1-git-send-email-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
	Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
	rspangler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, gwendal-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1447043150-4806-1-git-send-email-drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, 09 Nov 2015, Nicolas Boichat wrote:

> cros_ec_cmd_xfer_spi and cros_ec_pkt_xfer_spi generally work like
> this:
>  - Pull CS down (active), wait a bit, then send a command
>  - Wait for response (multiple requests)
>  - Wait a while, pull CS up (inactive)
>=20
> These operations, individually, lock the SPI bus, but there is
> nothing preventing the SPI framework from interleaving messages
> intended for other devices as the bus is unlocked in between.
>=20
> This is a problem as the EC expects CS to be held low for the
> whole duration.
>=20
> Solution: Lock the SPI bus during the whole transaction, to make
> sure that no other messages can be interleaved.
>=20
> Signed-off-by: Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
>=20
> v2: Move bus_unlock earlier in the functions.
>=20
> Applies on top on linux-next/master (20151109)
>=20
>  drivers/mfd/cros_ec_spi.c | 41 +++++++++++++++++++++++++++++--------=
----
>  1 file changed, 29 insertions(+), 12 deletions(-)

Code changes look okay, but I think you can drop the comments.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
