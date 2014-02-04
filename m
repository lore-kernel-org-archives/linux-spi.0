From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Add a timeout when waiting for transfers
Date: Tue, 4 Feb 2014 17:45:37 +0000
Message-ID: <20140204174537.GJ22609@sirena.org.uk>
References: <1391121536-10937-1-git-send-email-broonie@kernel.org>
 <CAMuHMdUVmL5Zq8AYPVmUyWEBTzokSMV-Xg4uFzpxr7c2uSmU7g@mail.gmail.com>
 <20140131114935.GA22609@sirena.org.uk>
 <CAMuHMdXLe+Ot5ntOtUC2Qynid4mv1h+UoitJuDW=Z-iyRKXCdg@mail.gmail.com>
 <20140131122617.GC22609@sirena.org.uk>
 <CAMuHMdXgDAPy4aezxULQsjiRUfyE3F2_NSjuWhBiy119DSXR5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uLekVA18SmRka8J6"
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXgDAPy4aezxULQsjiRUfyE3F2_NSjuWhBiy119DSXR5A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--uLekVA18SmRka8J6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 03, 2014 at 09:55:33AM +0100, Geert Uytterhoeven wrote:
> On Fri, Jan 31, 2014 at 1:26 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > to be letting the transfer run in the background.  Though I suppose that
> > might make sense in some situations...

> While I've been thinking about moving more code to the interrupt handler,
> the current RSPI transfer_one() is indeed still synchronous, so the timeout
> doesn't apply yet.

OK, that's interesting.  Actually one of the things that this
refactoring into the core is driving at is that hopefully we'll be able
to deploy some of the optimisation techniques like that in the core
rather than having individual drivers open coding them - this should on
average increase performance.

--uLekVA18SmRka8J6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS8Sc+AAoJELSic+t+oim9yKAP/0J9SAom3WSJmAGHvbF15Mpr
3Yemxtchsq1A31h9QYsnhq/766eWbwPhkiXOjjKoYx4+1OFqGkrayq5pkUe/6Zc+
50CLAuEsSz/4ZVIW8VKZhV9VuvBWvW3aSdKnPFIvQMjLKOrbXHIhUk4HOEE3WQnG
WDyvZ8OvgpryCv0Yn2b3QFrD63OWFASWgEBPg7ckLnPZNc9VNZxwZPZzmEEH6lZh
jWmfNNbh+Tx9L1U+2XFATrriOyf1gTECvDHRavg/VDkPK7mhV0xbIah9CJJKCrbr
knruOYWS99xR/B1ubrMvpGv0Gdeg05ZnrBczxMWTJNXonKbdeGHQfshX8VVZ9mgs
9YUclykh1KiTej1dUfSCLCOErWHg84fVJEjT8qF038Opd2qyG7uUal3Yb4ga+Vhj
nh+C19C81Pev1yhlQH55FBPR6YJhnrs0r4aRxLBY6LSJb/Ctjr59mUbbTDZkf4Es
VeSY4+3rsXakkjaWNpoUjS+2XgeM9SToGtoYo0sHCM3X9gFFG2vCKv0vHTJPheYi
2V5XnoeiP3qOvZCjbSfbjNgXWnQxHrqUmw7gCoX5UnexEXO39NuL4ZUcZjsrgmQ8
LSf8hENeXon7myoOv0LdzhxggQZL6g+n/4t0hMFkG+W3OkUy8GHSLKEs4ayUvjfi
xDN0gpB3tdiCYY6ce/DI
=Ru0I
-----END PGP SIGNATURE-----

--uLekVA18SmRka8J6--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
