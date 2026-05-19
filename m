Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358A33403F4;
	Tue, 19 May 2026 13:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198520; cv=none; b=cJg65ELbzyKB9W7HUd32BFQqeFht+Cal+G760IRebkiELBDJrFlFl6yTYdRE6cEYpFvLnXqtT5UsogA0WZWWsSyBl/19UJOMLIQDFJnX23gilkuV4ulLv4JDYt3+NL0CMCrlZrVTD8FQip5K3Yabm8hbaHpOQh0KgB+YMWO5Mj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198520; c=relaxed/simple;
	bh=FVOuV8wf9sDM1YaPL2xSfJNpfl3qVq5yw5xsV8IJn6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qF9l1NgchaMVWIxlr87iPWZVfk4SLN/WszGDnA+JBNB+00rT/fljuwM96Se0zSOujrvizrxBC/IFx+vY8FEGhkN2/u/CKXAxJj90P7pjMLeYNsO9xsX8qmuBAX2uTf+/DauPLlSOvPWXDHwQjm1Cwb9rUoQ776KblfpMNdah+lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKwfVucY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKwfVucY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097D7C2BCB3;
	Tue, 19 May 2026 13:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779198520;
	bh=FVOuV8wf9sDM1YaPL2xSfJNpfl3qVq5yw5xsV8IJn6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UKwfVucYoqBDygenr8Akgjc5r7KOUdujiqdNYti/LwjOIL1htVXoi+pWK3qloDJ1t
	 ON9Ux+efzXO3pELn8xOxlH0ZCCwgo2+ieZJk/p7fhqZLVpWvIHwGIeUtdo0hpvuzy2
	 54Qjcf1mSysaQwRk6JP90HhbX2pS/4KCHgwqJaqirGO/CdfTsvIxDD0ePBpUcGBVkv
	 OWj1dtZSx9X2QJGLES/pqx4hwuIg4s4XTUQMDigmZ5IlDxqh1m4OHcmW8eA/v7JrcL
	 SKqsyKhnVd57Cuj+4bF2rOSgYmjmfG5G25Hd3OY/LuPKG8uB2Ya+9FRBZjyq7ODPVg
	 KJcQRCjKh/DEw==
Date: Tue, 19 May 2026 14:48:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Ryan Wanner <ryan.wanner@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Radu Pirea <radu.pirea@microchip.com>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Wenyou Yang <wenyou.yang@atmel.com>, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spi: atmel: fix DMA channel and bounce buffer leaks
Message-ID: <b6f36521-a33f-4a2a-8018-d95b890e2147@sirena.org.uk>
References: <20260517-atmel-v2-1-36c836be6345@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="USxQfCqMN9ynMD/J"
Content-Disposition: inline
In-Reply-To: <20260517-atmel-v2-1-36c836be6345@gmail.com>
X-Cookie: <<<<< EVACUATION ROUTE <<<<<


--USxQfCqMN9ynMD/J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 17, 2026 at 06:39:54PM +0800, Felix Gu wrote:

> Changes in v2:
> - Switch to devm-managed variants to fix Claudiu Beznea's comment.

The switch to devm is possibly a bit enthusiastic.

> -	host->dma_tx = dma_request_chan(dev, "tx");
> +	host->dma_tx = devm_dma_request_chan(dev, "tx");
>  	if (IS_ERR(host->dma_tx)) {

> -	host->dma_rx = dma_request_chan(dev, "rx");
> +	host->dma_rx = devm_dma_request_chan(dev, "rx");
>  	if (IS_ERR(host->dma_rx)) {
>  		err = PTR_ERR(host->dma_rx);
>  		/*
> @@ -580,12 +581,27 @@ static int atmel_spi_configure_dma(struct spi_controller *host,
>  		 * requested tx channel.
>  		 */
>  		dev_dbg(dev, "No RX DMA channel, DMA is disabled\n");
> -		goto error;
> +		host->dma_rx = NULL;
> +		return err;
>  	}

If the rx allocation fails then instead of jumping to cleanup we'll
return, and since the driver supports PIO operation it'll still be able
to probe...

> -error:
> -	if (!IS_ERR(host->dma_rx))
> -		dma_release_channel(host->dma_rx);
> -	if (!IS_ERR(host->dma_tx))
> -		dma_release_channel(host->dma_tx);

...with the tx DMA channel still allocated.  This is very much an edge
case though, how much it matters is very questionalble.

--USxQfCqMN9ynMD/J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoMajIACgkQJNaLcl1U
h9CmEgf/QakNzbInpiu4NTqeeVvIoWpIy5d3bZjZxD4S3uYpZjqCFqFGwEaVhp6q
OuLIqkR8yMPbb6TSSSfuysRodTqRwCnKcumkMjAIWkGavZHTSkD7G2REk1hMyPhz
gxWJjR0cOdHivysmKvBYjTaeIV+rDaFR7ygCwYXaX/9wFoB/IFJ7rESApmGT/NcM
kkJWwDtUfh9b4V5hax+S5t2du00PLeuJK3+utumG8MW7IsRpK4F5XLik/0T6kM4l
I5R0TlN5a0beK6JNfA5ui/EhFbDSkthanKVQdjyyh128r6tZzx9u/4/BRN9kqyrq
oGfifMIztXUNb4iZcaIAGKwsFO2zfw==
=kR06
-----END PGP SIGNATURE-----

--USxQfCqMN9ynMD/J--
