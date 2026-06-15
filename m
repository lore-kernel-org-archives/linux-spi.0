Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAA22D0606;
	Mon, 15 Jun 2026 04:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781498969; cv=none; b=LY94XQUrygyUdrBFBhhnfTYstjiea172GYIm1P2CKo2sUUiRI6aQvU6wmPBSbDHs3Jx0h7NtS5PH0u2Uio/JxY3bD2lmEI/fHzkaeAn7o8lPEfHRLiOi8hpH3C5aXwa2RhciTXdEVVtsEk3k4WTrraGgGF4Q2581hEchslgMrD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781498969; c=relaxed/simple;
	bh=I7l3fZRFt0uqQDaf5mNJeKkeplIm8W5RWG8/qJ/lRBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSpt28NnEAXw9RMw+357PBKN+x4PbjFMFlnNn8fEHPDZp/XVkYnPyZx8Up82cDzN6k0fAAcjvak0HWREkMGUIS5+1dOBwYj1BLOlgySI5/Pk+UnCCXgv6gEIvLYHB4PQPUmh7aD6YYp5Sw8W8iK4AQtkuVX8C5vXFQkeAq5eljI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4sElz5M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4sElz5M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C694C1F000E9;
	Mon, 15 Jun 2026 04:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781498967;
	bh=GcYsPijVBsLoMGZ2Y/ySwoF1EWTNUOjSNwA20h948EY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K4sElz5MN27ecSqjjUciSpsfhpawFi3zTFFBJaYmcph9UBxjrVchC9vZ369/8Hm/b
	 LqzyeKNBBGzhWLMSVmofcWwp4pou+Pe+GbKAgw6LGWcJh2ieFkqpcQ4ZVyYRhK1Pee
	 wcYkefacKVqpIY2XnEt4+zD62CH4oXatZHdluCri1r/yiuD0PZiUzXgZfyw61qldLH
	 y3ys32yfADzXa3e4SYUH967/wKMPghaZTPe9dMXqDvTbHxM+Jl2IWTqJgy0vMQ6k8z
	 9KvAXnqvja54RN0+V8n3jdpYD7RDbf/aYo4hNAxEl8js1QgMPymSIP+7A+R+NtmLxo
	 r4966dSOyg6Xg==
Date: Mon, 15 Jun 2026 12:30:13 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Rosen Penev <rosenp@gmail.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: cadence-xspi: Revert COMPILE_TEST support
Message-ID: <ai9_1ZrxD28xE-U6@xhacker>
References: <20260606-spi-cadence-xspi-revert-compile-testing-v1-1-76219ea378bd@kernel.org>
 <a723320d-20e1-4e5d-8a11-d63f84bc8f69@sirena.org.uk>
 <20260608180927.GA2211222@ax162>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260608180927.GA2211222@ax162>

On Mon, Jun 08, 2026 at 11:09:27AM -0700, Nathan Chancellor wrote:
> On Mon, Jun 08, 2026 at 11:31:33AM +0100, Mark Brown wrote:
> > On Sat, Jun 06, 2026 at 03:26:04PM -0700, Nathan Chancellor wrote:
> > > Commit 0c5b5c40dc31 ("spi: cadence-xspi: Add COMPILE_TEST support")
> > > allows this driver to be built for 32-bit platforms, which causes a
> > > semantic conflict with commit 4954d4eca469 ("spi: cadence-xspi: Support
> > > 32bit and 64bit slave dma interface"), as readsq() and writesq() are
> > > only available when targeting 64-bit platforms:
> > 
> > >  config SPI_CADENCE_XSPI
> > >  	tristate "Cadence XSPI controller"
> > > -	depends on HAS_IOMEM || COMPILE_TEST
> > > -	depends on OF
> > > +	depends on OF && HAS_IOMEM && 64BIT
> > >  	depends on SPI_MEM
> > 
> > Why combine all these, they're not obviously related and HAS_IOMEM can
> > be turned off.
> 
> This is just a straight revert of 0c5b5c40dc31, so it is just restoring
> how it was before that change.

For the long run, it seems we need to add guard for the marvell support
code, then I will solve the readsq/writesq on 64BIT. But it's too late
to add new patches now, let me do this in next development window.

BTW: d58ecc54bb09 ("spi: cadence: Add 64BIT Kconfig dependency")
introduced the 64BIT dependency.
