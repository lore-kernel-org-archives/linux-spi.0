Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6434189DD;
	Mon, 20 Jul 2026 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784551127; cv=none; b=iwON7ym9jA7C1e1w/BjOLSuS0S8whUgicafcUXnJUB972FAGumoeFdPaFyhPictBO6/bI/nzde4hfTGZCz4o10NWVqmaqcq6JtuKEMrTM5XRmkHf0B6ug3MiGCFC3pCFEsEJoSbO25OP6TV5TRaquz1+qowzXrkwE6EkJZd1IiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784551127; c=relaxed/simple;
	bh=gpraWzl+KBhJuF4Pr5iLBP62bHahz3U+iuVW8QR8rHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUqlQewENUBjYuPiEeXZ21FwO85AcwfhJiMQQi2orjeUJBrldO4hMsej/hqgz0WWkMHDQdtKLMmRttInAHGLHh9Q+S/GgCDQLbLl8s8c23U0FiPSs2YbbrCLBNDz7BsGzVw6VNSwKsQPlBcKroGa6tDT6bUnGCDhw/L55JI969E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOmCo9/S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOmCo9/S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4839B1F000E9;
	Mon, 20 Jul 2026 12:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784551126;
	bh=puWnvjp6wSk1q46K8nji4rctf4uyq7uNKixfsrYJ+NQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hOmCo9/S98zhdZolb+dOly/vpmxdDY40Y+pLG1VGbWH2SW81jNl8e3l8pxv+wkNY0
	 kSES3jXofzBsMK8n0By0gBjMOJsn87+Hb0kJsFhLKjp4Qg3pnVFQ7M5YStxqfzPhp4
	 OPtIymsXYVRe+SptYdqlqG0o6sECpdtbAi2Too4tj+bTW8+7hMfIuydYK9FWYCzeat
	 iG/Td1HFvSrAzpe/cveixfMUAqaHon6z7Igp1CoC5uRfDs7ZI03zw1bMfjtarhyS6b
	 ODxnTqYuEkaCH9R1cttOOhgZtEvyaCbiUJVUaOVOI3HE6sdG57ONLmVOo2cF22x0Ie
	 LSdcNbsv0PgEQ==
Date: Mon, 20 Jul 2026 13:38:42 +0100
From: Mark Brown <broonie@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-spi@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] spi: ppc4xx: devm-ify probe and drop manual resource
 management
Message-ID: <de9cad84-76fb-41fa-9696-68c049bde497@sirena.org.uk>
References: <20260720003043.1536358-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7rABsF4Rq4Co8Zaf"
Content-Disposition: inline
In-Reply-To: <20260720003043.1536358-1-rosenp@gmail.com>
X-Cookie: Caution: Keep out of reach of children.


--7rABsF4Rq4Co8Zaf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 19, 2026 at 05:30:43PM -0700, Rosen Penev wrote:
> Replace open-coded resource handling with devm helpers:

> -	ret = of_address_to_resource(np, 0, &resource);
> -	if (ret) {
> -		dev_err(dev, "error while parsing device node resource\n");
> -		goto free_host;
> -	}
> -	hw->mapbase = resource.start;
> -	hw->mapsize = resource_size(&resource);
> -
> -	/* Sanity check */
> -	if (hw->mapsize < sizeof(struct spi_ppc4xx_regs)) {
> -		dev_err(dev, "too small to map registers\n");
> -		ret = -EINVAL;
> -		goto free_host;
> -	}
> -

The size validation gets lost here.  Not sure that really matters, but
it wasn't mentioned in the changelog.

> +	ret = devm_request_irq(&op->dev, hw->irqnum, spi_ppc4xx_int,
> +			  0, "spi_ppc4xx_of", hw);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "unable to allocate interrupt\n");

devm_request_irq() has it's own logging so we don't need to duplicate.

--7rABsF4Rq4Co8Zaf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpeFtEACgkQJNaLcl1U
h9DpbAf/SvHjC8cPmLOHNIra/KE48U+uGdIlbovzgB1EotGlk6MCIFK+TuVVjvI0
flBLCNewl5Pwjz0SS0xz2p58HYaQ8CmHsq24+rhWxtMNnf1uMzhttivPlrNbGr5Q
lhH3X3IJjN/H8xf+GSx1+a5enjlgfOzsjBdpUKW/uQyGHDbEmRtmBP2KtPuFP7zF
myTwl3oAGDv8w/XcUFHP71RzjurlR/BBeejk1cvzVG+TIsDXSLgBZXoN+Ic4EjHM
6vkedln6i9z7B4RtFi7+aZ3z5EoqGm6hvvklUcpBCqknhreOJuGE1LHDUWjHNmgr
XVJBgrf/nHDaWaso4IUz/mezCF2VrQ==
=tN28
-----END PGP SIGNATURE-----

--7rABsF4Rq4Co8Zaf--
