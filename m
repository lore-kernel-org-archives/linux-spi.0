From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v3 1/2] spi: Split spi message into chunks of <65535 in
 the spi subsystem
Date: Fri, 16 Mar 2018 16:55:45 -0700
Message-ID: <87po43vam6.fsf@anholt.net>
References: <cover.1520848302.git.meghana.madhyastha@gmail.com>
 <648641e37f11ac4a4d94d371e7b676c5a6108edd.1520848302.git.meghana.madhyastha@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1174096914=="
To: Meghana Madhyastha <meghana.madhyastha@gmail.com>, Mark Brown
 <broonie@kernel.org>, Daniel Vetter <daniel.vetter@intel.com>,
 linux-spi@vger.kernel.org, Noralf =?utf-8?Q?Tr=C3=B8nnes?=
 <noralf@tronnes.org>, Sean Paul <seanpaul@chromium.org>,
 dri-devel@lists.freedesktop.org
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <648641e37f11ac4a4d94d371e7b676c5a6108edd.1520848302.git.meghana.madhyastha@gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
List-Id: linux-spi.vger.kernel.org

--===============1174096914==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Meghana Madhyastha <meghana.madhyastha@gmail.com> writes:

> Split spi messages into chunks of <65535 in the spi subsystem and remove =
the message
> length warning in bcm2835_spi_can_dma. This is so that the messages can b=
e transferred
> via dma and that the tinydrm drivers need not split it. The current chunk=
 size is 65532.
> This is because the scatter gather segment is required to be multiple of =
4. The size
> has to be <65535 due to hardware limitations.
>
> Signed-off-by: Meghana Madhyastha <meghana.madhyastha@gmail.com>
> ---
>  drivers/spi/spi-bcm2835.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
> index f35cc10772f6..280ffa5aef7e 100644
> --- a/drivers/spi/spi-bcm2835.c
> +++ b/drivers/spi/spi-bcm2835.c
> @@ -365,19 +365,6 @@ static bool bcm2835_spi_can_dma(struct spi_master *m=
aster,
>  	if (tfr->len < BCM2835_SPI_DMA_MIN_LENGTH)
>  		return false;
>=20=20
> -	/* BCM2835_SPI_DLEN has defined a max transfer size as
> -	 * 16 bit, so max is 65535
> -	 * we can revisit this by using an alternative transfer
> -	 * method - ideally this would get done without any more
> -	 * interaction...
> -	 */
> -	if (tfr->len > 65535) {
> -		dev_warn_once(&spi->dev,
> -			      "transfer size of %d too big for dma-transfer\n",
> -			      tfr->len);
> -		return false;
> -	}
> -
>  	/* if we run rx/tx_buf with word aligned addresses then we are OK */
>  	if ((((size_t)tfr->rx_buf & 3) =3D=3D 0) &&
>  	    (((size_t)tfr->tx_buf & 3) =3D=3D 0))
> @@ -461,7 +448,7 @@ static void bcm2835_dma_init(struct spi_master *maste=
r, struct device *dev)
>=20=20
>  	/* all went well, so set can_dma */
>  	master->can_dma =3D bcm2835_spi_can_dma;
> -	master->max_dma_len =3D 65535; /* limitation by BCM2835_SPI_DLEN */
> +	master->max_dma_len =3D 65532; /* limitation by BCM2835_SPI_DLEN */
>  	/* need to do TX AND RX DMA, so we need dummy buffers */
>  	master->flags =3D SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
>=20=20
> @@ -597,7 +584,14 @@ static int bcm2835_spi_prepare_message(struct spi_ma=
ster *master,
>  {
>  	struct spi_device *spi =3D msg->spi;
>  	struct bcm2835_spi *bs =3D spi_master_get_devdata(master);
> +	gfp_t gfp_flags =3D GFP_KERNEL | GFP_DMA;
>  	u32 cs =3D bcm2835_rd(bs, BCM2835_SPI_CS);
> +	size_t max_transfer_size =3D 65532;
> +	int ret;
> +
> +	ret =3D spi_split_transfers_maxsize(master, msg, max_transfer_size, gfp=
_flags);
> +	if (ret)
> +	       return ret;

Mark: is this how spi_split_transfers_maxsize() is supposed to be used?
If so, I'm happy to see our hardware have fewer limitations, and it gets
my:

Reviewed-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlqsWYEACgkQtdYpNtH8
nugr0w/+JuBcnSv6dsbB9MafyOsht/dMbZOHm4mY1rqeV7hfk6HQNH4fU+FLP+AX
X0zuBbEpPfn50R6wD0s8Vmg4o+zDnSEbQWZMPTertEW59ObOVgnEKXNU1AN9yDpN
MOn9LY4wFvMMD7uZvz4QiM8rnf7WCgKSRc8mnNt4IEC2u3TM+gZJvbAUudoTaoIu
amQ9ZdNFdicKr2Z7n5+N+8fp4WUZpWYjTZ4YiTCwZh0FDvB1aHLpUQqsf1qx9urQ
2ZGpndZ2pZeCWiJ3pD2Jasqb+zO7g72ape1MAQzPqWjL4lCgjx7OArKXnb+4Zf5c
CpRqrwAfNCO7yMIso6Q/0dXcJropIP72hv6L1t4S6ZGjt46/Tu+HdUZc0Gzkxgrp
QaDZEzngRrOODBCDTgeWcAxKcJAgJPkEHFTnuKnwJKB8UkJO/QYuyvJ6mwmLMxPK
imr/akiDZxRFCk9QJTmmWSdkmHebUOURfYkDMZwJoBbizeAioNzWbgFoV5p69wwG
9XI39JuaE14py2w3XANb/hoCYad4qwGRhcK2Jb+um3MxpMS1at9IAbdEYIjg4a0r
9C039uk94SA3RcQYbyIYnsOosZ+mxr8ErcxnnLiTauFnvi0FVszmMhTMuINe4xp8
UvQKbTyUlDXpK7sX+IWhn26ayeIKtFZurYSg628fqeaFJ0KIZ0g=
=sljc
-----END PGP SIGNATURE-----
--=-=-=--

--===============1174096914==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1174096914==--
