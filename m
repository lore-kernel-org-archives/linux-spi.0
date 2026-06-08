Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B592E7368;
	Mon,  8 Jun 2026 10:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780915993; cv=none; b=bHxd1YIwoTqeWZw8R6wsMOpg7M/qX1op+2GfMp56aMLs+kI6oXuTC2NpWgEbE8bHbxElu373wHaHy0jIdddnHeEFmI1mI+2hb5aarVJ3CwymfxaDa7aauvXj6vQ5CMOfIBQPpUL2UzpKd98eT76+oLDpNXg7TP128a9VGWS4Za8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780915993; c=relaxed/simple;
	bh=n1AMChr6t5jfdanK6es/oTpN7NAI1DsuXSz0aZq2IIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzJfWJP8w2HqzmQthMoh+SudQOpgdw4WrzyuzFTuq0C/tyKyprJaTBLKHbLLvD9DndANdXQPr+eNLj3MrbeT5fr0bBT4+0kWTw/tM2J43rOFH77f+w0D3zN/dQ0pqXM6heml33HaBdxVZB2NT4hjv8s6QzCd8vCj2JwdSbVi8RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rrn4QeB6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rrn4QeB6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497731F00893;
	Mon,  8 Jun 2026 10:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780915992;
	bh=pTGSQgErg/Arp5VRvofr5JzJET68SF76bEcAEEeqMyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Rrn4QeB6IQCz0lWezlbna7qQFATILo8R3qo3AohPUrZXEgwUCTbOZIoi8TB4J1B0K
	 QXuLQVoyzSL69TccroGsPlnwmQePaGvnomxhqyA71LUmVDI3hVA89MxZEmSw3mzTbm
	 yVu8yeCjwtsMd8pfNnE2hRb+PwzewiFKf1vU4bIdHlbr2kNqqVyKquhVRIkjehGqCL
	 gq6XSYxAlFPOXkR0XGatAzTC0R+WB1YpYlxxX1Yj3/acun2mCEC8DmRHE67q6OR2Zx
	 HeXZoo0JMG5V0UDg3mXh5kzSB6/2xYxjMuaNPZc0HgT831nXZFBtho437ACJFWWQ5m
	 veEnPLRrlF1lA==
Date: Mon, 8 Jun 2026 11:53:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	cwweng@nuvoton.com
Subject: Re: [PATCH v2 2/2] spi: ma35d1-qspi: Add Nuvoton MA35D1 QSPI
 controller support
Message-ID: <8e751df3-6237-4c8e-9c87-34bb67e435f7@sirena.org.uk>
References: <20260608025009.1504971-1-cwweng@nuvoton.com>
 <20260608025009.1504971-3-cwweng@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Xd1MFY+nK8dwfKSr"
Content-Disposition: inline
In-Reply-To: <20260608025009.1504971-3-cwweng@nuvoton.com>
X-Cookie: We've upped our standards, so up yours!


--Xd1MFY+nK8dwfKSr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 08, 2026 at 10:50:09AM +0800, Chi-Wen Weng wrote:
> Add SPI controller driver support for the Nuvoton MA35D1 Quad SPI
> controller.

> +static void nuvoton_qspi_mem_set_cs(struct spi_device *spi, bool enable)
> +{
> +	struct nuvoton_qspi *qspi = spi_controller_get_devdata(spi->controller);
> +	bool assert = enable;
> +
> +	if (spi->mode & SPI_CS_HIGH)
> +		assert = !assert;

Hrm, we should have the core deal with this.  Separate issue though.

> +	ctlr->num_chipselect = NUVOTON_QSPI_DEFAULT_NUM_CS;
> +	ctlr->mem_ops = &nuvoton_qspi_mem_ops;

We don't specify mem_caps, I'm vaugely surprised nothing trips over that
when testing.

--Xd1MFY+nK8dwfKSr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmomnxAACgkQJNaLcl1U
h9CmEAf+MpO2k2NNGcoMDAdpYpmFVLXNz+7NM8gxd84SFap2YCj7QWwpERJVAemF
kY6pBKnK0Sjzx+b5sk1GNhbhG7SXYfqRv5NV/GZ6XC0g7f/TmBNn999DTJIkqpV2
Ke8NtxlpN47GU1n3B4OxYhsZ43FA2Q5cRtySFtoyRmK8quCSxS5EQpe2Q2hTfkdp
drPirHEvVXl1zynEwPmxaNUkqSy30Ic3Ibih2sXGDqtfrCH1liNDxzR1mZTnNjJ7
x/zhElVxcJhLxsqvRiEkAM92j3I4IkO7oKiEHWSpE5U5+oO0AyBtfVU/EAkbqX05
eRnQzWH1wTSKTa6lFWL+6e3piFV60Q==
=CCql
-----END PGP SIGNATURE-----

--Xd1MFY+nK8dwfKSr--
