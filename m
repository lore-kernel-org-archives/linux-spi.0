Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0DF391517;
	Thu, 24 Sep 2026 12:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252262; cv=none; b=N+DOGu0c8aJeQ0BgUSc/6erFhLXRZEmDpMnbcYyV+Xi0fArgGn+PcRmPGm1shY81b7/zjcmXDs0+pUnMuQuv+7Y41aQ09w1lRvGahga8ZxPU8FNE0xPPzcQGOWShYfR/bhacVMJJWceNYoCINUaLkfgcB+mCVLqVRBKkzE/VjYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252262; c=relaxed/simple;
	bh=cPST8MJ8TSeF9sY6hxKTYUf6ipTLK8bGEw9EmCQ4rxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMP4A0zqD7KSsl+cDNlDtrMCZRREHBfl4Y5Kh/8b6kDmfIJ0kq4RoPZMUoP2102zp6yoPmDoDRxP4odQLElRAg/tBfK/nIS/2n2j+N5DuXoo6FboyEBge5+hpTAWsvYZMpah6zTLhpHn4lh7Ki0BmppROxZcaV2ESu7P7MFvguE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMA8Cxqw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMA8Cxqw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88CE51F000FF;
	Thu, 24 Sep 2026 12:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790252261;
	bh=cPST8MJ8TSeF9sY6hxKTYUf6ipTLK8bGEw9EmCQ4rxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fMA8CxqwudWuPG0E5ZdCROfZrhpZq/XSp9/Lt9Q1RaCjs5rQaJ7KDPucalqvCr1cV
	 ECYVS2CL3hGU8ncfQZwdWRNcHxlAMY+Ep6JstbwXixQLa6+bT0t2DX+C7j4kxDRC4K
	 OZVjaIxhCC2+i5ViQagcWtrA4cfs7diqgwcFyH22rFyhyZUWgD4lS5sMZ4q5H7jmZy
	 E1atClSu+dtDj4hS3nqNQ8yET1UoQJxIqdr1iHUAWBdRVzva+PEYcARIWBWrdPK5yd
	 Wf/j63ZYMCOyd6KuI3xxGX46bXUl9S5LJaqL1Fj4s1cXfbcJOpnY3efdP2K7joxlAR
	 T4yS97EycaYNA==
Date: Thu, 24 Sep 2026 13:17:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Tim Kuo <Tim.Kuo@mediatek.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>,
	Sky Huang <Skylake.Huang@mediatek.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: mediatek: add mediatek,spi-ipm-v59
 compatible
Message-ID: <44a113b8-1ce0-4a17-bc07-b22f15665ef2@sirena.org.uk>
References: <20260924031211.2199921-1-Tim.Kuo@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tI8QpB5ulHks/lh1"
Content-Disposition: inline
In-Reply-To: <20260924031211.2199921-1-Tim.Kuo@mediatek.com>
X-Cookie: Oh, so there you are!


--tI8QpB5ulHks/lh1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 24, 2026 at 11:12:10AM +0800, Tim Kuo wrote:
> The IPM v59 SPI IP differs from earlier IPM designs, most visibly in the
> tick delay field of SPI_CMD_REG, so it needs its own fallback compatible
> rather than reusing "mediatek,spi-ipm".

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--tI8QpB5ulHks/lh1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq1FN8ACgkQJNaLcl1U
h9Dkxwf+JLiki44QczCJPdR7+T+U9+ImnKHa4QgCTBVGtu3Eyic2dwfep5sTkxd+
slZAs0royqIPXTRPtZmJnSrT2THSkvnSJ2YKQ6Oe5i/JbHDDIYxBoA5jqrX0hqUJ
wAID5faIFg1aNzFABtragm00EcLB+tD4j3J/uDQQfm+52mFNW89HCIaSAYT3SvZB
0tJGgE9qxYFTscyEpluvYGy+T6zl1zwWxd4ejiLBslNDW9rkfMycAcP43DL18TzE
Kp5PX+i+djEYoo/j/e+w/bA0yxdRmvflbCsAFPFFvgWfK5PUtBcm3mS6t7JTCbvf
AmTWpvf0CKPjopPgQv+uvXJZHePGzQ==
=Mwwx
-----END PGP SIGNATURE-----

--tI8QpB5ulHks/lh1--
