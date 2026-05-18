Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082C23D3326;
	Mon, 18 May 2026 10:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779101170; cv=none; b=IBztW13sjmD7hxa1gyaJkDb6HHM5DqTLG2u0AEzOaFYlRmXHT8IzQcMKMoVWas0X/X3m+dnc93rsTd/TgCjgINta9lucYFyKUEnxXaFuhdYksebOPIGHWuCpJqwwZb/qz06xux9z3h6JZwAwalrRMj45vvtorhIWKWJfWBV+hTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779101170; c=relaxed/simple;
	bh=FNklAmDdgJRWCvrWZPn9zrklUDe+m4/gEjhhUFPqDEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jw61JMrevqvOTye7j4eBCSDf00nrmY/Ii8F81KmGJTxqsOIGBXOyjb7G68dpccy0x3YGjkYEdw2AslCID2tNZhflcWXVymApobSnzLta2VBpI23oJHRooa5HMEwEFvWmSV7iccOrBezE0PNrdB3RaYVmbT2pGc9kqWFVmlE0gwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUz5heHE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUz5heHE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AEE8C2BCB7;
	Mon, 18 May 2026 10:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779101168;
	bh=FNklAmDdgJRWCvrWZPn9zrklUDe+m4/gEjhhUFPqDEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qUz5heHEwthqbGhDHHLPapztBzxrIvJpTdAkwv508Sl5zAwcD2mSrPi+3/I0q0bJt
	 eU0g+aNrDtz5MWfu63vCTc1UBj4zs18mWeO5K8wDVzQQ1bQPBOijfz+UinV3ChEKVZ
	 qrI8DUr03hmH0TlDIX/t9DiQzuOm8URZZKvskiMLjS+T3cKHWCTOB/YQGjOmvSekYZ
	 6kGtPonpE1LZWz3inUE4NibFw9MLrh0qprCUbtg/zQAqyBLbAKRNa7oMUuCvQivxyH
	 W+6qy/N8UaZHPr7MbI3FeK7V4VHhJffLiaeW6RDWByr4hdmbRuSom9/zjF8/pnwhA1
	 MoYz+r0c6Ptlg==
Date: Mon, 18 May 2026 11:46:04 +0100
From: Mark Brown <broonie@kernel.org>
To: Peter Collingbourne <peter@pcc.me.uk>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Christophe Kerello <christophe.kerello@foss.st.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: use udelay() for short polling delays
Message-ID: <8e7c7d5f-376e-4ab5-9ea9-a19a32d4ff67@sirena.org.uk>
References: <20260517062554.117448-1-peter@pcc.me.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LTqIc1W9Ts6Ezw8g"
Content-Disposition: inline
In-Reply-To: <20260517062554.117448-1-peter@pcc.me.uk>
X-Cookie: She sells cshs by the cshore.


--LTqIc1W9Ts6Ezw8g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 16, 2026 at 11:25:54PM -0700, Peter Collingbourne wrote:

> +		if (polling_delay_us < 10)
> +			ret = read_poll_timeout_atomic(
> +				spi_mem_read_status, read_status_ret,
> +				(read_status_ret || ((status)&mask) == match),
> +				polling_delay_us, timeout_ms * 1000, false, mem,
> +				op, &status);
> +		else
> +			ret = read_poll_timeout(
> +				spi_mem_read_status, read_status_ret,
> +				(read_status_ret || ((status)&mask) == match),
> +				polling_delay_us, timeout_ms * 1000, false, mem,
> +				op, &status);

This seems like something that should be fixed in read_poll_timeout()
rather than open coded in a user, similarly to how fsleep() is there for
sleep functions.

--LTqIc1W9Ts6Ezw8g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoK7esACgkQJNaLcl1U
h9D9lgf+MdHLc/I6SNRm5Po6+ewBEZpsWdtDZx1Q3pLMN0STv0pwUa6Ga8khHap2
QNwLIqcmD8neJx/3j8bfO5LFQTEf5U1854nxOjR2pgvNnmQzLZCw4cUkP/K7KXY3
YVnvg9SO0KswTS5CZZivL3upBkXhqe+QQHvWUtJ92v1FxO6MRMJsMrzhmjTccZ5u
BReI7h/oAwzzrpRM/bRRhQRi0RE3DVYUNSjycY73IQZy58Cxm46S/h9Nq2iM1Ldu
i62wmC5GfLWU4thGDxuj8gPd4jmyI/cEMdEkh/1yC7dO+TXl4ahxxGwyVcmaT4fn
2a8uQYbuqWvRrA9kPM8Lsmw/tRnpiw==
=BIGm
-----END PGP SIGNATURE-----

--LTqIc1W9Ts6Ezw8g--
