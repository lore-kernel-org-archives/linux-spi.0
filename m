From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi/rockchip: avoid uninitialized-use warning
Date: Wed, 28 Jan 2015 17:36:47 +0000
Message-ID: <20150128173647.GZ21293@sirena.org.uk>
References: <1957186.KORYFIrP42@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7125510561526158532=="
Cc: Addy Ke <addy.ke@rock-chips.com>, Doug Anderson <dianders@chromium.org>,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1957186.KORYFIrP42@wuerfel>
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


--===============7125510561526158532==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+Vji0eDhhLYWF1je"
Content-Disposition: inline


--+Vji0eDhhLYWF1je
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 28, 2015 at 02:25:10PM +0100, Arnd Bergmann wrote:
> We currently get a warning about potentially uninitialized variables
> in the rockchip spi driver, at least in certain toolchain versions:

Applied, thanks.

--+Vji0eDhhLYWF1je
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUyR4vAAoJECTWi3JdVIfQmLAH/0y3lsziZWsCZIiESFCVrFts
ZMZSqg97RXck1oND3xprQYzNwKjasrX6y/zhquobya2vNuFPIv+kAkZph1CAqLD8
HV5xmvBFhq//N8ZlLoLFUXGwUMbtRQA7RCR+SvObh6Ky9HTV6KSeP6VlSK5KUSOK
zqfd8FqRWuouht6OPgfhe/lEuMj3l2Fg3YVoBZdk3M5ihSAGDdwf8JQ1yhNF8pZY
cVu6dtaF4zI+5N1m323rWHs1/hUIQYm8jPKNwYfzCVKZ56F6rtlsRJxjbqqE+zYd
JjZggBXZhs09X17CgAI+wLS8YvdN/Pz/76yapAmlo4IZ3nQaXbEawnR8tt8INkg=
=C5l9
-----END PGP SIGNATURE-----

--+Vji0eDhhLYWF1je--


--===============7125510561526158532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7125510561526158532==--
