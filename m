Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794054812;
	b=3BfrPRNvJoPpbwcxLN7CQJ0UMpcWiPkS+cBfSxLdWhwzG9Uv2tk74uHQBSpj9XnfUoGM
	 OF1tbDp38I0RoichBrTa5Wu7ccScHUpy1TsWYlfZRdWxJgEBQ5AOIuWyaU6H8G8d427u4
	 vZiopyVuixY9B/fdsvgmd35ZcYmbXOs6maw4Y0tQzWXFcTN4iMGE4+4sZeN0eLWFCkF01
	 AXbj6eQ3FSrwfeZ5Ua5S5dS8O4JDJZ0QEEARN7dDcl9TpOu7bLJPcGImgrMiNku4zm0L4
	 sddKeU3YcNWGbTY/JWDo3QYXCkAVgNOeLgD9bdh1GtVwILw7MoGDY8cK+XLwCyNa7+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794054812;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=jaMPW1tyP+uJf07r00aX8sEiYPtJLiXioKEigkez23Q=;
	b=5XW+9GqwamSYZpVY7ZLYzNVWoiRzaXv58uB0UTJ0bbariCKui0aCzWbnU2Vshcs7Qyq3
	 lBYCxkgAWDXtbqInW9QNg6cmPjFKA569FxthTPocqtHxjCupAp3hGfuPlDaiW/bVq9hql
	 n+h0S6s7o+1JRYQlKjj8+QXNw1y8Hz6YZv7iFo6o/XqzVYUlCDU7Zsb0lfWTOm+MvfShN
	 PsEO9og3CdlI58dSPBVgvrBfLaSJXaVzSDuuZqi/ohgrfl5lVM5sX1vYV0ZC2IWqRpx1g
	 xQ6m4bwsFjba4OaYBLzTLk9A937cbe8JGXADPnbWh0nB60iB288eLwHZ9woTSmvkZRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E5XUhljX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C12606A326
	for <linux-spi@vger.kernel.org>; Sat,  7 Nov 2026 12:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E5XUhljX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1490E1F0089F;
	Sat,  7 Nov 2026 12:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794054812;
	bh=jaMPW1tyP+uJf07r00aX8sEiYPtJLiXioKEigkez23Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E5XUhljXyhWR1BvtH94HoQv+cz74b3lwKGuthd8UZLkDg4+pTQa0+Bqjkevz2ezXn
	 0vtRMNzoEjZEYHQMIaymkSxjFLBcNbBPWCIV9aylCVyTvSTL9Zvsnky994ASpzqBfe
	 MCh/PCHeviFzG/uVTSr28Z0w7Y341n7fvugm1YBVM6uVppLWxlILIq/93zTQDrHPO7
	 w1v1VRmxsUJ9zgD+Rtq1ntVhSOktYpz+vmR5Fb1BTtnNeJ0EBH7YrLBnHsMbKdDf8B
	 pQkBcVcy6HYEiaQsuFsujGnFXh1XbUdBxEVVWjwIznF7yGiULFVB81l6sS6hvUmBJF
	 6tMVafXp2qHxA==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id E6CEC294E593; Sat, 07 Nov 2026 12:33:29 +0000 (GMT)
Date: Sat, 7 Nov 2026 12:33:29 +0000
From: Mark Brown <broonie@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>,
	linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org,
	Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] spi: rockchip: Fix runtime PM underflow on CS error paths
Message-ID: <837464e1-ea38-4f41-990d-876711128e97@sirena.org.uk>
References: <20260806191854.922530-1-eagle.alexander923@gmail.com>
 <179397711825.3231166.14531785924256368148.b4-review@b4>
 <au6LMNctO1fx_Kcl@venus>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bibToZSqeWfQi63X"
Content-Disposition: inline
In-Reply-To: <au6LMNctO1fx_Kcl@venus>
X-Cookie: Whoever dies with the most toys wins.


--bibToZSqeWfQi63X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 07, 2026 at 03:35:51AM +0100, Sebastian Reichel wrote:

> I haven't found the time to investigate more closely, check for a
> proper Fixes references e.t.c., hence it has not yet been send. So
> take this with a grain of salt, but it seems to be not Rockchip
> specific:

That looks entirely plausible - could you post it as a regular patch
please?  It's probably more important to fix the bug than to work out
the Fixes.

--bibToZSqeWfQi63X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCau8amQAKCRAv73Ows9A4
iYMsAQCQi7R5dv9+DhClm3dOkK6Qfg5ON0frbPavWRIh5njRAgEAj+/xkLjxUOrJ
F3H17y45oLE90NvyNnaf4ikP/MFCcAM=
=dfxK
-----END PGP SIGNATURE-----

--bibToZSqeWfQi63X--
