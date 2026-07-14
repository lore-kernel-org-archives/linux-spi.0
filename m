Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ABD38734E;
	Tue, 14 Jul 2026 11:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030004; cv=none; b=EITriLKN0xlm8WHgmwmaVTqkfyZwtvR15wXz0d2htRU7ei4FbUPBRDX2tdrREx5Tf0ulNX30Q1iWYuFWkhUj626putTS9KYi6uDkpVcc/RJFczGGv6UyMDc8n0HmPzW98hWqEuATM8ovz4mzVWGgQ7Xa8SUuI5ALQd5qq+/x0iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030004; c=relaxed/simple;
	bh=du7Ag8vjlu+qkCCTucXMDawHMc1Ec5wX6VA4IFbAtZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5t/gxqYxi/pUw8jjxZBiG6Mgz2+eZ2mSBVjjK3tMzfqzR25FFeImCdpsVqZ5F+NnqnhoIzyjdG/PzfqJoDvqaQJi/IqTtahfA4QucP1GvuC4AKOtH4qO7AAcIwi1ttUDOk2+lfVB6svNtuFqAgoUsbp5PLTeXvao70G4x7c5lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QU+lsr/C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QU+lsr/C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6071F000E9;
	Tue, 14 Jul 2026 11:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784030003;
	bh=du7Ag8vjlu+qkCCTucXMDawHMc1Ec5wX6VA4IFbAtZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QU+lsr/C3zFGhJz3Gg0cmBczqfAcniLOkWFEkTbNfb8nt/+WV1m6t72bAiVeIjd18
	 T5cQ46+3cZCwx9IPueafpoREvceX/k8fVWeklGQoSXPP4l9xcvtLWdqUea/thxf5qz
	 QzS/dC58pxY6gcI8db2PWk9ZF4lMS+vy7cpKC82FhI6IKRu+9VttLjoh5PRsfIHRP0
	 Gr2LAX7XI0JVzSXOGcDo+r2GiFZO95KcgI+YCw0QL4t9v7yOF3fzUmdsAAxr6Plr+J
	 EDE/Gad3U3yIC41x8zGusPRccJDi7RB0trgq1QrB7K6ZySLlBqiekuw+MzpGaR0w+3
	 tgDwwoLOAMlLQ==
Date: Tue, 14 Jul 2026 12:53:19 +0100
From: Mark Brown <broonie@kernel.org>
To: Vishwaroop A <va@nvidia.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	jonathanh@nvidia.com, thierry.reding@gmail.com,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v6 0/2] spi: add new_device/delete_device sysfs interface
Message-ID: <bf566a40-f17a-4500-8a80-8c02bedcd282@sirena.org.uk>
References: <20260517201602.498135-1-va@nvidia.com>
 <cover.1784000000.git.va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gX8nTNVEUWnM+nxW"
Content-Disposition: inline
In-Reply-To: <cover.1784000000.git.va@nvidia.com>
X-Cookie: Neutrinos have bad breadth.


--gX8nTNVEUWnM+nxW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 14, 2026 at 10:09:42AM +0000, Vishwaroop A wrote:
> Add I2C-style new_device/delete_device sysfs attributes to SPI host
> controllers, allowing userspace to instantiate and remove SPI devices
> at runtime without device-tree changes.

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

--gX8nTNVEUWnM+nxW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpWIy4ACgkQJNaLcl1U
h9CCCwf/T5h0jZ3kDyIb++nPaDahYHku43HKR8rbAl5ZLvz4Pi2gueRAAIQGws58
dxzyYvbVLHOeFz0T67st1lBStgbS1QIld+0HWsXpmaa1jWQGawd9VUYuY0UZXRcG
hCCEozCxWkJQLqOYaJMvBfDSFvO4jVkVpXwC6mvu1yd9XoWYuMzxldZHVANhha3d
eugo/0yy2fE6Ec2bAh2uGLqjQ+AO7wGxzQZZjDZeO7Vs/4GSkv9i/TIkDBeFJWmE
bnzeoCYKF7NphRBaxWv3vxLucJDBEKoMVcL0ewYYHlbXKBokh3kcp3WWETfVdPbS
ePfIQxRdTx9KwC/6QQ7IcS0xvSw2rg==
=QtU9
-----END PGP SIGNATURE-----

--gX8nTNVEUWnM+nxW--
