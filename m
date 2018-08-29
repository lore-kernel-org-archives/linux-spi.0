From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/3] spi: Introduce one new field to set word delay
Date: Wed, 29 Aug 2018 12:47:05 +0100
Message-ID: <20180829114705.GC27808@sirena.org.uk>
References: <a77a6bb8b3abf1c127014c78f71533c24afacd93.1534423916.git.baolin.wang@linaro.org>
 <01c9b188-5b67-40c0-b08d-99a0543ddf54@cesnet.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Cc: Baolin Wang <baolin.wang@linaro.org>, linux-spi@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, lanqing.liu@spreadtrum.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To: Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <01c9b188-5b67-40c0-b08d-99a0543ddf54@cesnet.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 29, 2018 at 01:33:24PM +0200, Jan Kundr=C3=A1t wrote:
> On =C4=8Dtvrtek 16. srpna 2018 14:54:49 CEST, Baolin Wang wrote:
> > + * @word_delay: clock cycles to inter word delay after each word size
> > + *	(set by bits_per_word) transmission.

> The description can be improved because it left me wondering what "clock
> this is about. I suppose it's about the SPI clock cycles and not CPU clock
> cycles, right? I'll be hapy to patch this once Baolin confirms that that =
is
> the intended meaning.

That's certainly how I read it.

> It seems that this is only implemented in one newly added driver. I'm
> interested in supporting this in spi-orion.c, but that sounds like
> driver-specific work for something which is pretty generic. How should th=
is
> be implemented? Given that drivers for SPI masters can implement a functi=
on
> which transfers several words at once, there are not that many better
> possibilities than adding udelay()s, though. Thoughts?

Yeah, you'd need to split the transfer into words and then add a delay
between which would be rather expensive but it's about as good as we can
get I think.

> What is your plan to do with drivers which do not implement this (yet)? I=
f a
> spi_transfer gets queued which asks for a word_delay delay, it is silently
> ignored now, AFAIU.

Yes.  A generic handler would be best.

> What about userspace support, spidev and spi_ioc_transfer (that's my targ=
et,
> actually)? Is it OK to s/pad/word_delay/ in the spidev code and pass that=
 to
> the generated struct spi_transfer? In my opinion, once we support specify=
ing
> this from userspace, one has to definitely check that the SPI controller =
is
> ready to honor this request. Do we want a new bit in spi_controller.flags
> for this?

Not seeing pad in the spidev code?  A feature flag would make sense along
with a generic implementation.

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluGh7kACgkQJNaLcl1U
h9BTMgf/WsVnPfRsreSpuhbtndOSz23d4L5il38ytg2aGPqBlmb0zOOL6R/O54sm
kqmLj8hmcyudwQtWslTsqqnRXEwvQnIMBXKIW0ah6eA1nPulgQMaq8rWatGqcF/f
H6Sv6tYoQk1pCBpfgoINoPelAd8RyG/kgrSmxf1W4oUGv2m4Ejkaaujah7smUed8
chJQ055evB+dBOr/j8MRc9rsguA5z6dZwVNAqnLbzZBpAlqloBtC9CfRLCWbgkgD
F+Zxp2ZK78tfxIyaPIAnhdtI239vf21j9wy2+WvjtKE0LLERCF0bc957aGDWgUAB
KaMI6qlq2ikq44ged3Dx70VgxF3o8Q==
=LMiq
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--
