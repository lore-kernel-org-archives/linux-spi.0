From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 7/9] I2C: MV64XXX: Add Device Tree support
Date: Mon, 9 Jul 2012 12:25:38 +0200
Message-ID: <20120709102538.GD1296@pengutronix.de>
References: <1339324322-29388-8-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6040130521713986877=="
Cc: jason@lakedaemon.net, devicetree-discuss@lists.ozlabs.org,
 rob.herring@calxeda.com, linux-i2c@vger.kernel.org,
 spi-devel-general@lists.sourceforge.net, machael@walle.cc,
 linux-arm-kernel@lists.infradead.org
To: Andrew Lunn <andrew@lunn.ch>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1339324322-29388-8-git-send-email-andrew@lunn.ch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============6040130521713986877==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cQXOx3fnlpmgJsTP"
Content-Disposition: inline


--cQXOx3fnlpmgJsTP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 10, 2012 at 12:31:59PM +0200, Andrew Lunn wrote:
> Extends the driver to get properties from device tree. Also extend the
> kirkwood DT support to supply the needed properties.
>=20
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  Documentation/devicetree/bindings/i2c/mrvl-i2c.txt |   35 ++++++++++++++=
+++-
>  arch/arm/boot/dts/kirkwood.dtsi                    |   13 +++++++
>  arch/arm/mach-kirkwood/board-dt.c                  |    2 ++
>  drivers/i2c/busses/i2c-mv64xxx.c                   |   38 ++++++++++++++=
+++---
>  4 files changed, 82 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt b/Documen=
tation/devicetree/bindings/i2c/mrvl-i2c.txt
> index b891ee2..89ef899 100644
> --- a/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
> +++ b/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
> @@ -1,4 +1,4 @@
> -* I2C
> +* Marvell MMP I2C controller
> =20
>  Required properties :
> =20
> @@ -32,3 +32,36 @@ Examples:
>  		interrupts =3D <58>;
>  	};
> =20
> +* Marvell MV64XXX I2C controller
> +
> +Required properties :
> +
> + - reg         : Offset and length of the register set for the device
> + - compatible  : should be "marvell,mv64xxx-i2c"
> + - interrupts  : the interrupt number
> + - frequency-m : m factor in baud rate calculation
> +
> +Recommended properties :
> +
> + - frequency-n : n factor in baud rate calculation
> + - timeout-ms  : How long to wait for a transaction to complete

The way we define the bus speed for i2c with DT is using "clock-frequency".
You should be able to derive the dividers from that? Adding custom
properties for every driver will hardly be maintainable.

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--cQXOx3fnlpmgJsTP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/6saIACgkQD27XaX1/VRvgcACdHVXQfErRxfGN5/0+D7mc4Muv
kjwAoIo9wG3kt08YugwCqotUz0bD9mpQ
=G4A6
-----END PGP SIGNATURE-----

--cQXOx3fnlpmgJsTP--


--===============6040130521713986877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6040130521713986877==--
