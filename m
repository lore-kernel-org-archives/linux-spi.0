From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Single SPI Protocol Driver with multiple SPI Slaves
Date: Wed, 6 Sep 2017 14:09:50 +0100
Message-ID: <20170906130950.q5acowbqa65h3zrz@sirena.co.uk>
References: <faa18de5-545a-4be1-eaf0-a0374a75d7e2@naio-technologies.com>
 <af912d1d-a036-ebc3-5439-09a44e98f437@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7sgjarwmr7awkgur"
Cc: =?iso-8859-1?B?TOlv?= Serre <leo-fx4xgHRsvDuU6xZXA0faPpqQE7yCjDx5@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <af912d1d-a036-ebc3-5439-09a44e98f437-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--7sgjarwmr7awkgur
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 06, 2017 at 01:49:25PM +0200, Lars-Peter Clausen wrote:

> There are currently no facilities in the kernel to do this. I've have had a
> similar problem with a different driver and given this some thought.

The kernel really can't cope with this at all, it's got a fairly clear
idea that a device will only have one control bus.

> Conceptually I think the best approach is to have something like
> i2c_new_dummy() that creates a second slave device with a different address
> for an existing device.

> The main issue with implementing this is the global spi_add_lock mutex which
> prevents a SPI device from being created from within the probe() callback of
> another SPI device.

There's also the devices that want to use multiple buses simultaneously
that cause problems here, it's not just SPI vs SPI - there's one audio
CODEC upstream that's got mixed I2C and SPI control.

--7sgjarwmr7awkgur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmv850ACgkQJNaLcl1U
h9CGCQf/e2Tc+cYYUIaw/N7Uu+t6PRRp4qToSZED1J//7qNdMEEYjmRQMp7HOOsY
98a44puVg5nO/EqLuWCBl3365Z2KoQUCEtNjX3q65v9pGHt/FaAxBK1pdk2ZLO1P
FCjG+TSm0eh8iCV1KJlwsA9xjwZa6VhMCEKlE7JLSO/c+ZVhz3TRi2GBDLvAHcUP
0PnnyxeXoc3gR1+a/QZcZ8e2EN3qtRRMebmmv+YsChXz2zSMycFYyhNm0m02/3X/
n3nlHW9wMH5yP1NZESMo8XXmrPun4K3Un+lPq24O1kKSdVjbBCHCzVQRM8S7aEip
9f+uSlxiD/b8oMP3sGS0vszZb7M7rA==
=Vjyq
-----END PGP SIGNATURE-----

--7sgjarwmr7awkgur--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
