Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918BD446842;
	Fri, 31 Jul 2026 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785518546; cv=none; b=lq7+bLnum4KSD4O1/oO3eIllKH7BF0MEiH9csKKXIgF+kTa2yXmeDH82MVVzIft83kzaEQD85i4EGDIBswgt58GR7AeKqA5jBgPyU4vZBPM2oka1AyGCatIkw+twvYEvC4NuL4uNfLE2oUp7LSun8namgT+K2I3lGVosLXYDs3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785518546; c=relaxed/simple;
	bh=W1oO+ADGo9gyWhBG0QBswl5Or6C1cfUY909XIM/3290=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEpRRmdsbxsVJ/tS1e9sPpAWbRhLYvXiz+nDCcZYZebwYAqfYK/zuJ+SvxLLipm9oYgZvkNnPMdc2zCA4o6hFbmf6OS2r25MP47tlliGO7/EMp9/v8D1Lz2q3engz/+wfdBJ2NQEvj3phNUCQUA3/Bdgw0Io1zsZ17nleP3IFxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKnHIU3c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKnHIU3c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B821F00AC4;
	Fri, 31 Jul 2026 17:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785518545;
	bh=esBbtSATVpE7OKqQ/Ers3GZhdi/vzVT1f4Nq3U5LmFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OKnHIU3cFlOtMLEaQD2xmnhYWXCXKzAmMWLHL02ITxkGSDMhK8LkP9moI4iSu8jHe
	 UmTQ11Dhp7vyCr+F6HI0UQBU00CGw55dTNU3zm9xucay5bxRqHlmcCH8OUFQNRzxXI
	 7MQTG8nQ4McQCijTVNiJuLfDmuhEWRbi4Sf/vaHwhRJqMPO2BC50dxLLo2D1UUaVXY
	 bkmvawzqEU0/HEjXBoGZfs9dd3OcWRa/0EtbLHr4/5BujVRbtjviHJy72SvWJq6G6o
	 x7l3RbgMo/TwMJIXTW5ojCqKrYhktv7IJa6aFub0iz45CF5k2l3BjyUOk+RUV3IM7r
	 yTx6TLrAYUuvA==
Date: Fri, 31 Jul 2026 18:22:21 +0100
From: Mark Brown <broonie@kernel.org>
To: Vishwaroop A <va@nvidia.com>
Cc: linux-spi@vger.kernel.org, jonathanh@nvidia.com,
	thierry.reding@gmail.com, corbet@lwn.net, linux-doc@vger.kernel.org,
	smangipudi@nvidia.com
Subject: Re: [PATCH v8 2/2] docs: spi: add documentation for userspace device
 instantiation
Message-ID: <b48bef52-4851-49ea-8f5f-d142d478f096@sirena.org.uk>
References: <20260728191056.2337791-1-va@nvidia.com>
 <20260728191056.2337791-3-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="596JTbBaHDJa302v"
Content-Disposition: inline
In-Reply-To: <20260728191056.2337791-3-va@nvidia.com>
X-Cookie: No shirt, no shoes, no service.


--596JTbBaHDJa302v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 28, 2026 at 07:10:56PM +0000, Vishwaroop A wrote:
> Document the new_device and delete_device sysfs attributes on SPI
> controllers:

> +What:		/sys/class/spi_master/spiB/new_device
> +Date:		April 2026
> +KernelVersion:	7.2

These need updating.

> +On systems that need spidev access at boot, a systemd service or
> +udev rule can write to ``new_device`` after the SPI controller is
> +available.

The fixes for safe ordering of init mean that the new sysfs files will
appears slightly after the device is registering, we ought to do
something about ensuring there's a notification for the hotplug of the
properties.

--596JTbBaHDJa302v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmps2cwACgkQJNaLcl1U
h9CcKQf/TyWJU/SYtGlwANMCEq6k3344PbhUKlrrimm/XLYdyHIwJpi5zqbMnawi
5IK4esPqEIspck34edS9baUZfKNzNku7WVr4r1ZfAHllMd532G35OHCNANSBXDtJ
yvQO5Zy7axKY9f4fQ4+V7MS2RJzBanpVuXOME1BgksdvSzVl8pGnDjzoQ15sGkB0
MO1blFZ5DTWea6J/6EHL3hab67K2RnnHjLtdnfggHKPpEwmlMXMaoA782vsPJKtr
RMpudJ5b2AjetGmUuXy7n4jQyP7BqnxiYImKI51FR/F5NOvURic5R8Ur/7msynQ6
+Se22gAERoKNoPKHK9afixqIsdbJAg==
=Ktsh
-----END PGP SIGNATURE-----

--596JTbBaHDJa302v--
