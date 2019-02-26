From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 1/3] dt-bindings: Add dma-burst-sz property for
 spi-pxa2xx
Date: Tue, 26 Feb 2019 11:02:38 +0000
Message-ID: <20190226110238.GA7082@sirena.org.uk>
References: <20190226092441.49198-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6399128613529938661=="
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-spi@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, Robert Jarzmik <robert.jarzmik@free.fr>,
 Daniel Mack <daniel@zonque.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190226092441.49198-1-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============6399128613529938661==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 26, 2019 at 12:24:39PM +0300, Andy Shevchenko wrote:
> Add DMA burst size property to the SPI PXA2xx bindings.

Shouldn't we be inferring this from the device specific compatible
string (or PCI identifier for x86)?  That way if there's other quirks
needed we don't need any binding changes.

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlx1HMsACgkQJNaLcl1U
h9CyQwf/RcdAWM3mP/sSWEfhoabgVG2YSsVnDuL5Xh6D51llq5pmQXdLfh9lPvZK
rwaYha1ePDNn32QCdHxhxZEhPApyckYDCzS4GgZyD/lPyiyE3rI42yWfiPO66Pmw
5ts7zFwmDsxX11czU9K5RSbOVj08iW4Y42FjN0JwUcjuf8WgzQ4l9NrYDwIeUgkT
jT1TBy2ii6adQ5l2ec7K56OlfsCTi+2YjJoGznDdxi2P4/5oy043Ny4ok5ZEfoKQ
iuuNN9j+CH+rkKdvIFLpkKxXkRVsYFeJq/2jlALyWNpTdv/CmBvwk1Ir1rkXVkaB
GgQuSsR7YZFB2qO4CgvomHc65k2mqA==
=OW3g
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--


--===============6399128613529938661==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6399128613529938661==--
