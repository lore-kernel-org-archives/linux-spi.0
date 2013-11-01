From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: M25P80 Regulator Question
Date: Fri, 1 Nov 2013 11:16:28 -0700
Message-ID: <20131101181628.GD2493@sirena.org.uk>
References: <5273E881.8080401@nvidia.com>
 <20131101180243.GY2493@sirena.org.uk>
 <5273ED54.5030101@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0/mZ2nErRHiqrPHn"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5273ED54.5030101-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--0/mZ2nErRHiqrPHn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 01, 2013 at 02:05:08PM -0400, Rhyland Klein wrote:

> I just wanted to make sure I wasn't missing anything. I'll come up with
> some patches. I believe there are patches in for optional regulator
> support right, so I assume that would be the most logical path to take?

No, you should not be using regulator_get_optional() - it is unlikely
that the flash device will work without power.

--0/mZ2nErRHiqrPHn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSc+/5AAoJELSic+t+oim9GdgP/3v6VSFtYzcAjYduA0re2WYV
wirRydmXFD/fcrBFBTyhuyxsAMg0AFqbmdE1kZ3pykItMWkXfVF+KUZXZeauQjm9
otDtVjF99O3VNrCCyeqcIByEMjinG+dofVQZmYIaqbn6KOryue7aPHDTjXPry2zK
6AxH7zUfu/L1H9ddY5vbX7l/bDV/H5g1NwtC6di5qVI+pi0ME8Jq1t5d3K8vjR6a
ugLX8M58xbTwmrsOh0cwgktiZg4UAOZugJMBBs9gQEXzsIGLf2yT/S84HhZvkIsP
Bix2txf6CxA2eizlqzSRA61X0e51PMtWXzPuPpGcHbH0r6LhJoQ4IyxjxmwGz92J
gAW7/kmnsRfsX3muGEYE2ps9t7oSo0Id6wE/FLF0m8/3o9G+35kbX5N98EIFJS9U
/3+UjQvHb7+ULFkRMbb7zezIAlVTnrgpNmS6Inz3zCyl8t4B3VFE902Wfv+g6D1b
FcxzC6xCJriHKdCDM4hZBmzYSpswHfVKC6PHz26FlpxUy3J0zwYGNHfTRLYIL0Rc
YmvvlvqwCrjeVtAB4IDnbI8P5K3VA024juvPEhitwdh4FBiwAyaMWeZvzQVC8rrf
pDdgFizC9DfGYkeODdcRfAcjpkRKcGqJvRnEQF6JPOsaLudmHVuuWbKQ7vYu8EJq
SwOCBkSvV5sEDcuAUd8P
=Ojgn
-----END PGP SIGNATURE-----

--0/mZ2nErRHiqrPHn--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
