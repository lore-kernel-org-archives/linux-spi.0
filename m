From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] Revert "spi: bitbang: only toggle bitchanges"
Date: Fri, 24 Jul 2015 15:50:36 +0100
Message-ID: <20150724145036.GL11162@sirena.org.uk>
References: <1437716236-12715-1-git-send-email-larper@axis.com>
 <20150724104419.GH11162@sirena.org.uk>
 <1437738480.31818.5.camel@axis.com>
 <55B227B2.9080205@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Xd6meC5WbNV8N0zk"
Cc: Lars Persson <lars.persson-VrBV9hrLPhE@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55B227B2.9080205-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Xd6meC5WbNV8N0zk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 24, 2015 at 01:55:30PM +0200, Lars-Peter Clausen wrote:
> On 07/24/2015 01:48 PM, Lars Persson wrote:

> >No this is a misunderstanding about the semantics of the bool type.
> >When assigning to the bool any non-zero value becomes 1.
> >When comparing an integer against the bool, the bool is promoted to an
> >integer.

> From the patch context alone it is not clear that oldbit is of type bool. I
> think this is where the confusion came from. By just looking at the path
> fragment itself you'd think that oldbit is a unsigned int given its usage
> pattern. But it becomes obvious that the code wont work if you know oldbit
> is a bool.

...and obviously the clear intention is that it should be an unsigned
integer so the appropriate thing to do is to fix that.

--Xd6meC5WbNV8N0zk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVslC8AAoJECTWi3JdVIfQ9zsH/jGo2KQmoGk9TE/SVU3Se9wy
CFbfS3ZgPVOAwJtUOhFdHlmlC1XEJ7506mgEYyYwxsVg+cH90Bnvzgn8/0xIWtOA
P+Lve42qd49YpX9ZASH2yKFmto6ykiwZHf8dl/0njtHdb6oa/C9kRtWbBSsRIrPP
Uu4IyrSoYy9gM1dNCkV7YuF2CLP7+qU/SECFSI51n0cYZR2StthFBikA7TSesCXi
xj6WRJjaofIOMYTX8jdKNOuase6LERXnp3t9P+eo03S725fQfcP3hSikmBEPGH7m
sVMPTAswyiVLkPYJsOy6xp+PrWf8o/ytyNxgFu0Qpt9RAewwVRMEk77cMNuba3M=
=qqpI
-----END PGP SIGNATURE-----

--Xd6meC5WbNV8N0zk--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
