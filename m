From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 02/36] dt-bindings: spi: support non-spi bindings as
 SPI slaves
Date: Tue, 17 Mar 2020 11:39:02 +0000
Message-ID: <20200317113902.GA3971@sirena.org.uk>
References: <20200315134416.16527-1-sam@ravnborg.org>
 <20200315134416.16527-3-sam@ravnborg.org>
 <20200316204850.gggeyjulgiy53i7x@gilmour.lan>
 <20200316214346.GA23637@ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Cc: Maxime Ripard <maxime-R63rPqgGiG5yDzI6CaY1VQ@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,
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
To: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200316214346.GA23637-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 16, 2020 at 10:43:46PM +0100, Sam Ravnborg wrote:
> On Mon, Mar 16, 2020 at 09:48:50PM +0100, Maxime Ripard wrote:

> > All the SPI devices will be declared under a spi controller node that
> > will validate its child nodes (and thus the devices) already.

> This was the missing piece - thanks.
> And as Mark put it "why is this suddenly an issue"?
> Turns out this is already properly handled and I made up an issue.
> Maybe Mark tried to explian it to me already...

No, I didn't actually understand how it worked - I was just pretty sure
that it should and trusted that Rob and Maxime had got it right.

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5wttMACgkQJNaLcl1U
h9BF/Qf/e1f3FiL65tLxhJHgSVGWUtvYFUQ6BgqVznQPLNNNIGBfYV1AQsue7zDt
t4vHT0WIpuT/meGsf6ZOMs/tQlq7gQK2+tZzTJEyFCpV1oRmUjdxX63sJtsPVV3T
6rcE1CWMOlAAWIPfegrrkfLvK/LjS7bzRLhYYo7NCgqiRnCMOjsAZawCJtyWYep7
ffPIaxTv+73EvIDvy7/CYjsJRHUGbHtta8CiKb3cm0urAvtvLbcx0ppLHhyr9GcJ
L8uBdMkWd3DRDQM/fPUNmyuWSqGRZwBJmhU+z+jN9bKlQqIC4Iw7JytoE6IOgtg8
9AoTLBvS4BqnlQTGit3CFa6sWdqwIg==
=Df56
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
