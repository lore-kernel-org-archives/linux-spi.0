From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] spi: orion.c: Add direct access mode
Date: Thu, 24 Mar 2016 11:23:08 +0000
Message-ID: <20160324112308.GY2566@sirena.org.uk>
References: <20160322173546.40d24cc2@free-electrons.com>
 <56F17684.2010307@denx.de> <20160323113316.GH2566@sirena.org.uk>
 <56F2852C.5010006@denx.de> <20160323125448.GM2566@sirena.org.uk>
 <56F295E1.4030505@denx.de> <20160323132732.GN2566@sirena.org.uk>
 <56F2D19A.7020604@denx.de> <20160323183952.GK5250@lunn.ch>
 <56F37EFF.2090605@denx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3246798186537442758=="
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,
 linux-spi@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>,
 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
 Gregory CLEMENT <gregory.clement@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org
To: Stefan Roese <sr@denx.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <56F37EFF.2090605@denx.de>
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


--===============3246798186537442758==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JQOvt/yUJ6yzDJmH"
Content-Disposition: inline


--JQOvt/yUJ6yzDJmH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 24, 2016 at 06:45:35AM +0100, Stefan Roese wrote:

> Right. It is of course possible to use this direct mode to access
> SPI flash. Its just not the way how the SPI MTD driver uses the
> SPI controller. All information that is written to the SPI flash
> (e.g. commands, addresses) are passed as plain tx-data in the SPI
> message to the SPI controller. And it would be not easy to detect
> commands / addresses vs. "real data" in this orion SPI driver
> to put these values into the specific registers.

We now have extensions for passing commands through directly (see
spi_flash_read()).

--JQOvt/yUJ6yzDJmH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW884bAAoJECTWi3JdVIfQqE4H/0agHRVXxlsR+tEPrE9Yfeac
t+wzUvaJ6E6UoB5EYzx+WSLBzWGOhnhvE/Ir7Ux31QLfA4pD6kiFFEuyUr39OU+0
rRNkaF8QF9q91cdfAeAyGa9WL/3vfv4UAshh0oDq+IWZDTCqms+0n28PDrFilzFd
k4WICz97qBP7OLSSzpCWUlCqZ3yOiFD/x88GCIqKoGxsHZ5v1a+yiqiG1/lYcOE4
rWR/0VoQom75lwwLkCkfVn+LFI+ZCqyLpgN8u29HVlYhjNwjemnNSxvSz7xdAjBQ
QyTpCnsON36LYCQUOm/LibgPr4YHV1otj1XjNNfDLK11ShyJDJO1t/lACFeBOSg=
=TChZ
-----END PGP SIGNATURE-----

--JQOvt/yUJ6yzDJmH--


--===============3246798186537442758==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3246798186537442758==--
