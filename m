From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/8] spi: sun4i: add DMA support
Date: Thu, 7 Aug 2014 18:44:42 +0100
Message-ID: <20140807174442.GP17528@sirena.org.uk>
References: <1407183002-29420-1-git-send-email-emilio@elopez.com.ar>
 <1407183002-29420-3-git-send-email-emilio@elopez.com.ar>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1FpmNXN8nra/cBU6"
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org
To: Emilio =?iso-8859-1?Q?L=F3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1407183002-29420-3-git-send-email-emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--1FpmNXN8nra/cBU6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 04, 2014 at 05:09:56PM -0300, Emilio L=F3pez wrote:

> +static int sun4i_spi_prepare_message(struct spi_master *master,
> +				     struct spi_message *msg)
> +{
> +	struct sun4i_spi *sspi =3D spi_master_get_devdata(master);
> +
> +	master->dma_rx =3D sspi->rx_dma_chan;
> +	master->dma_tx =3D sspi->tx_dma_chan;
> +
> +	return 0;
> +}

Why is this being done per transfer rather than at probe time?

--1FpmNXN8nra/cBU6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT47sHAAoJELSic+t+oim9lrYP/RYHNqI8bpHKSFrF6fF9SVCe
rJuVq89n/b16M2qWMxsv7JdEOx7ZMhaLldcmyYuY18Ojz3Shk5S3DGn3yMabGyOw
0RWh21llTk+jPh2hqY/nfn6bfyun/OizK58f3C6E82rajatyHmdjiertQCBtXm4m
HZoUOl7GyGXzxFnCfGgfo9EpT6oobg8K9IK9nhqL4ewuhT8T1LcD+6uNCKV9PGTp
lC810iaTBWxfinyYMYWxCJMupOe1dRDWcXrpyCJy3rdWAYLwC95G1V0x/ToJ99HU
tjdkqW0c+H23CuLfkKmyTkzq/yXBakF81W+dl3kb9KNe8GRVHTKHdVH3/R9rfNoU
y9ZAAgGzefddaBm6fAY8fKIHfPXFtPEgCe5Kk+cE1sD6mV4dr6fVnS/BKR0fna5U
d3ZVQ93CVkNXn9g3OyR7rGeBe/TxEvloYZMj4mGVxJLDqnizOup4gFRqBDKVRjDB
uS6AJe/dQmpLOoFCp0iASLvWoZbZYFeZvlb5QGW8Kq1l20QGLX4x9G5jDE/WzV1Q
3r89g2Txt1Uw5FbU3O1/UYywRRWy+2po4e4WB/jotTJ/tLhUyoMbosNJtoQbW/6v
eBuAQCkTQSwlfWpiGzZpd+4RX8iIEo7beucp2tjktrPlJWlphzcAyGU72oYu+P3o
ctvPRQn7EukWIM4vak5o
=lpQr
-----END PGP SIGNATURE-----

--1FpmNXN8nra/cBU6--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
