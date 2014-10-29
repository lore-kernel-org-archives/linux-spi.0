From: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Subject: Re: [PATCH v8 7/8] of: spi: Export single device registration method and accessors
Date: Wed, 29 Oct 2014 10:19:33 +0200
Message-ID: <6C87C279-4ED7-4E37-88FA-87C61437975F@antoniou-consulting.com>
References: <1414528565-10907-1-git-send-email-pantelis.antoniou@konsulko.com> <1414528565-10907-8-git-send-email-pantelis.antoniou@konsulko.com> <54509AE2.80404@nsn.com>
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>,
	Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Alison Chaiken <Alison_Chaiken-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
	Dinh Nguyen <dinh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Jan Lubbe <jluebbe-H4yykcOXDpCzQB+pC5nmwQ@public.gmane.org>, Michael Stickel <ms-g5CePrrZ5ROELgA04lAiVw@public.gmane.org>,
	Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>,
	Dirk Behme <dirk.behme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Alan Tull <delicious.quinoa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Michael Bohan <mbohan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Ionut Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org>,
	Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>,
	Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Joel Becker <jlbec-aKy9MeLSZ9dg9hUCZPvPmw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-ke
To: Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54509AE2.80404-OYasijW0DpE@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Alexander,

> On Oct 29, 2014, at 09:44 , Alexander Sverdlin <alexander.sverdlin@ns=
n.com> wrote:
>=20
> Hello Pantelis,
>=20
> I've pointed to this already, but anyway:
>=20
> On 28/10/14 21:36, ext Pantelis Antoniou wrote:
>> Dynamically inserting spi device nodes requires the use of a single
>> device registration method. Rework and export it.
>>=20
>> Methods to lookup a device/master using a device node are added
>> as well, of_find_spi_master_by_node() & of_find_spi_device_by_node()=
=2E
>>=20
>> Signed-off-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
>> ---
>> drivers/spi/spi.c | 256 +++++++++++++++++++++++++++++++++-----------=
----------
>> 1 file changed, 158 insertions(+), 98 deletions(-)
>>=20
>> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
>> index ebcb33d..f81d799 100644
>> --- a/drivers/spi/spi.c
>> +++ b/drivers/spi/spi.c
>> @@ -1220,6 +1220,123 @@ err_init_queue:
>> /*------------------------------------------------------------------=
-------*/
>>=20
>> #if defined(CONFIG_OF)
>> +
>> +static struct spi_device *
>> +of_register_spi_device(struct spi_master *master, struct device_nod=
e *node)
>=20
> During the test Wladislav has found that node is actually not used,
>=20

Ugh.

>> +{
>> +	struct spi_device *spi;
>> +	struct device_node *nc;
>=20
> but non-initialized nc is used further in the code.
> Should not nc be a parameter of the function instead of a local varia=
ble?
>=20

Yes, my mistake. Updated patch follows.

>> +	int rc;
>> +	u32 value;
>> +
>> +	/* Alloc an spi_device */
>> +	spi =3D spi_alloc_device(master);
>> +	if (!spi) {
>> +		dev_err(&master->dev, "spi_device alloc error for %s\n",
>> +			nc->full_name);
>> +		rc =3D -ENOMEM;
>> +		goto err_out;
>> +	}
>> +
>> +	/* Select device driver */
>> +	rc =3D of_modalias_node(nc, spi->modalias,
>> +				sizeof(spi->modalias));
>> +	if (rc < 0) {
>> +		dev_err(&master->dev, "cannot find modalias for %s\n",
>> +			nc->full_name);
>> +		goto err_out;
>> +	}
>> +
>> +	/* Device address */
>> +	rc =3D of_property_read_u32(nc, "reg", &value);
>> +	if (rc) {
>> +		dev_err(&master->dev, "%s has no valid 'reg' property (%d)\n",
>> +			nc->full_name, rc);
>> +		goto err_out;
>> +	}
>> +	spi->chip_select =3D value;
>> +
>> +	/* Mode (clock phase/polarity/etc.) */
>> +	if (of_find_property(nc, "spi-cpha", NULL))
>> +		spi->mode |=3D SPI_CPHA;
>> +	if (of_find_property(nc, "spi-cpol", NULL))
>> +		spi->mode |=3D SPI_CPOL;
>> +	if (of_find_property(nc, "spi-cs-high", NULL))
>> +		spi->mode |=3D SPI_CS_HIGH;
>> +	if (of_find_property(nc, "spi-3wire", NULL))
>> +		spi->mode |=3D SPI_3WIRE;
>> +	if (of_find_property(nc, "spi-lsb-first", NULL))
>> +		spi->mode |=3D SPI_LSB_FIRST;
>> +
>> +	/* Device DUAL/QUAD mode */
>> +	if (!of_property_read_u32(nc, "spi-tx-bus-width", &value)) {
>> +		switch (value) {
>> +		case 1:
>> +			break;
>> +		case 2:
>> +			spi->mode |=3D SPI_TX_DUAL;
>> +			break;
>> +		case 4:
>> +			spi->mode |=3D SPI_TX_QUAD;
>> +			break;
>> +		default:
>> +			dev_warn(&master->dev,
>> +				"spi-tx-bus-width %d not supported\n",
>> +				value);
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!of_property_read_u32(nc, "spi-rx-bus-width", &value)) {
>> +		switch (value) {
>> +		case 1:
>> +			break;
>> +		case 2:
>> +			spi->mode |=3D SPI_RX_DUAL;
>> +			break;
>> +		case 4:
>> +			spi->mode |=3D SPI_RX_QUAD;
>> +			break;
>> +		default:
>> +			dev_warn(&master->dev,
>> +				"spi-rx-bus-width %d not supported\n",
>> +				value);
>> +			break;
>> +		}
>> +	}
>> +
>> +	/* Device speed */
>> +	rc =3D of_property_read_u32(nc, "spi-max-frequency", &value);
>> +	if (rc) {
>> +		dev_err(&master->dev, "%s has no valid 'spi-max-frequency' proper=
ty (%d)\n",
>> +			nc->full_name, rc);
>> +		goto err_out;
>> +	}
>> +	spi->max_speed_hz =3D value;
>> +
>> +	/* IRQ */
>> +	spi->irq =3D irq_of_parse_and_map(nc, 0);
>> +
>> +	/* Store a pointer to the node in the device structure */
>> +	of_node_get(nc);
>> +	spi->dev.of_node =3D nc;
>> +
>> +	/* Register the new device */
>> +	request_module("%s%s", SPI_MODULE_PREFIX, spi->modalias);
>> +	rc =3D spi_add_device(spi);
>> +	if (rc) {
>> +		dev_err(&master->dev, "spi_device register error %s\n",
>> +			nc->full_name);
>> +		goto err_out;
>> +	}
>> +
>> +	return spi;
>> +
>> +err_out:
>> +	spi_dev_put(spi);
>> +	return ERR_PTR(rc);
>> +}
>> +
>> /**
>>  * of_register_spi_devices() - Register child devices onto the SPI b=
us
>>  * @master:	Pointer to spi_master device
>> @@ -1229,120 +1346,63 @@ err_init_queue:
>>  */
>> static void of_register_spi_devices(struct spi_master *master)
>> {
>> -	struct spi_device *spi;
>> 	struct device_node *nc;
>> -	int rc;
>> -	u32 value;
>> +	struct spi_device *spi;
>>=20
>> 	if (!master->dev.of_node)
>> 		return;
>>=20
>> 	for_each_available_child_of_node(master->dev.of_node, nc) {
>> -		/* Alloc an spi_device */
>> -		spi =3D spi_alloc_device(master);
>> -		if (!spi) {
>> -			dev_err(&master->dev, "spi_device alloc error for %s\n",
>> +		spi =3D of_register_spi_device(master, nc);
>> +		if (IS_ERR(spi))
>> +			dev_warn(&master->dev, "Failed to create SPI device for %s\n",
>> 				nc->full_name);
>> -			spi_dev_put(spi);
>> -			continue;
>> -		}
>> +	}
>> +}
>>=20
>> -		/* Select device driver */
>> -		if (of_modalias_node(nc, spi->modalias,
>> -				     sizeof(spi->modalias)) < 0) {
>> -			dev_err(&master->dev, "cannot find modalias for %s\n",
>> -				nc->full_name);
>> -			spi_dev_put(spi);
>> -			continue;
>> -		}
>> +static int of_dev_node_match(struct device *dev, void *data)
>> +{
>> +	return dev->of_node =3D=3D data;
>> +}
>>=20
>> -		/* Device address */
>> -		rc =3D of_property_read_u32(nc, "reg", &value);
>> -		if (rc) {
>> -			dev_err(&master->dev, "%s has no valid 'reg' property (%d)\n",
>> -				nc->full_name, rc);
>> -			spi_dev_put(spi);
>> -			continue;
>> -		}
>> -		spi->chip_select =3D value;
>> -
>> -		/* Mode (clock phase/polarity/etc.) */
>> -		if (of_find_property(nc, "spi-cpha", NULL))
>> -			spi->mode |=3D SPI_CPHA;
>> -		if (of_find_property(nc, "spi-cpol", NULL))
>> -			spi->mode |=3D SPI_CPOL;
>> -		if (of_find_property(nc, "spi-cs-high", NULL))
>> -			spi->mode |=3D SPI_CS_HIGH;
>> -		if (of_find_property(nc, "spi-3wire", NULL))
>> -			spi->mode |=3D SPI_3WIRE;
>> -		if (of_find_property(nc, "spi-lsb-first", NULL))
>> -			spi->mode |=3D SPI_LSB_FIRST;
>> -
>> -		/* Device DUAL/QUAD mode */
>> -		if (!of_property_read_u32(nc, "spi-tx-bus-width", &value)) {
>> -			switch (value) {
>> -			case 1:
>> -				break;
>> -			case 2:
>> -				spi->mode |=3D SPI_TX_DUAL;
>> -				break;
>> -			case 4:
>> -				spi->mode |=3D SPI_TX_QUAD;
>> -				break;
>> -			default:
>> -				dev_warn(&master->dev,
>> -					 "spi-tx-bus-width %d not supported\n",
>> -					 value);
>> -				break;
>> -			}
>> -		}
>> +/* bah; the match functions differ just by const-ness */
>> +static int of_dev_node_match_const(struct device *dev, const void *=
data)
>> +{
>> +	return dev->of_node =3D=3D data;
>> +}
>>=20
>> -		if (!of_property_read_u32(nc, "spi-rx-bus-width", &value)) {
>> -			switch (value) {
>> -			case 1:
>> -				break;
>> -			case 2:
>> -				spi->mode |=3D SPI_RX_DUAL;
>> -				break;
>> -			case 4:
>> -				spi->mode |=3D SPI_RX_QUAD;
>> -				break;
>> -			default:
>> -				dev_warn(&master->dev,
>> -					 "spi-rx-bus-width %d not supported\n",
>> -					 value);
>> -				break;
>> -			}
>> -		}
>> +/* must call put_device() when done with returned spi_device device=
 */
>> +struct spi_device *of_find_spi_device_by_node(struct device_node *n=
ode)
>> +{
>> +	struct device *dev;
>>=20
>> -		/* Device speed */
>> -		rc =3D of_property_read_u32(nc, "spi-max-frequency", &value);
>> -		if (rc) {
>> -			dev_err(&master->dev, "%s has no valid 'spi-max-frequency' prope=
rty (%d)\n",
>> -				nc->full_name, rc);
>> -			spi_dev_put(spi);
>> -			continue;
>> -		}
>> -		spi->max_speed_hz =3D value;
>> +	dev =3D bus_find_device(&spi_bus_type, NULL, node,
>> +					 of_dev_node_match);
>> +	if (!dev)
>> +		return NULL;
>>=20
>> -		/* IRQ */
>> -		spi->irq =3D irq_of_parse_and_map(nc, 0);
>> +	return to_spi_device(dev);
>> +}
>> +EXPORT_SYMBOL(of_find_spi_device_by_node);
>>=20
>> -		/* Store a pointer to the node in the device structure */
>> -		of_node_get(nc);
>> -		spi->dev.of_node =3D nc;
>> +/* forward decl */
>> +static struct class spi_master_class;
>>=20
>> -		/* Register the new device */
>> -		request_module("%s%s", SPI_MODULE_PREFIX, spi->modalias);
>> -		rc =3D spi_add_device(spi);
>> -		if (rc) {
>> -			dev_err(&master->dev, "spi_device register error %s\n",
>> -				nc->full_name);
>> -			spi_dev_put(spi);
>> -		}
>> +/* the spi masters are not using spi_bus, so we find it with anothe=
r way */
>> +struct spi_master *of_find_spi_master_by_node(struct device_node *n=
ode)
>> +{
>> +	struct device *dev;
>>=20
>> -	}
>> +	dev =3D class_find_device(&spi_master_class, NULL, node,
>> +				of_dev_node_match_const);
>> +	if (!dev)
>> +		return NULL;
>> +
>> +	/* reference got in class_find_device */
>> +	return container_of(dev, struct spi_master, dev);
>> }
>> +EXPORT_SYMBOL(of_find_spi_master_by_node);
>> +
>> #else
>> static void of_register_spi_devices(struct spi_master *master) { }
>> #endif
>>=20
>=20
> --=20
> Best regards,
> Alexander Sverdlin.

Regards

=E2=80=94 Pantelis

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
