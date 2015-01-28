From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi/xilinx: Check number of slaves range
Date: Wed, 28 Jan 2015 19:57:48 +0000
Message-ID: <20150128195748.GQ21293@sirena.org.uk>
References: <1422474819-22689-1-git-send-email-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0022430508080649295=="
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Michal Simek <michal.simek@xilinx.com>,
 =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
 linux-spi@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1422474819-22689-1-git-send-email-ricardo.ribalda@gmail.com>
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


--===============0022430508080649295==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5j9EWX0zxF50a1Bm"
Content-Disposition: inline


--5j9EWX0zxF50a1Bm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2015 at 08:53:39PM +0100, Ricardo Ribalda Delgado wrote:
> From: Ricardo Ribalda <ricardo.ribalda@gmail.com>
>=20
> The core only supports up to 32 slaves, and the chipselect function
> expects the same.

Applied, thanks.

--5j9EWX0zxF50a1Bm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUyT87AAoJECTWi3JdVIfQiHoH/j4TmPHpDKBCuyxNQ5mYqJei
J0ffaP0OLVnhH3UUff8omaQpkVIvY5anTuvKJtLHsRUmqp3d8+LYKmcS/GjUWrEY
cCK7L1B/tmV9oH5JKKbodjuSV5g8MHy3G2ayBNuOz/uTo5K0xfjnJj5a3QI12sDI
vxKHCSfrXxzIf0SfKjOfEprHWyjNQMljM+4xjvAM7q/cuyFnojc35vs/nT78lC6c
IPA16HMeHgBOf7xqb07DifMI+w0naAO17CVjL2PgYMZyPMncgVaM/WSp4wE0TxXi
jv00oL6LdNln5MYaUW9ezuGYaWdngLNIOcWidBbXRUgtCVPkmkyivRhYjnwen7Q=
=8ucE
-----END PGP SIGNATURE-----

--5j9EWX0zxF50a1Bm--


--===============0022430508080649295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0022430508080649295==--
