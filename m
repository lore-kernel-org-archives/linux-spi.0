From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/4] spi: meson: Add support for Amlogic Meson SPIFC
Date: Tue, 18 Nov 2014 14:28:24 +0000
Message-ID: <20141118142824.GJ22111@sirena.org.uk>
References: <1416264471-774-1-git-send-email-b.galvani@gmail.com>
 <1416264471-774-4-git-send-email-b.galvani@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sT9gWZPUZYhvPS56"
Cc: linux-spi@vger.kernel.org, Carlo Caione <carlo@caione.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Jerry Cao <jerry.cao@amlogic.com>,
	Victor Wan <victor.wan@amlogic.com>
To: Beniamino Galvani <b.galvani@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1416264471-774-4-git-send-email-b.galvani@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--sT9gWZPUZYhvPS56
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 17, 2014 at 11:47:50PM +0100, Beniamino Galvani wrote:
> This is a driver for the Amlogic Meson SPIFC (SPI flash controller),
> which is one of the two SPI controllers available on the SoC. It
> doesn't support DMA and has a 64-byte unified transmit/receive buffer.

This is all good.

--sT9gWZPUZYhvPS56
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUa1eIAAoJECTWi3JdVIfQ4CsH/is/jUtomdmXalHCodXC1Itp
HRX6vo3rAYSVLvHK/6u0VRD8H9QyEsnW7fjK+LtcGnHmhwYhcPhwV53Dm381WTJR
k9NAhjTUCb0iQ/9+0WJ3+dbg+MJz2Mqj5P2q2wjiW5sFrBO11CRkaejhADvUDqCe
wMWeiJsQoRr90hpWAmDdP5qbqIIDcN/6MopmMuhc3HgvTcmwDKYjV/M+546SRMRW
rigmpJt9WmI0RB2oZeSWv5Soi41eTldM3Ad1ZCWwwboDBZlbk5cxC4Qte9IqphIx
ysxVOdFvOwaOIQ4JkWU0EbqUFWwtyRtcTdGml/rUPdBAyfJJqDZb5qPEJ0FQM/o=
=5SbJ
-----END PGP SIGNATURE-----

--sT9gWZPUZYhvPS56--
