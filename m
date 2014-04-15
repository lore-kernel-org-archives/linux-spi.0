From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: sirf: decrease the interrupt count and latency
 of PIO mode
Date: Tue, 15 Apr 2014 12:39:49 +0100
Message-ID: <20140415113949.GS12304@sirena.org.uk>
References: <1397546700-21605-1-git-send-email-21cnbao@gmail.com>
 <1397546700-21605-2-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vEk28Nl/eckWL8CC"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	workgroup.linux-kQvG35nSl+M@public.gmane.org, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1397546700-21605-2-git-send-email-21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--vEk28Nl/eckWL8CC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2014 at 03:25:00PM +0800, Barry Song wrote:

> +	for (;;) {

> +		writel(0, sspi->base + SIRFSOC_SPI_RXFIFO_OP);
> +		writel(0, sspi->base + SIRFSOC_SPI_TXFIFO_OP);
> +		if (sspi->left_tx_word =3D=3D 0 && sspi->left_rx_word =3D=3D 0)
> +			break;
> +	}

This would be clearer as a do { } while loop.  Otherwise this looks OK
=66rom a first read through, though the diffstat is pretty horrible.

--vEk28Nl/eckWL8CC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTRqCAAoJELSic+t+oim9O1wP/AlVHFCfzLPE3wsvQU4utHX9
IxfxHZ2V8aLqE2C/Mlv7zUXGRNwCyiKiuW9W1EvVlih8yoZvFXnONhMuBe4n9obx
pgAjCYJIrh5ppz1KERMU3HWdPbvd7pmyFf1z8PUQpUaJht8zRaySSAWij+GUKT0E
eUIcmaYXKfrSBLjaItcCefY6rZc9tC6EcjCnWsImizKPXKudD9FrgoCszdtVQj8Q
i5IDt5pGeGbtFwhgAU1tyXy9ncMatlj5yso3N02j5Aie8a1X59zVD7tU+Ilc9HBy
M5LtnrpfoShqQUcpemzuzYM4viciGdmkJKZHLcMXd0FzGk6CqYbIqu3litgrJJiw
mLphotcowlO3kTG7kDbtRmufuP9OtKfwoLdyqGPM+Srk07pN5pgdJeL6sw/zExnA
TZWNu6VqUg3QqmZ3wqBLN9DnunO20fqGfRlDUf8UpXb49S2kkfOee9xaotZo2Frk
STurDomEvbgsZIBAwEip325r3DPHs8MJwxtQHe3/Ga1aP1p9wVVVsp9zCAvYfQuZ
7ntNvkVRDlZ34WAkvV9UEGynU6FR75bxEVvUqH74QDapZgH+F/LJBpzMtBB0m5UF
Wymhbi7+Mxv9RA6rOX/pJQ0CcC5A8dSWr9KHuN18TdADQFOvcEz+UP1sEFPjEiye
6+3eHb9nDJLKrhzqP8Lc
=/Ew3
-----END PGP SIGNATURE-----

--vEk28Nl/eckWL8CC--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
