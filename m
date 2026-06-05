Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098D93F8228;
	Fri,  5 Jun 2026 11:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780659886; cv=none; b=Sdd0hfkIRa5t/pOZ7VFJiE9EtPvVvoIKIGCgH/Ks1szF+AcViXU6YLkPiDIzBx5sIFGGLStpFCad4VuGs894ch2zxQzTHTdFu9Voi3s/g0l7BdVv1zSWMapEZ5pittceqhjebK8w6pfq+D2f76bQx+QPwzGb+i0W/HlfNQW9L9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780659886; c=relaxed/simple;
	bh=lYNZ7Ow04WpOY/PM8SG2wXYg84A9g+fxEpMlpXaOp/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMjlsru/DlfdNw8MH1uyxVVRSxtRE3bMOxcZ0He14nTHW+YgoD4cvKqLhm+si5kZsbFLnmyVn840s8Q207vrUp+LGmSkv+qa0b+K4nHuJlfYWtIkvwenO0YGRV1YF0Skeri4waCNuRivBxFVpzDaRf/xzO6/84fC4JKoswkXD+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SovsI4ym; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SovsI4ym"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B4B1F00893;
	Fri,  5 Jun 2026 11:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780659885;
	bh=RhPl1xcsvy4s3kBqUiJdyhDa0kRnDkJCTM8WL4mk19M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SovsI4ymUus/MClDf3Ib+DzgZCFkndhAZPeI3Cj36RrhpyC4AfSSvG0wG7nAOObGr
	 qV2IgMdPbeAh9bcUvUQxVN0FEhMd0IE8rc87wDnL3e4LGUw2RDtlowYPQepjfSaWsk
	 UZCOkAyXdozEKQ/27+Cn3j9czCBJ9LlAoJWJhqSRIOOcBBE4mFKF1KLU8gFG6XTW6R
	 A04hGuQThLzXXTSeLFxMhttFqhcS8wyV1Jihr3tsPQsXJVmGbzTyWPsxk2siCkjcW+
	 fff2e5THziN9s0I/zz+rtGKTQ3d405syXHqkqDiNxvnGMzmOOEJx7rwlVH6szGS5/P
	 ajf7Lnb5j+mJA==
Date: Fri, 5 Jun 2026 12:44:42 +0100
From: Mark Brown <broonie@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Jisheng Zhang <jszhang@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] spi: cadence-xspi: Support 32bit and 64bit slave dma
 interface
Message-ID: <08471583-05e1-48f1-9de8-9297fa2c601f@sirena.org.uk>
References: <20260602235825.28614-1-jszhang@kernel.org>
 <e9259b2d-38f4-47bd-8816-3940c2314e9d@sirena.org.uk>
 <aiC98CaOgjs-q39m@xhacker>
 <f1cacc64-1f27-480a-8f03-4f4b0dad599a@sirena.org.uk>
 <20260605020634.GA1820810@ax162>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="05Hntv/qWgNXdU+7"
Content-Disposition: inline
In-Reply-To: <20260605020634.GA1820810@ax162>
X-Cookie: Error in operator: add beer


--05Hntv/qWgNXdU+7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 04, 2026 at 07:06:34PM -0700, Nathan Chancellor wrote:
> On Thu, Jun 04, 2026 at 11:30:27AM +0100, Mark Brown wrote:

> > Ah, the patch is fine then - I must have been looking at a fixes tree
> > without the dependency when I reviewed it, I'd forgotten that Marvell
> > update had gone in.

> Your 7.2 tree has commit 0c5b5c40dc31 ("spi: cadence-xspi: Add
> COMPILE_TEST support") in it, so this driver does build on 32-bit
> platforms now. -next is broken with

...

> which would not happen if the 64BIT dependency was there. If
> 0c5b5c40dc31 is to remain around, it seems like option A upthread is
> needed.

TBH I'm fine with dropping that given that it was purely for coverage
and at this point the overwhelming majority of new development is done
on 64 bit architectures so the coverage benefit is a bit limited.  I'm
not aware of there being any 32 bit hardware using the controller, the
commit log doesn't suggest any.

--05Hntv/qWgNXdU+7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoitqkACgkQJNaLcl1U
h9D4hQf/ctYa6n/JVt/0p2qhCGTOIWlgLaPHXOUwn63MXAFKyZCQXQ3tJFq5rLHA
PLzDPvumCCuuMH/kxoe9scsIgrp3L8VSEt4YFjzPCRM3qPQ36o/zx3IOnKxC8gr1
5Eef2Gj/pOYup+fVXv+bSzRJtONGX1y1/cqGoVai3ztF/zHFtdlO7tetTUbQk0mg
kSSag6dQX8zbspltjLwOXvG0xv0HpgNfol5WEWXH3y8J/IvzEecR8aheKAJhHOqe
3l/CSRoDgjMde0rydm8Vaw9i5sj/U1iV51oZa2VXY5rlrKQGPYNNQUbnBU1OxHa1
CxVCoSqTkJj0YvqxkU9HsFLIOFjp5Q==
=XPMv
-----END PGP SIGNATURE-----

--05Hntv/qWgNXdU+7--
