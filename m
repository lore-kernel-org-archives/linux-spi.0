From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH for-next] spi: bcm53xx: add spi_flash_read callback for
 MMIO-based reads
Date: Mon, 18 Apr 2016 12:24:57 +0100
Message-ID: <20160418112457.GU3217@sirena.org.uk>
References: <1460977843-9426-1-git-send-email-zajec5@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vBRosIkLXbYTRpGW"
Cc: "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460977843-9426-1-git-send-email-zajec5@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--vBRosIkLXbYTRpGW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 18, 2016 at 01:10:43PM +0200, Rafa=C5=82 Mi=C5=82ecki wrote:

> +static int bcm53xxspi_flash_read(struct spi_device *spi,
> +				 struct spi_flash_read_message *msg)
> +{
> +	struct bcm53xxspi *b53spi =3D spi_master_get_devdata(spi->master);
> +	int ret =3D 0;
> +
> +	bcm53xxspi_enable_bspi(b53spi);
> +	memcpy_fromio(msg->buf, b53spi->mmio_base + msg->from, msg->len);
> +	msg->retlen =3D msg->len;

There's no bounds check here but...

> +	if (core->addr_s[0])
> +		b53spi->mmio_base =3D devm_ioremap(dev, core->addr_s[0], SZ_32M);

=2E..we only mapped 32M here.  What if something tries to do a larger
read?  It's also a bit surprising that we're mapping a specific size
here rather than the entire resource.

--vBRosIkLXbYTRpGW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXFMQHAAoJECTWi3JdVIfQhnIH/j156JUEPrXhYC2vt7+SqgK2
ZtMtpRUCI8FiYf24svnxh7i4OjKkKlyRgUpuIVRRSJ97TltQ9TXWIevk42jH5mwq
319zp7fH94qmpoW4z51ZGEosRl01cB/C6BTp3ROPMbChRwtOj23ksitNCA2OO22l
zBgbSdRr1OjL2gIUCVlccKmli1BPk48/kKxUQNrqJGUbyl79a4juM5AgdKexk2kB
yUgPHsc1Mbx50HdKZNVytbUV5+ClxBzIgQiwVtlXqSnhwGxrvaJhH8WkoYtEUVDW
ZrKV7qR32Mz3w+csmZsA2Io+MRpI4YRC0bbW30py4xT2feh80zcngurItFPptuY=
=wUxw
-----END PGP SIGNATURE-----

--vBRosIkLXbYTRpGW--
