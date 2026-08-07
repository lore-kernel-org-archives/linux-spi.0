Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8EA392C28;
	Fri,  7 Aug 2026 16:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786119284; cv=none; b=hOIZmYV31GyhwE9g0+BnTdXhcesdHVLOX1CGZw6R0lW/IJk83j5gzBsUYgNPKGub88hXglPMz1JuUQk6SCOAgFh8QKkeyOL4QUCm7gOXa1UWIevluvi8i5imTPUCvYbjNF137lcYG2XX7N0s+6BftgvJZGFSsg6eQq4LoHJIsbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786119284; c=relaxed/simple;
	bh=oEkbQb0ZDYka7cQYJwrDpt0trsB31eGEPzGJYDp/PVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoOljf1yt6mzNpTpHRV9mxNyyxOlykF5CPr4SdaD7nX2U+5C8CEQUlGIrvNWML16EKnZ3K3VFtmIT2vVlrPsD6rLz4e9p/0lNlZ6IUHaIg/sIgu4XBXi3NjK69WmzGpNvF7Nc0CjNik8j+PttoxkQf+Il5uuHWacop8IUfqyhZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPXTWEe/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPXTWEe/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D6E1F000E9;
	Fri,  7 Aug 2026 16:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786119283;
	bh=Ce3bmsMw6Ybvp3hjSTf6Y/EA1mGMrK4DH/wdo1/aRWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LPXTWEe/9xqh7SjixQ3J97lvK7K/kNOkQmZrtLQHV6Yxde23o5A2L8lhZtL+xRUXz
	 y7ebNLvcrO3ZCExu+oj6pMK/41arLi8NrS23aKCnYvGybzynZhP3UdbyeqPjepfQ2G
	 L0FPdRMrKPV/PQKY6r14WQvFUatOCoa/ylpfVW2pmBeEuMHvGlPY01T7jdmvqAtpds
	 c1yGMT3uvGuHlQdoueCNdygrfRvnYK0VqLVQerYVCQEsdVRRrh27LkBSA0zT0DL2lC
	 OyIVLNS3V72OB43Z4eKa9WYGc4AD9SNnvii9TOa/IR69XuiIawQE4CTAZ5vMlztJws
	 FS7H7jpD/2nfg==
Date: Fri, 7 Aug 2026 17:14:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, praneeth@ti.com,
	u-kumar1@ti.com, p-mantena@ti.com, a-dutta@ti.com, s-k6@ti.com,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 0/3] mtd/spi-mem: Enable DQS support
Message-ID: <8a729209-3bf9-4f2e-8870-1cbb64a95184@sirena.org.uk>
References: <20260807-winbond-nand-next-phy-tuning-v2-0-73595e89d6e3@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r3GbSDDzJpsUdjot"
Content-Disposition: inline
In-Reply-To: <20260807-winbond-nand-next-phy-tuning-v2-0-73595e89d6e3@bootlin.com>
X-Cookie: Make a wish, it might come true.


--r3GbSDDzJpsUdjot
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 07, 2026 at 04:46:46PM +0200, Miquel Raynal wrote:

> Mark, as agreed, you can take the spi-mem patch through spi for this
> cycle, and I will pick up the remaining spi-nand patches after the merge
> window.

As I said on the previous version can you please send something that can
be applied?  The MTD patches are failing to apply.

--r3GbSDDzJpsUdjot
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmp2BGwACgkQJNaLcl1U
h9A9TQf/Xu8QNGCHTl+k89v1pz97+qSw7Z5IUVIZCdcju5wItAyOfqnx0zSoMwhW
aOgrCRuVEplOIB2QUZeaB1regRr/wiIcIUrB/bw29tY9yAJlTYVRrh7mzCwNcgkY
qMGCv9/rff5ZwxOgl1cB7XYuaWuqu42Xjp327b8auTVelLvEf9pXxFtasM46ofBu
YM3AqLogTFXA5UKv+udv4nPtEuTnEx6BQOpz42vooh2aRdeT15iA1WeGgeWrRDio
ORVD56CZ2SRVKsW31t3MpeGmlsr5SzTco9BlhzNw5z3fCu0yxrjIIugI3oChpOVs
Y53wvy5Or7O0vJ80fbpRBoHSEE5oLA==
=RKeR
-----END PGP SIGNATURE-----

--r3GbSDDzJpsUdjot--
