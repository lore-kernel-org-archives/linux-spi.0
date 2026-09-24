Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3483DE450;
	Thu, 24 Sep 2026 18:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790272949; cv=none; b=bqlaSYa+PS7HAv4jKw1tFCPslG7ZYoa4tlcsJF/qNAZX3/ofdvzo3stxZt+P6+5hQF3f3RpriPu/wx8U/JX0RltcjHaKUl+WRligQ255jFoM7XSAFMQBtQnOpUQnokhVHRHaYNmJNJZankx3LF6xivQaQozcBRkomMqxXwp/ZdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790272949; c=relaxed/simple;
	bh=AZGoHTeTNDMkQadnKB7dfXyJXbKwG3HyJJJgZx1Sglk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNPiWhxRNo5Zj7wOxFwaZJxaitBFgOi5vOrqMylLJ61I5nK7kdj/umxjocBc9pnVMQuw90zRvNRwnM1BkMJyFDwk09L7NJvF8jZcrL57Ogu2pKMr9p7li0e53JiOOUqEZ7YlQPuJn1V/5c1mvWmLHjJGcHDRzcoLUkKizPSD+6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kf1WS8ya; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kf1WS8ya"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CE61F000FF;
	Thu, 24 Sep 2026 18:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790272947;
	bh=YA0J79tad2IBUY1yBO/VfFPFz3wKbQS6yL6NKWIQSe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Kf1WS8yaONAJBrSoiagUl8fGmXcfKQjgzQsXjpAgZzJHtAuL1P5Y+G4b07aYjrPeB
	 87vGqOr9BaFV7iv+z1WTGLHkepaq20wH7EqfqftXOrs3hyMJbowiXb8QjA54VQuzAw
	 uGj3P769fAxCshoOZUjy9BIH023X5FgCk0CPJueP6NNNdNGMhJorS5l3vgXRftZe2O
	 jI5rIxe8VggrC9xmaX8+Zo95V8BiZX+JW4ZC7t6EatMpdZt8qeuTB+uXHTK6UOo3Ub
	 cnxsU5wik8RLjZa261wYxzli0+BErwkz9Y/1plNB6ocJGGF3IGCil/7dTx1J7ldeEa
	 4oRdyYxnGIHDA==
Date: Thu, 24 Sep 2026 19:02:23 +0100
From: Mark Brown <broonie@kernel.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Serge Semin <fancer.lancer@gmail.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] spi: dw: Request DMA channels at runtime instead
 of probe
Message-ID: <4688e732-0fab-4e23-9d3c-e0326b3bd65e@sirena.org.uk>
References: <20260923095705.233297-1-changhuang.liang@starfivetech.com>
 <20260923095705.233297-2-changhuang.liang@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QXquaRQuIuUTfBi1"
Content-Disposition: inline
In-Reply-To: <20260923095705.233297-2-changhuang.liang@starfivetech.com>
X-Cookie: Oh, so there you are!


--QXquaRQuIuUTfBi1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 23, 2026 at 02:57:04AM -0700, Changhuang Liang wrote:
> The DW SPI controller requests its DMA channels in
> dw_spi_add_controller(), which ties them up for the entire lifetime of
> the controller. Even a controller that is only ever used for standard
> SPI transfers and never for enhanced SPI transfers holds the channels
> exclusively from probe onwards, preventing them from being shared with
> other users.

> +static int dw_spi_prepare_hardware(struct spi_controller *ctlr)
> +{
> +	struct dw_spi *dws = spi_controller_get_devdata(ctlr);
> +	int ret;
> +
> +	if (!ctlr->can_dma)
> +		return 0;
> +
> +	ret = dws->dma_ops->dma_init(ctlr->dev.parent, dws);
> +	if (ret) {
> +		/*
> +		 * DMA is optional: fall back to the PIO/IRQ path instead of
> +		 * failing the message. Use dev_dbg() since this may happen
> +		 * on every prepare.
> +		 */
> +		dev_dbg(&ctlr->dev, "DMA init failed (%d), using PIO\n", ret);
> +
> +		return 0;
> +	}
> +
> +	return 0;
> +}

This seems like a lot of overhead for every existing controller with
DMA, we'll have to go through the request/release cycle whenever DMA
gets used which feels like a bunch of overhead for a hot path -
especially in the fast path in spi_sync().  If some platforms need it
they should be able to opt into it rather than forcing it on every
single platform.

> +static int dw_spi_unprepare_hardware(struct spi_controller *ctlr)
> +{

Adding this also causes overhead since we do the unprepare in the
thread.

--QXquaRQuIuUTfBi1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq1Za4ACgkQJNaLcl1U
h9Aytwf/XEi0d3qudaZSUOkvXzZdpza6mIsitOh5B5MXes9ITVxlL4S6PTtZP4v7
DFSgvNqEtkj34FbqBhyvgXmFXgVGBVnUjuj2fs0YjAAe13toAVDZXUq451cRJ0Ys
wtzuuV52K0tTCMegWS4nGTp+T87tha+6wSNZd4om/pyjhUx6WOQR8WBMaX79lbgx
Bm+D2VrsbGgBjFUbfhHfri0tzlETgud5zKD7stcECCzfkooJnBTv/HKLQ9DQPl0H
vRdHBvXWJW1TtaHM7jYe22RaYBkTKjN+XVCuNRUpD17eUEtGEb8uWjGXTQ2xrEN3
E+iEcb6zoEv5/iuyzUs37jOjIGpsEQ==
=71SQ
-----END PGP SIGNATURE-----

--QXquaRQuIuUTfBi1--
