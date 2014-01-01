From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: clps711x: Driver refactor
Date: Wed, 1 Jan 2014 15:07:37 +0000
Message-ID: <20140101150737.GR31886@sirena.org.uk>
References: <1388556568-10973-1-git-send-email-shc_work@mail.ru>
 <20140101132334.GP31886@sirena.org.uk>
 <1388583851.810843204@f301.i.mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wEheX93Nbmc2Tc0S"
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1388583851.810843204-7YUp6uTCZANsdVUOrk1QfQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--wEheX93Nbmc2Tc0S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 01, 2014 at 05:44:11PM +0400, Alexander Shiyan wrote:

> I wrote that this is a complex patch. This is not a fix, but new driver,
> many things are done differently.
> I do not see a way to separate these changes.

I already mentioned one thing that could be done incrementally (the
conversion to devm), from the glance I took through the code there's
several other things that jump out and like I said at least splitting
the hardware.h removal from the device tree changes would be a start.=20

Nothing in what you said the change did nor in the change itself
suggested that it would be impossible to break things up, I'm not
convinced that any attempt has been made to split anything out.

> As an alternative, I can create patch to remove current driver,
> then re-adding new one.  Will be more convenient to watch. Is it better?=
=20

No, that's really not good.  It's very rare that we just completely
rewrite a driver especially not one that's been around for a while -
there needs to be a really good reason for it.  This is a key part of
how the development process works, incremental improvements and code
review.  Doing this both helps improve quality control on changes and
allows collaboration.

--wEheX93Nbmc2Tc0S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSxC82AAoJELSic+t+oim9Td4P/3jCy6TnO2f3naQ040kFqrjS
uMzSj7afwPPc/1xQXb/L3qUCeS8a77OnC+IOa7GEaBLg+NkS2X6UPhMSierDSLHp
gosPwMftQ5CwDL9Xg6+2K8tib44J3lWe5cOAde6zld0RAAnb18dNkNPa07JvSA7r
Ram1udUHmDR501ZkTJUnqJdZs39FQgT2pzeLFGEm3qu33059POnici9KPDJDpd1y
jCqkXA13AJUMSPYQemHPLnLRpqwRGX94V0/yxglWvTvl9PRVanclzuNLwT/OpeW8
ELpEKgssz9f4NlJMvICj5LZephWGMPfmDc0H30Qpei5XULr38XVdOUsPFphiw9wq
3SLBEwUCxiVGKD0UN98fuAVl3WCcvw1gwyGgHqbdw830egfbAehpIZKRQnSiK3lA
hQTxDUolzFhjXBo6MYQ1E3ZT9/5H0ur0y0Hx/2Da1judq0J+uSxUgwgZtlurB3yH
k1QlZs569sHrAA9as9qwtmZlYOs4EP3RqGRoxVBxK8L755tRkc9gwAJrDckG2Nb9
OlbaCPPo0+h05KOrx89YNwz9ppiS0AXnbAdzy04cCSaTru6CtmpO0UGE7pkRBmyK
ZJPRHoraEibSVugGbdrg1dDZfczN9iN5w/eVT5Cy+LC3y0z6Pu61HxA7MgYXud3L
6GDQj5xlbQnk2cOJSjia
=pICh
-----END PGP SIGNATURE-----

--wEheX93Nbmc2Tc0S--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
