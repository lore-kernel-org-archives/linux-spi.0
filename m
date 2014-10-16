From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] misc: eeprom: add driver for Cypress FRAM
Date: Thu, 16 Oct 2014 09:09:02 +0200
Message-ID: <20141016070901.GC1949@katana>
References: <4b6664bedcb7bddfb6eed6c4b14a11a853197522.1413287343.git.jiri.prchal@aksignal.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2JFBq9zoW8cOFH7v"
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Prchal <jiri.prchal-cKCO0sOKHLPtwjQa/ONI9g@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4b6664bedcb7bddfb6eed6c4b14a11a853197522.1413287343.git.jiri.prchal-cKCO0sOKHLPtwjQa/ONI9g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--2JFBq9zoW8cOFH7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2014 at 01:53:55PM +0200, Jiri Prchal wrote:
> This patch adds driver for Cypress FRAMs on SPI bus, such as FM25V05, FM2=
5V10
> etc.
> Reworked from at25 driver:
> - simplified writing since data are written without erasing and waiting to
> finish write cycle
> - add reading device ID and choose size and addr len from it
> - add serial number reading and exporting it to sysfs
>=20
> Signed-off-by: Jiri Prchal <jiri.prchal-cKCO0sOKHLPtwjQa/ONI9g@public.gmane.org>

I'd think this is too much copied code. Can't you fold the changes into
at25? If you bind to the fm25 compatible entry, then you know you are on
that device and can act accordingly.

And since this is an SPI driver, you should add the spi list to CC, not
I2C!

> v2: changed upon Varka Bhadram coments
>=20
>  drivers/misc/eeprom/Kconfig  |  11 +
>  drivers/misc/eeprom/Makefile |   1 +
>  drivers/misc/eeprom/fm25.c   | 499 +++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 511 insertions(+)
>=20
> diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
> index 9536852f..aee6a73 100644
> --- a/drivers/misc/eeprom/Kconfig
> +++ b/drivers/misc/eeprom/Kconfig
> @@ -38,6 +38,17 @@ config EEPROM_AT25
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called at25.
>=20
> +config FRAM_FM25
> +	tristate "SPI Cypress FRAM"
> +	depends on SPI && SYSFS
> +	help
> +	  Enable this driver to get read/write support to SPI FRAMs,
> +	  after you configure the board init code to know about each fram
> +	  on your target board.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called fm25.
> +
>  config EEPROM_LEGACY
>  	tristate "Old I2C EEPROM reader"
>  	depends on I2C && SYSFS
> diff --git a/drivers/misc/eeprom/Makefile b/drivers/misc/eeprom/Makefile
> index 9507aec..6738752 100644
> --- a/drivers/misc/eeprom/Makefile
> +++ b/drivers/misc/eeprom/Makefile
> @@ -1,5 +1,6 @@
>  obj-$(CONFIG_EEPROM_AT24)	+=3D at24.o
>  obj-$(CONFIG_EEPROM_AT25)	+=3D at25.o
> +obj-$(CONFIG_FRAM_FM25)		+=3D fm25.o
>  obj-$(CONFIG_EEPROM_LEGACY)	+=3D eeprom.o
>  obj-$(CONFIG_EEPROM_MAX6875)	+=3D max6875.o
>  obj-$(CONFIG_EEPROM_93CX6)	+=3D eeprom_93cx6.o
> diff --git a/drivers/misc/eeprom/fm25.c b/drivers/misc/eeprom/fm25.c
> new file mode 100644
> index 0000000..c30c523
> --- /dev/null
> +++ b/drivers/misc/eeprom/fm25.c
> @@ -0,0 +1,499 @@
> +/*
> + * fm25.c -- support SPI FRAMs, such as Cypress FM25 models
> + *
> + * Copyright (C) 2014 Jiri Prchal
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/sched.h>
> +
> +#include <linux/spi/spi.h>
> +#include <linux/spi/eeprom.h>
> +#include <linux/of.h>
> +
> +struct fm25_data {
> +	struct spi_device	*spi;
> +	struct memory_accessor	mem;
> +	struct mutex		lock;
> +	struct spi_eeprom	chip;
> +	struct bin_attribute	bin;
> +	unsigned		addrlen;
> +	int			has_sernum;
> +};
> +
> +#define	FM25_WREN	0x06		/* latch the write enable */
> +#define	FM25_WRDI	0x04		/* reset the write enable */
> +#define	FM25_RDSR	0x05		/* read status register */
> +#define	FM25_WRSR	0x01		/* write status register */
> +#define	FM25_READ	0x03		/* read byte(s) */
> +#define	FM25_WRITE	0x02		/* write byte(s)/sector */
> +#define	FM25_SLEEP	0xb9		/* enter sleep mode */
> +#define	FM25_RDID	0x9f		/* read device ID */
> +#define	FM25_RDSN	0xc3		/* read S/N */
> +
> +#define	FM25_SR_WEN	0x02		/* write enable (latched) */
> +#define	FM25_SR_BP0	0x04		/* BP for software writeprotect */
> +#define	FM25_SR_BP1	0x08
> +#define	FM25_SR_WPEN	0x80		/* writeprotect enable */
> +
> +#define	FM25_ID_LEN	9		/* ID lenght */
> +#define	FM25_SN_LEN	8		/* serial number lenght */
> +
> +#define	FM25_MAXADDRLEN	3		/* 24 bit addresses */
> +
> +#define	io_limit	PAGE_SIZE	/* bytes */
> +
> +static ssize_t
> +fm25_data_read(
> +	struct fm25_data	*fm25,
> +	char			*buf,
> +	unsigned		offset,
> +	size_t			count
> +)
> +{
> +	u8			command[FM25_MAXADDRLEN + 1];
> +	u8			*cp;
> +	ssize_t			status;
> +	struct spi_transfer	t[2];
> +	struct spi_message	m;
> +	u8			instr;
> +
> +	if (unlikely(offset >=3D fm25->bin.size))
> +		return 0;
> +	if ((offset + count) > fm25->bin.size)
> +		count =3D fm25->bin.size - offset;
> +	if (unlikely(!count))
> +		return count;
> +
> +	cp =3D command;
> +
> +	instr =3D FM25_READ;
> +	*cp++ =3D instr;
> +
> +	/* 8/16/24-bit address is written MSB first */
> +	switch (fm25->addrlen) {
> +	default:	/* case 3 */
> +		*cp++ =3D offset >> 16;
> +	case 2:
> +		*cp++ =3D offset >> 8;
> +	case 1:
> +	case 0:	/* can't happen: for better codegen */
> +		*cp++ =3D offset >> 0;
> +	}
> +
> +	spi_message_init(&m);
> +	memset(t, 0, sizeof t);
> +
> +	t[0].tx_buf =3D command;
> +	t[0].len =3D fm25->addrlen + 1;
> +	spi_message_add_tail(&t[0], &m);
> +
> +	t[1].rx_buf =3D buf;
> +	t[1].len =3D count;
> +	spi_message_add_tail(&t[1], &m);
> +
> +	mutex_lock(&fm25->lock);
> +
> +	/* Read it all at once.
> +	 *
> +	 * REVISIT that's potentially a problem with large chips, if
> +	 * other devices on the bus need to be accessed regularly or
> +	 * this chip is clocked very slowly
> +	 */
> +	status =3D spi_sync(fm25->spi, &m);
> +	dev_dbg(&fm25->spi->dev,
> +		"read %Zd bytes at %d --> %d\n",
> +		count, offset, (int) status);
> +
> +	mutex_unlock(&fm25->lock);
> +	return status ? status : count;
> +}
> +
> +static ssize_t
> +fm25_id_read(struct fm25_data *fm25, char *buf)
> +{
> +	u8			command =3D FM25_RDID;
> +	ssize_t			status;
> +	struct spi_transfer	t[2];
> +	struct spi_message	m;
> +
> +	spi_message_init(&m);
> +	memset(t, 0, sizeof t);
> +
> +	t[0].tx_buf =3D &command;
> +	t[0].len =3D 1;
> +	spi_message_add_tail(&t[0], &m);
> +
> +	t[1].rx_buf =3D buf;
> +	t[1].len =3D FM25_ID_LEN;
> +	spi_message_add_tail(&t[1], &m);
> +
> +	mutex_lock(&fm25->lock);
> +
> +	status =3D spi_sync(fm25->spi, &m);
> +	dev_dbg(&fm25->spi->dev,
> +		"read %Zd bytes of ID --> %d\n",
> +	 FM25_ID_LEN, (int) status);
> +
> +	mutex_unlock(&fm25->lock);
> +	return status ? status : FM25_ID_LEN;
> +}
> +
> +static ssize_t
> +fm25_sernum_read(struct fm25_data *fm25, char *buf)
> +{
> +	u8			command =3D FM25_RDSN;
> +	ssize_t			status;
> +	struct spi_transfer	t[2];
> +	struct spi_message	m;
> +
> +	spi_message_init(&m);
> +	memset(t, 0, sizeof t);
> +
> +	t[0].tx_buf =3D &command;
> +	t[0].len =3D 1;
> +	spi_message_add_tail(&t[0], &m);
> +
> +	t[1].rx_buf =3D buf;
> +	t[1].len =3D FM25_SN_LEN;
> +	spi_message_add_tail(&t[1], &m);
> +
> +	mutex_lock(&fm25->lock);
> +
> +	status =3D spi_sync(fm25->spi, &m);
> +	dev_dbg(&fm25->spi->dev,
> +		"read %Zd bytes of serial number --> %d\n",
> +		FM25_SN_LEN, (int) status);
> +
> +	mutex_unlock(&fm25->lock);
> +	return status ? status : FM25_SN_LEN;
> +}
> +
> +static ssize_t
> +sernum_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	char			binbuf[FM25_SN_LEN];
> +	struct fm25_data	*fm25;
> +	int			i;
> +	char			*pbuf =3D buf;
> +
> +	fm25 =3D dev_get_drvdata(dev);
> +	fm25_sernum_read(fm25, binbuf);
> +	for (i =3D 0; i < FM25_SN_LEN; i++)
> +		pbuf +=3D sprintf(pbuf, "%02x ", binbuf[i]);
> +	sprintf(--pbuf, "\n");
> +	return (3 * i);
> +}
> +static const DEVICE_ATTR_RO(sernum);
> +
> +static ssize_t
> +fm25_bin_read(struct file *filp, struct kobject *kobj,
> +	      struct bin_attribute *bin_attr,
> +	      char *buf, loff_t off, size_t count)
> +{
> +	struct device		*dev;
> +	struct fm25_data	*fm25;
> +
> +	dev =3D container_of(kobj, struct device, kobj);
> +	fm25 =3D dev_get_drvdata(dev);
> +
> +	return fm25_data_read(fm25, buf, off, count);
> +}
> +
> +
> +static ssize_t
> +fm25_data_write(struct fm25_data *fm25, const char *buf, loff_t off,
> +	      size_t count)
> +{
> +	ssize_t			status =3D 0;
> +	unsigned		written =3D 0;
> +	unsigned		buf_size;
> +	u8			*bounce;
> +
> +	if (unlikely(off >=3D fm25->bin.size))
> +		return -EFBIG;
> +	if ((off + count) > fm25->bin.size)
> +		count =3D fm25->bin.size - off;
> +	if (unlikely(!count))
> +		return count;
> +
> +	/* Temp buffer starts with command and address */
> +	buf_size =3D io_limit;
> +	bounce =3D kmalloc(buf_size + fm25->addrlen + 1, GFP_KERNEL);
> +	if (!bounce)
> +		return -ENOMEM;
> +
> +	/* For write, rollover is within the page ... so we write at
> +	 * most one page, then manually roll over to the next page.
> +	 */
> +	mutex_lock(&fm25->lock);
> +	do {
> +		unsigned	segment;
> +		unsigned	offset =3D (unsigned) off;
> +		u8		*cp =3D bounce;
> +		u8		instr;
> +
> +		*cp =3D FM25_WREN;
> +		status =3D spi_write(fm25->spi, cp, 1);
> +		if (status < 0) {
> +			dev_dbg(&fm25->spi->dev, "WREN --> %d\n",
> +					(int) status);
> +			break;
> +		}
> +
> +		instr =3D FM25_WRITE;
> +		*cp++ =3D instr;
> +
> +		/* 8/16/24-bit address is written MSB first */
> +		switch (fm25->addrlen) {
> +		default:	/* case 3 */
> +			*cp++ =3D offset >> 16;
> +		case 2:
> +			*cp++ =3D offset >> 8;
> +		case 1:
> +		case 0:	/* can't happen: for better codegen */
> +			*cp++ =3D offset >> 0;
> +		}
> +
> +		/* Write as much of a page as we can */
> +		segment =3D buf_size - (offset % buf_size);
> +		if (segment > count)
> +			segment =3D count;
> +		memcpy(cp, buf, segment);
> +		status =3D spi_write(fm25->spi, bounce,
> +				segment + fm25->addrlen + 1);
> +		dev_dbg(&fm25->spi->dev,
> +				"write %u bytes at %u --> %d\n",
> +				segment, offset, (int) status);
> +		if (status < 0)
> +			break;
> +
> +		/* REVISIT this should detect (or prevent) failed writes
> +		 * to readonly sections of the EEPROM...
> +		 */
> +
> +		off +=3D segment;
> +		buf +=3D segment;
> +		count -=3D segment;
> +		written +=3D segment;
> +
> +	} while (count > 0);
> +
> +	mutex_unlock(&fm25->lock);
> +
> +	kfree(bounce);
> +	return written ? written : status;
> +}
> +
> +static ssize_t
> +fm25_bin_write(struct file *filp, struct kobject *kobj,
> +	       struct bin_attribute *bin_attr,
> +	       char *buf, loff_t off, size_t count)
> +{
> +	struct device		*dev;
> +	struct fm25_data	*fm25;
> +
> +	dev =3D container_of(kobj, struct device, kobj);
> +	fm25 =3D dev_get_drvdata(dev);
> +
> +	return fm25_data_write(fm25, buf, off, count);
> +}
> +
> +/*----------------------------------------------------------------------=
---*/
> +
> +/* Let in-kernel code access the eeprom data. */
> +
> +static ssize_t fm25_mem_read(struct memory_accessor *mem, char *buf,
> +			     off_t offset, size_t count)
> +{
> +  struct fm25_data *fm25 =3D container_of(mem, struct fm25_data, mem);
> +
> +  return fm25_data_read(fm25, buf, offset, count);
> +}
> +
> +static ssize_t fm25_mem_write(struct memory_accessor *mem, const char *b=
uf,
> +			  off_t offset, size_t count)
> +{
> +	struct fm25_data *fm25 =3D container_of(mem, struct fm25_data, mem);
> +
> +	return fm25_data_write(fm25, buf, offset, count);
> +}
> +
> +/*----------------------------------------------------------------------=
---*/
> +
> +static int fm25_np_to_chip(struct device *dev,
> +			   struct device_node *np,
> +			   struct spi_eeprom *chip)
> +{
> +	memset(chip, 0, sizeof(*chip));
> +	strncpy(chip->name, np->name, sizeof(chip->name));
> +
> +	if (of_find_property(np, "read-only", NULL))
> +		chip->flags |=3D EE_READONLY;
> +	return 0;
> +}
> +
> +static int fm25_probe(struct spi_device *spi)
> +{
> +	struct fm25_data	*fm25 =3D NULL;
> +	struct spi_eeprom	chip;
> +	struct device_node	*np =3D spi->dev.of_node;
> +	int			err;
> +	char			id[FM25_ID_LEN];
> +
> +	/* Chip description */
> +	if (!spi->dev.platform_data) {
> +		if (np) {
> +			err =3D fm25_np_to_chip(&spi->dev, np, &chip);
> +			if (err)
> +				return err;
> +		} else {
> +			dev_err(&spi->dev, "Error: no chip description\n");
> +			return -ENODEV;
> +		}
> +	} else
> +		chip =3D *(struct spi_eeprom *)spi->dev.platform_data;
> +
> +	fm25 =3D devm_kzalloc(&spi->dev, sizeof(*fm25), GFP_KERNEL);
> +	if (!fm25)
> +		return -ENOMEM;
> +
> +	mutex_init(&fm25->lock);
> +	fm25->chip =3D chip;
> +	fm25->spi =3D spi_dev_get(spi);
> +	spi_set_drvdata(spi, fm25);
> +
> +	/* Get ID of chip */
> +	fm25_id_read(fm25, id);
> +	if (id[6] !=3D 0xc2) {
> +		dev_err(&spi->dev, "Error: no Cypress FRAM (id %02x)\n", id[6]);
> +		return -ENODEV;
> +	}
> +	/* set size found in ID */
> +	switch (id[7]) {
> +	case 0x21:
> +		fm25->chip.byte_len =3D 16 * 1024;
> +		break;
> +	case 0x22:
> +		fm25->chip.byte_len =3D 32 * 1024;
> +		break;
> +	case 0x23:
> +		fm25->chip.byte_len =3D 64 * 1024;
> +		break;
> +	case 0x24:
> +		fm25->chip.byte_len =3D 128 * 1024;
> +		break;
> +	case 0x25:
> +		fm25->chip.byte_len =3D 256 * 1024;
> +		break;
> +	default:
> +		dev_err(&spi->dev, "Error: unsupported size (id %02x)\n", id[7]);
> +		return -ENODEV;
> +		break;
> +	}
> +
> +	if (fm25->chip.byte_len > 64 * 1024) {
> +		fm25->addrlen =3D 3;
> +		fm25->chip.flags |=3D EE_ADDR3;
> +	}
> +	else {
> +		fm25->addrlen =3D 2;
> +		fm25->chip.flags |=3D EE_ADDR2;
> +	}
> +
> +	if (id[8])
> +		fm25->has_sernum =3D 1;
> +	else
> +		fm25->has_sernum =3D 0;
> +
> +	fm25->chip.page_size =3D PAGE_SIZE;
> +
> +	/* Export the EEPROM bytes through sysfs, since that's convenient.
> +	 * And maybe to other kernel code; it might hold a board's Ethernet
> +	 * address, or board-specific calibration data generated on the
> +	 * manufacturing floor.
> +	 *
> +	 * Default to root-only access to the data; EEPROMs often hold data
> +	 * that's sensitive for read and/or write, like ethernet addresses,
> +	 * security codes, board-specific manufacturing calibrations, etc.
> +	 */
> +	sysfs_bin_attr_init(&fm25->bin);
> +	fm25->bin.attr.name =3D "fram";
> +	fm25->bin.attr.mode =3D S_IRUGO;
> +	fm25->bin.read =3D fm25_bin_read;
> +	fm25->mem.read =3D fm25_mem_read;
> +
> +	fm25->bin.size =3D fm25->chip.byte_len;
> +	if (!(chip.flags & EE_READONLY)) {
> +		fm25->bin.write =3D fm25_bin_write;
> +		fm25->bin.attr.mode |=3D S_IWUSR | S_IWGRP;
> +		fm25->mem.write =3D fm25_mem_write;
> +	}
> +
> +	err =3D sysfs_create_bin_file(&spi->dev.kobj, &fm25->bin);
> +	if (err)
> +		return err;
> +
> +	/* Export the FM25 serial number */
> +	if (fm25->has_sernum) {
> +		err =3D device_create_file(&spi->dev, &dev_attr_sernum);
> +		if (err)
> +			return err;
> +	}
> +
> +	if (chip.setup)
> +		chip.setup(&fm25->mem, chip.context);
> +
> +	dev_info(&spi->dev, "%Zd %s %s fram%s\n",
> +		(fm25->bin.size < 1024)
> +			? fm25->bin.size
> +			: (fm25->bin.size / 1024),
> +		(fm25->bin.size < 1024) ? "Byte" : "KByte",
> +		fm25->chip.name,
> +		(chip.flags & EE_READONLY) ? " (readonly)" : "");
> +	return 0;
> +}
> +
> +static int fm25_remove(struct spi_device *spi)
> +{
> +	struct fm25_data *fm25 =3D spi_get_drvdata(spi);
> +
> +	sysfs_remove_bin_file(&spi->dev.kobj, &fm25->bin);
> +	if (fm25->has_sernum)
> +		device_remove_file(&spi->dev, &dev_attr_sernum);
> +	return 0;
> +}
> +
> +/*----------------------------------------------------------------------=
---*/
> +
> +static const struct of_device_id fm25_of_match[] =3D {
> +	{ .compatible =3D "cypress,fm25", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, fm25_of_match);
> +
> +static struct spi_driver fm25_driver =3D {
> +	.driver =3D {
> +		.name		=3D "fm25",
> +		.of_match_table =3D fm25_of_match,
> +	},
> +	.probe		=3D fm25_probe,
> +	.remove		=3D fm25_remove,
> +};
> +
> +module_spi_driver(fm25_driver);
> +
> +MODULE_DESCRIPTION("Driver for Cypress SPI FRAMs");
> +MODULE_AUTHOR("Jiri Prchal");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("spi:fram");
> --
> 1.9.1
>=20

--2JFBq9zoW8cOFH7v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUP28NAAoJEBQN5MwUoCm2kXUP/1DuuIZZvJ5ux4WI1TGw7Yoz
QL1y7iDq2lz/YXq+2VqGTPlHiuM81c7SUARORYRUFsMBOpWnVhX0q6ssAlbGOaRD
QQjZXxXaok8b6pTJ5B2p5Ytcu2wwsc0NxtpmhYMxYCIaDo2B3A9J/oyhTckZdRX6
tcjkC4zDL+qLNTMRtGMEjIc3KG06BslvXZ8DcPXhRayLeMtor24u0JTDsDUcxXFy
G5ytzaIoYv5SLXjMLGIgbCr+x+VSEtkMz39vUt+YJK+P8nyY8oaGkxOKixA3dI0o
dnYUDD6BDHRMGI2/EebNsRdkJxlrsVlxSc99weWlgN8rb3QB1kU+YJcqMiqyUEG4
/Q9aFcj21wYvPRVxYQ1lHfD4XBa14UN/KIZ15ux2jjG+YxkyhmQNGE2343MBqJs2
Ih1xKDSGHaHzmqL6CKQCUsbz5kRdnndcsyGkWO7xlhNC1nNBr7qJimx3qlFa+zcV
ZJKwEqEKk/eVoDcg80TGvN2CiZritMdVlyNuswCcDzbdlQ6QGYP2MWnQcRNYQthp
k2Rp13viKZXErGonNty46/vNcQVFuxLFpAITjqJkpQ3zznjD87qkL72jHGBinLST
iZm/3rJbvqahOdPd9UfqF9WBCdsDWSCQc2jlw3pr7uYqoXVzEJmfrUPx7MFq9BQI
OE5hThWFi2XEX+ax5dmY
=ZCD8
-----END PGP SIGNATURE-----

--2JFBq9zoW8cOFH7v--
