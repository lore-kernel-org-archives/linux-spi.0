From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] spi: spi-mem: Add the spi_set_xfer_bpw function
Date: Fri, 28 Sep 2018 14:26:07 +0100
Message-ID: <20180928132607.GK20825@sirena.org.uk>
References: <20180921070628.35153-1-chuanhua.han@nxp.com>
 <20180928084431.300b7bf9@bbrezillon>
 <AM6PR04MB43573478FFD0E512A117484097EC0@AM6PR04MB4357.eurprd04.prod.outlook.com>
 <20180928091833.15e95f7f@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wSq95SjGPZBE6hCW"
Cc: Chuanhua Han <chuanhua.han@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eha@deif.com" <eha@deif.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180928091833.15e95f7f@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--wSq95SjGPZBE6hCW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 28, 2018 at 09:18:33AM +0200, Boris Brezillon wrote:

> I might be wrong, but that's not my understanding of ->bits_per_word.
> To me, it's something that you can use when your *device* (not
> controller) expects non-byte aligned words [1]. The spi-mem protocol is

Yes, bits per word is a device setting.  SPI devices can have control
protocols that have words larger than a byte with a fixed byte order,
many controllers do the required byte swapping.

--wSq95SjGPZBE6hCW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluuK+8ACgkQJNaLcl1U
h9BOQwf+LqkpaV7bP+BUmsidnAw28PcCEe57W885U1yULgNr1lMjbXdcA4azs5pj
jS+3UNRW1Cx44/3eKvNsASub2mapMXVdSWv0Q7JsMjuu5piICIHlovk1LDdWu6gN
2lLDvCuEYeq1Ys+hxl8Rx7hekX/cZ+Z7udG/aZkuh5sq1Gokqvq10fHk/wnLLel8
MoisTOIGXwarSQMIphhfAted9qYTzX6FgP3rEyMop1NOHo+0Bs9nrRPYWcpzvlsy
gNIlpmnUZ7d94Nx6NdQS1K22Ipk7MuyDkp21eeRtFJZe/QmWVbDKtI3ZljDxU6y6
BvtdaWoQrjkCwiIQdeZCehRBY7Xqcw==
=uT86
-----END PGP SIGNATURE-----

--wSq95SjGPZBE6hCW--
