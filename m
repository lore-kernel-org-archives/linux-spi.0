From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC 2/2] spi: pxa2xx: Only claim CS GPIOs when the slave
 device is created
Date: Fri, 4 Aug 2017 12:43:54 +0100
Message-ID: <20170804114354.yxbaagwzmb5ri2hf@sirena.org.uk>
References: <cover.1501760433.git.jan.kiszka@siemens.com>
 <5a691263ccf9d61134d6184861b37eaf37b13b77.1501760433.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="egrmqvzbqs2k3d4u"
Cc: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
        Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Jan Kiszka <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5a691263ccf9d61134d6184861b37eaf37b13b77.1501760433.git.jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--egrmqvzbqs2k3d4u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2017 at 01:40:33PM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>
>=20
> Avoid hogging chip select GPIOs just because they are listed for the
> master. They might be mulitplexed and, if no slave device is attached,
> used for different purposes. Moreover, this strategy avoids having to
> allocate a cs_gpiods structure.

This doesn't apply against current code, please check and resend.

--egrmqvzbqs2k3d4u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmEXfkACgkQJNaLcl1U
h9AFtAf8DEFoNuCcBizPkbsVuuSoBNX9CUW0zSljMdFl6ZMNGFcan+dhmgXSiH5e
ReHBO9tQHoetqtxKp90w07NcMNStcwaiDZJ6jfXUnWIf6MFDLwunJbfEIYfWzx7f
Ep9TskYZ2m1eHjko/S/0fD8cVBXDRmAKlcV257/+mrfxMWMJeqC2mkyum4wz2i3m
ZIOSa62fsqBLK2AVMHtcEHm0Wa8vU85zOntgl4YFQrE8NFQiSg7rLuLzwObDtTus
pCLeWTtWwk+nCcKJz7s3owXY2cJqc3aJGXHj8xm1kHtVFGdv1wgD6U9Rj7eZ6kRQ
l9chDsi3RM6Ilrt1DrSLiv8AVWxb/Q==
=JSZ3
-----END PGP SIGNATURE-----

--egrmqvzbqs2k3d4u--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
