From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Applied "spi: sh-msiof: Add compatible strings for r8a774[35]"
 to the spi tree
Date: Wed, 27 Sep 2017 10:01:45 -0700
Message-ID: <20170927170145.lseodaywmmuqvmcj@sirena.org.uk>
References: <CANqRtoQjvkm4rMXt6jEaVWBeieEzqzT-yw_oARV7sj-SpTxB6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a5edrn7wvgq2h4m4"
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
        Fabrizio Castro <fabrizio.castro-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Chris Paterson <Chris.Paterson2-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Biju Das <biju.das-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CANqRtoQjvkm4rMXt6jEaVWBeieEzqzT-yw_oARV7sj-SpTxB6g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--a5edrn7wvgq2h4m4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 27, 2017 at 02:36:01PM +0900, Magnus Damm wrote:
> On Wed, Sep 27, 2017 at 2:30 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > On Mon, Sep 25, 2017 at 09:15:53PM +0200, Geert Uytterhoeven wrote:

> >>   3. When updating DT bindings for new SoCs, we usually add "No driver
> >>      update is needed" to the patch description to clarify. Unfortunately
> >>      that was missed here.

> > That's basically the same good practice thing, it's just documenting
> > what you're trying to do here with not putting things in code but
> > writing things in changelogs doesn't make them so!

> My opinion that good practice is to document the per-driver supported
> hardware by explicitly listing the per-SoC compat strings in the DT
> binding document.

> Then exactly which compat strings the driver matches on is really part
> of the software implementation and it will most likely vary over time.

> So my view is that only updating the DT binding document should be
> enough in most cases when fall-back compat strings are used. I guess
> other people see it differently?

> Is it too much detail to let the MAINTAINERS file point out both
> driver files and the DT binding files?

It's supposed to do that already.  All I'm saying here is that the patch
doesn't seem like something that needs actively reverting since it's a
perfectly valid and even potentially useful change to make.

--a5edrn7wvgq2h4m4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnL2XcACgkQJNaLcl1U
h9DUqAgAgkT1Xp+tlFdsb0/54yD236svgkfMMwj4kEpa/CDnohJuKLfMUr8djN2s
pNFGJW2kGg7GyXNw3ESXy9gK82XdwDprHsfaICt3ozwLFs2xkOfmh9M9XZ6Wfl8S
/OFwgr/3RsdfW7pGJT/5uqVNz1jOM9ZJPsS/rPLcN7XQmlItbTh3FafUZhTDhh1B
sosIYtuRLL8/LsMSvDzkG3GH8ztrjWckYAk6JK+Tn0sMsCy8g6+ZLVTgptyhU3P8
/qYVcrT5UQXySstGb2/8PwQlu+2hgc8Ky9LJd6SCHP8SJ2xwDGQDBWMwUXbyFEub
TcdBaIPcKtwXW+M5a6VVwMWzxWC4ew==
=PVud
-----END PGP SIGNATURE-----

--a5edrn7wvgq2h4m4--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
