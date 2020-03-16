From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 02/36] dt-bindings: spi: support non-spi bindings as
 SPI slaves
Date: Mon, 16 Mar 2020 20:14:08 +0000
Message-ID: <20200316201408.GK5010@sirena.org.uk>
References: <20200315134416.16527-1-sam@ravnborg.org>
 <20200315134416.16527-3-sam@ravnborg.org>
 <20200316120239.GC5010@sirena.org.uk>
 <20200316132844.GA22822@ravnborg.org>
 <20200316163538.GJ5010@sirena.org.uk>
 <20200316185733.GA18307@ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GmiNL4+5WUWrod5m"
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,
        Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
        Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Brian Masney <masneyb-1iNe0GrtECGEi8DpZVb4nw@public.gmane.org>,
        Chris Zhong <zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
        Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
        Guido Gunther <agx-wGvLLbajjwFAfugRpC6u6w@public.gmane.org>, Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>,
        Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>,
        Hoegeun Kwon <hoegeun.kwon-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Jagan Teki <jagan-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>,
        Jerry Han <hanxu5-dyavHbARFqWrZjcNGxgArdPArS5jOdiE2SarAXORi/o@public.gmane.org>,
        Jonathan Bakker <xc-racer2-kt+e9JA1QaI@public.gmane.org>,
        Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>,
        Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
        Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marco Fr
To: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200316185733.GA18307-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--GmiNL4+5WUWrod5m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 16, 2020 at 07:57:33PM +0100, Sam Ravnborg wrote:

> It was the best I could come up with - and this patch was called out
> for review in the hope there is a better way than this patch.

It definitely seems like a useful thing, just a bit surprised it's not
already there and if this is the best way to do it.

> We have similar examples like:
>   - pincfg-node.yaml
>   - regulatro.yaml

I'm curious what properties your consumers have for regulators - I'd
expect them to just have simple pointers to the regualtors with no
configuration.

--GmiNL4+5WUWrod5m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5v3g8ACgkQJNaLcl1U
h9CQ3gf/ckkj/FyMuU25wpmw52sUNJySLmtRn6yJPOc2AMPbRhW2r1LrNNzxczyh
THPGUrBiVpjZ6eXQy9R+zAOFmQXHPpR2dErQ8z5M+/PH1oxwwcztLW5RXcVXbyBW
QP2qJ+sXzqYQIp1aRXEgD5Nt/ePqsLUvgkYj7SpG5Txx5hRQiesNzVovCJeaBAU6
CtYsvXOAfFvWhL9qNX5P9y+ULs+db7xySoOz/5wOK+e2TlWkOjTNlH5wtvY3D6oO
zS6VHPjaCy/wCfjjXUZhXbGRb+M2ZF3bwMD5dJ6Dw2rjFUXwa33L6BhpgAcTdP/P
QxPkPAvZsQX/9DwEs48aA5CckvRVKQ==
=VIU6
-----END PGP SIGNATURE-----

--GmiNL4+5WUWrod5m--
