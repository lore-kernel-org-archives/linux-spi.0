From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: pl08x: do not select S3C64XX_PL080
Date: Wed, 28 Jan 2015 17:37:42 +0000
Message-ID: <20150128173742.GA21293@sirena.org.uk>
References: <1957186.KORYFIrP42@wuerfel>
 <2608153.sC21ihDxEF@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2741153409227543815=="
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <2608153.sC21ihDxEF@wuerfel>
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


--===============2741153409227543815==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cvzIkD8pNUQN9i8I"
Content-Disposition: inline


--cvzIkD8pNUQN9i8I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 28, 2015 at 02:27:06PM +0100, Arnd Bergmann wrote:
> The pl08x driver originally selected S3C64XX_PL080 to avoid having
> the legacy Samsung DMA interfaces. Those are now gone, so the
> select is no longer needed, but it now causes problems when
> CONFIG_DMA_ENGINE is disabled:

Applied, thanks.

--cvzIkD8pNUQN9i8I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUyR5lAAoJECTWi3JdVIfQ3oAH/A5p6HJXHPMs5BfmlU6BaqUx
RUbu1UscJkaug8njc82qvpofFHxeS4ClccaBWoFjdDCuVKEngxTDBKJjrvY2+3Od
wwF7Zu9jReLFK+pJFk3lQtCh11buVNyDouyfqahGejX6lLTY6Tf5jBK4UM+OglKD
x/G9wrMxuSyieRTAwuRKehBtzYtzSb6HgbIXRJj7vBbZaFPGhnJj1lFCub6lQ51H
Zy+pMGObEaNewEomnbys7qEOuIjAuFL20rfIzAzmu8s71/GYwjP+2rB0KxQLvR4/
jOc/fjptQMhTf3sZWOvOnmdZTTx4Jl0gm4j4iD/jM/+sGh2kribyaR+YlTj3cB0=
=mEzf
-----END PGP SIGNATURE-----

--cvzIkD8pNUQN9i8I--


--===============2741153409227543815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2741153409227543815==--
