From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: M25P80 Regulator Question
Date: Fri, 1 Nov 2013 11:02:44 -0700
Message-ID: <20131101180243.GY2493@sirena.org.uk>
References: <5273E881.8080401@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e8znkWhb8vS+si4n"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5273E881.8080401-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--e8znkWhb8vS+si4n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 01, 2013 at 01:44:33PM -0400, Rhyland Klein wrote:

> Is there some mechanism for defining this dependency?

Same as any other device, add the regulator to the binding for the flash
chip and add the appropriate code to the chip.

--e8znkWhb8vS+si4n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSc+zAAAoJELSic+t+oim9JtIP/jlbXEf+WU8G0I2e2Omo/je6
HqHB5xOVqLL+0o7NvgSoJ433D5+FMWgUUOTvDmEVw6QmIRfH9bK6nSjlUt84OcPo
8wpHbGFZ1JAS8bUvyLlnDDr5sQ2PfQHvj0nRkA+GwFLnaKxJLbCo8tlWXW6KN1f4
qqtLKj4r4cPHVUTI6R/kaGHasbOdeM/dxyrbUYrw/5n5MCQ4fhTsYKgqD2VzgYY1
aqZ//f1UDoasWv31W8Ds+qN+smuJg9lQU2DLN/oxGm50B7jKuathoY2VyjLEYyxU
MLS9lt9WSshaxW855dkRw1+0bq2E/v8xhvo29hwYHM++MO5pLIPpBFCZsb1ySb7I
HrmA1OBKEtDgcog7yWY3/m0V20YZvKuuck96aCSqTmo5d6TH35yiO+IplecteEOD
K0C+uMO2gWULBMVKf9vK4/++ubKlTjz7AWBkv2HEm3qBNZBYGaS6n9Q39WccqVc+
gV3VsG1r+rJ/Kh1tga0nJZb7zIafL+Oddiq02V0aQA8Ux9exF+iVF0j5cot8LTuK
NqP0l6chW7K7QezbMX0/ZNWIU/BYem1dQh0b/GoxBVW8OFxom3dS5MoR2vr7blVY
MWLsmW35Lop+QypGlyWtbCUBi0ViXFgzaFeSv5nrm9DvHRI7vkYk8pWLKRjHRO6j
uL96Dv/p7pWqGjb4LHjO
=bmwN
-----END PGP SIGNATURE-----

--e8znkWhb8vS+si4n--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
