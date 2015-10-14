From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH] spi: omap2-mcspi: disable other channels
 CHCONF_FORCE in prepare_message
Date: Wed, 14 Oct 2015 11:56:59 +0100
Message-ID: <20151014105659.GU14956@sirena.org.uk>
References: <5616816C.9020904@baylibre.com>
 <20151008152105.GA13157@deathstar>
 <20151009113810.GD1542@sirena.org.uk>
 <20151009142451.GA25376@deathstar>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qa1NXTiqN6KSzHv0"
Cc: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Fionn Cleary <clearyf-/Zw1syy4LHg@public.gmane.org>,
	Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151009142451.GA25376@deathstar>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--qa1NXTiqN6KSzHv0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 09, 2015 at 09:24:51AM -0500, Michael Welling wrote:
> On Fri, Oct 09, 2015 at 12:38:10PM +0100, Mark Brown wrote:
> > On Thu, Oct 08, 2015 at 10:21:05AM -0500, Michael Welling wrote:
> > > On Thu, Oct 08, 2015 at 04:45:00PM +0200, Neil Armstrong wrote:

> > > What is the point of doing this void cast below?
> > > Avoiding compiler warning perhaps?
> > > Perhaps you can __maybe_unused for the variable instead?

> > > > +	/* Ignore message */
> > > > +	(void)msg;

> > You shouldn't need it at all, but yes if there is a good reason to mark
> > something as unused the above annotation is better.

> Which one?

__maybe_unused.

--qa1NXTiqN6KSzHv0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWHjT7AAoJECTWi3JdVIfQ4c0H/30Ifkg0CLxBPxkYNQOurf8c
ORL+JKikloHu3gKvzYBwz1kJyPpcUXSZQbf6JWPtNXku4mObq9S2ubpaDRv3oUfV
d4J8vvCKe1BSvIScmMro/+yGkfx2Md9+DE1Pe2WG2iUm/LvLpSUzGFbYXajsgLAe
/fo9jQT+WDOTREpOCJ37PhHfXt+8DNiR5+XKYQ1KNeL7briKj1saZZjaxFMeKuAt
dbVZc8qAPYmKnAzSdVNWw2lEKWdNy+3oURfk8AcSMSJlFbxqLw05jjmoy/8Dw9P+
yRbg6I/PGceKVbTp/WSZhmX/uC3i1pQfg3zUmdf0kx5d+WJQW6pfX1YXPlvuqwM=
=MpAa
-----END PGP SIGNATURE-----

--qa1NXTiqN6KSzHv0--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
