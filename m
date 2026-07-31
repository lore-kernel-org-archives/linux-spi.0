Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316B3378D98;
	Fri, 31 Jul 2026 20:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785529705; cv=none; b=GOe1nftpwUW39Bz96G2mA634CacHJpBo32FSZi39/Pgzt8BGrQx6bsXKKJ4XMon3Y6Vna0s0j795uxn5R7RlwHSmU233HkDjlzgRKxQsiGiywgxGyEppdmTpkrH4lTgd9Mp+xE4RDU0P22Y8k/R68pEgIL5bxZhlDCRqK5SgWYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785529705; c=relaxed/simple;
	bh=UlfLHhsfVRRA2IXK/jiVHmYps1AcbvBZLryo0bq3ryA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1qbjWaRTSh7h3OQ4m3XCWdZUaH94PqgOy7PrngRjCR/7xo8/oProBpBlEN7vEdIO9+jFmLeHoaaVzdU8DLP3E8tbUMGKlTV0peYMRx8PIzRb3EM3frWZRzOZfcNeBEG8rcqpCEWoU23V++17U6K4kOg92Cd0F5qUO50z5sfLwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RocqfHZ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RocqfHZ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46341F00AC4;
	Fri, 31 Jul 2026 20:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785529703;
	bh=YwfwtYedoAYnXW3RFF0QQ984O9NKILCL29Vuw4RagBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RocqfHZ4DdmBRsHm0GYmpWyjw3R2lD2KQ3rujjOaUt+3YXjFAmK/ehdX/+kZw0BNc
	 yn3JnvxAJt0IhCyFSSbTwDcxhojvaq83/WaANL++PXuQfxAlcpycaPD/uchKxQgBaR
	 3LNa71E2G+h9Tc3ALO7YjTH4BxR3C87QI9bxVAetjZ47R/q8AAAY5MRTIf9zjSQpdD
	 vkFD6/XtYtacAMhVrZe7XyCBgCYI2G2m4mdvpaZ/zgr470MFztOUSr4i4/aq+9qNPF
	 QGGxIpZy6PIaSz0e3Q036Byhdt1rv/YRo4PVSaZGyiuvdeM5uB2DFWVOvAFmp/o5Rx
	 yu7FdbDZZkzgg==
Date: Fri, 31 Jul 2026 21:28:19 +0100
From: Mark Brown <broonie@kernel.org>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	cwweng@nuvoton.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: spi: nuvoton,ma35d1-qspi: Add
 Nuvoton MA35D1 QSPI
Message-ID: <5769eae0-1b40-419f-8311-0d919bf619fa@sirena.org.uk>
References: <20260731023818.1626075-1-cwweng.linux@gmail.com>
 <20260731023818.1626075-2-cwweng.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Cs5fTReg+qQ322w5"
Content-Disposition: inline
In-Reply-To: <20260731023818.1626075-2-cwweng.linux@gmail.com>
X-Cookie: No shirt, no shoes, no service.


--Cs5fTReg+qQ322w5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 10:38:17AM +0800, Chi-Wen Weng wrote:
> From: Chi-Wen Weng <cwweng@nuvoton.com>
>=20
> Add a devicetree binding for the Quad SPI controller found in
> Nuvoton MA35D1 SoCs.

This leaves the generic binding's support for GPIO chip selects enabled
but the driver doesn't set use_gpio_descriptors so they don't actually
work.  Either the binding or the driver needs an update.  Otherwise
things seem mostly OK so I'll apply, please send an incremental patch
for this.

--Cs5fTReg+qQ322w5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmptBWIACgkQJNaLcl1U
h9Bvdwf+IyO6Hu9Z5099OlvPR/gx0z5P+A2YPrWyLLDOKaffMb1GC8evhY20FanO
e/xY0SsVy0K4M5UwbfvOBfK4eBfMujZO48FaFx/7eSWrs9H2pHytLSdJfN6DXrFr
93XpW0f0gafiU8vxRMu2mY7fnqR3B7VtdhsjIW09gCG44LxWi3YbIE4s/IQVCQT1
QnUB6DSjDB6e7YNDha19LVEqjdp/vxZgmpsEt43xs9TvZqC5iyOn3Ycuuxy7/eLm
y66Vr4vMVCTkkQ9jbR0orEdJzKY5I1QKcrJUc0+0/kX1FTrXPp5QcxCH2/ex6yGk
UWID0/HT7/b3Vv5M3v3M3QyVljIl2A==
=GnHY
-----END PGP SIGNATURE-----

--Cs5fTReg+qQ322w5--
