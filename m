Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258B93B995F;
	Tue, 26 May 2026 16:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813027; cv=none; b=Hx+bJ7gjG8zAZt+GdASYBm8OkFoKTSGmpOvX3c5aO2g46xfcTpgqcFSS5M9Ax5fAeOpYT77pBSE3gz2UfbIQ2R2+HoGSEKXlJm25+EFvbHA8kcSjF+w9vYv5Gb1mjxnG9o4pCfEieDVYS1oxuMrijBBkkoOaSHUV/7sCXGqSRq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813027; c=relaxed/simple;
	bh=N1zQ/GnLIMTNMTyliK2PK2FgHD+TxRA5OeforZE4vNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHDjGXm8WaEKbTgeBX5aWg0Peb7ZQYayi/nXJtBvwtzRx3h7ZnQrDVwYStv6GU0CuiP1WL78ZuetXfMqeYbAQz8cuWVXjOGsCEqf1jed37g1efQOvSaZWqVBL6LOuA/a6fqwJP4NZ2jxlZ8OBMyHkmlwiUAERxjHlAU2o38+NnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E98wwYHq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E98wwYHq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39EB41F000E9;
	Tue, 26 May 2026 16:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779813025;
	bh=N1zQ/GnLIMTNMTyliK2PK2FgHD+TxRA5OeforZE4vNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E98wwYHqUSZ1ZFu4yZW2IYMhiymKdhxy4pI0qNyTU7tiRSe2AQfOW2dinU4YRaoiF
	 WoMmTOIQjL/C01NOEwoW7SthRE8x72M2xEnAVqm1n9BXzr+3bbYeijvvX5aMX0agBS
	 qdoGBuldJpkeetMlVqHFw4YEssWpm1WMf+A5x74inLkn737/tJSY4SWP6yhR36cSp0
	 9J/Y+i2i4Yk/i+Skgsm4pmYE9s4XS+rlNzAxbjAyu+wrWUydg5ZL2+s1r81JW0fZRB
	 PZEu09LoaVDO8EPw0qzEafgZ93w2kUpbatAI63ySd6pxsJ+AyJqfpyd56BPeSYAdVX
	 KEjva8ejbhgbw==
Date: Tue, 26 May 2026 17:30:21 +0100
From: Mark Brown <broonie@kernel.org>
To: Gaetan Florio <gaetansjo@gmail.com>
Cc: michal.simek@amd.com, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: zynq-qspi: Remove redundant clock enables in setup
Message-ID: <8b3f5645-5589-4ad4-b4af-ff5d37b35717@sirena.org.uk>
References: <20260525174614.1052191-1-gaetansjo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W3rUfarjGCZc3sU7"
Content-Disposition: inline
In-Reply-To: <20260525174614.1052191-1-gaetansjo@gmail.com>
X-Cookie: You are fairminded, just and loving.


--W3rUfarjGCZc3sU7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 25, 2026 at 01:46:14PM -0400, Gaetan Florio wrote:
> The QSPI clocks are already enabled in probe() with clk_prepare_enable().
> zynq_qspi_setup_op() enables them again with clk_enable(), but the extra
> enable is never balanced. This leaves the clock enable count elevated and
> can trigger warnings when unbinding the driver.

This doesn't apply against current code, please check and resend - there
was a recent fix here so I think the issue is already fixed.

--W3rUfarjGCZc3sU7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoVypwACgkQJNaLcl1U
h9Cg2gf/ZuG4skohiVfl20CqyWYWH6iC2PcX0TOn8HhH4ZN6TCrrOhumy/+yjsCg
RwNIeegsZZKd8Nh4QD9/TUSeNgFW2LBfxs7orFh7f7q+R1jIJivR0qtG8L7N+nBS
rGvFAwLKo06wP99qX5yFuYS+HF2gY8fShMysJA3tkdvBL5Agmmm+I5x7r+n/4VSK
14vYazehz9CiMpN8LIXcqipJj+pC0Ygc5PxtP8Ki9S43Z6GuO5tzJG+7A+ZZMhC/
Wni2ohi+idn0EPXizVP/R2pl91mzj/LxdFR2hQ67JFjRk1LK6bDCDDCMdB6X5Zv4
rLF2365W0U2Vw5g6jdh3i+UBCIGfxQ==
=KHGn
-----END PGP SIGNATURE-----

--W3rUfarjGCZc3sU7--
