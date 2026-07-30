Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C6938837B;
	Thu, 30 Jul 2026 12:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785413149; cv=none; b=JB+V5laLa18TNOHakwn+5aAn6ZiYBd++/YrrJp0qs1AtXxxmOjUMEEHMaRv00zwL7MXdV7f+x3ao1XO713Zjz1RjoWITjhWNL/vaZ5tSmsIqPQolTB2B6R3cbEwRcDTm6ijeRmzii68WDIEvA+YA1xeW7u1FBx8JFibX92FzdpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785413149; c=relaxed/simple;
	bh=yMJtZAEaPAwhFjSwKhfm0pX9S3qY4eiB47M6qmEtGQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tf1pTWmpl7OmNSHGVz1EPnkn4UufiDfjWAiGT/3UJZbfwhqwvczRn27R3+AjLTjz2kiBpd0g3JfSISxzorb1pNzE4wobEtl/8s4b+gbRV5wFsA8TwF08NGpfjg0VY+EGXV4ZlmstNl5xOU1iIWPdsro/b9H8KK+vCUmYe48IDSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2gk9GyZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2gk9GyZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E571F000E9;
	Thu, 30 Jul 2026 12:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785413148;
	bh=qsUQy8M66IQC4lINcyq/oQdCxyYdqshF1zc1xBHxHA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e2gk9GyZgq8oQEURY5p40WzWG9z4659Vkf3Ehzzt6nAG7f59GgY9fEXIQKviG6uxV
	 s1OGPXVVbPk2Z7CX8V59491Lap2GC79ZUr2osPt9XIdbtvmgaqMec/nYObE7QyTBH+
	 nyGeYAAFXGdxJ3av2WpsMgeDjUd4boPv/Jkse01hSAhr07CmZGL/wzgL+vCIocG+/y
	 jw3UhkyxKZpYLecDHrSmL9Tn+YGyOKZUoltrU0XK1Z1ZQ9wkt49KNvHD+pyC5pQJMj
	 g0QgSNkP6K8T0f2euFhc4GFcujxYpeLWe8mnXiuo3RDYCG9PtfqYrPUeQN1V75C83T
	 XKE9oNVwsAw+w==
Date: Thu, 30 Jul 2026 13:05:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: meson-spifc: use devm_pm_runtime_set_active_enabled
Message-ID: <d91cc800-1f41-424d-baf8-c1b2fe935978@sirena.org.uk>
References: <20260722-spifc-v1-1-e4462a4c6a06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/A/xRZp0AlOIxdtl"
Content-Disposition: inline
In-Reply-To: <20260722-spifc-v1-1-e4462a4c6a06@gmail.com>
X-Cookie: In specially marked packages only.


--/A/xRZp0AlOIxdtl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 22, 2026 at 08:09:17PM +0800, Felix Gu wrote:
> Use devm_pm_runtime_set_active_enabled to replace
> pm_runtime_set_active() + pm_runtime_enable() and drop the out_pm
> error label and now-unnecessary remove function.

> -static void meson_spifc_remove(struct platform_device *pdev)
> -{
> -	pm_runtime_get_sync(&pdev->dev);
> -	pm_runtime_disable(&pdev->dev);
> -	pm_runtime_put_noidle(&pdev->dev);
>  }

We still need the pm_runtime_get_sync() here since the driver uses
devm_get_clk_enabled() - we need to exit remove() with the clock
enabled.  The other changes look OK.

--/A/xRZp0AlOIxdtl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmprPhcACgkQJNaLcl1U
h9BCFwf/fJYvAB49gnyQfVxHK32NXtzFjH+/iHS5QiweU/ilAXloDOMCGhHxw6Bt
wEUpzncjFa+GP0Cy3L3uqO5+o2daTAh1JjfRsai8wCZ2OSa20PqmVJDmw+liiL0c
jf86aCksazxg9Cx19/wyEPJ98mqcLUu3rLPrQ6VTi/DvWggukh3cs2o1q2XWK7qb
eJb/+X57ex9cffILOmueqjG9SJSQQstM9k2MhRCfTeZw0hKwigKeGZW1F9JY95JW
LqoAnFMbyx4Jk3Fcj6fr/KIYroMKNGSTaTh0mVQ5Cmnvp/lbYc0fWny861xwW0yb
g7yhZ0cNaCHvxq4U/zBKFslj5eznMA==
=JqfB
-----END PGP SIGNATURE-----

--/A/xRZp0AlOIxdtl--
