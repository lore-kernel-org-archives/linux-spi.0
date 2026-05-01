Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDAD54768;
	Fri,  1 May 2026 02:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777601562; cv=none; b=rYKaTQ1wehh9sly/Du9U7bTrkUzkoN7FX+M958Ylgmby2tidMB7vESyMa6fZqcytgfO9KuPy7PaV27Kzvjv+lcyRoriD83M5RK+ceeuWufnZedxVHdiuNr/8WhiYoIHmueK6wYWgKciFtyuTT9F1S6/7s7Iww5KSNWMcdJy6R78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777601562; c=relaxed/simple;
	bh=MDPNTuF/vrUrWPFsSD67VIl7SRNTHWI31fM7YEOkPZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rezxHB1fBDIvVRV+k/8ktDDP+J902Xay6MdXc/IRM4F+5Im3m8Utq21E+8x/kc6FtUAH5d4Tyr1dWpjT7NpA4Twv1elM9WkZS/uLgWn3OsZVVIfREBsbEZnS4uaQl8hVIWvYIRgvPXdIhvSkj+kzmb1iq4cXynlSIXWZm+YuC6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7aGnKUU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7aGnKUU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4ADAC2BCB8;
	Fri,  1 May 2026 02:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777601561;
	bh=MDPNTuF/vrUrWPFsSD67VIl7SRNTHWI31fM7YEOkPZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n7aGnKUUEzO4flpeCCq3sHXvTgtq5QkaW7ZY++KVeM2vF1UP9zJ3cxek+1ahPOELZ
	 6229f+aZi0pmz8OdN0bxLehzmOuPDgMue/JpySmbdNefQrzEGFM6NBp3SG6EeBTzkO
	 dnyjRgJO+BvMEiSFrtX7MdbRHMDdZBPGXUizjLaoL2taZw3OPQevCsiSkRaJ1wWPOl
	 +QIlMjfYVi+z0JJX433C6ot899cR9xVxCYVZL2iy3+RI5RcSllk609vA7iqp2G3dIj
	 DnmDRMo/HwSQxXV6d+GTsqhq5SmWnEvdE5ikP7hQm2/TrhDbumWue030zjWf9QgXmd
	 NbHFFPl2y2tXA==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 3E1011AC5863; Fri, 01 May 2026 03:12:39 +0100 (BST)
Date: Fri, 1 May 2026 11:12:39 +0900
From: Mark Brown <broonie@kernel.org>
To: Vishwaroop A <va@nvidia.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	smangipudi@nvidia.com
Subject: Re: [PATCH v2 0/2] spi: add sysfs interface for userspace device
 instantiation
Message-ID: <afQMF96WKJMZKU-E@sirena.co.uk>
References: <20260420031417.291442-1-va@nvidia.com>
 <20260425173425.622042-1-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o77jnx3IzAJYxn6J"
Content-Disposition: inline
In-Reply-To: <20260425173425.622042-1-va@nvidia.com>
X-Cookie: Garbage In, Gospel Out


--o77jnx3IzAJYxn6J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 25, 2026 at 05:34:23PM +0000, Vishwaroop A wrote:
> Development boards such as the Jetson AGX Orin expose SPI buses on
> expansion headers so that users can connect and interact with SPI
> peripherals from userspace via /dev/spidevB.C character devices.

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

--o77jnx3IzAJYxn6J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmn0DBYACgkQJNaLcl1U
h9CLnQf+LEjISXgyWJRNdRiK4RXDub1Z474m+BcvFR8imtfG4eyCMAu6iaWntFWD
tDLvfW4uhNjpkjZusGnVx2ygo3BK/cp21jMXn5hkfgIUmaQwfkY6TGthdyLmmedl
wcAWo3stzVursWAX0TAfa9HMbCNVAIjKCH5Ot49639dBbUjJjKdUkd4s5kKcNlyb
OcvTdzwnKGs0DwJQB7GbyNUWyxW1JXDmFoHwDE1/YMVa/cvGFARQdhcRY5AKx9gp
DoRE9caUMIk26yb/F1CZOH+5WEwx8Q450//MTYiuWEFvdcIxmBFM6OLCTajZ79e7
FMV8J0+P7296hH1m4LHxPBwtRNPrfA==
=dwuy
-----END PGP SIGNATURE-----

--o77jnx3IzAJYxn6J--
