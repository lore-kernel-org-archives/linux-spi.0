From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Subject: Re: [PATCH 3/3] spi: psdev: add passive serial driver
Date: Fri, 14 Mar 2014 09:06:47 +0100
Message-ID: <20140314090647.55da971e@ipc1.ka-ro>
References: <1394639617-26917-1-git-send-email-m.grzeschik@pengutronix.de>
	<1394639617-26917-4-git-send-email-m.grzeschik@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Michael Grzeschik <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1394639617-26917-4-git-send-email-m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

Michael Grzeschik wrote:
> This patch introduces the psdev driver. It is used to communicate to =
an
> Altera passive serial connected FPGA by writing into an character
> device.
>=20
> It simply initates the protocol on open and clocks the data into the
> FPGA by using the underlying SPI bus on write. The used SPI bus can a=
lso
> be an bitbang SPI bus. On close it will check for the response of the
> FPGA and tells if the write process was successful.
>=20
[...]
+/*--------------------------------------------------------------------=
-----*/
> +#ifdef CONFIG_OF
> +
> +static const struct of_device_id psdev_dt_ids[] =3D {
> +	{ .compatible =3D "altr,passive-serial" },
> +	{},
          ^
<nit>
Since '{}' always must be the last entry in the initializer list,
the comma doesn't make sense here.
Omitting it would cause entries added after it (e.g. due to a bad merge
conflict resolution) to generate a compile error.
</nit>


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info-AvR2QvxeiV7DiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org
___________________________________________________________
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
