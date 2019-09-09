From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/4] Deterministic SPI latency with NXP DSPI driver
Date: Mon, 9 Sep 2019 11:06:18 +0100
Message-ID: <20190909100618.GC2036@sirena.org.uk>
References: <20190905010114.26718-1-olteanv@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
Cc: h.feurstein@gmail.com, mlichvar@redhat.com,
        richardcochran@gmail.com, andrew@lunn.ch, f.fainelli@gmail.com,
        linux-spi@vger.kernel.org, netdev@vger.kernel.org
To: Vladimir Oltean <olteanv@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190905010114.26718-1-olteanv@gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2019 at 04:01:10AM +0300, Vladimir Oltean wrote:

> This patchset proposes an interface from the SPI subsystem for
> software timestamping SPI transfers. There is a default implementation
> provided in the core, as well as a mechanism for SPI slave drivers to
> check which byte was in fact timestamped post-facto. The patchset also
> adds the first user of this interface (the NXP DSPI driver in TCFQ mode).

I think this is about as good as we're going to get but we're
very near the merge window now so I'll leave this until after the
merge window is done in case there's more review comments before
applying.  I need to reread the implementation code a bit as
well, it looked fine on a first scan through but it's possible I
might spot something later.

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl12JBkACgkQJNaLcl1U
h9A12AgAgjBaLkxqsVW5TL56eMjLxX9dEojMe22QzVUBeRfLcXLRQ0M/5AJqvzf4
AEmOsHlPLqh/SKRoVfOa4Xr2h/Zaiz6wzCcvsLxe3B9P7MYg0/9kyHiDEjGExuq4
X1r18hLuMKsWjBmrWoojtSGlQd5pbpmRdVPDseF+ved5Gp4S78KKx2gDZxYGuiy6
JB9LDRvsELfSndCxCJAC6s5BTb4uSmlVOB4gyzWR31XZXtNwIT4lz0eLUlaI0UBW
ckxeMzTSeBRrQ5vQMm/1ZwjYh7hdhQYlWn3minuDj5FWwgVj754fdoi/2+rW7FaU
27xyj6cr4VIcQXWmU3DylfAbe+qE8Q==
=eS/Q
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--
