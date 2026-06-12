Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B299C39182A;
	Fri, 12 Jun 2026 15:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781278188; cv=none; b=C4TcJAGgbuPeChmwxR6qezd6Qp0CAlk1sIXA6uoxq1T2zmUuxGWaaaUayvzV3yk3O1QnNJKDfWMeRu9YP01CMiVi7Niq00/pp/hbjaUpFHGSY1snapOzozvbTmNFuG1G9I0BnYhviMmbMp/otBCVxVfDvftecOMj1Sr9nsdtEcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781278188; c=relaxed/simple;
	bh=RVo4op1tZeRdt9h1HL3gna0rrZjO4YknO+7wZdF3Rpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/yI6hK9wJj2fkqUNQO0iWuZvb1CN4obQwGWwdV1btQETBvZe7OddhUmjx8upzZP5Y3RTCU59OUf13AbhtFOHNjnd9E2zgMkubScOFJ8iP3yatzm0PEQ7X1d/VPS6+SyM9c/kRyqcyUikpmVsMHCeXobkpztz+I5jrzTiu176II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A571F00A3A;
	Fri, 12 Jun 2026 15:29:47 +0000 (UTC)
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 936ED1AC5AC2; Fri, 12 Jun 2026 16:29:42 +0100 (BST)
Date: Fri, 12 Jun 2026 16:29:42 +0100
From: Mark Brown <broonie@debian.org>
To: Vishwaroop A <va@nvidia.com>
Cc: Thierry Reding <thierry.reding@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Breno Leitao <leitao@debian.org>,
	Suresh Mangipudi <smangipudi@nvidia.com>,
	Krishna Yarlagadda <kyarlagadda@nvidia.com>,
	linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] spi: tegra210-quad: Convert to hard IRQ with
 high-priority workqueue
Message-ID: <aiwl5ggiRVGHWSpR@sirena.co.uk>
References: <cover.1781037385.git.va@nvidia.com>
 <552afd84ee31c9e475ed1344ea9349af01eacfa1.1781037385.git.va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZQQIHIagp5Ti8+th"
Content-Disposition: inline
In-Reply-To: <552afd84ee31c9e475ed1344ea9349af01eacfa1.1781037385.git.va@nvidia.com>
X-Cookie: Nice guys get sick.


--ZQQIHIagp5Ti8+th
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 06:24:00AM +0000, Vishwaroop A wrote:

> @@ -1506,6 +1508,19 @@ static irqreturn_t handle_dma_based_xfer(struct te=
gra_qspi *tqspi)
>  	long wait_status;
>  	int num_errors =3D 0;
> =20
> +	/*
> +	 * Snapshot curr_xfer under the lock before the (potentially long)
> +	 * DMA waits below. The timeout path can clear tqspi->curr_xfer
> +	 * concurrently; using the local copy keeps the subsequent dma_unmap
> +	 * and FIFO-drain steps consistent with the transfer that actually
> +	 * started, and lets us bail safely if cleanup already happened.
> +	 */
> +	spin_lock_irqsave(&tqspi->lock, flags);
> +	t =3D tqspi->curr_xfer;
> +	spin_unlock_irqrestore(&tqspi->lock, flags);
> +	if (!t)
> +		return IRQ_HANDLED;
> +
>  	if (tqspi->cur_direction & DATA_DIR_TX) {
>  		if (tqspi->tx_status) {
>  			if (tqspi->tx_dma_chan)

This can be called from both tegra_qspi_work_handler() and
tegra_qspi_handle_timeout() - I can't see what stops them both handling
and completing the same transfer simultaneously?

> +static void tegra_qspi_work_handler(struct work_struct *work)
>  {
> -	struct tegra_qspi *tqspi =3D context_data;

> +	 * Check if the timeout handler already processed this transfer.
> +	 * Can happen if the workqueue was delayed and the timeout fired
> +	 * first. In that case there is nothing to do: tegra_qspi_start_
> +	 * {cpu,dma}_based_transfer() at the start of the next transfer
> +	 * (or the next message) re-enables interrupts.
>  	 */
> -	spin_lock_irqsave(&tqspi->lock, flags);
>  	if (!tqspi->curr_xfer) {
>  		spin_unlock_irqrestore(&tqspi->lock, flags);
> -		/* Spurious interrupt - transfer not ready */
> -		if (!(status & QSPI_RDY))
> -			return IRQ_NONE;
> -		/* Real interrupt, already handled by timeout path */
> -		return IRQ_HANDLED;
> +		return;
>  	}

Can't the timeout handler also be running at the same time as this
rather than already having handled things?

--ZQQIHIagp5Ti8+th
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmosJeUACgkQJNaLcl1U
h9Ab3wf+IDvsbdEuyWsqrnWX3c9fiyMb/lV/L4MP5nTrjZP9sKhxdC2IGkqgM6sa
1D7v0vYmIaWwozg2uSqfrap2ks2YZFy+CbnKtzdvcneIpPdIT0sZ5l1kIzfAIKhh
XlKZz8N0uuMBcObTi82av4UDUN6FElrCdbmQ1HcHiD5oJ3TpgAn9PnfM1MC0W2HA
L8EFCdru/hPut+BTD5808P7Q15vrqDQk+Yv15JwA1oMembkH7d36b9+68D/YIhmI
no2Xyh7WPY1MhiiAwFaNI40D1HlqFvmh4PhMBD+DupzC1iRqeoDGCoigmvosKYzM
2IdB1kQu+sCBsO0+FSsCu4TdANfhow==
=BY/3
-----END PGP SIGNATURE-----

--ZQQIHIagp5Ti8+th--
