From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Single SPI Protocol Driver with multiple SPI Slaves
Date: Thu, 7 Sep 2017 11:13:06 +0100
Message-ID: <20170907101306.jsaa7ysckdxk3m62@sirena.co.uk>
References: <faa18de5-545a-4be1-eaf0-a0374a75d7e2@naio-technologies.com>
 <af912d1d-a036-ebc3-5439-09a44e98f437@metafoo.de>
 <20170906130950.q5acowbqa65h3zrz@sirena.co.uk>
 <6a5ddbb9-3203-48aa-a4d9-7bd100224592@naio-technologies.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="choolnanjbxm7vor"
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?B?TOlv?= Serre <leo-fx4xgHRsvDuU6xZXA0faPpqQE7yCjDx5@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6a5ddbb9-3203-48aa-a4d9-7bd100224592-fx4xgHRsvDuU6xZXA0faPpqQE7yCjDx5@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--choolnanjbxm7vor
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 07, 2017 at 09:03:59AM +0200, L=E9o Serre wrote:
> Thanks for your answers,

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

> It appears that the solution is to bind the driver to a unique SPI slave =
in
> the device-tree using a fake CS pin.

> Then in the probe function, assign two GPIO pins to the control the two CS
> of the device.

> I'm sure that solution will work but:
>  * The driver will be written specifically to a configuration (GPIO pin
> number hard-coded)
>  * Requires a unused pin (the fake CS pin, except if it is possible to se=
tup
> the SPI bus as "no-cs" in the device-tree).
>  * Requires do find the GPIO pin number, that could be quite difficult in
> iMX6 for example.

That's going into an ABI so will be difficult to support in future if we
ever do get direct support for this.

--choolnanjbxm7vor
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmxG7IACgkQJNaLcl1U
h9AXgQf+MvLD+daHKP6j1L2OZDNF/zvNTr1yuj3gDgYyDK8m20jJtRrQ1QrEGVeO
2V4NezAImi070EBs6ooQb3geDgO0gTasVNp+KgDsNkKi3tUlMZ/dyDdTZjlcvZk6
uHM+hZsiLxvw6nxbWGqDf6t9mMqD+bmUp9LPY5/OImtdxAjN1cvC3O2PyXkp79Sp
/WwcCOgC9N+rf2byGjtKMPo8xDDLi+xw+LF3b8lt/UGJUV7Wa5GA6vsxMAnFNBRj
DP3E7PrGzweqxGYcJ1+NGQ7l1kTdDRDf0mz9E+R+lK1p03zWDxGnqHtNyOspMU2N
UQEEwLW1JhFr6/pW4gKRT16vLg0kCA==
=gdFt
-----END PGP SIGNATURE-----

--choolnanjbxm7vor--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
