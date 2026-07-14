Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8591B448CE1;
	Tue, 14 Jul 2026 12:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784032033; cv=none; b=DyAWrLpIwRYRhehfZ2yOhWAx93K5543IHtWAPzUzNF6K9UIkmpUQbLZZ/QRIrp7vqdv5lYjcXV7ffCNvDX6Dg3E4pUJKCre1O/UU2ul0pxZGaC6ptsYCu6c4pejIMeUYCDvO1vMO39RCWFfKTTw54AI91153aIXrYQyPilN2R5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784032033; c=relaxed/simple;
	bh=jveJ9Ve3MzQPBcsqfHTqBG7Ez446DsX8QdPJ6UO3psc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMGvVKsi/+C+1nW2FASS245EpiaVTIHCJTHMTPK/Dri1ocD8AI93yKEzpLSxppJvxniM4AyUz0kxrlir4Gc6X3J+NoVEaWnsG1Jr4MQWn9m1dAAiyeesfq0UIK8tQV76JdW7FDraSQicsLSzjcPXNvX6Eme/L+cu7WnUajzcFwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrU17R+A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrU17R+A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B84E1F00A3D;
	Tue, 14 Jul 2026 12:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784032029;
	bh=jveJ9Ve3MzQPBcsqfHTqBG7Ez446DsX8QdPJ6UO3psc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FrU17R+As4dTtuBKs5UwXEbdCOYTqmZgtV5V8lrNJmoTIryHXrtsnmj/txQM2cN4j
	 k/0VDSpb1PmnTKzSii9shxuFVF8QDBd3jh08xDuT9pI1fmWd3rRhB17KVYjOxvOgjj
	 m6Y7G6vLN7tPjcMh0BrAtr3sMweTx9AZqaoU9sLK6vQden+6Bvx8lV5NdHni6ihb+D
	 McWi5k7tSP84EcnQ0QB/P6zq57bDS0ErSNFRGL+RNXzcGDCLej5nqXVDvIGXVcEAis
	 JJpjEaR8zkaMn2sc1wLFgdp/JGUXeQIiVdqDX8xlbRc300CJ+0xuFnPXoBQsHMsfd4
	 4Eq6hLVZsWi1Q==
Date: Tue, 14 Jul 2026 13:27:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v2] spi: qcom-geni: Use GSI mode if DMA channels are
 available
Message-ID: <77953dc6-a7a9-4d74-be14-0424d019b8fb@sirena.org.uk>
References: <20260616122605.668908-1-mitltlatltl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="upJlTpi5TohI3iCD"
Content-Disposition: inline
In-Reply-To: <20260616122605.668908-1-mitltlatltl@gmail.com>
X-Cookie: Neutrinos have bad breadth.


--upJlTpi5TohI3iCD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 16, 2026 at 08:26:05PM +0800, Pengyu Luo wrote:
> Some devices (such as gaokun3) do not disable FIFO mode, causing the
> driver to fallback to FIFO mode by default. However, these platforms
> also support GSI mode, which is highly preferred for certain
> peripherals like SPI touchscreens to improve performance.

This needs a rebase against my current branch.

--upJlTpi5TohI3iCD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpWKxkACgkQJNaLcl1U
h9BdbAf+P0FiM7cDlhrEYzpEzlRzST/Zolnh6w84ZZbiFImeQ4V78ht+yL6B1pDi
yMJqrM0+9id3v+shGxkrQBm8CdY7kr8iRrnq4LX6BjyYwCBdMqHgWKcKavgCAn1u
SOv5MfvM7+Y7ApjYdy8gtHHIGUPniUVm3lVMuKg596t410c2uA9E2aXTmKuKixvO
JbbiVt1y7SgELVWDtFAWl0OV1/n4loQyNFLD/UAyNOBdCfV3LHlrbCn7nWTYlHJ0
XZ7fqFrhy9g96yyIFhekcnWQB4VsAxIuh/gLqg4XsMmPl6RCvnUJZeE70w0OepP9
cpl9FZoOuebxxldljIgcbH5LE8/1YQ==
=IXAh
-----END PGP SIGNATURE-----

--upJlTpi5TohI3iCD--
