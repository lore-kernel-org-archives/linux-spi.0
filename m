From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/3] spi: spi-fsl-dspi: Enable TCF interrupt mode
 support
Date: Thu, 14 May 2015 10:56:18 +0100
Message-ID: <20150514095618.GN2761@sirena.org.uk>
References: <1431511911-19376-1-git-send-email-haikun.wang@freescale.com>
 <20150513181701.GJ2761@sirena.org.uk>
 <BN1PR0301MB0612557038FAE3C4ADE5EE80F8D80@BN1PR0301MB0612.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JjsO4Ft8DCMnlCnY"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Wang Haikun <Haikun.Wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <BN1PR0301MB0612557038FAE3C4ADE5EE80F8D80-RQSpjbwlmjRE7VHr0KMBWpwN6zqB+hSMnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--JjsO4Ft8DCMnlCnY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2015 at 02:26:53AM +0000, Wang Haikun wrote:

> Yes, you are right. Platforms are different about this. Some platform=20
> only can work in one of the interrupt mode due to silicon issue. So we=20
> need support both of the two modes and chose the correct one in the dts=
=20
> node.

It is more normal to do this sort of selection by having different
compatible strings for the different versions of the IP (often using the
SoC name if the IP isn't versioned) - that way we don't need individual
properties for every difference in the silicon and we only need to
update the kernel and not the device tree if we discover some issue.

--JjsO4Ft8DCMnlCnY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVVHFBAAoJECTWi3JdVIfQmLgH/RqgDN3fZDd9rYICbX++d1UG
w6oRLp8zFBWDFwLk60iCv1OAEXNgZiOEFE1yjt2RbEzDwOQ3vxqe9m6N0VzKA+tu
dYAOHJSp3pt6Z53dvsPTg+162gM7f6yJFXi5VjLQVYfTY5ERQvYEHVoduGF+lC1Q
TW0JYamVMwvUVKyjcd9wU12ICsyBRtSJHMmS1dzHcMVzhZS7soL2Yrd6cKOzOfEC
QPKiX45HF0GbOJl/Uf2y5h2rMUGZePC3TDUP6xdaZWvBJAqf3aulDfPF6VCaPWy/
DffodKBSNB5HC/Dza/odXOxQ8aEU/LsF4Z5Z/9u2pEwIKyuMC8DmbFGPyo2rwKQ=
=6BnJ
-----END PGP SIGNATURE-----

--JjsO4Ft8DCMnlCnY--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
