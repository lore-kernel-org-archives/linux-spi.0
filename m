Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC443B1B3;
	Wed, 29 Apr 2026 02:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777428452; cv=none; b=H0Laj2t4zMBro7/6Rwmf17ajcl+6auDGwIyxvjeikniDR5yiaNDNTJ76Fh1Uf7aZ5r9kEtbyqKAOJ90D3F/ZC/RuOEENznR0VrrvadvXRtzUePhYCjVwL5zsSzvAAgEXcuY0MHYHZe//BMxYcRqyBFIEv1GwTWPceceO6QCd+Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777428452; c=relaxed/simple;
	bh=2Q7QJmrzfUIV3u6Q2zRjAHkmQNZQ8sJEgfn9JuqHxgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPYe04BMg7UbLZ/7aT6esO64dEJse6NwIl33dJuf1R4O+w6nbgBT1RX7bIWDr0537il5I/WphtzbzmmSluvcxsNFL5UACzg79Mdc2CPfuv3ALlDZtSuOHnje17KJCvi2DFJpL1yQnSG/rRSwRdcZFr3Tr14hsIH7g9LZ/4tAbTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhPYOZIQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhPYOZIQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3E0C2BCB7;
	Wed, 29 Apr 2026 02:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777428452;
	bh=2Q7QJmrzfUIV3u6Q2zRjAHkmQNZQ8sJEgfn9JuqHxgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lhPYOZIQAnuZtUFkLvJrZ7l+TPAXd2qjCLVO9KP2r/PXHAFC26WmyAbtAtk75WWQs
	 9Dxtp2yJ22noHN0fbOf8OkzxyxpnfGzG7JOwdi/JJcByAsYYJt6KgDE6EkTd0+cKCu
	 q8TpzhJDscvnZ1ODOhQ6X33U5hGwrfJrG73h/nmpNExRSHz3WF3mnAysVN73z46Lhh
	 bf/e5l9QcivI6Z9ari4t2W1CGVsWM9y+gAUja+cxwHJTGRMqX19aHpjuoHBjHmdeBg
	 B36O5o3+3+5pngIpfpRsnON56vcKy/3s0tx5NhzRV6TA2BHwW5JtLIq6XVyns7XIMQ
	 ejAH54h+jggkQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 0BC121AC584A; Wed, 29 Apr 2026 03:07:29 +0100 (BST)
Date: Wed, 29 Apr 2026 11:07:29 +0900
From: Mark Brown <broonie@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Cyril Jean <cyril.jean@microchip.com>,
	Valentina.FernandezAlanis@microchip.com,
	linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] spi: microchip-core-qspi: control built-in cs
 manually
Message-ID: <afFn4dAm3QTzzsAl@sirena.co.uk>
References: <20260428-plexiglas-smith-6ae4e9ba8abd@spud>
 <20260428-perceive-kettle-d42b33eb62bc@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6VbyOw/cB43uFUpm"
Content-Disposition: inline
In-Reply-To: <20260428-perceive-kettle-d42b33eb62bc@spud>
X-Cookie: 667:


--6VbyOw/cB43uFUpm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 28, 2026 at 05:12:05PM +0100, Conor Dooley wrote:

> +static void mchp_coreqspi_set_cs(struct spi_device *spi, bool enable)
> +{
> +	struct mchp_coreqspi *qspi = spi_controller_get_devdata(spi->controller);
> +	u32 val;
> +
> +	val = readl(qspi->regs + REG_DIRECT_ACCESS);
> +
> +	val &= ~BIT(1);
> +	if (spi->mode & SPI_CS_HIGH)

The core already has handling for SPI_CS_HIGH, you shouldn't need to do
it in your driver.

--6VbyOw/cB43uFUpm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnxZ+AACgkQJNaLcl1U
h9BMkgf4rRJKK0zLNNtQw9r3kGLLSH3POxNR2BF05mdDucmpDiazwWYzPjHPW19c
VGVyV8GO+x2SjLk56XWUqxk4k0KmMfstb6J6LAz0VEc21KVq24iX9LtUYADtOoUL
ilgtlJ4BMIY8Kj9X5rii4bI9YGUzfQIyEbe3DXKTzXVqx4HJVuhHjjsvmJNgxoZy
d0HWsup0k47uP2MzQTuUgRgZ8Sx0VopoJ6KZdbNS3zQv4+CpCEQzwVtN39UP4gcf
XyJMDWXLFGZLQM+ytda+LiMobyFh0FFxIpdJ+agFTyqLc8bhidiaGd7yi2HuoAo+
M94znkBDEaeqAZLm7Oq6LpkYC3sw
=txPY
-----END PGP SIGNATURE-----

--6VbyOw/cB43uFUpm--
