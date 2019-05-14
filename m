From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] spi: For controllers that need realtime always use
 the pump thread
Date: Tue, 14 May 2019 16:06:07 +0100
Message-ID: <20190514150607.GA1917@sirena.org.uk>
References: <20190510223437.84368-1-dianders@chromium.org>
 <20190510223437.84368-2-dianders@chromium.org>
 <20190512073301.GC21483@sirena.org.uk>
 <CAD=FV=UBic4qywgYQFGEXx_frD9ZoRJX7XGgDbQCvb2CbkBa9w@mail.gmail.com>
 <20190514093038.GB8665@sirena.org.uk>
 <CAD=FV=UXhQg2CuNsTCkSe1BuEvkGMj6qeUB2iF=Qfj=Z0fLiWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Cc: Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
To: Doug Anderson <dianders@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAD=FV=UXhQg2CuNsTCkSe1BuEvkGMj6qeUB2iF=Qfj=Z0fLiWw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 14, 2019 at 07:42:38AM -0700, Doug Anderson wrote:

> ...but I guess you're saying that you don't want to guarantee that the
> SPI core will happen to have this thread sitting around in the future
> so you'd rather add the extra complexity to cros_ec so the core can
> evolve more freely?

We need something to support spi_async() but what you're asking for is
fairly specific implementation details about how things are currently
structured, and we do need to be able to continue to make improvements
for users who are interested in performance.  Ensuring that the calling
context is also less likely to be preempted is going to make it much
less likely that any other work is going to cause some timing change
that creates problems for you.

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlza2V4ACgkQJNaLcl1U
h9BdzAf+KMVQaYP9/vNw0i0uGrveiVFMzejKMkn1HLO53K5CGl+UPRj+Y2OYUy/4
o4zonygqZNCkn+XY4BVZHOGInN1sb2Vzp6Ky1kuw76YxxwL+xKsLuua7+HQ9bCQM
oVh1Okwky0twqGK78DMtZpfRrYyetWfXA6teiW7G3LZ9+eEd0hXuVVGamq9lzDlM
zYR8ar3mdRRJmW8JGkJSE0t6Q03CMoeVPoNT8TUs41QnLfNOi/shVZ5kRwbuyoTA
PZGyAEjbIEYmMe7UR09ePu685ymCtrO9KjqplYeBQBOaUm6KqjURqrJBGWhVyLqF
sRSuDvQVfjGjiNbqlpfc7QsEj0HaLw==
=RN96
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
