From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: Add spi-bits-per-word binding.
Date: Fri, 17 Mar 2017 21:21:43 +0000
Message-ID: <20170317212143.bogj6efzyvvf24yd@sirena.org.uk>
References: <20170220153512.6563-1-adrian.fiergolski@cern.ch>
 <20170221190830.xyubgimyc2w5p5v6@sirena.org.uk>
 <983e943b-30f2-7d80-294a-df29bca11738@cern.ch>
 <20170313175504.mpwjxqbhc4yxk434@sirena.org.uk>
 <12c66ecf-8472-c108-d2b4-1d6c3a8e6e74@cern.ch>
 <CAMuHMdVLUrFnTY+swpxd0yUZ3iMR0_Wi1Dn05NQpYc_4=rA19Q@mail.gmail.com>
 <5f86da77-c3f9-24e4-6c9a-3e2554bb49d3@cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nhvgtzck7k2bdoun"
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
To: Adrian Fiergolski <Adrian.Fiergolski@cern.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5f86da77-c3f9-24e4-6c9a-3e2554bb49d3@cern.ch>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--nhvgtzck7k2bdoun
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 13, 2017 at 09:26:04PM +0100, Adrian Fiergolski wrote:
> On 13.03.2017 at 20:57, Geert Uytterhoeven wrote:
> > On Mon, Mar 13, 2017 at 7:12 PM, Adrian Fiergolski
d
> >>> I can't see any way in which it follows from the above that it's a good
> >>> idea to try to override bits per word settings in the device tree, that
> >>> just wastes user time and is an abstraction failure.  We need better
> >>> handling of defaults done purely in the kernel.

> >> If enforcing by device tree specific for a given device driver SPI_CPHA,
> >> SPIC_CPOL, SPI_CS_HIGH, max_speed_hz, etc. if fine form the abstraction
> >> point of view, why it doesn't apply to bits_per_word ?

> > Because unlike polarity, phase, and speed, bits_per_word is a property
> > of the communication protocol.

> > E.g. you can talk to the same EEPROM using different polarities, phase, or
> > speed, but bits_per_word is fixed.

> In this case, currently, what is the proper way to handle SPI
> controllers (spi-xilinx) without 8-bit transmission support ?

As I said above we should fix the handling of defaults such that it is
possible to instantiate a 16 bit using device on a 16 bit supporting
controller; there should be no need to have anything about device tree
in this.

--nhvgtzck7k2bdoun
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljMU2YACgkQJNaLcl1U
h9AiBAf/USaREgxvBaZGRu4zT+dwv0/+4xF+wfbsHR9pHZ8/kXOdEmmWFXqEH40p
z88GoIrpr7V0MRzjkGYbT2cgsb1GyC2UN1PmCWbRoHRAaGHuqhVDVEue/sFB8wkJ
NUqwjW9H5uWCwo1TF2Kxr2BNwbdn5jRu7UKL6pIJijJOIG7s6hVjxV3D/nsRi9uS
tGOTXtWWIGAISHjQWluRqKvQ0/hl89uU9bEBG2Tp0N36Mr8Nn0WWEaJgPfzFLK+p
nQP8AEzqxV8Y75bmKK1AKapNxcAFMMay3yhmy6cRySHSRsAEVLGxmZPEzzpMnJMC
RvqJRPK795ksOWR59nVDbHM7nFxM7g==
=2nST
-----END PGP SIGNATURE-----

--nhvgtzck7k2bdoun--
