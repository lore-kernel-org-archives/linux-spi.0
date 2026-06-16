Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7BE37BE8B;
	Tue, 16 Jun 2026 14:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781620082; cv=none; b=Np4E4z6wWkrY+8tKKOvhGtTHSFSyXKSWyv+UBbtBzzo5IZHuRHrq+5jX1L9mwH3wnwJKKTeXb52Xd3jGsz0bH5/pK/N2OUEALbMm7QD1IVhFiS18X5Vwy98uK16fp/piXPkg+UWP5rymEe1OiTNJXHgeldHzY8nD1F6nMTmjWgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781620082; c=relaxed/simple;
	bh=b1eh0ZyTi0wcjMPK6djozgDnU7N84YMBSKDnWAkr20s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hd9dTqViwcuiHTY7VpottA+PDfLmwRcq+a6GgLzlojawi+SWxfpvcVNveGaV9jhp9gEjovqJbOHld5oH2PiJLeWFVyPfhWP1d5yw+b3kxTD4g+WewD5nUKcDAL1rlogjht5poidDZGBVVHLIMGqxN7uU+BM/+Bv/AZNxX+WF9HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pk0Mh7dC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pk0Mh7dC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487911F00A3A;
	Tue, 16 Jun 2026 14:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781620081;
	bh=/Zw+CYMsW5G4hMDT3Wt09Hv8QxRWWeA4f0rpTNEwYW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Pk0Mh7dC6aB623xNBd3KjyL4/E1oa2nr37COEa6zj8YmLsqBokJWY1ghV1ddvLKiO
	 ja/+r3j5SUrW4uglMxwu03YXoPYQKzxIA9+e2hsgxNpzjubrPp65g2P7Fs5zes84Sd
	 S0nTHf2GSz5G7cY91NvOQqc8VAcZxTbzCYpB3dMxng+KptgtVebh8LXERbOSlQqCtF
	 IrmvWPA/+jQ1Ny/RuN8WtIx5z6aU3GVU4yrmdAEfJ1MrNPsC3SjOA4huT+5l0qa8vQ
	 ZRtw+GDGelAZKchYvD/RBAAgHt94qfaekHsasp0i7Fgb/YIf3sOUSz/S9QDZqbDvap
	 TJNFYnIFtDYww==
Date: Tue, 16 Jun 2026 15:27:57 +0100
From: Mark Brown <broonie@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] spi: dw: use threaded interrupt and optimize the
 threaded ISR
Message-ID: <b1c1c0ad-f920-429c-a98d-9714be286700@sirena.org.uk>
References: <20260615044039.9750-1-jszhang@kernel.org>
 <20260615044039.9750-6-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fiWOAXj+iVHB9g2A"
Content-Disposition: inline
In-Reply-To: <20260615044039.9750-6-jszhang@kernel.org>
X-Cookie: Password:


--fiWOAXj+iVHB9g2A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 15, 2026 at 12:40:39PM +0800, Jisheng Zhang wrote:
> To avoid blocking for an excessive amount of time, eventually impacting
> on system responsiveness, hard interrupt handlers should finish
> executing in as little time as possible.

> +static irqreturn_t dw_spi_irq_thread_fn(int irq, void *dev_id)
>  {
> -	u16 irq_status = dw_readl(dws, DW_SPI_ISR);
> +	struct spi_controller *ctlr = dev_id;
> +	struct dw_spi *dws = spi_controller_get_devdata(ctlr);
> +	u16 irq_status = dw_readl(dws, DW_SPI_RISR);
> +	u32 rx, tx, imask, mask = 0;

> +	do {

> +		rx = dw_reader(dws);
> +		if (!dws->rx_len) {
> +			mask = DW_SPI_INT_MASK;
> +			spi_finalize_current_transfer(dws->ctlr);

It should actually be safe I think but it's not 100% clear from the code
that we can't take an additional trip through the loop and report the
same transfer finalized twice.

> +		/*
> +		 * Send data out if Tx FIFO Empty IRQ is received. The IRQ will be
> +		 * disabled after the data transmission is finished so not to
> +		 * have the TXE IRQ flood at the final stage of the transfer.
> +		 */
> +		if (irq_status & DW_SPI_INT_TXEI) {
> +			tx = dw_writer(dws);

This is the only place where tx gets initialised...

> +			if (!dws->tx_len)
> +				mask = DW_SPI_INT_TXEI;
> +		}
> +	} while (rx != 0 || tx != 0);

...but we read it on every run through the loop, so if there's no TX
interrupt we'll be buggy.

> +	ret = request_threaded_irq(dws->irq, dw_spi_irq, dw_spi_irq_thread_fn,
> +				   IRQF_SHARED, dev_name(dev), ctlr);
> +	if (ret < 0 && ret != -ENOTCONN) {
> +		dev_err(dev, "can not request IRQ\n");
> +		goto err_free_ctlr;
> +	}
> +

Do we need to adjust when we free the DMA resources as well?

--fiWOAXj+iVHB9g2A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoxXWwACgkQJNaLcl1U
h9DoIAf/Sx6jCLw+l6C1KbdXF4LgMBv6tkUWcyfwzYxkSMt3GjFPN1iN6HbwjBmn
ivfoe+GZkPiDHipYmElVmagr6/mrUadMFWpayugNWbEp2EakgjFMjQzJGX/yVh+N
YUtCwRfC7oVnhzYicxD5o3ToBDQHmF3o1LEwIJD6Ej9bj3I1VR4FvrK4G1v4VFa4
syBR5ThPEoPbEI8Hl/THr6S1yIMDoo+uDGOkgae3NJrTChCbe5op2GpDwWRfCy4d
mMiNihgjosCd0g/Ic/GcQZh3QTuv0JwabZSODY8yjWzxCKuVvEweqBlwN6LcL7e9
1pfJW6rZr6CK4nq9HtrSsvmpilDAww==
=SJHU
-----END PGP SIGNATURE-----

--fiWOAXj+iVHB9g2A--
