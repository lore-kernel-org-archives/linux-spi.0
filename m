From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: master driver to enable RTC on ICPDAS LP-8841
Date: Mon, 22 Feb 2016 19:39:30 +0900
Message-ID: <20160222103930.GA18327@sirena.org.uk>
References: <1456105630-28914-1-git-send-email-ynvich@gmail.com>
 <1456134057-9824-1-git-send-email-ynvich@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UKdSZztwKekUWPpk"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"open list:SPI SUBSYSTEM" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Sergei Ianovich <ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1456134057-9824-1-git-send-email-ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--UKdSZztwKekUWPpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 22, 2016 at 12:40:54PM +0300, Sergei Ianovich wrote:

>    * drop empty master->cleanup

You still have an empty remove() function.

--UKdSZztwKekUWPpk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWyuVhAAoJECTWi3JdVIfQGU0H/jlp6+nlCU3OgdlN9Q6nQ3sC
jz5EtK1gW4idZwuHb+VLBVi+JB56FooE9iXpE/CdOpbJHjMZ+Q+zRic1N6lA1A7U
zouY7mdXPgUguuY3Bxw01n6GaHjwSFbH5kp/0TU6kwGiFWmaA+ewnv8Y9LSHbnRx
vua4xqvj4zlI3mELDkxDgaw8ZuVs0AjJYAwovZnto0n7e6fGSPqcfyXwm3U7mXIV
O52PexHsjGU5DpyYocoLGT2jc18znHySSMoeWXvjrQt0eRYRgWuMeQTOPfKgiTmO
Ee371hUFEakLHDnZe6oVSF6folDklfxeLanedVH1Jhq06Ecsk2G6mhdFRN44z0E=
=TPiN
-----END PGP SIGNATURE-----

--UKdSZztwKekUWPpk--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
