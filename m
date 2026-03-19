Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74801254B18;
	Thu, 19 Mar 2026 18:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773945019; cv=none; b=ZCuH3yV1kipxA17Gvk3NI/uaAzZpomkG4qj7g0D2X55vaiSSd7gRwT7GOEiZs8CT46LYUd1sOcTfCiaKI6gdCGR9MA6+IC3TYPp6m7Jr5Onc2hv0qnZzU6Kzye6hl5sX4dKwD9RZHqSPdnq80j6aR2qW0TRGN+zLHMnixfMBTtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773945019; c=relaxed/simple;
	bh=39Cu39toy/8GhZJ1SgNYS+5TuFP8tJKlZwmBlPRVTyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hurUxWmJmpwZfI02OVxWgDYbSWwOQ+f9dSmshI/z6mmQLuMbyT23c0WlIm6M52n1RWxJILOKhjHwAHx3JOyeOeyG0BPIn/YFjom73Q9/p+QfUx4SuOPjvC9ENWyasP9yOVvjTY0JOfruUS2cv4s2lnNUi1I1meZyyjwvKE3zlCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mH4ZE2RM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mH4ZE2RM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F1BC19424;
	Thu, 19 Mar 2026 18:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773945019;
	bh=39Cu39toy/8GhZJ1SgNYS+5TuFP8tJKlZwmBlPRVTyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mH4ZE2RMd4lnRRky54nqLEeAMEN+ykwXu0nCF43Mkdsb6H7KxQTBoK9+gR7JwoL9v
	 1nw9Od46tXH5FqN8/+h+LCOnjzj+IQTvZXUGONvamwRvFflqds+TQ/9P47olGMl832
	 UR8YVXcNqB7Z//D3pEFc1UpZrfvx4zImqjtWp6EkBqD/LIYbnlcBSkRygZGFo0RnoQ
	 l5ETfGl44nPTnZsu/NqTiHKWDdYUyVmT3zRMDKfvQMY4ca4bG1bRRNlggmJn//2hJO
	 lz2SKFJPnDgD2JZvmRCDwLDgqjJSXM7rDmCL2Ts57rtqAVDyRS8a+BH5iJu+EEXeQt
	 iDbynoypmOuPQ==
Date: Thu, 19 Mar 2026 18:30:14 +0000
From: Mark Brown <broonie@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	openbmc@lists.ozlabs.org, linux-rockchip@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, Frank.Li@nxp.com,
	amelie.delaunay@foss.st.com
Subject: Re: [PATCH v5 10/17] spi: slave-mt27xx: Simplify clock handling with
 devm_clk_get_enabled()
Message-ID: <e9e26679-036f-4cfe-90b7-ec0ce57b5304@sirena.org.uk>
References: <cover.1773885292.git.xiaopei01@kylinos.cn>
 <d8a7d6cd3c33419db98027b9346cf078a6b8b4c8.1773885292.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="noPRvBXZlo6sTtNk"
Content-Disposition: inline
In-Reply-To: <d8a7d6cd3c33419db98027b9346cf078a6b8b4c8.1773885292.git.xiaopei01@kylinos.cn>
X-Cookie: Given my druthers, I'd druther not.


--noPRvBXZlo6sTtNk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 19, 2026 at 10:04:06AM +0800, Pei Xiao wrote:
> Replace devm_clk_get() followed by clk_prepare_enable() with
> devm_clk_get_enabled() for the "spi" clock. This reduces boilerplate
> code and error handling, as the managed API automatically disables the
> clock when the device is removed or if probe fails.

This driver is dynamically managing the clock so devm_clk_get_enabled()
isn't a good conversion here, there's probably some bugs around runtime
PM being disabled but this'll not help.

--noPRvBXZlo6sTtNk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmm8QLUACgkQJNaLcl1U
h9AlXwf+O/j4y9RCkRUATb7XdaYqoh/vDEx4mftt8jW3vU1SX0BXTm7XYbi1yLLO
+EKgiIdTRsnLBX/qp3gOXWkQPLLXRuFjsE0bA3x2yXeTRhQcpAEDUB55LLzEGzmd
79I+MlMlDSNmDhqsOT6/nyFYyP1HDQonwyMDlXc1Ec+qf39VS1Jf0I0jyttCAV2Z
6tRuFSmQiY59a4QR8tXqIzpLB7yqhIqqIRonUA5zuOxdB6S1O9BTh5SCXTOVE6t/
C58WLO0KgipP/jucVZUz4iCb94XRvzrRt+r9nTwbGgLxGPwbPgB12NPH/BbDwGdx
if/9vikYeWfN8GP3BkZJSg6wWr/vHw==
=JXnH
-----END PGP SIGNATURE-----

--noPRvBXZlo6sTtNk--
