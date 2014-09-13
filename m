From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] spi: davinci: add support for adding delay between
 word's transmissions
Date: Sat, 13 Sep 2014 17:06:28 +0100
Message-ID: <20140913160628.GF7960@sirena.org.uk>
References: <1410536892-22775-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VuBTcNUPe5zwk2q6"
Cc: santosh.shilimkar-l0cyMroinI0@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
	Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1410536892-22775-1-git-send-email-grygorii.strashko-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--VuBTcNUPe5zwk2q6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2014 at 06:48:12PM +0300, Grygorii Strashko wrote:
> From: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
>=20
> This patch adds ability to configure delay between transmission of
> words over SPI bus if it's required by SPI slave devices.

This is fine but it doesn't appear to apply against current code.  Can
you please check and resend?

--VuBTcNUPe5zwk2q6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUFGuEAAoJECTWi3JdVIfQKc8H/ijpDNXj2WWtW7G5noyqLNK9
+aBWR5rVkWSD3TTQKwjgmue04pJmUBymxwlAWU/XyNiXNaD3mXTeEyZBGwPN8n+M
6BiW485pQVjuvq+PCXfq6m2J4yvd3B3rsdGoSSV8FZcHZpWHaC66/QCyzr3sMXnO
SCwfO153ielCln3/oxGXC0Re9+ejgaludiXLY7Cb2SMnlp5Lc9LFd0qQwf0+E6Y8
40+cNVq/JvHRdc1X16mLpxwR+u6Vrj2pGJpegBlVxCTzAX5SmVFxahXHhr0wGBp6
7fF6ncmpxeqmpu/XAGzb/V409TyAgj1xOBAapQ/b9ekW1iPfX7X4ZCfWy7KPXPY=
=ob3H
-----END PGP SIGNATURE-----

--VuBTcNUPe5zwk2q6--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
