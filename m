Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D284EDCC0;
	Thu, 17 Sep 2026 20:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677499; cv=none; b=RsTw353De1bzIdwRj3LzmwZaPaDG8Apw6+F6/RCKl1A6OrPQ7E12Ed+rIIHWxQ3lULOXB7L/K7kze9+69ThOg+zyvxttsmuZjxNe1UwbVHDGCn0vdWMZS4H/XxJmvz1RAKdGRi1sQzDrLin6ydywb11k5NA7tMMsoVFMcOXijUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677499; c=relaxed/simple;
	bh=JfPygrq/9UL/43uIzokrxsWa31TuxaNmx0RdKo083jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2M+3C1g/nzBv0blrLjLql7A2hU6DCKaXLmvqQmQxFOZBOalSIzQH/7X+qSoorcWe9mwjxjGZh35xrB7/ArKNBXtGW0wzFfEvus9Batb1gwmBTY2SJJaeuTHSzCrkKSdrSHBVIkX3jqrpzzSp8EwtThxkh/Nprae9og27jJ3aNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrJlVaar; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrJlVaar"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6F51F000FF;
	Thu, 17 Sep 2026 20:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789677498;
	bh=SWUtFnbkl/ANEyOP/8G3mNVn9Z4HzwhIEpWFM6p/Mpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lrJlVaarsGQ9on1c4U+EiFHGWSuEkMFksogd8968E1TcdHD1h63wrM6oaNnxxUga7
	 xRrpcfdqZu5+aCWeB1iVE4UlyQ3KZParHmH4VVeOXAxY46q0MVQBO7S+DKl4/77++2
	 2n3JXuA9UGbxyILLQZ8bcbJ7TfbCmpYqm7kHwCMc4ArrmwY5447xg++3NRrpBRyinZ
	 jOorI8sUXDohbPSLgei2CN+ZDiEcskkdCkPUmZdpwMcAxKTmIOrMHFHSpmCP0noUTn
	 A96L/XsdpugluNUI2Jm1wR5iomN26rqlAzqDced6aq+ywk2ci4nivmNWJ4BqlANSSW
	 iZxIgK7kUadrA==
Date: Thu, 17 Sep 2026 21:38:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Han Gao <gaohan@iscas.ac.cn>
Cc: Longbin Li <looong.bin@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen Wang <chen.wang@linux.dev>,
	Inochi Amaoto <inochiama@gmail.com>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Han Gao <rabenda.cn@gmail.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	sophgo@lists.linux.dev, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/4] spi: sg2044-nor: Honor SPI clock limits
Message-ID: <fd3dad9f-7997-47ce-875d-db43901002f3@sirena.org.uk>
References: <20260917-fix-sg204xspi-v1-0-5c95dac429a8@iscas.ac.cn>
 <20260917-fix-sg204xspi-v1-2-5c95dac429a8@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gzg0WQ0iyDkhretZ"
Content-Disposition: inline
In-Reply-To: <20260917-fix-sg204xspi-v1-2-5c95dac429a8@iscas.ac.cn>
X-Cookie: Whip it, whip it good!


--gzg0WQ0iyDkhretZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 17, 2026 at 10:29:20PM +0800, Han Gao wrote:
> The fixed divider ignores device and operation clock limits. Calculate
> the divider before each transfer so SCK does not exceed either limit.

> +static int sg2044_spifmc_set_speed(struct sg2044_spifmc *spifmc,
> +				   unsigned int speed_hz)
> +{
> +	unsigned long rate = clk_get_rate(spifmc->clk);
> +	u64 div;
> +	u32 reg;
> +
> +	if (!rate || !speed_hz)
> +		return -EINVAL;

Specifying a maximum speed is optional so we might have a currently
working setup with one omitted.  The driver should just go with the
maximum speed it supports in that case.

--gzg0WQ0iyDkhretZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqsT7MACgkQJNaLcl1U
h9ChUgf/eAoO1JBRrehh23WNTyeoLDYUC/+Qaxj77qoslz/vc36kBzcN/xwqSFV6
MyrZmHaWzdra3c2Z76l4MjssxvP6tN5UOldDyINacKYDE5WGU72XyJGbxXXFgzNV
xcsWAueHF6glcg2QqqA9Gp0b5ZOtHLZegCiPfJmmjOyR0dJUWlcoZSWcZNVjBcpI
fe2zAwHAMGN0RAcXg9nbnmCdATkfo8FruPDx8A2904TRZJjORB8cDHS5Gk997KhU
feb4PhizTGUINbvbpombQ9ZKuKMBo4cTwNA3A9OP869Gv7puQ3P3Y2aDlCBnLIqp
F5Ph65rtr70KpqBotgdbaKIZ0utdHw==
=4TGH
-----END PGP SIGNATURE-----

--gzg0WQ0iyDkhretZ--
