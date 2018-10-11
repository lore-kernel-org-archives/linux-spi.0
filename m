From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: dw: add cs-override property
Date: Thu, 11 Oct 2018 14:46:36 +0100
Message-ID: <20181011134636.GC25351@sirena.org.uk>
References: <1539155293-21750-1-git-send-email-talel@amazon.com>
 <1539210111.1944.31.camel@impinj.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "talel@amazon.com" <talel@amazon.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "barakw@amazon.com" <barakw@amazon.com>,
        "ronenk@amazon.com" <ronenk@amazon.com>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>
To: Trent Piepho <tpiepho@impinj.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1539210111.1944.31.camel@impinj.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 10, 2018 at 10:21:51PM +0000, Trent Piepho wrote:

> So that's the problem!  I, like everyone else I suspect, switched to
> using GPIO chip selects with this driver because of this.  I narrowed

That's generally a good idea.

> it down to a CS de-assert when the bus switched from TX to RX, which of
> course makes a SPI register read fail on most devices.  The TX FIFO
> would empty at this point, so that would explain it.

> Did the designers of this IP ever read a SPI device datasheet???

> Got to agree with Mark Brown, why would anyone ever want to NOT have it
> work properly?  The previous behavior is not "alternate correct", it's
> Broken.

This isn't even that unusual an innovation for hardware to have, for
some reason automatic chip select management is *really* popular and
rarely helpful.  It's far from the most entertaining thing I've seen
hardware do.

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu/VDsACgkQJNaLcl1U
h9ABMAf+LpTg0hfmKHD8PJyE/3o5CLdISGYbgbh/3uyhir7nDoi1nZz4BEferKLN
VGI3KRpgRAHm784pLf+YC7aBMb/xmPEfsI3F22xz4+3leFd6Oj/gix9fJXak9Fxv
jmzHPPqMu2VlN3jW0jJXX+SnmIQXtjEQx5IrFVJAkO9BjtUYEhLu2Pj1ra998XAF
k2GHIq4lNwLvYA79HaXSk3fQnc9asagNhdjOVFcqDZ/FkAPdajynB6jrmZp/nEOV
ip4TmDodXwHGJbOgiLd7aSlUDwyQzJbtwnwyLbAGMVH/dbXUrPPDXFQriW9BHDFV
OdLIoq8jBQ74bJD0ypcjPZ1LSzZ4/w==
=Nr+X
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--
