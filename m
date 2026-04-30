Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F072139A07B;
	Thu, 30 Apr 2026 10:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777543515; cv=none; b=oesbYl3AI0eG7GXxHqODC40tGaQ7j3ODgiLQsQVQtdmAi+hpQyGKrZXMNj49JmDvwt5hLAsX3Ha3AqSYYr1VTVCEu6M9FddSecr9J455sld3iDOldMoo3Kp0gZvym4tbZQqSI71+rCrWIUQvLj0NJOZ+rdY6QTHC3XCA2I+MHzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777543515; c=relaxed/simple;
	bh=FDWShGGmHLzo3U/oyhN+S2y7XC474Jp6Sf1UdWptFMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3EtQWdh7bwpN5O9Nuy15bsndEU60mPs7DrlioYEQ97FV9o9jZNY2woMvMyg9ZQwopU/to+bi2/ihSB5+M2ZkBRnTLzFfXUDZvlJYFgm0gMUoUvsw0RlbdCbHSTlh47B/+u0BtTv/WBlfdLGfEHZN+KVh9e1+Bllsf6py+bZP4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5VpDNGr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5VpDNGr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79505C2BCB3;
	Thu, 30 Apr 2026 10:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777543514;
	bh=FDWShGGmHLzo3U/oyhN+S2y7XC474Jp6Sf1UdWptFMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c5VpDNGrm9x1+5EO7gDJba2hj4XrV25Av9VrgfuAV9IwMig/OH+DyNatgh87kf2kg
	 DqeLCcAAO0FN4cwiYJfc/n09kdmFf8SfRK3ZTBpSiJ4rbSZ2FQa0+UlwBU8ADE/Nk4
	 6jYYsIvDqwqdU8lPoG5ZxzCtKy7P54hQAfh4+yQKsPpKhvVXyxbdcR34zUboyuWc/D
	 JNRdFDhJBq6Lbes6MYFR9uSNjk2ObvmOxB4Ll6evBUeXUi4wb/CScZra6xgOUA1li/
	 h0SfE2EZgvvycTn+yznZYKo8IRrhr0hsQ0Y+YRNKYRFqK6sRMsGnMPE+Jnx1myjSZ0
	 +koEH5JmhBGsA==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 5D7BD1AC585E; Thu, 30 Apr 2026 11:05:11 +0100 (BST)
Date: Thu, 30 Apr 2026 19:05:11 +0900
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Radu Pirea <radu_nicolae.pirea@upb.ro>,
	Ryan Wanner <ryan.wanner@microchip.com>,
	William Zhang <william.zhang@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/19] spi: omap2-mcspi: switch to managed controller
 allocation
Message-ID: <afMpV6V79oCzIZSh@sirena.co.uk>
References: <20260429091333.165363-1-johan@kernel.org>
 <20260429091333.165363-19-johan@kernel.org>
 <afKisC-NX9YZhaEv@sirena.co.uk>
 <afMA8buX6EP3pKhs@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HPkd+/tNgE6OmyMu"
Content-Disposition: inline
In-Reply-To: <afMA8buX6EP3pKhs@hovoldconsulting.com>
X-Cookie: 667:


--HPkd+/tNgE6OmyMu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 30, 2026 at 09:12:49AM +0200, Johan Hovold wrote:
> On Thu, Apr 30, 2026 at 09:30:40AM +0900, Mark Brown wrote:
> > On Wed, Apr 29, 2026 at 11:13:32AM +0200, Johan Hovold wrote:
> > > @@ -1556,7 +1553,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
> > >  		status = omap2_mcspi_request_dma(mcspi,
> > >  						 &mcspi->dma_channels[i]);
> > >  		if (status == -EPROBE_DEFER)
> > > -			goto free_ctlr;
> > > +			return status;
> > >  	}

> > Here we return directly...

> > ...which skips the _release_dma() as well as the put - I think the label
> > needs a rename and the goto keeping (or some more refactoring to also
> > use devm for the DMA, but that's more work).

> This works as intended since omap2_mcspi_request_dma() cleans up after
> itself on failure.

This is in a loop so there might be previous calls that succeeded and
need unwinding.

--HPkd+/tNgE6OmyMu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnzKVMACgkQJNaLcl1U
h9Atygf/eIBrXL+VQQPCFHf3LUjLWu9yiOsuJ1oVqilH7L+gSj8NDq15420xOQer
6RNw1rua1UaTfp280sjI+1oPCmygY8q4c0sOsl6d/KIpvi1KWma4iOzseSU3gP3E
yWZOZEczYsWlSk33blGu0zAz9s/hdiOeSl5yOvlNu8afowZyJi94t+K5oYXpVWzJ
vKZ2yu6E1RXc3ksHRR8U082zeJVT3WI1xKU4/dI2niVYvgZIe/cBJ8Rjwrz1M2vP
+o8hCfa8mnah9PY4ti9HiqIV1BkBmesn9umfa7NmtVjyQn5csRci8sSyz3L0mu2+
JLOrDxFwCqw/oscrl5BjPcU5xRHJ0A==
=8PjS
-----END PGP SIGNATURE-----

--HPkd+/tNgE6OmyMu--
