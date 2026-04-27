Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B076E2EB10;
	Mon, 27 Apr 2026 23:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777333530; cv=none; b=SUH1QcsHA/qoN+Sgg9AMeZtY5iad1U7R8VoZlW+XwEdQBERAPkuwT2h3ErOmDKYqsZ49FPUEz/s9FUfyOMo7Mu7Dm5yX0EInb6WFdufvO/DPdC32sFJE8zSLwEwCtptIocWRPdmz6nW+nIx2C83XbmzRTru3tRPxjxe7NhZFKms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777333530; c=relaxed/simple;
	bh=iNUVz32+ZmRXhhmJskRiUJf6GS14RqQQlQPBx1DWsKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEqmeHQF1YMWxFeSYqDrFR+G4EeBzKsSllAQxF8uJwPz1cdmYGLdGw3oubmuKokySKiCgA9sew/d1eHmxdJxRdt3j4t7rkV2qztyJ71cYLrJaEHVcQQJa6+DX0E2Ve/oftZxxSPjj09EA2RwyZChCS5ZMFK1l6LiA5csEi62YpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+IJFxAf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+IJFxAf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BAEAC19425;
	Mon, 27 Apr 2026 23:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777333530;
	bh=iNUVz32+ZmRXhhmJskRiUJf6GS14RqQQlQPBx1DWsKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J+IJFxAfLuZ846RGVISa3U7kuN5V1+FpjxU3GkRmXZSD3H3MGrbV6Tm7MfNxtK0Dn
	 wALy27ziHiAfInsEO+ReGT65yrLEoSHPgUDE2r/z6PLQaCwV51tFuQxIEyB95U+VlH
	 asp6crTuydstvTk69W3ZvcsmII/KGOlsicfCJSiCpNCC76DpgdmoFXeo5K1kjV2npP
	 n8D1etefFPz0CtEp0DvLEhnT3MksTBHrUowzwwjNjAXqg+qwUpDH0UWqHRhP/wWXBJ
	 fEGcvCE3vl5TxXlrt9YY6qHjBClLtV6ymGDxPPTcVe/mUWN+AWOEg594UkuCIDDPFB
	 epCC/Z1B37I6g==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id CBA451AC583E; Tue, 28 Apr 2026 00:45:27 +0100 (BST)
Date: Tue, 28 Apr 2026 08:45:27 +0900
From: Mark Brown <broonie@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>
Subject: Re: [PATCH 0/4] spi: spi-mem/mtd: spinand: Prevent SPI NAND
 continuous reads on am65/am62
Message-ID: <ae_1FyLxEwWqNFzX@sirena.co.uk>
References: <20260326-winbond-v7-0-rc1-cadence-cont-read-v1-0-0d626e1dfb2b@bootlin.com>
 <87mryoh6s9.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8Joz10+QGWXmFyC4"
Content-Disposition: inline
In-Reply-To: <87mryoh6s9.fsf@bootlin.com>
X-Cookie: Victory uber allies!


--8Joz10+QGWXmFyC4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 27, 2026 at 03:28:06PM +0200, Miquel Raynal wrote:

> This series is related but I wanted to double check with you: can I take
> the spi-mem patch and include it in that immutable branch which I will
> share with you for inclusion in the spi tree?

Yes.

--8Joz10+QGWXmFyC4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnv9RcACgkQJNaLcl1U
h9BFagf/YjtP5kDc3k98IW+Rkwo9nxiTLI8aFESXl57np0JJhmJkJVyzpgO7oK0N
plECehs4WQSfZYZ6wtwQwZKadh0+L7ZEn3xv6pg4MT5MumZDKhO2979Hpowpev0T
pwgm+jLz8IQQhFd8MMfe9c5mpquctPZu/8D6Y3FC3+6f/5utfV5yhY/sEwVXY6G6
0/fQM2h/zCKrPLFdbFIYWKAzIrCOK/0BAniwl3D3OZt+RBGYSM1DRi8zP8ILVb7w
hW+B+lBUEp2KkbVUBLmgbsdnHNrgSLEyBzYdbvQfO2ZDB1xDkpkJG0hfq6O2pph2
2BetnLGK+TzAuBpeFktpFLmqDPTbOg==
=Lrto
-----END PGP SIGNATURE-----

--8Joz10+QGWXmFyC4--
