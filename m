From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: orion.c: Add direct access mode
Date: Fri, 25 Mar 2016 15:50:32 +0000
Message-ID: <20160325155032.GH2566@sirena.org.uk>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <12540712.SXPhdxqg9f@wuerfel>
 <20160325103253.GA2566@sirena.org.uk>
 <4319407.5A4b1VspuB@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XHgmWAdw81HgL5Tt"
Cc: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4319407.5A4b1VspuB@wuerfel>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--XHgmWAdw81HgL5Tt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 25, 2016 at 04:11:05PM +0100, Arnd Bergmann wrote:

> There is nothing magic in the binding if we just do the same thing
> the flash driver does, and describe the memory range that is associated
> with a chipselect.

Why are we even doing that though?  Like I say it just seems pointlessly
unhelpful for users.  Are we really saying that every single system has
to go through and manually modify their DT so that they can use this
entirely in SoC feature?  That doesn't seem like winning...

> > > Ok, so with the static mapping it could be done very easily, or
> > > we need a more complex solution for the dynamic mapping.

> > Part of what I personally don't understand is why this is complicated?

> I think we'd need to add another special case in the bus driver
> for it, which otherwise should be able to handle this in a generic
> way: if we just use the existing binding, the spi host driver can
> simply call devm_ioremap_resource() to see if there is a map
> for a given chipselect and otherwise fall back to the current
> mode.

Why does the binding have to be in the client device to do that?

--XHgmWAdw81HgL5Tt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW9V5HAAoJECTWi3JdVIfQZDYH/jw4rfYBxzSqGb0YEUhOILvH
8PJPFH9VmCUrv6B58mRw6JdD2Vstbj4xHo+oy+OGK7QVY+AKsMo/SYYd+59WmhNa
kCfF2xN1YtekHUT9F1bU/sMY7MnXARvr9Qj0iahUcsUqxuN55N/VY/l04kvnvTh3
PBHQjt9bLcqKNmujcK98ra/I7gmCrtFPPksjDPImKrm8Os2nRhaQoOYi1qrC6m1P
JxnubUY1Ks1JXQBXvW+LTBWKE9i0H22HHBGGp3O0mpgPARdU4phVYTkLO43jK3H6
mPn3n4sIBoW5RA8fSADPAjXCf737eDQNgLsYhOy9HKQSSJWTLpOaswp72rrvolM=
=/GjQ
-----END PGP SIGNATURE-----

--XHgmWAdw81HgL5Tt--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
