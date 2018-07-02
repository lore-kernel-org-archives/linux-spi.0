From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC net-next 15/15] net: lora: Add Semtech SX1301
Date: Mon, 2 Jul 2018 17:12:58 +0100
Message-ID: <20180702161258.GA18744@sirena.org.uk>
References: <20180701110804.32415-1-afaerber@suse.de>
 <20180701110804.32415-16-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4246174822250046768=="
Cc: Steve deRosier <derosier@gmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Jiri Pirko <jiri@resnulli.us>, Ben Whitten <ben.whitten@lairdtech.com>,
 netdev@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
 Dollar Chen <dollar.chen@wtmec.com>, linux-kernel@vger.kernel.org,
 Michael =?iso-8859-1?Q?R=F6der?= <michael.roeder@avnet.eu>,
 Janus Piwek <jpiwek@arroweurope.com>, linux-spi@vger.kernel.org,
 Jian-Hong Pan <starnight@g.ncu.edu.tw>, Ken Yu <ken.yu@rakwireless.com>,
 "David S . Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180701110804.32415-16-afaerber@suse.de>
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


--===============4246174822250046768==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 01, 2018 at 01:08:04PM +0200, Andreas F=E4rber wrote:

> +static void sx1301_radio_spi_set_cs(struct spi_device *spi, bool enable)
> +{
> +	int ret;
> +
> +	dev_dbg(&spi->dev, "setting SPI CS to %s\n", enable ? "1" : "0");
> +
> +	if (enable)
> +		return;
> +
> +	ret =3D sx1301_radio_set_cs(spi->controller, enable);
> +	if (ret)
> +		dev_warn(&spi->dev, "failed to write CS (%d)\n", ret);
> +}

So we never disable chip select?

> +	if (tx_buf) {
> +		ret =3D sx1301_write(ssx->parent, ssx->regs + REG_RADIO_X_ADDR, tx_buf=
 ? tx_buf[0] : 0);

This looks confused.  We're in an if (tx_buf) block but there's a use of
the ternery operator that appears to be checking if we have a tx_buf?

> +		if (ret) {
> +			dev_err(&spi->dev, "SPI radio address write failed\n");
> +			return ret;
> +		}
> +
> +		ret =3D sx1301_write(ssx->parent, ssx->regs + REG_RADIO_X_DATA, (tx_bu=
f && xfr->len >=3D 2) ? tx_buf[1] : 0);
> +		if (ret) {
> +			dev_err(&spi->dev, "SPI radio data write failed\n");
> +			return ret;
> +		}

This looks awfully like you're coming in at the wrong abstraction layer
and the hardware actually implements a register abstraction rather than
a SPI one so you should be using regmap as the abstraction.

> +	if (rx_buf) {
> +		ret =3D sx1301_read(ssx->parent, ssx->regs + REG_RADIO_X_DATA_READBACK=
, &rx_buf[xfr->len - 1]);
> +		if (ret) {
> +			dev_err(&spi->dev, "SPI radio data read failed\n");
> +			return ret;
> +		}
> +	}

For a read we never set an address?

> +static void sx1301_radio_setup(struct spi_controller *ctrl)
> +{
> +	ctrl->mode_bits =3D SPI_CS_HIGH | SPI_NO_CS;

This controller has no chip select but we provided a set_cs operation?

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls6TwcACgkQJNaLcl1U
h9CtNQf/ZkgI4m6ipAehhMLl5FnfWF06bpi2CDPHl+6Cz0LgN9Qnfs0oqOGo4Zb/
Y6/6bRwMLButsPy07H9JjgbDdDbqGvXamBcDEr2QUpituYS2FBgGCJKxS09beCw0
sYsYVbTKu92JQbymL8/Ps8vU2l8GsUTvg1gZfLwiJq7Crs9x18j0HQSW6QOuPVLI
eFhv2kXtoi30yP+HUc2eRYtQEf0eoY/V46h57YqdqeJQDbHILKDLq1Fstfd/8gLR
BQLiCdKDRKPuc4qCMC7lrSQFmTTMFdoF9HxC9R+afZCrT/TUWLkAhDCz+b8OwMlD
GrQ/DQFX0ki2DD7Eb/HMqIk4+gmYWg==
=dmQR
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--


--===============4246174822250046768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4246174822250046768==--
