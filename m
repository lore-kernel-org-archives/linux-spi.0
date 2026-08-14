Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAF13939B1;
	Fri, 14 Aug 2026 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786719303; cv=none; b=SmLWG4KWS2XtQrpDQwz0Z+Qro1TgpfeW5Bvvdlbp5TdM/t+jtzp7PYXbkKZoAPePaCCIGQIoKmR1n9N0coWZsn/jO9Slq2+P2ydkv0ZDv5CQ859ujEPV9+rmJtWtLoDMFXDHhObuMw0xq2W5yUG2XhWgrDNW+Eq3uP3sD3RYQ/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786719303; c=relaxed/simple;
	bh=JFTUH4LBZVuJ0BdPgvLb24tuPX47Ricy8PranmglIrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWx3zxXydOQ+gGd26nagT0xrFbU0M9NBmCmJSP7nXScbm7H25Db07d7qTVsS9MD9y7ztzTxueiHGjfjERvEF0l0vEqTovYcG+4ind/wBzz/ZspzSD4I9y+dxiKSAPFg7pML1ls8/P7FMzMOUC9JyX9fNj08OTb+DJdulOCOlSNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meXiWt+W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meXiWt+W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CA21F00A3A;
	Fri, 14 Aug 2026 14:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786719300;
	bh=rPIcBy5oj/SPEmZhQQcquejPyURqzT9qNJI7jOJb5GQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=meXiWt+W0DHFr5F+i+7Hlia/cgu9U1Qg2SQMaBIpe6TR5ZN2tB1Ok8R7/rw/qka6D
	 eoyVPSYVXLmlLXUIw9ttq2xc1JM8JT1Z3VGyxIj7fyLC8idUiz8xAB0WpFEu4FN1M5
	 j+iO1YA2ie4bIWSNvCq7pte7sHcOSo687BouCz87m295s60u60yDf4jXjiKloXeJwF
	 WFEc5R7x+vuI2yHzgT+EnAL6lSL0AZxI0dduruG+VryC4WTW/soVSqlT2lOpXdqwQo
	 xPOafK/lgENcwLT8DrWzUaUO8lOimbBCfgFjVjHlYp5uRrWOf49It7gg/Gdr3Y5HEZ
	 xJVgf/9sCxgCA==
Date: Fri, 14 Aug 2026 15:54:55 +0100
From: Mark Brown <broonie@kernel.org>
To: Udaya Kiran Challa <challauday369@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	skhan@linuxfoundation.org, me@brighamcampbell.com,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v4] spi: dt-bindings: microchip,pic32mzda-spi: Convert to
 DT schema
Message-ID: <e7efc91b-9d8f-4344-982b-c2b5014985b6@sirena.org.uk>
References: <20260814083221.34606-1-challauday369@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0DWBlUCJP51eztW1"
Content-Disposition: inline
In-Reply-To: <20260814083221.34606-1-challauday369@gmail.com>
X-Cookie: Body by Nautilus, Brain by Mattel.


--0DWBlUCJP51eztW1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 14, 2026 at 02:02:21PM +0530, Udaya Kiran Challa wrote:
> Convert Microchip PIC32 SPI controller devicetree binding
> from legacy text format to DT schema.

> +maintainers:
> +  - Mark Brown <broonie@kernel.org>

Try again!  :P  I think the DT people had some default they used for
cases like this, but ICBW?

--0DWBlUCJP51eztW1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmp/LD4ACgkQJNaLcl1U
h9ABJgf9EsSQunQ6QkKnoluc6VAmmq7Jq9c86ypx/AzNCeNL4pImzN1vPTU+zIBr
9TTig2w8kQMCa7TDVVoNqbPgqD+bfkI41Nm0sh1ziGz5XwNiA5u7OIVWMRpADTrJ
EyN9/B4zufmnZS3WgZjsBprriQ65Tl2vQEG/7jMMfvRdXyL6gnVI3eRu9sZ4DURS
pky7DhXOyLxUbzSFzP6Oqwt9890Jir7wbgd+Ftiy/gVsBc66qpUM7Y7a98TIKD3a
X0c6p3nT2vY41sqXZVrhpZzJXc4JBwox2uzYOkKlDj7My+BS1xUFyqtUNlDya4WY
4DEis9zl0o1KIFWn/Rp+Hs7efIcm6g==
=JfdW
-----END PGP SIGNATURE-----

--0DWBlUCJP51eztW1--
