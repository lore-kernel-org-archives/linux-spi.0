From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/3] spi: SPI bus multiplexer
Date: Fri, 12 Apr 2019 09:29:13 +0100
Message-ID: <20190412082913.GA6909@sirena.org.uk>
References: <20190412050213.17698-1-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Cc: robh+dt@kernel.org, mark.rutland@arm.com,
        Hamish Martin <hamish.martin@alliedtelesis.co.nz>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190412050213.17698-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 12, 2019 at 05:02:10PM +1200, Chris Packham wrote:

> Unfortunately recent changes have stopped my hacks from working. I've
> tried adapting cs-gpios to work with my particular hardware but I came
> to the realisation that the current cs-gpios support assumes a 1:1
> mapping of gpio to SPI device whereas my hardware used the state of the
> gpio selecting the device i.e. a 1:2 mapping.

> This is my attempt to implement a driver to deal with this. One nice
> property is that it is pretty much self contained. The only change to
> the core SPI infrastructure is exposing a function I needed to lookup
> the spi_controller instance.

Why not implement the device that demuxes the GPIOs you're using for
chip select as a GPIO controller?  Presumably it might get used for
things other than chip selects.

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlywTFYACgkQJNaLcl1U
h9BDOgf+IcHAaeWBs4Mx2UtTah7O0uKNJnMfEXCcEao8tcgoRcqci45sx2Nr76JE
1qsM5/xGOsIBAnrP6saJ4hsY+oVuebCI/WOyy9VGgwSTYEtZCkObtVGxphM9aesN
3/gIVxrga7JjARBZB71csTJ9CuzdBDMCQA44qfjbbrMv40WIX/OSvMMrG7+IGCqp
cvYZ5Wh6gUjdoW1Bz795QnAxsmjJFrctcDYu7tSNBk92M5r+972l/27eDwjRnjKG
xRj05HYDartmd4aSaiYIm/hjFYwb7Uc7oR2SFYa+5vZF6N/yjRuSL2AqSueEvp6y
epJnfXiXFUSaDvAJRu/O22f97jHwbA==
=1YqJ
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
