From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: cadence: Add usleep_range() for
 cdns_spi_fill_tx_fifo()
Date: Fri, 13 Apr 2018 19:03:05 +0100
Message-ID: <20180413180304.GF6854@sirena.org.uk>
References: <1523272610-49116-1-git-send-email-sxauwsk@163.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3yNHWXBV/QO9xKNm"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        guojian <guojian@innoinstrument.net>,
        wangshikai <wangshikai@inno-instrument.cn>
To: sxauwsk <sxauwsk@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1523272610-49116-1-git-send-email-sxauwsk@163.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--3yNHWXBV/QO9xKNm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 09, 2018 at 07:16:50PM +0800, sxauwsk wrote:
> In case of xspi work in busy condition, may send bytes failed.
> Add one bytes delay

>  	while ((trans_cnt < CDNS_SPI_FIFO_DEPTH) &&
>  	       (xspi->tx_bytes > 0)) {
> +
> +		/* When xspi in busy condition, bytes may send failed,
> +		 * caused communication failure so add one byte delay
> +		 */
> +		usleep_range(10, 20);
> +
>  		if (xspi->txbuf)
>  			cdns_spi_write(xspi, CDNS_SPI_TXD, *xspi->txbuf++);

This looks like it adds a byte of delay on every read/write - that
seems like a lot of overhead for something that sounds like it's
probably only an issue when the FIFO is full?  Do we need to do this for
every operation, and is it needed for read or is it just write?

--3yNHWXBV/QO9xKNm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrQ8NgACgkQJNaLcl1U
h9CFvgf8Ce2RR4+sAhzVgT5d0yhSHLIjwr5jYoA9N6jsBCNIl1B/wwjlD5Lna0NK
JbkK9DI5gV1PPdbR6sIRs5uA4E5yMMR5mAsYWdUITk6QR4r/wY3FnehfiUYHsaaw
4rNBj3G1FilnwHw3bBd731Jo9DSzEIFHfSv3MfHKfdOsuF3Ut0BDJKIAxQ3OqMOa
wGzTny7NzLg7mqU931avo8WOl+6N11Ms2UVCqt6YPTXA+KwzvXcqB2cLRuaG8RTJ
b7l3i3VtiUcVynZURI1RnvIy1/TXVCfIimvES9VkJMBu2uKBTXZ1HQrZaupimVsa
Ydz1ZhjtVF+ZHLJ/DDJyVmak9NeRQQ==
=xL/n
-----END PGP SIGNATURE-----

--3yNHWXBV/QO9xKNm--
