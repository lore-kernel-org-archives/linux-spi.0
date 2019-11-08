From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/7] spi: zynq-qspi: Anything else than CS0 is not
 supported yet
Date: Fri, 8 Nov 2019 12:07:32 +0000
Message-ID: <20191108120732.GB5532@sirena.co.uk>
References: <20191108105920.19014-1-miquel.raynal@bootlin.com>
 <20191108105920.19014-2-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8516661312265564073=="
Cc: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>,
 Michal Simek <michal.simek@xilinx.com>, linux-spi@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
To: Miquel Raynal <miquel.raynal@bootlin.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191108105920.19014-2-miquel.raynal@bootlin.com>
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


--===============8516661312265564073==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 08, 2019 at 11:59:14AM +0100, Miquel Raynal wrote:
> Unlike what the driver is currently advertizing, CS0 only can be used,
> CS1 is not supported at all. Prevent people to use CS1.

This (and the rest of the series) doesn't apply against current code,
please check and resend.

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3FWoMACgkQJNaLcl1U
h9CyRAf+OzujcGHVTH3TILnu1RcNmDMHsq5AWnHviUgP3ljXhKwem+t3Es+mYTXt
yTLfHFCRlv6wLltW/V10d3fQDQIBlT6oBAx+jmQMzJOA3CNNk+2kDhUhjmyv0HKv
QKhIWqPg5StiQmmcvKz5zVoSyT2owP/glVMI6tNPqJD95QtHxj3GDUTI22B/xnZ7
ObnQqXLs5pcAklyLlkOFEhfzfOrKGKIsH9p46svKT68upTTZbYm4RINOdGYSXPwL
Xf28mCljPVXy/kHSnGcci8hXcXrwEzMalt6a3eCvp1vpxqmA8P2cj8hjW/67IiQw
sJ4ofqNSUWB3YP42i1vj2olILm8/Lg==
=lXpj
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--


--===============8516661312265564073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8516661312265564073==--
