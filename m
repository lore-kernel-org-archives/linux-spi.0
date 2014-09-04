From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] gpio: Add driver for AXM55xx SSP chip selects
Date: Thu, 4 Sep 2014 18:06:30 +0100
Message-ID: <20140904170630.GL29327@sirena.org.uk>
References: <1409576021-24828-1-git-send-email-anders.berg@avagotech.com>
 <1409576021-24828-2-git-send-email-anders.berg@avagotech.com>
 <CACRpkdby4H-fivNn_kG2uL0EjsCGAc+t6OyFi0+VcNGf2Z9NQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QRMPWTMRwp+GIPe+"
Cc: Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdby4H-fivNn_kG2uL0EjsCGAc+t6OyFi0+VcNGf2Z9NQA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--QRMPWTMRwp+GIPe+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 04, 2014 at 07:04:44PM +0200, Linus Walleij wrote:
> I need an ACK from Mark Brown on this before I apply.
> The driver seems to do what it should, but I need Mark to
> be OK with exporting the CS signals from an SSP/SPI block
> to be exposed to Linux as GPIOs.
>=20
> (Top-posting and quoting patch verbatim so Mark gets it.)

I don't see any sort of reasoning for this?

--QRMPWTMRwp+GIPe+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUCJwTAAoJELSic+t+oim96LkQAIp1bppb41pXt3R11K1vTTHG
FiDJF761Cafs/2DXkPEDzLrKjOw6Z5i3pxzeZupNoVvfjn+4X9nmQdjXPqRAWy5v
8H8sdrlhQ6ner/tyL5hXz2VnRbFtFrH9UepbxLJbFsuQ4mNj/5ZbWctN16DyN7H0
D/9GeujTRW2EF10MAB/T4uOsLmvWTNWVNlDizKG0MP2icLPVFc5h3c7O6PqViRuS
u+ouYBFVn8WMbA7zjuaaCMB4MiRdJ6Mx0hH++ZWg+GRpgmKLeIB6xQUn/p0JWeu7
fU+7OJV2KQS1TQHGwPvs+Y4mXUnRNdob3Q81fvCh+9W3MZFan9vaFxYYyCQjLf05
KboI4thHFQ1Uz1v6pTeabDXwClANMQjUmuKwP0pfn3z+PHVL1qmrN9iSsV68T6xR
0SVulDSjtQ+gkp6Kx0xugk0/8iwwK8TvBE6xKpvz3Hs6aTALqQ2jeR04vby9Muu/
i/4V2bBCwn7EW7r/2d8yIMt4Am9sgMlFNB5sJYN2hVfu1vnUSobbksF1LTPz9y1u
hf/VhCTh6hwqh/Z1DJQSLYtzs/+p0ATmatQc1fsIvYJq/Smw3uoUaMVeSwOt0fS0
7RAi6lFcKxprD48Pz0vyNQWxu/Q4nPrf7NBbn74Qc2kSExVuLnS9RD7Mxk/wJ1+p
fD4ucPQfIx2lr7/h7Cl9
=Szsp
-----END PGP SIGNATURE-----

--QRMPWTMRwp+GIPe+--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
