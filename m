From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/7] spi: spi-fsl-dspi: Remove spi-bitbang
Date: Wed, 28 Jan 2015 19:25:45 +0000
Message-ID: <20150128192545.GA12296@sirena.org.uk>
References: <1422356244-15629-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <1422356244-15629-6-git-send-email-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4201417194081579740=="
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@arm.linux.org.uk,
 B44548@freescale.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk,
 Li.Xiubo@freescale.com, linux-kernel@vger.kernel.org, stefan@agner.ch,
 linux-spi@vger.kernel.org, robh+dt@kernel.org, galak@codeaurora.org,
 shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org
To: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1422356244-15629-6-git-send-email-bhuvanchandra.dv@toradex.com>
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


--===============4201417194081579740==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2015 at 04:27:22PM +0530, Bhuvanchandra DV wrote:
> From: Chao Fu <B44548@freescale.com>
>=20
> DSPI module need cs change information in
> a spi transfer. According to cs change, DSPI

Applied, thanks.

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUyTe4AAoJECTWi3JdVIfQEHQH/RdKiPoPotBM0/69lF5IH44z
7AiRC0G611a+DnAkBrQmYHZ+od0qfKEUYF1C1RBfrHXo8qzQWqw6o4aDJS2whh6t
fIeJrIRGMISYoh5I83Jwe39f3IZwGtOtw8igQiqjq1sBzH2YoPD+Szmq2IhSufMB
qf47bJbq2IqlrTK8WK2Ev4d2ear534injn5vycf9DN5/G+yDwkM+t2ACZh3ujBzf
5lslQGYFmm89AZImSA/VnlSjXyUQ2Fm7tRnSWbjfXNRTNnISOdpLE6BNMMWEcWdy
pDnVTHK/zd77xBfFrxfdvWB64J6GWQH6OiPRE9spwriakeQgOzTS0wOQgUlIbBk=
=WP2r
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--


--===============4201417194081579740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4201417194081579740==--
