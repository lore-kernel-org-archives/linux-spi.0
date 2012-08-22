From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] spi: Master driver for NXP SC18IS602/603
Date: Wed, 22 Aug 2012 19:32:30 +0100
Message-ID: <20120822183230.GC7995@opensource.wolfsonmicro.com>
References: <1345305987-1954-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="obRs6g3QSNdgmoVb"
Cc: spi-devel-general@lists.sourceforge.net,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Rob Landley <rob@landley.net>, linux-doc@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org
To: Guenter Roeck <linux@roeck-us.net>
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1345305987-1954-1-git-send-email-linux@roeck-us.net>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--obRs6g3QSNdgmoVb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 18, 2012 at 09:06:27AM -0700, Guenter Roeck wrote:
> This driver adds support for NXP SC18IS602/603 I2C to SPI bus bridge.
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied, thanks.  One small thing:

> +static int sc18is602_probe(struct i2c_client *client,
> +			   const struct i2c_device_id *id)
> +{
> +	struct device *dev =3D &client->dev;
> +	struct device_node *np =3D dev->of_node;
> +	struct sc18is602_platform_data *pdata =3D dev_get_platdata(dev);
> +	struct sc18is602 *hw;
> +	struct spi_master *master;
> +	int error;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
> +				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA))
> +		return -ENODEV;

This feels like the wrong thing to do here: given that the user needs to
explicitly ask for the device to be instantiated we really ought to be
one the right bus so this should be more of an error.  Not sure what I
can constructively sugget except for an error message and perhaps
returning -EINVAL though.

--obRs6g3QSNdgmoVb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQNSW3AAoJEFJkBDiqVpZ4Og0P/Ag8woq/d92e8QevY6iMfOF/
U47IywXwijTehU1zHxSbaaJm5dKRAnOHJNRLQntDOoUfmze5ldVpHgjrxMLzfJYE
o/5DM6E4Xs3s11wLtetI7gaI2Q9mO9ZJJN72ybShZkfaUS5g2sm+yM3ziH34zrFV
5CMJilND0QOsctEk3Z0Td9Fc1nSFe4xY0IZuEuxgvMgrSO2GXqSieQS8olW9dBiV
sPasQ2NwJWq1/eDcVcHnbPGe7iQkIxLjprHcluuBzldxC5R/Sx2VsijjD/uzyi9b
DlTaP+++M23/eakYS+AUBZWRnjywg35eLzhn/GgSyUOUVshm90yN38+Q0dISXYEs
331UKf6qtL0VvLweC3WqjM6qKPBg5Mn3aaKjlI3uMLhCixEKTTi7xBbAV/V3Pdfj
MgQzXzTyMTqc1jqXouVc3kV42RtFM689snUbWnNLtPbi5yBEq/ajfDl3as2V4ods
gkUlUB5l70hxwxSfb2AkwVOBtl5p7y16lLMEKQHYa1kABt5rKawJqhDt60hKKoKE
sBjAJVRppv7W5hkadh1FJ88VxIhPsxEqOxbBt+QKffK7O4e6f4lWniiOmed8Pzvo
di8uArbtPLOxndU2AInaXPFPMDIYQ+PLvKcGQiXRpssNfD4SBbJWEypuvApFDTy3
Gvm9OERYIcWoNE2dDPX/
=xu15
-----END PGP SIGNATURE-----

--obRs6g3QSNdgmoVb--
