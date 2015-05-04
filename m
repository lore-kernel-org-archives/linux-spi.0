From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: add spi_statistics framework
Date: Mon, 4 May 2015 14:56:49 +0100
Message-ID: <20150504135649.GA15510@sirena.org.uk>
References: <1430741564-2849-1-git-send-email-kernel@martin.sperl.org>
 <20150504132436.GX15510@sirena.org.uk>
 <3BC3DB7A-8E03-45B5-BEB2-6E74B9597276@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UbqA5qh2E+WCbFAw"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3BC3DB7A-8E03-45B5-BEB2-6E74B9597276-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--UbqA5qh2E+WCbFAw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 04, 2015 at 03:39:10PM +0200, Martin Sperl wrote:

> Typically (i understood) you want things as separate patches, so I=20
> did split the API change from the implementation details:

Separate *logical* patches, just splitting things up by file isn't
really helping unless the change is very large.

> Patch1/2 with the framework/API and the other with the implementation.

> Also the Patch2/2 requires the =E2=80=9Cto_spi_master=E2=80=9D method fro=
m Patch1/2.

> You want now everything in a single patch or you want patch 1/2
> split into 2 distinct patches?

I'd expect to see to_spi_master() in a separate patch.  I don't
particularly see a need to separate out the header file changes from the
implementation.

--UbqA5qh2E+WCbFAw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVR3qgAAoJECTWi3JdVIfQlRcH/3CyxPf/VGce2bfSaYMgxzKf
+1C458bE7Tg/YBeiHnWONb2wSGZmlMJR5tFb61drj8+mRBrheGwAf3OCBPad1yeJ
Iwi7ktRdux1uK542cK4HoeBvw5FJf1w/E3BBLpY5QhkstOdMls3ZAtBzd2SbDSjH
Edgcwb4oWrtMYGrwtv2U+Z0voWVGM85KztIYJ27IgbDinjXc2RJH6aS9yaztgM56
UNFzsm1meziIuUdhTOZlaYxQax/6l98qQe6NvWEpHB0AEMF2a4vJ/92AnDQke/oJ
vqUYqWySrLqfYXdAshitGqJBmjZkP2AfPDUHat53/bkmXpv/fAHs0iFXxiSoohM=
=xYAX
-----END PGP SIGNATURE-----

--UbqA5qh2E+WCbFAw--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
