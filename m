Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E8F408002;
	Wed,  3 Jun 2026 08:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780474833; cv=none; b=OzXtU3Aqa83g1A4FGnj96rhUFcYh5T5UGfPIu7/bTJPn8bo4wq3olTAHXCiQfuoBI9a4c5YN8EDPwuTgkcHnAlPFtuJrJZpLtyR/UgGqB/P5UZ4uFAfC7PWg4VFsqmR5gimRfjNxYZTUUCjwvU9GRR14Xd7rWjiRRbWEhL4D0r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780474833; c=relaxed/simple;
	bh=ZGwE567JM/DQjVagBQXZRiKOH4uImPmIt7izQ53IG8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MT9IoPjqqPnFBP6GC+AOXWbq0gsZ+W/kSKIQe/ZihAEhOatd1BqVIeZRm5yvzTTgVQYix0P475xaFeLSP0tHitc3uuh0dRpH+7hJ9sKwfhfiuIG4KKoeXcm8cIccuK/zMLFQ2nkUgb5lcDoqRSugJemGa1LfQGgQBYKDWwdBDLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nzzh+2yH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nzzh+2yH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B574D1F00893;
	Wed,  3 Jun 2026 08:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780474832;
	bh=N61HYaec6DTNNACR/E3N5o0P2xL/9MybuxK081KnMrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Nzzh+2yHu4YHycSi9a/a5x/rTnYhT9jxrEhp6R/lHU/rL0XwIaQHOl0KMlNK4EQ3p
	 YfntXIhWXawwAye+odrFXsKL+zUJnJ+YTOuzIbn1VdPnsAonoUjTsmcEvgZqiGjISO
	 64li4430qdEaJLx0r7+XoRPrc1w1/rqX8tcIajpNTuw2X3kWzfqbyUVnc6wqSgnszF
	 zraIF2kmmGmM5IfmiowSn83V+5bCoqLvCAP+t0119/qrjdndBjCjCjesaMaMs8/23a
	 8ACP9Y4hxXY8CLR2MqMe6A++i6Mb+TC2Wa6upw+oxvJzClN/M8toy48hqepp6x6Rpy
	 Pww7732U0ADlg==
Date: Wed, 3 Jun 2026 09:20:29 +0100
From: Mark Brown <broonie@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] spi: cadence-xspi: Support 32bit and 64bit slave dma
 interface
Message-ID: <e9259b2d-38f4-47bd-8816-3940c2314e9d@sirena.org.uk>
References: <20260602235825.28614-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zloYhxFvZqJbTWGW"
Content-Disposition: inline
In-Reply-To: <20260602235825.28614-1-jszhang@kernel.org>
X-Cookie: micro:


--zloYhxFvZqJbTWGW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 03, 2026 at 07:58:25AM +0800, Jisheng Zhang wrote:

> +	} else {
> +		if (IS_ALIGNED((uintptr_t)src, 8) && IS_ALIGNED((uintptr_t)buf, 8)) {
> +			readsq(src, buf, len >> 3);

readsq() and writesq() are only defined under CONFIG_64BIT AFAICT, but
the driver will build on 32 bit.  We need to configure out this option
on 32 bit architectures.

--zloYhxFvZqJbTWGW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmof48wACgkQJNaLcl1U
h9AB7QgAhZNN47rFnQZJFNh+5f9S2fsVlM/DJzYJdyq380SeSNfYhNuncAJK+3yb
9cmLCLKC9W36CewlPyaW2YeaJ+/1dqzxaa2+SA/bBL/JGbWOZ4aZbpMaXHQ2ault
ahirCiz3w3808g/vA99Z4+F/80aFW94b0LVI8GhbAI4nGyVvudMiAZZBsdsESVoS
lZ2REdQAqY7ZPUCqFHHZ9Z6KUUhPQ1tzrnz8GomZwhCyF9+22xeffg/6lC164KHo
EKevvqVDKnD5WLHw0X7YJUiMDpGUMvJspk4HEJH3ZmXy/dutaDM+JX5GxkNi9wkA
qext33vi7gXDKxpP96GnSOh0RLadgg==
=PnLj
-----END PGP SIGNATURE-----

--zloYhxFvZqJbTWGW--
