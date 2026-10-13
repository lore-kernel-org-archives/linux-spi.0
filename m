Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E97351AEE2;
	Tue, 13 Oct 2026 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906027; cv=none; b=T9BTz72QLATTyOK2T/YmJpMaS5zSRFimjgICyzdfWDw4qiS02brSA2N5FDxJvZE47Cc08ttRKFFn8gmZUiLv8d00SDO3kLpzhMoBaWWTinyT3m0PKzYuIwYnAiAQXwl9Gz0Snc+xva60QcbPyUihKQpZg2D7F9mwcUEg1dbvkNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906027; c=relaxed/simple;
	bh=aePh6U74khONlchJMqoCW7bzUBKnKhlb8hEUHQbTKnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxPvRCKiX/9x8ZnTlZNR9RmlgnMpZ7DDPUrcR1Yo3h6qSsaWyBYKeggOsvMQYoCz7rg3+MHRjeFE36o/PWBo5p7V/3VBZ89CLKz7QACaDQd4f7THnjUTYtIf6MdLvSX8s3OelFlSHFIYCh47WRPwsht9DTRV+7pSWWMh982qXL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVUu7flc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVUu7flc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DED21F00898;
	Tue, 13 Oct 2026 15:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791906026;
	bh=NJfxrBBuE+qmr3EtyxVuFFbz+aCw8+gpkG0ib2QwahE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DVUu7flcNuGSas4GgqlFBqwDfapW7WYVrzgU2QBvOdMTKwVHiWl2zVe4pBXSFt3Vq
	 0DR2c8kulFhKYU/Pl8JJQLBYn0xc7c6nS3sClSGi2Q7zTqD2aoczDI/aodtY+Nmpf+
	 JC4P0lUJOq1NdQGRSf6Pcg3H4vdDvdtFpDH+BtDfkEy9nEPRUCZfO6AqvKzQTVgCS1
	 TfC3vREgH/t0tOJuCIgqY9nNU84bzcQHHmJ4Y1tb0CnsH9Sjx2BfIJfHtNJOkjc6SZ
	 64ygftEDo8SFqpS0Dnngitsu34Cjv2l6Rkd4/MamTY4yC44SAnv4CSO6c0t92eSTnI
	 g8ZRkXVyN8oTg==
Date: Tue, 13 Oct 2026 16:40:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Sahaj Chaudhari <sahaj123.sc@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: omap2-mcspi: handle DMA setup failures
Message-ID: <4a20222b-7d60-4763-9833-bc453d26ade8@sirena.org.uk>
References: <20261013142004.1729849-1-sahaj123.sc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8iTOAyz0EiYcRMdX"
Content-Disposition: inline
In-Reply-To: <20261013142004.1729849-1-sahaj123.sc@gmail.com>
X-Cookie: Some equipment shown is optional.


--8iTOAyz0EiYcRMdX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 07:50:04PM +0530, Sahaj Chaudhari wrote:
> The DMA paths ignore failures from dmaengine_slave_config(), descriptor
> preparation and dmaengine_submit(), and carry FIXME comments about
> falling back to PIO. A failed setup can leave a half-started transfer
> or wait for a completion that never arrives.

> @@ -1227,10 +1300,27 @@ static int omap2_mcspi_transfer_one(struct spi_co=
ntroller *ctlr,
>  					+ OMAP2_MCSPI_TX0);
> =20
>  		if ((mcspi_dma->dma_rx && mcspi_dma->dma_tx) &&
> -		    spi_xfer_is_dma_mapped(ctlr, spi, t))
> -			count =3D omap2_mcspi_txrx_dma(spi, t);
> -		else
> +		    spi_xfer_is_dma_mapped(ctlr, spi, t)) {
> +			ret =3D omap2_mcspi_txrx_dma(spi, t, &count,
> +						   &pio_fallback);
> +			if (ret) {
> +				bool is_target =3D spi_controller_is_target(ctlr);
> +				bool fallback;
> +
> +				fallback =3D omap2_mcspi_can_pio_fallback(pio_fallback, t,
> +									is_target);
> +				if (!fallback) {
> +					status =3D ret;
> +					goto out;
> +				}
> +
> +				dev_warn(&spi->dev,
> +					 "DMA setup failed, falling back to PIO\n");
> +				count =3D omap2_mcspi_txrx_pio(spi, t);

Do we need to turn off the FIFO here before doing PIO? =20

> +			}
> +		} else {
>  			count =3D omap2_mcspi_txrx_pio(spi, t);
> +		}
> =20
>  		if (count !=3D t->len) {
>  			status =3D -EIO;
> @@ -1246,8 +1336,12 @@ static int omap2_mcspi_transfer_one(struct spi_con=
troller *ctlr,
>  out:
>  	/* Restore defaults if they were overriden */
>  	if (par_override) {
> +		int restore_status;
> +
>  		par_override =3D 0;
> -		status =3D omap2_mcspi_setup_transfer(spi, NULL);
> +		restore_status =3D omap2_mcspi_setup_transfer(spi, NULL);
> +		if (!status)
> +			status =3D restore_status;
>  	}
> =20
>  	omap2_mcspi_set_enable(spi, 0);
> --=20
> 2.43.0
>=20

--8iTOAyz0EiYcRMdX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrOUOUACgkQJNaLcl1U
h9CflAf9FxnOkGW3I+4O6FGCNKhHWwZvviAk4+Owdo7QhfwRyFjEjpmXpT+5MPnw
VFzLl9xNzw1dN/sQ0kV06es5pdgcobY9Bh+pKPHhDJZQVnLtgx2xJlf1YMMfasQc
x28CA5WwC6A5mOg+3ul/urrqRorum79xSh4Qqjydyy0Hp4f9eXF80q8rzeAJT1/g
o470mtVZZZAty7aaMaFWJ+5+6Aka4zAQt83e2T1lJ8C11NfNAjz4Cgqjs02JyOF6
KJOPK3kw+aJt9VUwyYZGKJEwgGjchcMeAmwQov7xdL+vo0BWyTWaRivcOShadEo9
pGSx8FakDQ9oAlDzuo7APBY94g6dXg==
=HfFf
-----END PGP SIGNATURE-----

--8iTOAyz0EiYcRMdX--
