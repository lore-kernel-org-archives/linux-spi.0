Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF371FC101;
	Tue, 12 May 2026 01:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778549238; cv=none; b=GJQg4ZGR7n8zXnC5xHTpM804GTMcUGr5KqJ8TUZI7aGk0f4oYckxKPLAbXkscrVd29HMU76WWgrhUTHbX28ufsVuMmRrDU2nmW+3PJwLHiWAcIfhE8C7mPhr7WXkGIZdYtRemhFP/qn/+UjOT33U82j35HLzRGDvX8Qx8b927QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778549238; c=relaxed/simple;
	bh=oUJ2ENxBJr/aEbr6dAxLopR+EW9fYBCZYTg0zi3ROzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fi9YcpqgLU1CFsbqvaeIv7Id/LFaNAsKMzFKtseg0SLMfsh3QG5Dx9QfiiQs6CgxT5YwBqQPMKYDc844slgEjubqOmaMTchwU96O4rFJ+Pfd7MRrqifZOCVwCym0WTHRRtxEZdfk1nmV9xUR+bvQVr/v5MMkwUTSNhj2y0yHgl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Et5E7njp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Et5E7njp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7266FC2BCB0;
	Tue, 12 May 2026 01:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778549237;
	bh=oUJ2ENxBJr/aEbr6dAxLopR+EW9fYBCZYTg0zi3ROzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Et5E7njpFt1hBoVQUAa5GjoxpaFgvXaEwveaXxY9WmreGQN673MtFgX1YJLp9kkkm
	 JsWjkH80bM7G83L6Ba1+AHPI7Z2i08iGB1eBdtMk8lcJCSyHNZ0N9FDJ9izCk8Snt4
	 e69Tnzq1nP9eBBoKR4VxnQehMW+g4KroR0TrBaouS/3LCfHA9zSzE6PDNFsic3bHNP
	 fmx5VoKZxDTa77DwNCv+RNi1ekSTYN1BxVDALBn17Hjoh1YCCrRfQzjHpN5EENwI/+
	 fbCg/FmCRsOG9ERB5qYIyx2zxCzLWI0Dc9lHddL+TiykMkrtXRjCeGm6JYdwngen/y
	 6jUQtVe1l+tcA==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 6D0E61AC58C2; Tue, 12 May 2026 02:27:15 +0100 (BST)
Date: Tue, 12 May 2026 10:27:15 +0900
From: Mark Brown <broonie@kernel.org>
To: Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: MIPS Lantiq VRX268 general Linux SPI timeout
Message-ID: <agKB85O1LM5kF_J6@sirena.co.uk>
References: <m3bjemm0ds.fsf@t19.piap.pl>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ol9mjDSSaJOBAxyd"
Content-Disposition: inline
In-Reply-To: <m3bjemm0ds.fsf@t19.piap.pl>
X-Cookie: Truckers welcome.


--Ol9mjDSSaJOBAxyd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 05:28:15PM +0200, Krzysztof Ha=C5=82asa wrote:

> Now what should we do with this?
> a) should we increase the 200 ms timeout? Would it still fail eventually?
> b) should the timeout be configurable, maybe by the platform code?
> c) some other way?

If raising the timeout resolves the issue just raise the timeout, this
is not something that should ever happen in production and is just there
to ensure we don't completely deadlock on catastrophic errors.

--Ol9mjDSSaJOBAxyd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoCgfIACgkQJNaLcl1U
h9BwZgf+PinRTIDJRHuncyCylEpXjckGZz39hA2jyj0fSst6SbujQtnoqkkq9B5L
JJgHZZ3b1Tq1EgIhiEI1crEehjgC42Lgn59zEwn+lxCoh1MadT8j+PaGarTlnmNk
Xz8TsY6mbUMRBj0DJFeYvIxg+0kItXhPNT+7JIUz2NEhSnsyNM3/SJRrOAC+GD/z
iR5MU10UHacmluuvG8rR5LhuYwTIJZcFwZG7aN6A7Luda4m4E6z7jRYEgujx1e/m
xVE29dq8ubcT8tWbzf8OYrVHLv8nc1Kd9LZAKdRRl5sILKH9fStmHfu5c6ejYYGg
VQYMWw/PNqUQeOH6w3HWkktdtSvtFQ==
=DWsv
-----END PGP SIGNATURE-----

--Ol9mjDSSaJOBAxyd--
