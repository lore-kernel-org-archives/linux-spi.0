From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V4] MXS: Implement DMA support into mxs-i2c
Date: Sun, 16 Sep 2012 12:23:42 +0200
Message-ID: <20120916102342.GA933@pengutronix.de>
References: <1345779871-7677-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1345779871-7677-1-git-send-email-marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 24, 2012 at 05:44:31AM +0200, Marek Vasut wrote:
> This patch implements DMA support into mxs-i2c. DMA transfers are now ena=
bled
> via DT. The DMA operation is enabled by default.
>=20
> Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>

Unsurprisingly, I also couldn't get the mode switching between DMA and
PIOQUEUE to work :(

However, I did come up with an idea how to select DMA or PIOQUEUE per
bus via devicetree. If we change the view from "I want PIOQUEUE" to "I
don't want DMA", we could simply override the default DMA configuration
in the devicetree with, e.g.:

			i2c0: i2c@80058000 {
				...
				fsl,i2c-dma-channel =3D <>;
			};

So, no DMA channel set up will fall back to PIOQUEUE. This is more
generic than a custom binding, because if one doesn't want DMA, don't
configure it. That should also work with other devices which can fall
back to something. I think this is worth trying, another advantage is
that it doesn't expose something new to the user. So, there is no legacy
support needed in case there will be a better way of configuration.

So, here is a proof-of-concept patch which adds that to Marek's DMA
implementation which I'd like to fold into it. I am about to prepare a
proper series and will post it later today. Comments appreciated.

Thanks,

   Wolfram

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 1f58197..0198a43 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -35,10 +35,6 @@
=20
 #define DRIVER_NAME "mxs-i2c"
=20
-static bool use_pioqueue;
-module_param(use_pioqueue, bool, 0);
-MODULE_PARM_DESC(use_pioqueue, "Use PIOQUEUE mode for transfer instead of =
DMA");
-
 #define MXS_I2C_CTRL0		(0x00)
 #define MXS_I2C_CTRL0_SET	(0x04)
=20
@@ -556,24 +552,13 @@ static int mxs_i2c_get_ofdata(struct mxs_i2c_dev *i2c)
 	int ret;
=20
 	/*
-	 * The MXS I2C DMA mode is prefered and enabled by default.
-	 * The PIO mode is still supported, but should be used only
-	 * for debuging purposes etc.
-	 */
-	i2c->dma_mode =3D !use_pioqueue;
-	if (!i2c->dma_mode)
-		dev_info(dev, "Using PIOQUEUE mode for I2C transfers!\n");
-
-	/*
 	 * TODO: This is a temporary solution and should be changed
 	 * to use generic DMA binding later when the helpers get in.
 	 */
 	ret =3D of_property_read_u32(node, "fsl,i2c-dma-channel",
 				   &i2c->dma_channel);
-	if (ret) {
-		dev_warn(dev, "Failed to get DMA channel, using PIOQUEUE!\n");
-		i2c->dma_mode =3D 0;
-	}
+	if (ret)
+		i2c->dma_mode =3D false;
=20
 	ret =3D of_property_read_u32(node, "clock-frequency", &speed);
 	if (ret)
@@ -624,6 +609,13 @@ static int __devinit mxs_i2c_probe(struct platform_dev=
ice *pdev)
 	if (err)
 		return err;
=20
+	/*
+	 * The MXS I2C DMA mode is prefered and enabled by default.
+	 * Ideally, we'd switch between PIOQUEUE and DMA depending on the
+	 * message size, but neither Marek Vasut nor Wolfram Sang got this
+	 * to work without resetting the controller completely :(
+	 */
+	i2c->dma_mode =3D true;
 	i2c->dev =3D dev;
 	i2c->speed =3D &mxs_i2c_95kHz_config;
=20
@@ -640,8 +632,8 @@ static int __devinit mxs_i2c_probe(struct platform_devi=
ce *pdev)
 		i2c->dma_data.chan_irq =3D dmairq;
 		i2c->dmach =3D dma_request_channel(mask, mxs_i2c_dma_filter, i2c);
 		if (!i2c->dmach) {
-			dev_err(dev, "Failed to request dma\n");
-			return -ENODEV;
+			dev_err(dev, "Failed to request dma, falling back\n");
+			i2c->dma_mode =3D false;
 		}
 	}
=20
@@ -668,6 +660,8 @@ static int __devinit mxs_i2c_probe(struct platform_devi=
ce *pdev)
=20
 	of_i2c_register_devices(adap);
=20
+	dev_info(dev, "registered. DMA: %s\n", i2c->dma_mode ? "on" : "off");
+
 	return 0;
 }
=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlBVqK4ACgkQD27XaX1/VRvO4wCfSyhPeAw1jYcAgN8QZ56sihUk
XmEAoICub57e9YW215qWDq6l2jNKMlWt
=A7f0
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
