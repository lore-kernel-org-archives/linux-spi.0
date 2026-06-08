Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1D0384CCD;
	Mon,  8 Jun 2026 18:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780942172; cv=none; b=lO6MJC1WK3pCdpDSTJlUeKDPMjBlUziZJXgxC3CWpxXTnhHDDrINije4ou+5GlutdTZmJTDjyUqwnTlHpgcBMEFwjw3yUCVtBNagOmmQKo54Tg3XfaNCodvMByv0IRXpZ0cPhRmFx3DYD6e/Ss2ObSNma/LinSSkxI3jByUNGkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780942172; c=relaxed/simple;
	bh=GQD84jiJ53f0VvVZzKkCViIPd6j8oZOLz3cqprwn3vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+8lpeqTLx0HQUb9+ADm8+r0nnoOXnihYQEsmBs8eFhBH0Gv55JU44nrH23J8KmIx0slXPlDev9uJADOWpXS8OV8P0DG8qa0cbsCay585170IkgPnzyMZi6JkQGGFR6yiTyfpXL8ZJvwxg2Qk/0OVKDEPI2ZtCuWI3O8fTFN5IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfKGE0Sl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfKGE0Sl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECD91F00893;
	Mon,  8 Jun 2026 18:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780942171;
	bh=Oh53wHcvsgHIUjUod/3WqZ3CDxkPDjLqN6NEj/vXsXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lfKGE0SlvnGkF3VDq5e1jksszi4+NwMf+jAzqj6pT+yFX6peA7hWnKP/HsNrj6Ddi
	 E6dn94nRDvr0WDuEcFpfSTC7JT0B5crekv27UBH3av83iGIH2kkuhkchKQVyGWINBr
	 u+PXu2aZePQKXRAGI+WvHskxhso/LXY0OC23VhaVdIchXID4RUMdAh7+bQWxqrMYii
	 jzXYVLl+cWl1FIWNikGgh69ZL4DCro+hq9E5oKXTgAoynQWzwQYBFGE8pkMzWJ+uSE
	 5QNd/a3xncSWL5G2EQCVbgSNQJ1fhoEwZDnWaVBv5SbrkR2l7snIWkDK6sggWOZI8s
	 vzeuQ2MdFtiZQ==
Date: Mon, 8 Jun 2026 11:09:27 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Rosen Penev <rosenp@gmail.com>, Jisheng Zhang <jszhang@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: cadence-xspi: Revert COMPILE_TEST support
Message-ID: <20260608180927.GA2211222@ax162>
References: <20260606-spi-cadence-xspi-revert-compile-testing-v1-1-76219ea378bd@kernel.org>
 <a723320d-20e1-4e5d-8a11-d63f84bc8f69@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a723320d-20e1-4e5d-8a11-d63f84bc8f69@sirena.org.uk>

On Mon, Jun 08, 2026 at 11:31:33AM +0100, Mark Brown wrote:
> On Sat, Jun 06, 2026 at 03:26:04PM -0700, Nathan Chancellor wrote:
> > Commit 0c5b5c40dc31 ("spi: cadence-xspi: Add COMPILE_TEST support")
> > allows this driver to be built for 32-bit platforms, which causes a
> > semantic conflict with commit 4954d4eca469 ("spi: cadence-xspi: Support
> > 32bit and 64bit slave dma interface"), as readsq() and writesq() are
> > only available when targeting 64-bit platforms:
> 
> >  config SPI_CADENCE_XSPI
> >  	tristate "Cadence XSPI controller"
> > -	depends on HAS_IOMEM || COMPILE_TEST
> > -	depends on OF
> > +	depends on OF && HAS_IOMEM && 64BIT
> >  	depends on SPI_MEM
> 
> Why combine all these, they're not obviously related and HAS_IOMEM can
> be turned off.

This is just a straight revert of 0c5b5c40dc31, so it is just restoring
how it was before that change.

-- 
Cheers,
Nathan
