Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F3C4AA58E;
	Thu, 24 Sep 2026 18:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790273452; cv=none; b=s/5YhWOPSZFMmuGjsdTFYo1Eh7PGYdzvvK7K+MEUmW66DfLxhbmCX2lXtih92YSqG9HbhHwH/eWG0KgtQU4bBkZWhiYvRJcmA5e05P1C1eDXRg5tSVJ1mkm5o+KsJVlPvyVSuPgaNfNWWVVjidtQW4ERvazLb2gUFwj9Mmk+rzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790273452; c=relaxed/simple;
	bh=BOL6ljZqHT4eSR2tcAznUPg+wvR8oXMCt8dAB/9cdg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wl8jOzaQo087y5mfOyKxJ6a5CSpFyDqd3ZOC8Jgqdzjq0cjDYl/ibWo3X1Pwa7pvJyfvZOcOnRsA88NLyGoyCUMbqkfjmegtJ5IkrYEyQMcnjyayayYs0XbpB07CD1/ZI43is8+YEdUHLA5g81F/1u/QAPzSpE1RvqTYdw3u+t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOfdlZh8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOfdlZh8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19721F000FF;
	Thu, 24 Sep 2026 18:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790273450;
	bh=iUyJ3F5pCxEfwlQ9lea9YBXzOZT5eF2QS0Ypku+S4+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KOfdlZh8AhBNa5q67lGeLuUDyYXS9ySz9LwZ7tl4QraCw/AgSVFSa6kA7uXz5WuC3
	 LjyZqxyYiq2kNBhcWHj7Xv6M60DQ3CB4yLXEGpTCpj8szSCyZr8KEt3FLv7hfps8+r
	 bA2bJk1Ro7y+Ze38W0qvHPE6IAT8VgNgcw0ebFYGV14QJWcOiU0KeXhzBI4kEuwMol
	 3wic/2fdUxBMxK1dAAjtA5qZ43vCi46EvP+/bXLD9qdadurZhHGTISl/vTZ4eqnbHX
	 +fOVlydtluEHLHWopRV2URuqgM3zS0alFuF3LkFQda/xFFzbFgO9M3s5aFowAvxhXp
	 nbA2czTeDzWWQ==
Date: Thu, 24 Sep 2026 19:10:42 +0100
From: Mark Brown <broonie@kernel.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Serge Semin <fancer.lancer@gmail.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] spi: dw: Add DMA support for enhanced memory
 operations
Message-ID: <e77a4254-2041-47f1-b0a7-b496f77a29d1@sirena.org.uk>
References: <20260923095705.233297-1-changhuang.liang@starfivetech.com>
 <20260923095705.233297-3-changhuang.liang@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7CCrzub0Penet8VL"
Content-Disposition: inline
In-Reply-To: <20260923095705.233297-3-changhuang.liang@starfivetech.com>
X-Cookie: Oh, so there you are!


--7CCrzub0Penet8VL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 02:57:05AM -0700, Changhuang Liang wrote:
> Implement DMA support for enhanced SPI memory operations. On some
> platforms, such as JHB100, only one DMA channel is available for the
> enhanced SPI controller, so the channel is allocated dynamically based
> on the transfer direction.
>=20
> Add enhanced memory DMA callbacks (init/exit, setup, can_dma, transfer)
> to struct dw_spi_dma_ops and hook them into the generic DMA operations.
> The channel is requested per operation and released afterwards.
>=20
> In dw_spi_exec_enh_mem_op(), record the direction in dws->tx_dir and use
> the DMA path when a channel is available, can_dma_enh_mem() accepts the
> transfer, and the transfer exceeds the FIFO length; otherwise fall back
> to the interrupt path.
>=20
> Rework dw_spi_dma_wait_tx_done() to take an explicit speed_hz, add one
> to TXFLR for the word possibly left in the shift register, and compute
> the delay in ns or us, dropping the dependency on the xfer pointer.
>=20
> Also move the udelay(5) workaround into dw_spi_enh_write_cmd_addr() so
> it applies to both paths, and enable the generic DMA setup in
> dw_spi_jhb100_init().
>=20
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  drivers/spi/spi-dw-core.c | 107 ++++++++++-----
>  drivers/spi/spi-dw-dma.c  | 281 +++++++++++++++++++++++++++++++++++++-
>  drivers/spi/spi-dw-mmio.c |   2 +
>  drivers/spi/spi-dw.h      |  10 ++
>  4 files changed, 357 insertions(+), 43 deletions(-)
>=20
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index 04a5b48373e1..6da3812f72f6 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -970,6 +970,15 @@ static void dw_spi_enh_write_cmd_addr(struct dw_spi =
*dws, const struct spi_mem_o
> =20
>  		dw_spi_set_cs(mem->spi, false);
>  	}
> +
> +	/*
> +	 * FIXME: The exact reason for this delay is not fully understood,
> +	 * but empirical testing shows it significantly improves the stability
> +	 * of read/write operations. Without this delay, occasional transfer
> +	 * errors or timeouts may occur under certain conditions.
> +	 * Keeping it as a safeguard based on practical validation.
> +	 */
> +	udelay(5);
>  }
> =20
>  static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_=
mem_op *op)
> @@ -981,6 +990,8 @@ static int dw_spi_exec_enh_mem_op(struct spi_mem *mem=
, const struct spi_mem_op *
>  	unsigned long long ms;
>  	int ret;
> =20
> +	dws->dma_mapped =3D false;
> +
>  	switch (op->data.buswidth) {
>  	case 0:
>  	case 1:
> @@ -1004,10 +1015,13 @@ static int dw_spi_exec_enh_mem_op(struct spi_mem =
*mem, const struct spi_mem_op *
>  	cfg.dfs =3D 8;
>  	cfg.freq =3D clamp(op->max_freq, 0U, dws->max_mem_freq);
>  	cfg.ndf =3D op->data.nbytes;
> -	if (op->data.dir =3D=3D SPI_MEM_DATA_IN)
> +	if (op->data.dir =3D=3D SPI_MEM_DATA_IN) {
>  		cfg.tmode =3D DW_SPI_CTRLR0_TMOD_RO;
> -	else
> +		dws->tx_dir =3D false;
> +	} else {
>  		cfg.tmode =3D DW_SPI_CTRLR0_TMOD_TO;
> +		dws->tx_dir =3D true;
> +	}
> =20
>  	if (op->data.buswidth =3D=3D op->addr.buswidth &&
>  	    op->data.buswidth =3D=3D op->cmd.buswidth)
> @@ -1043,47 +1057,68 @@ static int dw_spi_exec_enh_mem_op(struct spi_mem =
*mem, const struct spi_mem_op *
>  		}
>  	}
> =20
> -	dw_spi_enh_write_cmd_addr(dws, op, mem);
> -
> -	/*
> -	 * FIXME: The exact reason for this delay is not fully understood,
> -	 * but empirical testing shows it significantly improves the stability
> -	 * of read/write operations. Without this delay, occasional transfer
> -	 * errors or timeouts may occur under certain conditions.
> -	 * Keeping it as a safeguard based on practical validation.
> -	 */
> -	udelay(5);
> +	if (dws->dma_ops && dws->dma_ops->dma_enh_mem_init &&
> +	    dws->dma_ops->can_dma_enh_mem && op->data.nbytes > dws->fifo_len) {
> +		ret =3D dws->dma_ops->dma_enh_mem_init(ctlr->dev.parent, dws);
> +		if (ret) {
> +			dev_dbg(&ctlr->dev, "DMA enh mem init failed (%d)\n", ret);

This doesn't pay attention to the probe time detection of DMA, and
there's no probe time path for requesting the channels so we'll always
drop and request the channel.

> +	if (dws->dma_mapped) {
> +		dw_spi_enh_write_cmd_addr(dws, op, mem);
> =20
> -	/* Use timeout calculation from spi_transfer_wait() */
> -	ms =3D 8LL * MSEC_PER_SEC * (dws->rx_len ? dws->rx_len : dws->tx_len);
> -	do_div(ms, dws->current_freq);
> +		ret =3D dws->dma_ops->dma_enh_mem_transfer(mem, op);
> =20
> -	/*
> -	 * Increase it twice and add 200 ms tolerance, use
> -	 * predefined maximum in case of overflow.
> -	 */
> -	ms +=3D ms + 200;
> -	if (ms > UINT_MAX)
> -		ms =3D UINT_MAX;
> +		dws->dma_ops->dma_enh_mem_exit(dws);

Do we check for errors from the hardware anywhere?

> +static int dw_spi_dma_wait_tx_done(struct dw_spi *dws, u32 speed_hz)
>  {
>  	int retry =3D DW_SPI_WAIT_RETRIES;
>  	struct spi_delay delay;
> +	unsigned long ns, us;
>  	u32 nents;
> =20
> -	nents =3D dw_readl(dws, DW_SPI_TXFLR);
> -	delay.unit =3D SPI_DELAY_UNIT_SCK;
> -	delay.value =3D nents * dws->n_bytes * BITS_PER_BYTE;
> +	/* Account for the word that may still be in the shift register */
> +	nents =3D dw_readl(dws, DW_SPI_TXFLR) + 1;

This affects all DMA users and wasn't really explained, it should
probably be a separate patch.

> +static int dw_spi_enh_mem_dma_caps_init(struct dw_spi *dws)
> +{

> +static void dw_spi_enh_mem_dma_maxburst_init(struct dw_spi *dws)
> +{

These are very close to the non-enhanced versions, it would be better to
factor out the common bits.

> +static int dw_spi_enh_mem_dma_init_generic(struct device *dev, struct dw=
_spi *dws)
> +{
> +	int ret;
> +
> +	if (dws->tx_dir) {
> +		if (dws->txchan)
> +			return -EBUSY;

Surely if the driver already has a channel there's no error?

--7CCrzub0Penet8VL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq1Z6EACgkQJNaLcl1U
h9BTygf/Y89pFFSN6zhkrm8QC6M8gwZjgWPBuPYViYYlQfJ8y36BNwze5uZIpFfx
1+HUoZNcei0U0MyTVxYPRzg4PSCcOfVyCQ8wVhYrCdxBRnPp/AYYFovrFcTqfsMI
377Ge2vc2mbRxkuyf89b7mM6giMTn12//PFvGCiGzneFpzgvqrGVUFRgNbp6vdVn
nONrD9hUpI7RHhrNzUdnTFMsku99DL47UvpSlNkqWEEicQ82/weiV7+JDxzFeKG4
21KwJu7LQWkd4Kbd3wpav1CIJu9jqCjcwDmoNPhjIhOFgpxBFj8ByJf7gkZP7R76
T5UwTkOdmIp1uTJmADWTUYa6r5jAxQ==
=RZBn
-----END PGP SIGNATURE-----

--7CCrzub0Penet8VL--
