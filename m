Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA081D88B4;
	Fri,  1 May 2026 00:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777596765; cv=none; b=vB+gKkBk4ddwZkyE/rtc8YOxCB0QZ60n6y1+LIwwma1cM4JGFwVsezCSqkqu3mWU8A3u+qtY0xbUlQqZO5fEm8shVHa7ij0r2k6lRfDGFhWref+WKsJ+jP19iJuJX8mvWCZbQSWlf2rXSjuV7DVtWRl/TjkCoq/RnRy8IgByQQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777596765; c=relaxed/simple;
	bh=EOOhMWkdwXNe+cgIqAYVnr7cBZIq3XZI0KMFnUqE0CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czm/DPAg7/TSBBoXaacHo4+ou7xWSgDSC1GKUp4wUJASbZTPn/sTnoqPa3yNpEaNJUlrKoAgJCgu9N5n3GRVDlEmwjb0UX5dL2+UUDDwSVYM17uUPu3a7Wwi1rxGgv0HfDfnPueTmo83FTec6PaRFzrkbhH0kro9lyPaoJZ0+EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ib244Ctw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ib244Ctw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D5CC2BCB3;
	Fri,  1 May 2026 00:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777596765;
	bh=EOOhMWkdwXNe+cgIqAYVnr7cBZIq3XZI0KMFnUqE0CQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ib244CtwJUUvN8KWPb5lMj+V3cAt3pp8wwvKUMag+XKg5JDHMOtEYwLvQIdp6xLw/
	 SuAEUvevA4tChXEj+76ZFA/OYARODzVt5oLc08jwP7CWYVINfkFlfn/5fQF1dXOICq
	 XH3ZGXBE5C1EzeAAbLsIqR6XNrOdIiqTiYDHBPynlH4tO5XIsERzAYehSDAckiWfyH
	 Mc1EvcAPlvHoibwjKqQ5VSbMK5PyhZS9FjazSC5rqaUXH9aIm4X+O31INX1YSot854
	 hUO/IAoikN02Dv1EcKbWhUZ0WyGsG4SDiLRwIjHIpSkBbLLWtyDxab80brTW95TtSG
	 mOibVax7L7wlA==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 1290F1AC5860; Fri, 01 May 2026 01:52:43 +0100 (BST)
Date: Fri, 1 May 2026 09:52:42 +0900
From: Mark Brown <broonie@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: sunny.luo@amlogic.com, xianwei.zhao@amlogic.com,
	neil.armstrong@linaro.org, khilman@baylibre.com, han.xu@nxp.com,
	haibo.chen@nxp.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, lhjeff911@gmail.com,
	hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
	jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 03/10] spi: cadence-xspi: Use FIELD_MODIFY()
Message-ID: <afP5Wlzt-dTvnzii@sirena.co.uk>
References: <20260430155456.36998-1-18255117159@163.com>
 <20260430155456.36998-4-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JFs5EhvgRVT+vvgO"
Content-Disposition: inline
In-Reply-To: <20260430155456.36998-4-18255117159@163.com>
X-Cookie: 667:


--JFs5EhvgRVT+vvgO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 30, 2026 at 11:54:49PM +0800, Hans Zhang wrote:
>  		writel(clk_reg,
>  		       cdns_xspi->auxbase + MRVL_XSPI_CLK_CTRL_AUX_REG);
>  		clk_reg = FIELD_PREP(MRVL_XSPI_CLK_DIV, i);
> -		clk_reg &= ~MRVL_XSPI_CLK_DIV;
> -		clk_reg |= FIELD_PREP(MRVL_XSPI_CLK_DIV, i);
> +		FIELD_MODIFY(MRVL_XSPI_CLK_DIV, &clk_reg, i);
>  		clk_reg |= MRVL_XSPI_CLK_ENABLE;
>  		clk_reg |= MRVL_XSPI_IRQ_ENABLE;
>  		update_clk = true;

The existing code is a bit weird here, we could just delete the
modification entirely AFAICT.

--JFs5EhvgRVT+vvgO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnz+VoACgkQJNaLcl1U
h9DEnQf/VAnw03Dnq8NVXT8eelt6wkRf2zJKsMEPrCCYPKzeWXivCbUy9eykDun+
0JMG0iLP/LpWGz4qpUWkbR2Kz8aA0BehHcrEQ56Du8lygGmGeFUNtTcr3KL8API3
DEQrtR2rOyvQ5gxfbyX9NN12jKoVi+SQ6E/W2FFwRY9o2Akuj+NK2rRSYcSmiIBO
b5oZbhABu4P6LiXAtHZ1LK+Yf7NhvgSiFch1chrm/dk225txoJfTFn5BSn14cC+8
FWtjbKtDpupiD1C94wsXHfoUDT2hOtJqxnQLE63hNAKIMqkU3raORVOemHKqcB+M
0qK9zAkxfGtf5GZdQ3rD7/lt2v0bCg==
=Ca6l
-----END PGP SIGNATURE-----

--JFs5EhvgRVT+vvgO--
