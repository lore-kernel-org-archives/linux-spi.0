From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/2] spi: support inter-word delay requirement for
 devices
Date: Tue, 29 Jan 2019 16:41:43 +0000
Message-ID: <20190129164143.GF10524@sirena.org.uk>
References: <20190126163220.26421-1-jonas@norrbonn.se>
 <20190126163220.26421-2-jonas@norrbonn.se>
 <20190128181038.GF11699@sirena.org.uk>
 <1b9807aa-3e6e-16f2-a2c2-ebe5e186d904@norrbonn.se>
 <CAMz4kuK9HAmntmqG-_s6re854tK7UL6wwCh0Lm8=bzpFZsseaw@mail.gmail.com>
 <28617b72-fbc0-4274-d9d1-34c37f03f867@norrbonn.se>
 <CAMz4kuLOSx9mQ-RG9qqy9Qbor97Nj5oYdOgLg_dNfxFeT+XK5g@mail.gmail.com>
 <abb0749c-629f-5a81-1dba-0be260b0fb8d@norrbonn.se>
 <CAMuHMdXyuWMPUdipwW0oQUdPLDyZhssZ1NHQfMF9hWTtMkTZ1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/QKKmeG/X/bPShih"
Cc: Jonas Bonn <jonas@norrbonn.se>,
        Baolin Wang <baolin.wang@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lanqing Liu <lanqing.liu@spreadtrum.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXyuWMPUdipwW0oQUdPLDyZhssZ1NHQfMF9hWTtMkTZ1A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--/QKKmeG/X/bPShih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 29, 2019 at 11:07:50AM +0100, Geert Uytterhoeven wrote:
> On Tue, Jan 29, 2019 at 10:50 AM Jonas Bonn <jonas@norrbonn.se> wrote:

> > OK.  So the user (perhaps in userspace using spidev) has to know the
> > rate of the IO clock that the SPI controller sits behind and then has to
> > match this to the required delay of the slave device...  Doesn't sound
> > very portable.

I think if we're doing translation we should just do it in the core and
either say that clients should only set one or the other or pick what
looks like the higher value.

> I can see the value of having both:
> On some slaves, the delay may depend on a fixed internal or
> external clock[1] on the SPI slave, so it should be specified in time units.
> Some slaves may be clocked by the SPI clock[2], so the delay should be
> specified in SPI clock cycles.

Yes, they're definitely both useful.

--/QKKmeG/X/bPShih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxQgkYACgkQJNaLcl1U
h9BpcQf/ccdkXJ6vmh0isqva90NnEMmC8ctfpWCZ1lh5senmjaIQrllQrXgfsAkm
9V/XOGrByMBLbS1U5dBaA3CPcWuZjtph1axjDkhJy2GG5e+gDZNIFq4sTQvSmTCS
nb8DQgRtHbz/RGFuaW7frG9gCDbQb9T7FSvuLaGFrPABiUJKLKGkRgm3tpxrXXPd
Bo3UGsJgPiO9mjI7IZO60aXSgS46rsE+hnfiJ1v3fc/8ySa6w5zsU6bJh2g8hGj1
ti6kAIrk3dicYPzhSkfgwdNFeJ/din8SBITm04xLbUA4GAFxyWCnohbRDZdZPHHb
LBkls9P3mXpe3gV/9oxc5YGkE0kBzg==
=vhvC
-----END PGP SIGNATURE-----

--/QKKmeG/X/bPShih--
