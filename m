From: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: xilinx: remove unnecessary spaces
Date: Wed, 26 Feb 2014 07:20:22 +0100
Message-ID: <530D87A6.6080902@monstr.eu>
References: <003101cf3291$8948f3a0$9bdadae0$%han@samsung.com>
Reply-To: monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="imjlvnLMcuTP3DnehUJ7bk0cPlpmQ3Nqo"
Cc: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	'Michal Simek' <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <003101cf3291$8948f3a0$9bdadae0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--imjlvnLMcuTP3DnehUJ7bk0cPlpmQ3Nqo
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/26/2014 02:24 AM, Jingoo Han wrote:
> Remove unnecessary space in order to fix the following
> checkpatch issues.
>=20
>   WARNING: Unnecessary space after function pointer name
>=20
> Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/spi/spi-xilinx.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
> index 66dbefc..a3b0b99 100644
> --- a/drivers/spi/spi-xilinx.c
> +++ b/drivers/spi/spi-xilinx.c
> @@ -87,10 +87,10 @@ struct xilinx_spi {
>  	const u8 *tx_ptr;	/* pointer in the Rx buffer */
>  	int remaining_bytes;	/* the number of bytes left to transfer */
>  	u8 bits_per_word;
> -	unsigned int (*read_fn) (void __iomem *);
> -	void (*write_fn) (u32, void __iomem *);
> -	void (*tx_fn) (struct xilinx_spi *);
> -	void (*rx_fn) (struct xilinx_spi *);
> +	unsigned int (*read_fn)(void __iomem *);
> +	void (*write_fn)(u32, void __iomem *);
> +	void (*tx_fn)(struct xilinx_spi *);
> +	void (*rx_fn)(struct xilinx_spi *);
>  };
> =20
>  static void xspi_write32(u32 val, void __iomem *addr)
>=20

Reviewed-by: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--imjlvnLMcuTP3DnehUJ7bk0cPlpmQ3Nqo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMNh6YACgkQykllyylKDCGEDgCfUINQUvPmZ237QkUxUtBYOXGo
gtQAn27oYdey1NtaZWZZDhgp79KBb1z5
=1RM4
-----END PGP SIGNATURE-----

--imjlvnLMcuTP3DnehUJ7bk0cPlpmQ3Nqo--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
