From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] devicetree - document using aliases to set spi bus
 number.
Date: Fri, 27 May 2016 19:36:29 +0100
Message-ID: <20160527183629.GO16172@sirena.org.uk>
References: <1464107960-10775-1-git-send-email-christer@weinigel.se>
 <20160524174140.GE11605@leverpostej>
 <5744BC76.9090403@gmail.com>
 <20160525092034.GE1337@leverpostej>
 <5745C5A3.6060202@gmail.com>
 <20160525174809.GA8206@sirena.org.uk>
 <5745F30B.2040605@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LfQcPIWFRhGivmDw"
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Christer Weinigel <christer-rKHMIqA5R6gwFerOooGFRg@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5745F30B.2040605-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--LfQcPIWFRhGivmDw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 25, 2016 at 11:46:35AM -0700, Frank Rowand wrote:
> On 5/25/2016 10:48 AM, Mark Brown wrote:

> > Sometimes the best thing to do is remove the behaviour, some of these

> Yes.  And I have not formed an opinion on whether the existing
> behavior should be kept, deprecated, or removed.  I have avoided
> commenting on that.

That's not been clear...

> > Adding documentation for every last implementation that happens to work
> > in a given situation through layers of indirection isn't going to help
> > with the usability issues DT has, one of the things that the

> That is not a reasonable description of this case.

> What the kernel does with the spi aliases is not a random unintended
> side effect.  It was a deliberate choice.  Read the commit message for
> bb29785e0d6d150181704be2efcc3141044625e2

I've read that (for the benefit of those playing at home that's "spi/of:
Use DT aliases for assigning bus number").  What that reads like to me
is that it's a quick hack which may or may not be intended to be used in
the specific way it's being used now - it's still at a remove from the
obviously not DT idiomatic spidev which isn't mentioned at all, it could
be for that but it could also be for people trying to read log messages
or distinguish between other devices.  If it were for spidev I'd have
expected labelling at the spidev level as it's both more direct and
useful (we can easily get a string out rather than just a number).

It does also mention a previous effort based on cell-index which is now
being ignored as far as I can tell but presumably you feel must also be
documented as a thing that might've done a thing in some older software
release, I'm not sure that's useful though.

Personally the way I parse this situation is that the kernel is taking a
look at what's in the DT and making an effort to present it usefully in
the running systems.  Fixing our current interpretation in stone as a
supported thing when we don't have to makes it more cumbersome to
improve and discourages any efforts to do similar things in the future.
It is reasonable to provide and document something here but when there's
some fairly simple and obvious better things we could be doing it should
be those rather than the legacy stuff.

--LfQcPIWFRhGivmDw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXSJOsAAoJECTWi3JdVIfQfIAH/0idQCgC7AJPmjR/erggSuYo
mOh6m4x1RCKIbgAyeiuxyyzy+GQAXHuE7xG6H0/ZTE7d8HdzBxSzFJiGTiRsgNA2
IkKBsjiPqcr+NRRaXU3rx3VVKNNMIwOgNojtkjq6c0/FUajVlGEXJ2+CpSCa1Oa8
uXyP/2QbGi7qRjKv5LeMF+OWLN1Hgq5myIIC9SdfjnjIOHKogSBDtjavzRj+vu/c
q0IjsckeKQCnaV2cJKRvgBukk4n3CIXQoaIgEh+XpRsqKmutXomYVECn0FvycrYz
ETLwUoUQ7SmkDVuyVur4aWBvK/RMWygX/8eUS1PLe+LMHsdCbdal2ir9Btf4a/0=
=sUj7
-----END PGP SIGNATURE-----

--LfQcPIWFRhGivmDw--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
