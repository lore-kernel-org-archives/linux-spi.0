Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC7A374E7F;
	Thu, 24 Sep 2026 20:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790283288; cv=none; b=Pdz7K3nJxtmu7C6Xq8/rkbafbD/HI8f0YyBk1l9/ma8ZunULPWtyhQhJFrlwUmXX29fYBqEZVhPxdVxTr49VSX6Uxw+532gmxLZaL7cknrRqGZGBzEkjedFE+y7yckriD4sEKtXZRXXU7iguLi2bt+PyqTksI8CynNHwipGFCFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790283288; c=relaxed/simple;
	bh=uA0Bp8lrw2jX8ZwXSyrF9Fcc/M4EwAUsZDeQAxZ0Hr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flqiHO9hhQhJXqNSL4fJrHvu3EgWO5NNEhFhMYQYgNrRVH2gg7SafZyw6V6tthlz5ZabwCBYxXbCF8BVp6bg6Hb9lKtSz6oQVEvTNmhbPMMoAUqjcZfj8xs/uCz4dc3cMllSOK22pkrApK4LFebLLfPom+0QuGJ+IAhRT4pVR6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/dEA4zO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/dEA4zO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EE11F000FF;
	Thu, 24 Sep 2026 20:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790283286;
	bh=hfelJYcuvy3YH+Y9mKFdTCc4S+f9cbisEzGvLAiWVYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g/dEA4zOpzsZfA2OY4RgtWpV8zjHOLVLr6dn00a53M1S703IWoWEUENJvMOfF032H
	 V3M7RJYZwvKScFN3OUo/+2E4v+mWNxgcPbu4mhAXxMsmt/YpGWga7mwuBP2VkGGnAf
	 yCD4ET7cLvFkEUFjDptKV2V6dC+wZg2y4cPm4uxmU3Lt1aXO36jb0H3sQw6cvLZx8A
	 fQ3R2S1NR2nJk59a52TX+GsvXOdKIlV2FTYNqIe+qZfQqjrL+mqXkQ92+zmlSijo9v
	 ZOaVxuHw0znHrVJ6CWk0hPaYGXKPdE515fnxU2oKjz4UH6HF8TF5IUp4KH42jMLY6w
	 caIKQ/0mMDoPg==
Date: Thu, 24 Sep 2026 21:54:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de
Subject: Re: [PATCH v7 08/13] spi: spidev_test: allow disabling rx or tx
 buffers
Message-ID: <dcb8c604-b394-4126-bfc0-81ce23603d26@sirena.org.uk>
References: <20260924-spi-sun4i-spidev_test-v7-0-126e31a07fdc@pengutronix.de>
 <20260924-spi-sun4i-spidev_test-v7-8-126e31a07fdc@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0PQWNGqYXqRhBKvd"
Content-Disposition: inline
In-Reply-To: <20260924-spi-sun4i-spidev_test-v7-8-126e31a07fdc@pengutronix.de>
X-Cookie: Oh, so there you are!


--0PQWNGqYXqRhBKvd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 03:43:58PM +0200, Jonas Rebmann wrote:
> From: Marc Kleine-Budde <mkl@pengutronix.de>
>=20
> Allow not providing rx or tx buffers. This is useful to check if drivers
> that don't use SPI_CONTROLLER_MUST_RX (or -TX respectively) handle their
> operations correctly without a buffer.

> -	_write_count +=3D len;
> -	_read_count +=3D len;
> +	if (do_tx)
> +		_write_count +=3D len;
> +	if (do_rx)
> +		_read_count +=3D len;

Separate issue but this exposes the fact that show_transfer_rate()
prints these with the wrong labels, previously it made no odds since
they were incremented in sync and always had the same value.

--0PQWNGqYXqRhBKvd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq1jhIACgkQJNaLcl1U
h9ByYgf/f2smLO3RVG5xbTqGjeK+kJnYXa3Lih+7eOwAb90Qxax/iu6nPyksLVO9
xs/0GsSdHbYLs9nrRGu6VV0F0df5Oadl4nwwtAk6ArpS19lcB/yfWjvnGZZ33ENK
QByF0qsoqsePJfogprH0Ka5UO0oJCa6BgIweC2ayv10r8WvKRJyoKbrDi3SNiEI5
VwytUdoQAbKRxDbo5RvMiOmyGA6jHLZhRaI87DPWVRh6H8xdDQWkfa4T8nebWIQi
ZF6ala+VfsQhbWGXeJfKyz8OnnVmmQwPXrJm5ioRpMfYtYktFwYdG+sxXCfmHfdH
inPPLXWfmrmzElb/YLrsW/7GPuL9wQ==
=lwLx
-----END PGP SIGNATURE-----

--0PQWNGqYXqRhBKvd--
