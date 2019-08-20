From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH net-next 03/11] spi: Add a PTP system timestamp to
 the transfer structure
Date: Tue, 20 Aug 2019 17:49:37 +0100
Message-ID: <20190820164937.GE4738@sirena.co.uk>
References: <20190816004449.10100-1-olteanv@gmail.com>
 <20190816004449.10100-4-olteanv@gmail.com>
 <20190816121837.GD4039@sirena.co.uk>
 <CA+h21hqatTeS2shV9QSiPzkjSeNj2Z4SOTrycffDjRHj=9s=nQ@mail.gmail.com>
 <20190816125820.GF4039@sirena.co.uk>
 <CA+h21hrZbun_j+oABJFP+P+V3zHP2x0mAhv-1ocF38miCvZHew@mail.gmail.com>
 <20190820125557.GB4738@sirena.co.uk>
 <CA+h21hr653oqOPxoJKWkP9ZhTywNR8EBjWV7U9LHwPRz=PJXsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KuLpqunXa7jZSBt+"
Cc: Hubert Feurstein <h.feurstein@gmail.com>, mlichvar@redhat.com,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-spi@vger.kernel.org, netdev <netdev@vger.kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+h21hr653oqOPxoJKWkP9ZhTywNR8EBjWV7U9LHwPRz=PJXsw@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--KuLpqunXa7jZSBt+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 20, 2019 at 04:48:39PM +0300, Vladimir Oltean wrote:
> On Tue, 20 Aug 2019 at 15:55, Mark Brown <broonie@kernel.org> wrote:
> > On Fri, Aug 16, 2019 at 05:05:53PM +0300, Vladimir Oltean wrote:

> > > Maybe the SPI master driver should just report what sort of
> > > snapshotting capability it can offer, ranging from none (default
> > > unless otherwise specified), to transfer-level (DMA style) or
> > > byte-level.

> > That does then have the consequence that the majority of controllers
> > aren't going to be usable with the API which isn't great.

> Can we continue this discussion on this thread:
> https://www.spinics.net/lists/netdev/msg593772.html
> The whole point there is that if there's nothing that the driver can
> do, the SPI core will take the timestamps and record their (bad)
> precision.

I'm not on that thread.

> > I'm not 100% clear what the problem you're trying to solve is, or if
> > it's a sensible problem to try to solve for that matter.

> The problem can simply be summarized as: you're trying to read a clock
> over SPI, but there's so much timing jitter in you doing that, that
> you have a high degree of uncertainty in the actual precision of the
> readout you took.

That doesn't seem like a great idea...

--KuLpqunXa7jZSBt+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1cJKAACgkQJNaLcl1U
h9Ajjwf7BKBd41sf2crMlSALL87ftWHff3zu1s9zzh4XvUN+afcw89zuNjTuCdJJ
soVj9H+nLOGS5Ylh22zu3scMpXcTtrRmYNoGixBW08UtkZDGTAxII5sM9kKdRNlj
e2u9fiqJ6bLLoWfQwlYodzO/5pXi0tCXoe+HuqP9a3GezNTR54EpO3iaCOeGSvq5
RXPXs6U76X+u8folfG1/s6N4yDDgWZatwBD+rjwhSOaWuNtDEf4/06UGLsczxoup
DkX/0FAAixRH/6twBZ4qs2gTTLeSsVt2zimSwfyDsfI0CRvfR6CQH6qIwKt3HOaO
kCue4zjaFxBzR6SU877WWSj6gMNZAA==
=SHGy
-----END PGP SIGNATURE-----

--KuLpqunXa7jZSBt+--
