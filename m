Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA37936A035;
	Thu, 22 Jan 2026 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769104667; cv=none; b=D6FNHQt9tSdioQMaWRsSlN1PmTBs+Szc76Kf+rYcHupPzfTRe98+kKqfi2HDp4EDJmPCZsgsvBiaOFKXczywLK+UXbVXYJskdA0vaMfkBWeUh0SKF42aAlSM8tDPMasmJ68Umvx0S0cGoSHhcmCECr5QGDz1kBH1s19wAOzUyzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769104667; c=relaxed/simple;
	bh=5fjnngp+GlKw8HvyjksZExdpaBfAHK66zWEW1o8n1Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+EuM5TNglXWrVJwvvyFTcs02nceQAklHcBA4Y/H5FWmlS5PxEIl5aB2zfEuge21KbDJkyuB94zASFkpiRPBLXCZFhUH1saU4NPpPTHVqOHQsQRopnMLF+zg0yp6hD/m2wy6ZKu4riU3KTdr06/T+V0Cai9dMsT+nJdHyLD3hXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niT7xvld; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niT7xvld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83E6C116C6;
	Thu, 22 Jan 2026 17:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769104665;
	bh=5fjnngp+GlKw8HvyjksZExdpaBfAHK66zWEW1o8n1Dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=niT7xvld9hSeM5hraX2u1CihrESUTPG+hr5yClwDPzVoTCekednRMUOniIGlp+aXF
	 dtTwJAEbs7+xRExqeXjg4FOyf2jhIdtuzBhu8Ns/+fd82So0EIru5aCjuwCNOcrHs8
	 YoeDd6VikKbf5E2Cjxu9ZESfuhFbK50+wy4ek06NAI7bzcNvB6JEbxiOaNVU8A6qGc
	 +zi/tZU/a7DPOUeH33BrrJhmdVK2kzAB1hpy3yQBSbfDZWRjv0DutJxz8MnGjEoI93
	 vPOZ9LoO4aX818CeqjW7VxRneVJ42LmRKNf6mVK/Nrqszq4b39Fmoel9FyPpjwguGx
	 dhE0BUG3mRO4g==
Date: Thu, 22 Jan 2026 17:57:42 +0000
From: Mark Brown <broonie@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dw-mmio: support suspend/resume
Message-ID: <d0bd831a-08dd-4c2c-97e8-896f885cdbe8@sirena.org.uk>
References: <20260122155046.12848-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6DlJi9IOD4eHoX78"
Content-Disposition: inline
In-Reply-To: <20260122155046.12848-1-jszhang@kernel.org>
X-Cookie: Don't read everything you believe.


--6DlJi9IOD4eHoX78
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 22, 2026 at 11:50:46PM +0800, Jisheng Zhang wrote:

> +static int dw_spi_mmio_suspend(struct device *dev)
> +{

> +	clk_disable_unprepare(dwsmmio->pclk);
> +	clk_disable_unprepare(dwsmmio->clk);

These were allocated using devm_clk_get_prepare_enable() so we shouldn't
really be fiddling with the state at runtime.  In practice this should
always be fine I think but it's not really something we're supposed to
be doing, in theory we could fail to resume and then end up doing a
double disable on removal.  Probably the open coded version would have
the same issue though so perhaps this is pedantic...

--6DlJi9IOD4eHoX78
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlyZRUACgkQJNaLcl1U
h9AGGwf/T5YLt+VUiqnO79jPuzU/oX0f6hor9x+yXZXYZws+ltTPvF0OLRVj+Byh
+0P99twv6Qpwzqg6oO8DPpJzZ+IO3ie225vRZh6f5J6Ni8JnPwBtoPGzFAgJaHnA
IoKKzqFAE0IXdnIg5lDcGd6o2nyt++ZyBrPEBiieYKSmnL4RC+Lt7DTBvgG2/Cxm
dFfzLRONO67cau5v4LpflfeZCjPSH/GQCdq49NpbtJhwRzjRKpfLBlG7XGiZA51w
3i3dx/jjvXcH+qL0JCoDsKb9v8mpdEmLwPE0L7CGvCaRX69qGZo0acbUNi0KhjEp
BHV36sbwcBL0cuH8LcKUmVwnx8kvzA==
=7AOE
-----END PGP SIGNATURE-----

--6DlJi9IOD4eHoX78--
