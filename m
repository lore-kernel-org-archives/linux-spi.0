From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/6] spi: core: handle timeout error from
 transfer_one()
Date: Tue, 3 Apr 2018 17:18:24 +0100
Message-ID: <20180403161824.GB11578@sirena.org.uk>
References: <20180403152905.1524-1-ssuloev@orpaltech.com>
 <20180403152905.1524-2-ssuloev@orpaltech.com>
 <20180403155224.GA11578@sirena.org.uk>
 <c0476d75-821f-7a0d-3c3f-270304e7b032@orpaltech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Sergey Suloev <ssuloev@orpaltech.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c0476d75-821f-7a0d-3c3f-270304e7b032@orpaltech.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 03, 2018 at 07:00:55PM +0300, Sergey Suloev wrote:
> On 04/03/2018 06:52 PM, Mark Brown wrote:
> > On Tue, Apr 03, 2018 at 06:29:00PM +0300, Sergey Suloev wrote:
> > > As long as sun4i/sun6i SPI drivers have overriden the default
> > > "wait for completion" procedure then we need to properly
> > > handle -ETIMEDOUT error from transfer_one().

> > Why is this connected to those drivers specifically?

> These 2 drivers have their own "waiting" code and not using the code from
> SPI core.

Does this not apply to any other driver - why is this something we only
have to do when these drivers do it?  That's what's setting off alarm
bells.

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrDqU8ACgkQJNaLcl1U
h9CfBQf9FR4YOhz8uwlhDNIzN9CekuiesXW3onN1YxoMt6obrmWm8u9wWex1ghrL
7tkfxjIFjtqqVRnksV7pMZeCeMoHTVNWev0/aw4pd9+0H3jG0CRa/HVm5bxtYyU+
GI6F/VN78LL06TXipvbR58oRmBqa0EEeRPQr8ujowH/ygaXTUwgW7mahI4Y/7LOT
e3VfAWwDUqhMB/YAsBLV9AB8cMJtmrBu3co3qdXANhAydkkHIz2wJ1sEYeHaDtF7
8nj70c+sIAoftBQdmj9J1pMAk+6eSxsHc5oxpvoZFs6Ch33Okq4AHHQsQThKumaQ
njNB/kN3pNZhRJQ34TgwYE5Nrw4xrQ==
=pR09
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
