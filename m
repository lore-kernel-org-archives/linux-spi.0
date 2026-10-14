Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E102F309EF9;
	Wed, 14 Oct 2026 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982875; cv=none; b=DjYbLOLRDXNfj8rIBO+SFjTRLEpVYAkthjoA98xnUlU+nOZZJ/zLmJEEWFwtWe7ypDfRt4+lByFJ4quyDL+booss+ZFYAOAS7C/o9ReF3dL5oA7JcDmxlc0s5c03vqGVUP7jW9XD8TOKQCBie1byOnvxu1CMfhfS8EN8uvQ0S1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982875; c=relaxed/simple;
	bh=KblVDuTQeYbUES5nsnWY78N75QXn5LURXzxd616++nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tw9ROGnjWNFOEmrDbQ47ucS32FTHs5Tok083xfTaAeFqNHpTcm3LE8VoRvKLU81+I+5EqYPrLKCJecmFEJO0BTbf7FUYOQ72ywT5/vTnyD/1ekBZ4IcdwRdUA6OUaQzUYfwQyuUHMIbTVzCODQrbJ029vxsTJIYEI8vJk+rbzPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0Qg+IKq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0Qg+IKq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89081F000FF;
	Wed, 14 Oct 2026 13:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791982869;
	bh=KblVDuTQeYbUES5nsnWY78N75QXn5LURXzxd616++nQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R0Qg+IKqH6u0qWy2cRWMgkVRaAAeMvczDznDEAQJrKaBQUMbq3VEi6Fpa/Z6AQwSu
	 wtBP4XbKFX1Hts1f0aLZSAju+lojPcRY8FHec6YbkMfuAbdQ1BF3hXZhhsGSH2pak5
	 9O6+4f5FmBWdN/3kIVEjA+s3mh2kdnb+ica61TL24HcK7Ebj3gU3ljU2m4OVqVZECu
	 BPJV7BHcNDsvU6k1iv0FGNNY/OmdFYszJyxPK8CGoZ942QCKM9p1BCW8M15X8c21fj
	 U6cZ69eFw+VJbVuRi8gtfNHfXq8Q6xar0FYCHQzT3hA1/ndrU9B6WupnIjcjoGuKcu
	 kSedJwdXlG9Lg==
Date: Wed, 14 Oct 2026 14:01:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Sahaj Chaudhari <sahaj123.sc@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Grant Likely <grant.likely@secretlab.ca>,
	Linus Walleij <linusw@kernel.org>
Subject: Re: [PATCH v2] spi: omap2-mcspi: handle DMA setup failures
Message-ID: <eadae021-6d1f-4b40-a100-2d04503e5c1c@sirena.org.uk>
References: <20261014045617.2894886-1-sahaj123.sc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vjFsnozWQasCpqyJ"
Content-Disposition: inline
In-Reply-To: <20261014045617.2894886-1-sahaj123.sc@gmail.com>
X-Cookie: Live free or die.


--vjFsnozWQasCpqyJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 14, 2026 at 10:26:17AM +0530, Sahaj Chaudhari wrote:
> The DMA paths ignore failures from dmaengine_slave_config(), descriptor
> preparation and dmaengine_submit(), and carry FIXME comments about
> falling back to PIO. A failed setup can leave a half-started transfer
> or wait for a completion that never arrives.

This doesn't apply against current code (spi for-7.4), please check and
resend.

--vjFsnozWQasCpqyJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrPfRAACgkQJNaLcl1U
h9DgcAf/YNBmN9JuMH8TOhyF7NTQFuLFQ1Lwj0lSg8t8GUor5sOXkT6zADNlpn0k
cM/D8YwTFwdglPGVOjjcz9DvptvxRwNKdxpOMBLLYNOaGs6ooT8Kt9SvDfGi4aRM
gP209L1X+mM4zIc13r7sWrLMjt000iscKg2UO9G7m2Kcd8j3D7f+8bxyF2I9jq6G
HBKtP1Fb6BcMm7XVr+i25r9NWTI09oO3QMJs+/5meEQ3KjTOE+CizUsHcfsQDhjG
pQaZlyQohnnjMEvRUMaj6qfBlTC+eqZs9M+IM+Ga16bbq73hS1HBzT07ewavJZJD
+Jx+SpcyKIMrDJzOTXVxDqthy1U1tQ==
=nk6y
-----END PGP SIGNATURE-----

--vjFsnozWQasCpqyJ--
