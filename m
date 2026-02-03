Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC61345753;
	Tue,  3 Feb 2026 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770122929; cv=none; b=h6XyB5g96gYaXsiN7PEVbYpgcMqxzdFGUqMlo5yzvYB9dL1moppTimJ2jS0NoMwcwVNTwvn8nrsSLEEyHZyKDaI+pKGOhjwQMxYDp6x0YegZXKv7LomzxYiD/Eq00gDIvQivnPo+WYK1E+fJfgVBahgvxng4Xw+bjvzff83mshE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770122929; c=relaxed/simple;
	bh=GoQEXTMZ9Ikue95Hghv2U4KfjvZP3qi4h7j/Au2GuAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQoX+rI4CprezlnTmUG6WOzE8GOAq6EEt0AsA2Eq0ctXtlQ8xLLGgAMMrzUU20ZaEDiOFk3vtGNtaii1yPp76ETFGndBTtcKT46J5/lxKee3zLAV+LJMOgY54kswbpGyWGRPJIB+5JnF6FMMAp41Y3peZ0bc8TjnJb4m0BO+WfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALpjSkom; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALpjSkom"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7BCC19421;
	Tue,  3 Feb 2026 12:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770122929;
	bh=GoQEXTMZ9Ikue95Hghv2U4KfjvZP3qi4h7j/Au2GuAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ALpjSkomsKM3SQ34jEsx3t1EKwY1yvq9CrzOJwoVGQVtHWHml3CP7puEaQH0Er3zH
	 brdEcWlTNROiVmuvM9FxuLtgloWaNNekO2pQp1I5tMMx2GgY3CDtDRZN1xqztkAT46
	 h14cqQcqDUtSqAteqhgYWfA/eEI+oMWpIZCv1kj5KRVC1JWQ6c1p1yHwgalPDpwade
	 XqLFET29PEZ4zDK/6H7gej50jpnogTUmU5A+TN7dBZ3LqUbbNcawWMKWWg95iuFsgf
	 LC4VM6/iKvS5NWJn5Sv2T0FG+dGvvNQ4gHWv8rtuocabvyTD3iL4OibYPKf8rNm42g
	 022BEijLBGadA==
Date: Tue, 3 Feb 2026 12:48:45 +0000
From: Mark Brown <broonie@kernel.org>
To: abdurrahman@nexthop.ai
Cc: Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] spi: xilinx: use device property accessors.
Message-ID: <849bf95a-133e-4faa-973c-19342afca327@sirena.org.uk>
References: <20260203-spi-xilinx-v4-1-42f7c326061b@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t84k7qtBs9ObTbmj"
Content-Disposition: inline
In-Reply-To: <20260203-spi-xilinx-v4-1-42f7c326061b@nexthop.ai>
X-Cookie: Do you know Montana?


--t84k7qtBs9ObTbmj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 03, 2026 at 01:55:12AM +0000, Abdurrahman Hussain via B4 Relay wrote:
> ---
> Changes in v4:
> - Removed patches making the irq optional.
> - Link to v3: https://lore.kernel.org/r/20260122-spi-xilinx-v3-1-8cea20e82f0b@nexthop.ai
> ---

That was the changelog for v3 as well (and you dropped the changelog for
v3...).

--t84k7qtBs9ObTbmj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmB7qwACgkQJNaLcl1U
h9DYngf/a0dtVE9bwl62OCn814HhMa027S2vocFd+4LOvRmwR9AeCktln2ffod7m
YWPa3ktlAM/7mZizlo30Ge5BtbvE9yTXL/NfDUXHTaQqrF/UtT3IUqjs4Uaq3Ibk
kRSpWxx0Z8SxEUTwwYuRQO3zVT/bfRrYIrMDOz/HFAQSBTZqU8EdIfn1RFmvhryG
WGNPeU1L9Ixw6SZH7j0QCOnUA5RWSXtqj4cz7Gw7PXoJxoWEATddFo/nnpwp5Abq
UmS+VaBYFNMRGlVkv9o94IYWVGwd/CuiYieO7JOf7qY3MZQTnnaiPkOny3xR1kTb
ktzCfDcYpvLk+VmDAOVMLp91WedA9A==
=1d7o
-----END PGP SIGNATURE-----

--t84k7qtBs9ObTbmj--
