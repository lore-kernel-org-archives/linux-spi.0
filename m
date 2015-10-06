From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] misc: eeprom: at25: add Cypress FRAM functionality
Date: Tue, 6 Oct 2015 15:40:48 +0100
Message-ID: <20151006144048.GS12635@sirena.org.uk>
References: <c7beacd629a47a0bd5023353378a3eda4d7d0f89.1444139729.git.jiri.prchal@aksignal.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tCskcS2bjfK01Pum"
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
To: Jiri Prchal <jiri.prchal-cKCO0sOKHLPtwjQa/ONI9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <c7beacd629a47a0bd5023353378a3eda4d7d0f89.1444139729.git.jiri.prchal-cKCO0sOKHLPtwjQa/ONI9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--tCskcS2bjfK01Pum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 06, 2015 at 04:01:32PM +0200, Jiri Prchal wrote:
> This patch adds functionality for Cypress FRAMs on SPI bus, such as FM25V05,
> FM25V10 etc.

I'm not entirely sure why I got CCed on this?

> +	mutex_lock(&at25->lock);
> +
> +	status = spi_sync(at25->spi, &m);
> +	dev_dbg(&at25->spi->dev,
> +		"read %Zd bytes of ID --> %d\n",
> +	 FM25_ID_LEN, (int) status);
> +
> +	mutex_unlock(&at25->lock);

There is no point in holding a lock around spi_sync(), the SPI framework
has locking which will ensure spi_sync() and spi_async() calls will be
serialised.

--tCskcS2bjfK01Pum
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWE91vAAoJECTWi3JdVIfQXWEIAIL3/C5ZmgcvCOMOkTiFLxfi
o22iChNQrXLBrLKa1CYotn0KSIxPnQDR/xSaJMX+vg6i5VsOPa6UamqVsf6f4lJE
tY7K7tKrqXp8InmUT5qyTrkDQUv8VhSOYVMbCtAIci0A/RPXXdI922slwMf27OcF
zMSndF6krXKIur6W2EZ/tluBwOUuWnyHwNmrCK35A3AfU2Fm8Fa/GVw7JpT/h665
/zJxcHG0X2KO61q8L7RXvI3O/yUptKJZChrSrXbRDxeSvJ4qj4XePKhUbvtEpYeh
mUdDvAm3GRWAvP8Y/DNv6QJYP62/pPTuU96JV7gkhvjd/rrLIkyDeQTFQCVQMeE=
=/8gr
-----END PGP SIGNATURE-----

--tCskcS2bjfK01Pum--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
