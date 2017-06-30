From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv2 9/9] spi: spidev: add Aardvark to device tree
 compatibility list
Date: Fri, 30 Jun 2017 12:51:50 +0100
Message-ID: <20170630115150.zea5iaoih4alqibm@sirena.org.uk>
References: <1498578321-13980-1-git-send-email-amelie.delaunay@st.com>
 <1498578321-13980-10-git-send-email-amelie.delaunay@st.com>
 <20170628185445.fsnqs2tlqqeqzl57@sirena.org.uk>
 <67764839-889b-e398-16eb-de583d82cbf3@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gml6e5yjm24yaoyf"
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Amelie DELAUNAY <amelie.delaunay@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <67764839-889b-e398-16eb-de583d82cbf3@st.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--gml6e5yjm24yaoyf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 29, 2017 at 02:58:43PM +0200, Amelie DELAUNAY wrote:
> On 06/28/2017 08:54 PM, Mark Brown wrote:

> > What does this device actually do and why is spidev a sensible fit for
> > it?

> This device is actually a debugging tool [1] which can work on SPI bus (and
> also I2C). Connected via USB on a PC, it can either acts as an SPI master or
> SPI slave and it can transmit/receive serial data using SPI protocol.
> Polarity, Phase, Bit Order, Frequency can be configured. So this tool is
> really useful during SPI driver development to troubleshoot. And that's why
> spidev driver totally fit for it when used as an SPI slave, for the reason
> described in spidev Documentation: "Developing simple protocols used to talk
> to" Aardvark "acting as SPI slaves, which you may need to change quite
> often".

This doesn't seem like something that should be in DT, it's a tool used
to implement or emulate other things and is no more specific than spidev
itself is.  Whatever it is implementing or emulating should be in DT
instead.

--gml6e5yjm24yaoyf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllWO1UACgkQJNaLcl1U
h9Cllgf+OaogYnbSbFheFfqBhJaEq3eVS1BF9ZDiWZ0O4BZyOlFlkM952YNySEls
8Ow1vj8AXmFeLhDrPLr5U9Uxj6o9AynyqUForPTZoJxAaRXWNOROMBT08/HUOgyp
zgTSNtbmkJvz9/5Qlr7xTiKhX1y5tKpgA18CcuCrePnb8i0Z/MyeIX7FhFlpQ9zb
f6lCHpa+t0BbkXv2nI+YexBFVQVvYOCM7BqV4HxTgfrvijIQNN+vjNkqBwhj1UdH
zqx6Vl1H2mbESfhV+QE6qYnrlx+eyOg3+lgU2GJM/Y/wL7ETeqFaffaUUi+QaDST
R4bSmVBa2ZhVpTnXBXhEKHvD0UK1Cw==
=gnT1
-----END PGP SIGNATURE-----

--gml6e5yjm24yaoyf--
