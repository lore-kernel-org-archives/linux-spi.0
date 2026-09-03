Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851EC4FC8F4;
	Thu,  3 Sep 2026 17:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788458124; cv=none; b=QO9Lh26N3AD4tf/WEGqjKrw0y4m6GAQSTSDRvgyxygTVPkvbliu3vVNHwKrPgGuI4Z3WopwitlOQMXzIaRbMuTi4eBQGftABWJL9OiNzsLE4ZEgM6nkDJhWcwQErgOb08l8NhPdlrIyNGr+9wbz39BzrWc+Dod4RYHG9YgmVjZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788458124; c=relaxed/simple;
	bh=LOAtcg1KYF6lB41X99rB06UgRQwziM+xiJEqeXODtIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8nCK6MD4rU1xBnq68jAQoLcM+3duTK+dzdDrPEQ7WH2mzIJ8YOlq+ToT64OFC4fuayeq8wYRBGPrLWA7FG+PR4bJUKVTOYCEl3tnVoCX5nk6FQceMcBqNovvJ4qszHNA2CloIKMOD3wg7QPOCmDX+g6Oqs9MllXfj+F6oflpuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEiKGBsW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEiKGBsW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EADC1F000E9;
	Thu,  3 Sep 2026 17:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788458123;
	bh=yICCSCAcuhUA36xxNq/ZPvJoy+98fuFhMbUfdfYXPZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KEiKGBsW537Fthl1v2Ev8tkuQozXOYG7WJ836vf7cXsrIw4eWQAb9/onhsCEObdVf
	 TxF9pg4hCu2hWgfdCqPJ3TtY/P90NqJ/C9lJbuLVNaBHmxk+qyVAPp2wIqTFj5HQsg
	 C9r81wFVSuYj+GBJ2Bfb10+tpp8HSFjOj7e8A0mh//H6tb0Dl8Za9WxnFTmlHbVZnw
	 e/0lUTKbhAu0EwEDKc5bO9CppqVoRuf4W5yR44O9S9liXH0m2/9WxaOqtkyQWKs9NE
	 keFpMKTXCZ3dOVwIEDngMLftUymk4T4zHzpwfo3kJzhKbbYq2Z606EunE8tf3uo1o1
	 0iI1s57ftR+Fw==
Date: Thu, 3 Sep 2026 18:55:18 +0100
From: Mark Brown <broonie@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com,
	michael.hennerich@analog.com, jonath4nns@gmail.com,
	andriy.shevchenko@intel.com,
	Dennis Heinzel <dennis.heinzel@irs.systems>
Subject: Re: [PATCH] spi: axi-spi-engine: fix stale SYNC IRQ pending
Message-ID: <75a27e3d-ea3d-42ce-b4c3-920c71e9c8b1@sirena.org.uk>
References: <04d51e99b8cddce51113db933d806e83848f04f5.1788313558.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nXJfhlQ63sdcYu2d"
Content-Disposition: inline
In-Reply-To: <04d51e99b8cddce51113db933d806e83848f04f5.1788313558.git.Jonathan.Santos@analog.com>
X-Cookie: Surprise due today.  Also the rent.


--nXJfhlQ63sdcYu2d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 03, 2026 at 10:49:22AM -0300, Jonathan Santos wrote:
> spi_engine_setup() sends a SYNC(1) command and polls SYNC_ID to confirm
> it was parsed by the FPGA, but never clears the corresponding interrupt
> pending bit (INT_PENDING[SYNC]). When the first real SPI transfer starts

> +	/* Clear the stale SYNC pending bit so it doesn't fire when the IRQ is later enabled */
> +	writel_relaxed(SPI_ENGINE_INT_SYNC, spi_engine->base + SPI_ENGINE_REG_INT_PENDING);

Is there something later which posts the write?

--nXJfhlQ63sdcYu2d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqZtIYACgkQJNaLcl1U
h9B2lwf/W4FCGdTWNLk+AxmWzoVGMTk7X22pM37OP7oYHfFaFhl1aQpwoE53z7Fd
KzssTRivULoatDC5vEOJcAFrsdhQtKziH88HDC3BKT969T9kYdJ0DqP8clpYL/QD
R/iuoXZFxQthgUQrj1kErv/1Isos2MzsVIUZa0r5PYlNxtJc+IAauWTEhwRc2Iv3
1Il3FZm4WYZcfTsUmsT/uZfFof1rwEG0MT3Gmw7nA4hT/hsxZmf0V1z4jwqfL4/r
d7tWItGDEM5JRIz08MhPCMoQ02C436TCY0xUVxtdgXTSK/e6TJylpFGhsxXJJb9P
5ORjA+ghpyPgzudLkNEqSxwZwQ85DQ==
=Yiql
-----END PGP SIGNATURE-----

--nXJfhlQ63sdcYu2d--
