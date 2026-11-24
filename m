Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795520157;
	b=hqNEBiV8DQsC5BqCjrURm57/5+ECNLhxYKdJhAG2bEyT7lkFYkkCFaSG6cezpCTcJH2M
	 cH56fZUy7ZFsy/4RiiLLIVIAq0FXnVkXXh/7xIHnn1jDbkPRmXKfMMYb4MgaGbI6o4kBm
	 KTCUsX9gxu6kkhLnraVg65ITwwvo8nxMU0UPjp0nXSM/vZwMaiakE4ePHf7odzOP8mBKv
	 Iex8WTAaSbwwaWmw9g10XZNgGAsMvubO1v+RUm5/dXv5fnfr7sPUZG+FigP+Q1BffQkYO
	 2OWDwOzlRyN7EuGYium7w/LNyOIX9esU6OB+wJY74tBxmqitUQAJiu0pU4kGyXPocqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795520157;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=876+fwGzsHgubS3eU7gxfVqu6W2+V0uTJ15kZvLjf44=;
	b=bNErUBOJZX3qu6uJlXIla79sXzSoo3OtvxnmGYbUi6xdfeM6hwsr3EjuZc2M+18ioEjL
	 tSrLlLaKbIGxCfnDoTa91sy5oDLh3ECYN+N0EHGW9AIgbz0eRdCU5LsMwXx3GJA17R5xY
	 kDFUEExdDAEJ72/ky9vB2RI4EQ0D5TwGJfgPxlHADDMKwjgbULbhH6sKS012KcWn8Nx1X
	 rahcfZmEk6I3tfJ5lkA7e24NhdT21B9N3Hq3T+72nJL09NYURXjoIb7lnLS/oNtVTBen5
	 4fSYC1k68rqKrhk3VIkSHAq7/2Yd0tbNVp6GsYo36IrJKCw0aCDBg39Tp6XDCjHa1EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cGGvjYyd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE6F606A31E;
	Tue, 24 Nov 2026 11:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cGGvjYyd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905191F000D0;
	Tue, 24 Nov 2026 11:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795520157;
	bh=876+fwGzsHgubS3eU7gxfVqu6W2+V0uTJ15kZvLjf44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cGGvjYydN7/lzWQLw3o4rLdPdRwW19vuuiP1lU+ADsTFIMgqW3R8Upg/8Yi//KaGY
	 9LCcaE5uBbyvffTzy30uumDf2VoEPU5qQRZOKzAniakx7dah7hjoe50HCT+CnWse86
	 tTfAJBdbXfun+exa32JZJs552xW0YEo1i6RUKq1lyJeahkygJbsUFss75mNzWYDcFH
	 QbRtfQYdIKnBY9PwMlzi5k6oy7w6xus/b7CeEcl2t/sMgzhbC2LOdkVr8uVTIYqB0C
	 gTeuAThq3JfKevDJyML6xakqK0d/4a9V05yalHMv4uSmY6zdk9OTTkOSF/WWgpbAPW
	 KbPtbRuI0qIdg==
Date: Tue, 24 Nov 2026 11:35:53 +0000
From: Mark Brown <broonie@kernel.org>
To: Yadu M G <yadu.mg@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Praveen Talari <praveen.talari@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: spi: Add compatible for Qualcomm Seca SoC
Message-ID: <04e8a33a-ad20-4f2d-845e-1c0b13984a69@sirena.org.uk>
References: <358f1284a656582ef0ea0e2b7bc07224372f9fdf.1795517702.git.yadu.mg@oss.qualcomm.com>
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
	protocol="application/pgp-signature"; boundary="h22AHbBH7jYC9AtG"
Content-Disposition: inline
In-Reply-To: <358f1284a656582ef0ea0e2b7bc07224372f9fdf.1795517702.git.yadu.mg@oss.qualcomm.com>
X-Cookie: Real Users never use the Help key.


--h22AHbBH7jYC9AtG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 24, 2026 at 04:25:03PM +0530, Yadu M G wrote:
> Document QUP GENI SPI controller on Qualcomm Seca SoC which is
> compatible with the SA8255P controller.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--h22AHbBH7jYC9AtG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmsFdpgACgkQJNaLcl1U
h9B3nAf+MIXSQROnhAHfC/ntT1IpFGTsyVSpAhCrUcBuoeWpmQ0ckd/AY66tZ7TT
nzDjp/dn1tHH16cypPJsYps5jXAHLTNWtsHUNsjoqRQCFY/TjfsNuCxkTts9QqlD
KFccmwrmEepVtJVrnDXu5Fbfy8YQle/ZXx0YEe9/kDsU/NJOzdfao/a+rf5EXXFP
qx5x3sDNTP27LKNNgMl9UMIyW0HtbsLeKtV2x4+UVW0DC63WJr7igVswvNiwPs7R
TfWbNfXVkwbW1EJOnuHYeD6mBM/aaNOg63Rp2Qc05XwdqKgc4+HiPvCNVTLImD8/
6k7iStDl2r4WgTQvHu0ZLh3XIKEJYQ==
=XhVd
-----END PGP SIGNATURE-----

--h22AHbBH7jYC9AtG--
