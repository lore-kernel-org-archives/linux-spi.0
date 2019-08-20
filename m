From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH net-next 03/11] spi: Add a PTP system timestamp to
 the transfer structure
Date: Tue, 20 Aug 2019 13:55:57 +0100
Message-ID: <20190820125557.GB4738@sirena.co.uk>
References: <20190816004449.10100-1-olteanv@gmail.com>
 <20190816004449.10100-4-olteanv@gmail.com>
 <20190816121837.GD4039@sirena.co.uk>
 <CA+h21hqatTeS2shV9QSiPzkjSeNj2Z4SOTrycffDjRHj=9s=nQ@mail.gmail.com>
 <20190816125820.GF4039@sirena.co.uk>
 <CA+h21hrZbun_j+oABJFP+P+V3zHP2x0mAhv-1ocF38miCvZHew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
Cc: Hubert Feurstein <h.feurstein@gmail.com>, mlichvar@redhat.com,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-spi@vger.kernel.org, netdev <netdev@vger.kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+h21hrZbun_j+oABJFP+P+V3zHP2x0mAhv-1ocF38miCvZHew@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 16, 2019 at 05:05:53PM +0300, Vladimir Oltean wrote:

> I'm not sure how to respond to this, because I don't know anything
> about the timing of DMA transfers.
> Maybe snapshotting DMA transfers the same way is not possible (if at
> all). Maybe they are not exactly adequate for this sort of application
> anyway. Maybe it depends.

DMA transfers generally proceed without any involvement from the CPU,
this is broadly the point of DMA.  You *may* be able to split into
multiple transactions but it's not reliable that you'd be able to do so
on byte boundaries and there will be latency getting notified of
completions.

> In other words, from a purely performance perspective, I am against
> limiting the API to just snapshotting the first and last byte. At this
> level of "zoom", if I change the offset of the byte to anything other
> than 3, the synchronization offset refuses to converge towards zero,
> because the snapshot is incurring a constant offset that the servo
> loop from userspace (phc2sys) can't compensate for.

> Maybe the SPI master driver should just report what sort of
> snapshotting capability it can offer, ranging from none (default
> unless otherwise specified), to transfer-level (DMA style) or
> byte-level.

That does then have the consequence that the majority of controllers
aren't going to be usable with the API which isn't great.

> I'm afraid more actual experimentation is needed with DMA-based
> controllers to understand what can be expected from them, and as a
> result, how the API should map around them.
> MDIO bus controllers are in a similar situation (with Hubert's patch)
> but at least there the frame size is fixed and I haven't heard of an
> MDIO controller to use DMA.

I'm not 100% clear what the problem you're trying to solve is, or if
it's a sensible problem to try to solve for that matter.

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1b7dwACgkQJNaLcl1U
h9Dwjwf/dbqcU17zGra+YlgRKo6DqR3lr7Zs78XeUA8t53b61L28+ZuDRE1j6wYZ
9OR/cjPU20FZ5KSjqpHsGbGvvJh6M0/v5az8EBm0e3vpglKcTRNGJ5dsZHLbOyPb
uEhweMwaanElatxIvhQJvnL6aicGZhl4CQeWqLglAfxvmnfxDzAluYoalAMBk5+c
pjUunBGPtX3bIDuSS/TGeoAtP1+wu/pNS8Nr6+rJ6IIclLlxrm9m3UqxxU8Gg48o
Wxlm31t+Byb5sp8BgweEStjxUzKgwFr4yrgVXCP/mPNpdUv6ViqAq5usdN0SlNsS
ph2TXu+C7V/RLrSsXeCjjbK+STc2Xg==
=wLY1
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--
