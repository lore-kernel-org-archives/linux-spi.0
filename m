Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBB23AA4E0;
	Fri, 14 Aug 2026 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786719208; cv=none; b=rVQXKLEA9gqiD6j2b/Qz9wADZUNnK1bPTyQvN3P/dX/eX9HtuRL/woDpahMeFgleRyss+rCUN3s3ZuExVGy2JgT7az6EUD5f+iK75EeX/1P+F1Wann1SCr9lWIPLWYwxPZY9fA0yn6AiS2YOaahtoDOF8VdOorEM4vIUz2SZBqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786719208; c=relaxed/simple;
	bh=+0fOs0cjuupEEu8I3nWVscZ8VY2SVse6Z0r3a+3DDHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrjystR6hK78R8bUcgPStOSsKVBVeVddlmrGn++CSboTwGkD+O++hLzJnkzw6lDrMv0L1OfMGPL5P8HcDGoeIr5wIk+VHrJ9emF/6IVxdaO5rHjkyNFl0mOM6pvasYTb/aTxh/8A4ajvADOjgurXsIQL8VZflnUXMuTy/OSjSkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AD41F000E9;
	Fri, 14 Aug 2026 14:53:21 +0000 (UTC)
Date: Fri, 14 Aug 2026 15:53:19 +0100
From: Mark Brown <broonie@debian.org>
To: Vishwaroop A <va@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Breno Leitao <leitao@debian.org>,
	Suresh Mangipudi <smangipudi@nvidia.com>,
	Krishna Yarlagadda <kyarlagadda@nvidia.com>,
	linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/3] spi: tegra210-quad: Improve interrupt handling
 for loaded systems
Message-ID: <6b16a970-324c-4c51-a832-07eff2e73332@sirena.org.uk>
References: <20260813200027.2711863-1-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E/zV4tVL93trwLgr"
Content-Disposition: inline
In-Reply-To: <20260813200027.2711863-1-va@nvidia.com>
X-Cookie: Body by Nautilus, Brain by Mattel.


--E/zV4tVL93trwLgr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 13, 2026 at 08:00:24PM +0000, Vishwaroop A wrote:
> The current threaded IRQ implementation in spi-tegra210-quad suffers
> from scheduler-induced latency on heavily loaded systems. The old
> irq_thread() runs SCHED_FIFO but is pinned by the kernel to the IRQ
> affinity mask (typically one CPU); when that CPU is saturated by RT

This looks OK on a first read through, if I don't spot anything else and
there's no other comments I'll apply at -rc1.

--E/zV4tVL93trwLgr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmp/K94ACgkQJNaLcl1U
h9DzqAf7BL/0crezgFD6eZYzL6kMUZQSU3ITxsp2w7F+XiMlp99+8PJFlXtUaI8D
l9452FU856eOX3Q9DG/TQVJf7e5ii1LkcCgKXUy93swbXAfbx60oKOcByEt6HQ4V
f/HqIF3LWh+yIYR/rjqw5tFd5m7KRy+evnFll1HY7eQ76FeJRfNkodD3FcbxHhDL
8DHFRV85VQT7fSl7BP9EMXt6y6Rx6ppjUv5w7N+FV5b1np1810/Y7SfiApX0cykn
gf5YPnDkgfl4l3MOIwsS+Wj+act57qKAkEi93q5XXPaa3vtqgukzAdAJxn/Eeu14
mbbeDz6+7DCsMSHby0xHFvE1pv6xAQ==
=7uFZ
-----END PGP SIGNATURE-----

--E/zV4tVL93trwLgr--
