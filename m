From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: orion: Allow specifying which HW CS to use with a
 GPIO CS
Date: Fri, 26 Jan 2018 11:51:22 +0000
Message-ID: <20180126115122.GC32674@sirena.org.uk>
References: <a1884719d4381cc3254408229cf5d9f94d4f2995.1516744108.git.jan.kundrat@cesnet.cz>
 <CAMuHMdU-06YxWm3MPSBY5weCRCRVRQPUiabGxa-n8ikXi9D-3A@mail.gmail.com>
 <60b34619-5034-4e71-b0b2-75a62de0cf2c@cesnet.cz>
 <96ca6f6776cf4146bcfb56a884236165@svr-chch-ex1.atlnz.lc>
 <CAMuHMdUOFJS=s-8Dv-BBLayXxKqZ0kPAUednA-3NL0+AZYuq-w@mail.gmail.com>
 <20180125115741.GA21900@sirena.org.uk>
 <5dec18c8e18845d39999ca60547fefff@svr-chch-ex1.atlnz.lc>
 <CAMuHMdVESS=_JhsO2pziFshWF+d=g78H8XSny34HTJn=1Lei7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qbvjkv9qwOGw/5Fx"
Cc: Chris Packham <Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>,
        Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Ben Whitten <ben.whitten-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdVESS=_JhsO2pziFshWF+d=g78H8XSny34HTJn=1Lei7g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Qbvjkv9qwOGw/5Fx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2018 at 10:27:24PM +0100, Geert Uytterhoeven wrote:
> On Thu, Jan 25, 2018 at 10:18 PM, Chris Packham

> > I'm more than happy to update the DT on this product. But I've no idea
> > what that update would look like.

> (Un)fortunately a mux driver is WIP, as Mark mentioned above.
> See https://lkml.org/lkml/2018/1/22/859

=46rom the discussion there I think the case that Ben had was for a
controller on the SPI bus rather than a mux on the CS so you're probably
going to have to do this yourself.  I've been thinking about what we
might do in DT terms but I've not been getting too many ideas, we may
need to talk it over with the DT people.

--Qbvjkv9qwOGw/5Fx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlprFjoACgkQJNaLcl1U
h9Ad2gf+NxBPhTDrl34O2NAkvSxe4w69cNCqd084R+mzYnL8mSu3BvsivBAqLTRU
6RQEonL5yKWxD+UW2NPQF1elSjM+Or2kR0ntQMaWPY2jW2OczjCZDSGqjWcHTqiv
bRAKeNWi10O69enA65GJsix+Nj9fIkUQpmOzlVb+9xjFV+JOw9U1Zp66LRJwjwl6
VSTnnc3Tun2M6mq9UeAlNP8L1HyLr3XcxIV52Wwd5xkqVI4NUZkwOAqYYsRt5bE7
GkkVlWVxA22XE7Cw82O7XycGGLgCZ7KOLc012INq1YOpLNyG5NEDTwtyhPieoZCV
6X5BWkeffDMXEK4osL916vanyAp+lQ==
=KAia
-----END PGP SIGNATURE-----

--Qbvjkv9qwOGw/5Fx--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
