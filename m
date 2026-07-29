Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4453E00A1;
	Wed, 29 Jul 2026 23:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785367794; cv=none; b=BBytADzuNqc+8wyOvP1D6foppoi5LUqz3SwgPMFz8+g34wbgZbnZYlW77YzKyFTIzFBk62LwxM016WC+Ui1/Cw3NReXwCUMTxnrxsEjONUf7t+9Ii2oa2zZ7MAD9G3xSSV/EBCo/ZDzU4+Cj0T0JXPumMFfJhnDlT1axgol9/Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785367794; c=relaxed/simple;
	bh=VxP0uduREoJ7Be/glwK1hb2fg1EFYacNeHpFwDFHE90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRv9pAycn4JIKxMiSTNtWncJ/GWj2FC9bKQ9j2OjONh2k3c3SGypvTckJHWeBQQubWmfqNPv2YB6sBvxPqbF4BlBEkVkWIZF1mAuDgVnfprvGm3XqwdO+yYwsfKoAl9t8cYCmTn+gVpKyl9UPVU4wlbSwOwf2bsgT6joEct2FeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QgTHhqwU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgTHhqwU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B421F000E9;
	Wed, 29 Jul 2026 23:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785367792;
	bh=VxP0uduREoJ7Be/glwK1hb2fg1EFYacNeHpFwDFHE90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QgTHhqwUoMCHWAQLhJrVPBswxSvAvDNBqQv7iVpbMilUI8rtewpEpRxW7NUvFLX12
	 JmvLfQTyNOR41HLtt00kurJjtoVrUDscJX4fhlLNHEiSn1Yb2SxEei116lfUn2noVQ
	 MIN9RlWbNtCk55jkElKfmVvVLQ8xNBG6bOm73SGfOdjLQFsD1ycN6GRCYS6PnvSOkD
	 6DmqmgPt9mcLqq9fQh1il5DcY0uTdip2pibqPnIYt++LsT5CVCJqcKVAeyzjt2YQJe
	 2XCZkzspj+X4jURxmq5M2gSG/MxuqcInX53paCmn21uGBVBaMSmaXEdw22L9RSZ0TJ
	 La+GssTLln0ig==
Date: Thu, 30 Jul 2026 00:29:46 +0100
From: Mark Brown <broonie@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, praneeth@ti.com,
	u-kumar1@ti.com, p-mantena@ti.com, a-dutta@ti.com, s-k6@ti.com,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH RFC 0/4] mtd/spi-mem: Enable DQS support
Message-ID: <e2acbded-b8bc-4f45-a852-0abecec45de2@sirena.org.uk>
References: <20260205-winbond-nand-next-phy-tuning-v1-0-5e7d3976f0f1@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="csLLV3JhdNRIAkyk"
Content-Disposition: inline
In-Reply-To: <20260205-winbond-nand-next-phy-tuning-v1-0-5e7d3976f0f1@bootlin.com>
X-Cookie: Captain's Log, star date 21:34.5...


--csLLV3JhdNRIAkyk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 05, 2026 at 08:06:57PM +0100, Miquel Raynal wrote:
> For his PHY tuning series on the Cadence QSPI controller embedded in TI
> SoCs, Santhosh needs to access the availability of the DQS (data strobe)
> signal. This is a chip dependent capability, which may sometimes be
> enabled.

> base-commit: c5884449d02575c7984000eb30d2a2971c7dfcc7

I don't appear to have this commit and this doesn't seem to apply
against anything I do have, can you please resend at least the first
patch against my tree or Linus' tree.

--csLLV3JhdNRIAkyk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpqjOoACgkQJNaLcl1U
h9CsPAf/fHHDAt+oKKCfY07bWGQaSVkV6a/LhY8URpM1lhWtZa95tUwIWiyZFjZc
m/2yODd4iyJ+XK2+ois6FCYy3HcUSu5auGzNY0g6+DWPCbZavSbC3vJjVYPLolXK
qjpi+Ab6brgj+xRPVUo6D6xVUBMR1mblpEEHKJU0FNg/z1GPUU5atZLdIEIruPT8
V5srEvz14tZz8ND7IGFieYjTojcELpJe9FeXg/+3vNaqBNPODeCz5IbylX3v9YyU
zzilTY8LdTqv11xnW/nLaLExewFjiZ+IbZDB4gnzCpioBV8eN343Cfam3VOHRx4u
soUfZuVn2+AbxTDms6nPGx7Ka1C7uw==
=MEZG
-----END PGP SIGNATURE-----

--csLLV3JhdNRIAkyk--
