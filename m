From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: davinci: fix build warning when printing
 resource_size_t vars
Date: Tue, 14 Jan 2014 14:39:45 +0000
Message-ID: <20140114143945.GP15567@sirena.org.uk>
References: <20140112110916.GR15937@n2100.arm.linux.org.uk>
 <1389707408-24785-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OmL7C/BU0IhhC9Of"
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	nsekhar-l0cyMroinI0@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389707408-24785-1-git-send-email-grygorii.strashko-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--OmL7C/BU0IhhC9Of
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 14, 2014 at 03:50:08PM +0200, Grygorii Strashko wrote:
> Use %pa format specifier when printing variables of resource_size_t type
> to fix build warnings:
> drivers/spi/spi-davinci.c:966:3: warning: format '%d' expects argument of type 'int', but argument 3 has type 'resource_size_t'
> drivers/spi/spi-davinci.c:966:3: warning: format '%d' expects argument of type 'int', but argument 4 has type 'resource_size_t'

This doesn't apply against current code, it seems the same patch has
already been applied.

--OmL7C/BU0IhhC9Of
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS1UwuAAoJELSic+t+oim97VoP/iu7e9VECnaXtoBpi+miFBqD
dFwNoG2CF9vVitfAOw1911k6KQLsa4Wy+HMs0Q6vZcVQFiQhxn5+chxseX2nHjF3
4vlyHOO1Ui/nHuV1Tu9S3xPZn8m+TFyzsGILc/6/Rmny/TqJwepgdKdMKMj60TRB
iFvs+EEqzOyjVbYIq/lXpp3dk+wC5ylv4b9njsOH8/sjXX21rox6M+ieecYgO7+/
jbHsFIX5TWf97P+/gbybJSTicSfl+vUucC4v+PvVT715GxyZWGzZiS70Xl424rk1
ZyaN/VDKubcbhphYAHnU2urUcv64/ZSP5Kj/lYidxpP3KLnF1BdOF0OFuVOHL0ea
g9MHZKBpchwHzp5sfM0K7/u0dAOfDMfqH27GyG94SaEgCwZzKnWjPnmdgAmPblHo
iWpl627Tlx2EU24gwusk9Z4VlcJZwrbtscU1PmMaGT/WqA/isdCE3HmeoqapP2rT
5aShOF0ZPouOUEYZ9Hkt3kHmz2J86OOBrEK33aAGYTrTpA1y0s5eHJMBmhPA5YEa
kMSY0uVWgRPBkFMhz8jK9GBYyWJA3XreBaxxf762kSP0X0yvEhKYy/DEJTMbtCg3
vGwjGj1FH3gvx/ASioBXByskamWKrUIeaLBsqJidhiuq8EKq9NirPs2JhfhN0Cfw
XNLkUVCT8hpB4C6ZgRMg
=Ov9t
-----END PGP SIGNATURE-----

--OmL7C/BU0IhhC9Of--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
