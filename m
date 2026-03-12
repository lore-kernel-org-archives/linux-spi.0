Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8667A2BEFF5;
	Thu, 12 Mar 2026 12:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773320218; cv=none; b=nJVni+PPkkwDd7ohruCglYqoHQyPSG8WZtKDQs2nyyey2kvkSrKolwek2NBXR+zzvTUIb50VGhZOfzufCHJnq3SWH7ZuWkNfXdSwF34mQwYvJRhyWvSplwhRUv72dicX8j0HOX4S5kcejYnE7jHL/fEp/IgZchBPeQhCd2JYsig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773320218; c=relaxed/simple;
	bh=cJK3mpyT79e9qtgSDmo9xoFCS+6kGW9BW2Ply5mwOwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmR/2ciBjMLX61fZSDlcm50119riQ8LKb4aTsPAp7NmcicUeTSdgv8tG7NZqsqQpOVrbzVUBH4HX0MqlaiWg/KELGXJ5KyTZ2z0X/gBkfldvj3P0mRJfpk9YCaGkyFx4UUWnnYyxYeOlYuMTFrYN1DqItAoy0waWT95NuJUnYcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hcs9nRxf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hcs9nRxf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29CA1C2BC86;
	Thu, 12 Mar 2026 12:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773320218;
	bh=cJK3mpyT79e9qtgSDmo9xoFCS+6kGW9BW2Ply5mwOwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hcs9nRxfcpQv9i4VUoc9iF/DJrAf6Id276T6HxF/Ib7iBm1MqhkwzZ4IfPqId91sf
	 ZqTwIP18zfG/TDbMGdttgXRsihfieBSg6vZsmvZlImvkzzxOM0cbpwIWcjHdiCXdPv
	 Mnl7ZTawiavyFdyTgK0aGIm/S1C8HO1unx7GoIKoxbDPOCjCfAnvIJuHbvOV4y+If3
	 c/x8YlSrdrUims11yxA5JjlEFzCFR/MJugKWJ+UGBCgaTYfuLSBJJ9FYMWZ9LXsf4k
	 RmzAIPbd77QF9MTrRJ0zFetOCQiNctC2pXXkacBo0ec7YFR0rxvC9WEyHJpYYooXGy
	 eB/ColMjmpvyw==
Date: Thu, 12 Mar 2026 12:56:53 +0000
From: Mark Brown <broonie@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	openbmc@lists.ozlabs.org, linux-rockchip@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 02/17] spi: bcm63xx-hsspi: Use helper function
 devm_clk_get_enabled()
Message-ID: <62a5a878-f88c-4ecf-a0e6-fe5430de16e1@sirena.org.uk>
References: <cover.1773306858.git.xiaopei01@kylinos.cn>
 <9391f0c3a62e698e66a4b6630ae10b329faf3c11.1773306858.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yl7jQAg1ktMo1H3W"
Content-Disposition: inline
In-Reply-To: <9391f0c3a62e698e66a4b6630ae10b329faf3c11.1773306858.git.xiaopei01@kylinos.cn>
X-Cookie: I feel better about world problems now!


--yl7jQAg1ktMo1H3W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 12, 2026 at 05:28:54PM +0800, Pei Xiao wrote:

> -		ret = clk_prepare_enable(pll_clk);
> -		if (ret)
> -			goto out_disable_clk;
> +		pll_clk = devm_clk_get_enabled(dev, "pll");
> +		if (IS_ERR(pll_clk))
> +			return dev_err_probe(dev, PTR_ERR(pll_clk), "failed
> +					     enable pll clk\n");

It's nice to print an error message but having a line break in the
middle of a string not so much, put the "failed bit on the same line as
the rest of the error.

--yl7jQAg1ktMo1H3W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmyuBQACgkQJNaLcl1U
h9CEzAf/ecvpiU7/HU5Fp3TOFVTXTv8suK734EdILMdPMYzg2XQ5APg0FjZnaDWK
n27vFo4zq7eUDrvGme1Dzv10k/4Cjpw2DrQx/Ahqa3jpKOCHGmSxpijsGaAXLiJx
+LsKIWIOva86JU+2aUnnG2N/OYF8veII4MzVSaJohLty0G5K0iDpFd0LfzMJe3Me
unarWsC/fxwcVKrf6PagZGMg1lH37wpcAC2In9I7FrtGsoZCLS1JOZrLonKf1P7w
l3S+1h6hvY2cZtV5YrpK99SnkNKC6NSRw80K3GIUzkqT6P7RiaCbldAabB4newkT
u2aU/H0zcagXZXr0ZHcpjfYPMZXG6A==
=BmZA
-----END PGP SIGNATURE-----

--yl7jQAg1ktMo1H3W--
