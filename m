From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] spi: support inter-word delay requirement for devices
Date: Fri, 25 Jan 2019 17:50:31 +0000
Message-ID: <20190125175031.GA25898@sirena.org.uk>
References: <20190125114429.20066-1-jonas@norrbonn.se>
 <20190125114429.20066-2-jonas@norrbonn.se>
 <CAMz4ku+sqzK19994BpdSfaDjNdXW_-gnCutr_fYQiv5ynxOq2g@mail.gmail.com>
 <f34151c8-28a3-3d53-a27e-b5ff512d9c94@norrbonn.se>
 <20190125174713.GA6939@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Cc: Baolin Wang <baolin.wang@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>
To: Jonas Bonn <jonas@norrbonn.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190125174713.GA6939@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 25, 2019 at 05:47:13PM +0000, Mark Brown wrote:
> On Fri, Jan 25, 2019 at 01:06:45PM +0100, Jonas Bonn wrote:

> > Having this as device property rather than a transfer property allows this
> > to be configured one time in setup() rather than having to fiddle with the
> > configuration register for every transfer.

> That doesn't mean that the coniguration should be done in DT though, and
> given that this presumably is a property of the device there seems to be
> no reason why we'd have it in DT - if every instance of the device is
> going to need to set the property we should just figure it out from the
> compatble string instead.

To be clear here: the suggestion is to add a parameter the slave device
can set in spi_device which sets the default word_delay similarly to how
max_speed_hz works.

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxLTGYACgkQJNaLcl1U
h9DCxAf/ZhToJUZAbdC/m5PTY8/S4yw7f6hqcYtAsweSErRzlz8oiLKYQNQ7h29F
pqKkoM6bRQMgVQU+P91QjCFJwsfOVHYUowcG97/zu8h5wmG/Ca9PNErXj1yhh8GI
nWP6HidxnqPgnuv61U3nLxDV4sClpQwjbsVNKyGuyshyQiYNn5+8w2kjMJkEsjUe
cGPLwgwpmarj4W3gvhdrQYZO09d6je5QH4hu1PGLLBIB2KfAPRWgHdpzrifZRSnC
csO5ofEbBTOAsmgvtYxwG4jg7ewHbJmQ5zcOSVTziPs3GCWyrK7exyY29jDnzQqH
Y1exY/p6I1RNfMj3R7U2EvWz7mbVaA==
=AuTe
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
