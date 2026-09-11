Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4234125A321;
	Fri, 11 Sep 2026 18:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152487; cv=none; b=uxk6UrOkbpvHlchB7v4jxm+XhxvnhTMIxVswYn1e23Vbro+VkxEQiCZorI0o2d/sgG5NqT/D0Hf4NsKW9oibkoNO9d6m9a+msrPmictoRGSqM/fKHPpnngxIdG9jjnCjR1Ibv3U4FUZjv3J/gDorQ84oCxUIlxLrmdsG6RqSf/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152487; c=relaxed/simple;
	bh=CdtGzejQ3/70IhLqCvcDyaWYYJHJ6dcyLSsxPfaE0SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oezdrqb6k23C+X8Zi7AMMzWkjiOd4UwLie1/LlsxbVbs2piBc+AXd0AdBFHTY7A5NZLoHqa3zoMOucOTUbc8mLUWlDOjfUEC9iRK6fmj+EtVLGS04y8Fst6EQpWYrNlDhQ2AwCCwl7lvPqMT/TsJ/0KuLu7zn/eKlATMeEiBOOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxhUj3uR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxhUj3uR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF981F000FF;
	Fri, 11 Sep 2026 18:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152485;
	bh=9ajwAaY0cVsvSHCyTqIKZnd53jar7upwfZE55GX+kls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NxhUj3uRiZdCUVnfy9OJ6JxZSwXTLbC2JDs2SOawDDUst15bOPObpauIjTa4/lYez
	 B2q/sRDfkck9M3N9IDoieUVemUV7eFXoyAZy8RRe5XD7vHLydhRCAb009rmiUlJRkP
	 2U/g9JZX05It1GjaJj3gNnMIxz7B5IkAOTjIn5QumtQDQDQroFA0maitbO2TjL8Haj
	 2TVt5zM1L6/P2aYau3PZzL1Mcbq4Akaz3GJtFm2kcSxWXjLtSkvjmpx4l2C9RwnwMd
	 9K+8X0o6DpC+LjytkD0lU3ZjnpkNkSDVkl5HNOtWyziqf4nw6L+dpGSXNEznk+Elep
	 XKjkkSjOf4dEw==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id 6213ADAB022; Fri, 11 Sep 2026 19:47:51 +0100 (BST)
Date: Fri, 11 Sep 2026 19:47:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] spi: rockchip-sfc: skip DMA cleanup in PIO mode
Message-ID: <aqRM17TZ0-5pd6Y0@sirena.org.uk>
References: <20260911172701.58177-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yXCBlsD+8N8P77Ma"
Content-Disposition: inline
In-Reply-To: <20260911172701.58177-1-mhun512@gmail.com>
X-Cookie: Orders subject to approval.


--yXCBlsD+8N8P77Ma
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 11, 2026 at 01:27:01PM -0400, Myeonghun Pak wrote:
> With rockchip,sfc-no-dma, probe skips allocating and mapping the transfer
> buffer. However, controller registration failure and driver removal still
> call dma_unmap_single() for that nonexistent mapping.

>  err_register:
> +	if (!sfc->use_dma)
> +		goto err_dma;
>  	dma_unmap_single(dev, sfc->dma_buffer, sfc->max_iosize,
>  			 DMA_BIDIRECTIONAL);

Rather than adding use of goto to skip aroud within the cleanup here you
could guard the calls that need guarding with if statements, that would
look a lot less scary than jumping around like this.

--yXCBlsD+8N8P77Ma
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqkTNYACgkQJNaLcl1U
h9CWowf9FYhn4CUqLi778/DZdnlco03RF07n1WzzIV7B/q7VDMOeIelC+xtd9Ltq
7MDi3uvnr1X7i6KKjqeOD74R0Ty5sDH5nVjCtilRp+GZZ9E19CjA41jA9+Gb+Y/7
9g3bpHT1bykk+xr9VgZM42sZ7sl5m8tFtSnrvDckjqzb4eC5To5MbkHwJM3ZXE+W
UTQNnDachWQHnWxSQXCOYCpoQHfvy3BBsUP//ByXb/y/6M+7gvEhozDUJY5MEm06
AXWiqb4zlZwznGh0gPNZ8vDy8JU74GRhF+xGrwLRDsg1zTuZPQ+5GwXJs40WWMia
7jh1hekMc9VqDUbIG56TVwSaIk/7Gw==
=AA3J
-----END PGP SIGNATURE-----

--yXCBlsD+8N8P77Ma--
