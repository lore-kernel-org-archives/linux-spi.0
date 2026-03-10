Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B6A3D47DE;
	Tue, 10 Mar 2026 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773165074; cv=none; b=D5nxQ8ahSULZxPQOKWsWFSI4xXvDcXUv6n3IC3IE5juUfVxUKv+8LLwhYBuAW2IwPSC/C77naf8htdBH6YMSvZj3/DMzGo+wKYEPzxIHgsSKikzqhWSdrwbdyeU7Vj9wZP33qWs2Lzhpf+Qah6I2/11RJdqYM0J/28hN3cXrlZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773165074; c=relaxed/simple;
	bh=TQ8NAOHe3S4Tgt64Lk4Bs52nBwPgcoDwQr04trMpgCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caHarqB0n6vlAo32n6RogX7+38m8OM0lMgkBMtdZZewf1cdWTcqz6fPd3DcgimDU4OoFKKmBU/5Aj89kNvdLSovI+S8FJGKLgxjmdpSYAyg7nEFudSO7tjfgZxqF8L93Jb4EK+ncJqP4ZfJoGnvte18iNBFCYyNN/MoqPyN6JCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsGzmEKe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsGzmEKe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EABC2BC9E;
	Tue, 10 Mar 2026 17:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773165074;
	bh=TQ8NAOHe3S4Tgt64Lk4Bs52nBwPgcoDwQr04trMpgCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NsGzmEKeYrSUJdWKf114pGjAics9cD4iLzQXnnRdzJbR1pXzjHdB+zXt+N5hGA5X0
	 y/yDe/unTUyK3+5ZzTg0MEY9XBN6PKKRbj8eD2HmBrxLTz0s8NpP+FpgDnBkzkbyLR
	 LRjqgPxslKbAy3mLEBik3IWCsUPWA6mA2PE4J5Wdv+9xC/mFfkG5TZDsC2380j/Alg
	 3wHD8Mz9tRL4bO3VIh68J3RVpafXBhBgWseloLTLDktt1LDMIrLvKoyDYK/AKIf1Gu
	 KXpxfSpkj+fk3xM4+YRDilqOHdLIJoM/LvUd/IvtdopTMr3jGv8Jnh8EqO1U4gpN71
	 /HZWAUJ/V2CSg==
Date: Tue, 10 Mar 2026 17:51:10 +0000
From: Mark Brown <broonie@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: cl634@andestech.com, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: atcspi200: Use helper function
 devm_clk_get_enabled()
Message-ID: <854b2c44-24da-441e-a667-c8512913ab9d@sirena.org.uk>
References: <9f6e31608a24f3cdbd6e1429c1e006ccf9f7d9c1.1773132237.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JNRm/CNWn0illbqN"
Content-Disposition: inline
In-Reply-To: <9f6e31608a24f3cdbd6e1429c1e006ccf9f7d9c1.1773132237.git.xiaopei01@kylinos.cn>
X-Cookie: A fool and his honey are soon parted.


--JNRm/CNWn0illbqN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 10, 2026 at 04:53:02PM +0800, Pei Xiao wrote:

> -	ret = atcspi_setup(spi);
> -	if (ret)
> -		goto disable_clk;
> +	atcspi_setup(spi);

Previously we checked the return code here, now we ignore it?

>  	ret = devm_spi_register_controller(&pdev->dev, host);
> -	if (ret) {
> +	if (ret)
>  		dev_err_probe(spi->dev, ret,
>  			      "Failed to register SPI controller\n");
> -		goto disable_clk;
> -	}

Similarly (and more seriously) here?

--JNRm/CNWn0illbqN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmwWg0ACgkQJNaLcl1U
h9D20Qf/fA1KtGcGnADtnOsujWlofmF6JIqNCtTx4rN3FGmoXHa5XXpEfoAuTp9L
NSs9uI5nHULiR+ksa52bFEu1pan9bz+oTatsaNzOW98WF21LskZdh64P47RgAS3T
U2rPjVXIjNRc4Xf3NfaRMB2km+uR1pLgz/hXxYkKBE8vy3EZE32+3D4LtBPvRFWe
8+J0A9oWJYXomP2CXjX1O/uy4W17KBjJX3TqgY2Nk6U2qi9mRPK1DRMrSN+sM3u2
uCqxUmiKlBHrSWiVM5pzEBrUNDB8atYV/452Sd1U6wpdvuBzEM7L7Tdf5T9jCN7x
m+bdwRuSAqAAVKTwzC8RCpPesmC+7Q==
=ZMz+
-----END PGP SIGNATURE-----

--JNRm/CNWn0illbqN--
