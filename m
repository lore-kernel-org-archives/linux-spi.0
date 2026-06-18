Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805513D8132;
	Thu, 18 Jun 2026 12:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781787177; cv=none; b=PUatNYYAJ0CL2i9CSXgu0RJOzJW71Xc5vYORMHu9dOxYrsrnlCwQzCmQ4lJxaOYYsRyLCwzfPTBDsJMzPZ6cq1IU9Iu7XFhG8sbr7dSufbtmYpob+L+1hEN1k7/1s5eTieJZJnu/JOVHOD/LvRCdzLjn+D9Kfr6Vwbb/GdG67NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781787177; c=relaxed/simple;
	bh=dmeprXuLYyR2akL/lszBWYYAcALlQA8Um+uLTLTsxYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwlWKLzw9UtPkBC1XWRuWsMWIJpkqs9QLW8OKvysk688JdHiTHrOYyzK1zdbNWx1iGoU2gjbFHn/qKaB2x3lKz4QB0Nj82nCTsqa+3R8a2f0axkLQu+j79EZx61SQwzg3Bci7MZfsCpuO2TOpUW3hX30elnPOjolFqj4mtKLcfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIKZQS7m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIKZQS7m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1706A1F000E9;
	Thu, 18 Jun 2026 12:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781787176;
	bh=hFtv0bCpkP45fWQKAWd4dZGvV8Sw72GT3PsYcnm2eRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bIKZQS7mTqCMuxfO7TVoAmIbJ2+pHFAohMBvd9hQtR41Jnd33XeIKlRE0F8EWrEcx
	 R2DqHfqHO2+5k+yEFnkglqJlFC2+8+oI3T6Gh67H6LhVks60G5xdimffUDEN7GUD0l
	 gI78HmJKJ5CyrzAyM8u9xem4CzfHCkkUxyIUvi8KkMxyXg5BJ9zla3IPXf3S+3p7zt
	 Yoec0wHZSEnuTerimljxHz77kT7WYUyGRzqOv+ewOXSAZI/ks7c7p+vcSozoc7dvgr
	 SuuDfm/rXP3UdSZZ51ZpbvD7dGaxj8rjpn2UiDIAluuJYuNxUZ4jCO1ivTykhd9iEL
	 r8wpK8sbbRLJA==
Date: Thu, 18 Jun 2026 13:52:52 +0100
From: Mark Brown <broonie@kernel.org>
To: han.xu@oss.nxp.com
Cc: Han Xu <han.xu@nxp.com>, Haibo Chen <haibo.chen@nxp.com>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] spi: nxp-xspi: Improve AHB read performance with DMA
Message-ID: <fde1ef05-c506-43e5-bb0d-41477756ac80@sirena.org.uk>
References: <20260617215520.3327836-1-han.xu@oss.nxp.com>
 <20260617215520.3327836-2-han.xu@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2FrZl0V/Y9ofhCnh"
Content-Disposition: inline
In-Reply-To: <20260617215520.3327836-2-han.xu@oss.nxp.com>
X-Cookie: This unit... must... survive.


--2FrZl0V/Y9ofhCnh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 04:55:18PM -0500, han.xu@oss.nxp.com wrote:
> From: Han Xu <han.xu@nxp.com>
>=20
> Use eDMA for XSPI AHB read to improve the performance.

You've not copied me on the rest of the series so I don't know what's
going on with dependencies.  When sending a patch series it is important
to ensure that all the various maintainers understand what the
relationship between the patches as the expecation is that there will be
interdependencies.  Either copy everyone on the whole series or at least
copy them on the cover letter and explain what's going on.  If there are
no strong interdependencies then it's generally simplest to just send
the patches separately to avoid any possible confusion.

--2FrZl0V/Y9ofhCnh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoz6iMACgkQJNaLcl1U
h9Bz1QgAgerKmup6X49SiMAcBdeXoXlQAZ0TycdtJIMIXJxX7lzWv+DaV8asxeGR
W3XoYPkfTkSqOefka18rvhl90A/BrDzQ3toQcJslNuzgTXjh91T/XmQuPe8ZJpXf
HdrNATD3ml90LK9Tj/U8J/C2Gp/o5sUUdnS8d6OJBVy4hstu9AJrNx/C7h4XAhbT
bH5jDkF+SuqIumPQcB+cHYPqHkhvotoVwGYDztqD5eCOV6WtrfVOtgEXhum+vkm6
Fm0Op1+fZXcUwaPKCDwFwecRnDl8Gq7jvoamke4wlOokDtNLlZ5XwUqLz+0l9fag
wLHvKqMFekhn9F2F40VsgsbRf1FQGA==
=as8M
-----END PGP SIGNATURE-----

--2FrZl0V/Y9ofhCnh--
