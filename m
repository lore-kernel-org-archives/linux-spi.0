Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D102459DC;
	Sat, 16 May 2026 02:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778899457; cv=none; b=he82YR8XZU+ZoRvcK7lqeFJiTelNVH9Baj0AnTvWLrKAUbeQF+WLCJGaYnoOFInMXe2Qj1I5+SKkR6yo5iBdR0orEz9YOBmKZAX7bx3M4ek6TSVwr4jiue2cHdD/B0i5/IGxVRJySCJMBLscZbE5CIBFyniGE6YfpEggElccA9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778899457; c=relaxed/simple;
	bh=sPYltGWTPgslsBw8OQ08aTqEyR9CGMgzL6hmjPVya3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFcy+rFRsLCuCRu7b8Ugi7/XV87nDpBJFwCjTyDIqogMkXQq3m8qy6v6IG+RWjJmBHBZR5Ld+oA7Oeonf30NvbLy82kYHunjs8F9S8ePKBu6tQ17Udh10VG4GwW3rAdjzZocOK1HyQoxOaZViApuWl2jf3VLhXPGtXPYhceBE9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVLpIdsV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVLpIdsV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA8AC2BCB0;
	Sat, 16 May 2026 02:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778899457;
	bh=sPYltGWTPgslsBw8OQ08aTqEyR9CGMgzL6hmjPVya3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VVLpIdsVpBWVW3R4DGqINeO0mRTIrAjBGQlBToFk6sfrUDiyxf5uSJ3s1jGOnEBrl
	 Oe78h/lTwFms+o/xQme5C4Rv7UGJN6Lz254WBgPCEtSLgGqIWpQbXOGIPZJNKcd5Uc
	 LOvVGVvdl3Yh+KMBYnUy+AbB8uGh0A3KpAU5v4dPfRJ34u93QWkqHbX29I/M9gEb+D
	 0fWYLGg7m4fug9r7lc7ojlf9LT/jKoliVLhsFr3FtBjdorn13D4hmh9abUX9o/MyDv
	 IM4wrXwSUXQOkouRBvXxAoeGqoqh2GA4GFv4u9Z8kCTuL3mGaU9zHv1jAD1/C/gBoS
	 NFXuqdsfLz9zQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 33E041AC5A48; Sat, 16 May 2026 03:44:13 +0100 (BST)
Date: Sat, 16 May 2026 11:44:13 +0900
From: Mark Brown <broonie@kernel.org>
To: Vishwaroop A <va@nvidia.com>
Cc: linux-spi@vger.kernel.org, smangipudi@nvidia.com, jonathanh@nvidia.com,
	thierry.reding@gmail.com, corbet@lwn.net, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 1/2] spi: add new_device/delete_device sysfs interface
Message-ID: <agfZ_aYMPeXhG037@sirena.co.uk>
References: <20260511104002.976269-1-va@nvidia.com>
 <20260511104002.976269-2-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v630eC0Tsht6JCav"
Content-Disposition: inline
In-Reply-To: <20260511104002.976269-2-va@nvidia.com>
X-Cookie: Truckers welcome.


--v630eC0Tsht6JCav
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 10:40:01AM +0000, Vishwaroop A wrote:

> +static ssize_t
> +new_device_store(struct device *dev, struct device_attribute *attr,
> +		 const char *buf, size_t count)
> +{

> +	/* Controller is dying; clean up if __unregister hasn't already */
> +	if (device_is_registered(&spi->dev))
> +		spi_unregister_device(spi);

This runs outside of userspace_clients_lock so there's a possibility
that if the controller is in the middle of unregistering (which is
likely since that's the case we're handling!) it might be running

	device_for_each_child(&ctlr->dev, NULL, __unregister);

which would result in a double free.

> @@ -3633,8 +3813,35 @@ void spi_unregister_controller(struct spi_controll=
er *ctlr)
>  	if (IS_ENABLED(CONFIG_SPI_DYNAMIC))
>  		mutex_lock(&ctlr->add_lock);
> =20
> +	/*
> +	 * Mark dead and drain userspace_clients before __unregister,
> +	 * since spi_unregister_device() doesn't do list_del() itself.
> +	 */
> +#if IS_ENABLED(CONFIG_SPI_DYNAMIC)
> +	mutex_lock(&ctlr->userspace_clients_lock);
> +	ctlr->dead =3D true;
> +	while (!list_empty(&ctlr->userspace_clients)) {
> +		struct spi_device *spi;
> +
> +		spi =3D list_first_entry(&ctlr->userspace_clients,
> +				       struct spi_device,
> +				       userspace_node);
> +		list_del(&spi->userspace_node);
> +		spi_unregister_device(spi);
> +	}
> +	mutex_unlock(&ctlr->userspace_clients_lock);

The spi_unregister_controller() side does things with the lock.

--v630eC0Tsht6JCav
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoH2fwACgkQJNaLcl1U
h9DX/wf8DiPmQpuyODBrj+UsR+40mZOCsoM7BWbHbq9EwsxCqTqLzBdEdaHEb/x0
rrVTOlHKai+AuJW76DFE3EvXAnwOZrL82kZCXvALAMmEnnNaaC66BOTWzbH2M2F+
AOTrB1N8irAnNKfRS56whgLf8i9Whx/WfjSRBo2lUsc8anpyOVfweh6vzavXxBuP
AjzVIsmSBGKS3dYicvRFAh6pqx1roGKirt6oLOp9wZpOAgBnl6tdElxfMjHsGLGm
JeBAQf5UiXzYSvdRfpkMrjZzzGR+JpRtX2sH/aB6q2ggjLicvNCmjm3Gi3buC97G
5+KkKVkohB7t+IydHMbpWCkouMi2Hw==
=Daza
-----END PGP SIGNATURE-----

--v630eC0Tsht6JCav--
