Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3BA3BE140;
	Mon, 23 Mar 2026 16:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283743; cv=none; b=hP6Mc6T7wZ/YUKtXOWbfYy+dY0T4x+tYcZ7tAuohxaGkLZrlqgVhThMXFO/Ss7Q0kvWOvOvUpwvfiUrzlnI186dUGsKEn8l9dcDbDDDPXq9HyPGMHl+EuNDv4aeEQ4Pvvsl9aoqoCP3ZGaAP0umyym/JyAdnrzea/nfKGqo/Gc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283743; c=relaxed/simple;
	bh=0iPY1l1mZvTX65TrREMHdsQh2M8IwSM2wQuGYTxhi+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbTTt6waA4tVdr2EszwrfvbaPQQvSSv0fyaexZnC38dFFRMs9ao9CzTAltZBbFS5US30ZiVhjyqQuEB8+MuZcSM0uZ6JgunhJuxZyXONUFXBaZGNAU4j78DxZhUebqTkg9hae2/UuCucr/Wl91KvMcIu1oCix+i/2raKb4L9vVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9UlkHG3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9UlkHG3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B34C4CEF7;
	Mon, 23 Mar 2026 16:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774283743;
	bh=0iPY1l1mZvTX65TrREMHdsQh2M8IwSM2wQuGYTxhi+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j9UlkHG3atOCJucrKLxMQ3u2U5tV75B68waMRrsCa/yUHf0L4Wiq5/E/x7iVwazKO
	 0/6UP381u8ZJ69CdpgxuMefHN1HZntcWVuWeJCCPrnzqnQi5awYiIh9X/Qs5bCJ+AG
	 lQDelJxeYYA07iMERBiNYVaoOHDcTelFZrNvg0RaSH1pUes/MYboBvf8xDbSd8UQae
	 tGmimxDHZkdCjb9zZ3ZNd0uSGuelxJW2VCvaFdcABGSFv6skrMYj3Gehho4UqON1Q8
	 0LFiV6LG++R7pk7iJdNpjWZG3nUEhQjgZ/UhWwpPGAwj0U8jP0Nh0hNyAhfjiHy+uI
	 16zurkW0bKjkw==
Date: Mon, 23 Mar 2026 16:35:39 +0000
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Laxman Dewangan <ldewangan@nvidia.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] spi: rockchip: fix controller deregistration
Message-ID: <2ef1dcd6-68f0-4111-b8ac-fdaf4aea36d9@sirena.org.uk>
References: <20260323104948.844583-1-johan@kernel.org>
 <20260323104948.844583-5-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="U6/GiLJMGAaw9o5u"
Content-Disposition: inline
In-Reply-To: <20260323104948.844583-5-johan@kernel.org>
X-Cookie: I invented skydiving in 1989!


--U6/GiLJMGAaw9o5u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 23, 2026 at 11:49:47AM +0100, Johan Hovold wrote:
> Make sure to deregister the controller before freeing underlying
> resources like DMA channels during driver unbind.

Fixes should go before any non-fix patches in the series to avoid
spurious dependencies and make it easier to manage applying the series.

--U6/GiLJMGAaw9o5u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnBa9oACgkQJNaLcl1U
h9D5Swf+Ptm/Ktx2vb8Uad4FMVn3+htcPjxh7GYkz2Yrm9jkc5SHtbQRPI3n9Twi
RvUbBXUoRslbF26YSSeNdpSP3KBv9MrSteiv4c63kDWxA+5fKfoVXzP7i7bEcEjg
R8tEQpfOlGlWaL8YP6qVcB3erD6uuSbmN5L94GPNqlDEaWGme40ewGQiKNLoYlfh
j1WHsTanTR+aJdVWaYq/S3ilnRDWlXphDww6ztZwPHbfqMpbTKnguXkVOsXczKRM
csUKDl+Z3Z/XUNffG+1pC2UqVv4oEq3fURp06O2AsRczF3ri1DpNFOqCjN8zEmxu
DnUbQxFZTvXPi3EiDMsfZ1NddzhhmA==
=JrSQ
-----END PGP SIGNATURE-----

--U6/GiLJMGAaw9o5u--
