Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7AC1DA0E1;
	Mon, 23 Mar 2026 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774284683; cv=none; b=KksSAQm9md2XN6NpUrCMxVzka20H9V6rb94qL+v3AG6C29HOqArO777hdPlECut895fgiM6/aANjOAemNrxcqSVdmgAzTg/pOIYxoG0p7zbnL/xAgGDVVV7fgMfapkpTFq1+GWSecv8GNGQ0u/0u5UixSgzc0OMJlG9KmXqkfjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774284683; c=relaxed/simple;
	bh=IIk0sG8FwKMHk3yyLAWRHiFwn3Y12VcusKVTyEHIGH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2eg7S+kTJyqJXkfl1dCIwDzjmqAC8vcZWKIewn2SLGAyIMiuH2pev5VCu8VJ5qxyp2JxBcX5RFQLNH3gjeoX6sSDQONZR9fJ+HMlOlcofntsBrpfpqDop+MaqWNo53Sky2RKzDnM1KkAEgdq9DHvdGu0ShKuABl2qDiRajeQK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgBnqZ6Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgBnqZ6Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F030C4CEF7;
	Mon, 23 Mar 2026 16:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774284683;
	bh=IIk0sG8FwKMHk3yyLAWRHiFwn3Y12VcusKVTyEHIGH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tgBnqZ6Y0Coagg0Z0X5omjLG0n6QcXqBejnPJRmJPpZmUAOK1ZQ4nk4KjajMICpie
	 DyqcsfDvjAfduW+Fc5CVJ0viD5G/eJOATZx+zT+wf7NxU0KYNCUwVZTW5j/O1gMZwZ
	 INzNz1SkaL07fGU7nIWtpo7wN6oWu1KjIUEYkVFttlVUzKSJ4VSo3madnW++mG2JKm
	 ldInm4ZC8ZXd9P1jcrbzExPAMVHqEirKvbLP5oaOkNM40+ds3zWA584ntdXYK/lPs8
	 MrRwDbQ5Sq8j9Iah9p9AlU4uTbzQfAnApDU7x9gGelD3iTzzGWYGbV7gzr5odMD1yY
	 5dlfLjmNs17CA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w4iUq-00000003eSs-3Efu;
	Mon, 23 Mar 2026 17:51:20 +0100
Date: Mon, 23 Mar 2026 17:51:20 +0100
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Laxman Dewangan <ldewangan@nvidia.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] spi: rockchip: fix controller deregistration
Message-ID: <acFviPkEwqJb4y36@hovoldconsulting.com>
References: <20260323104948.844583-1-johan@kernel.org>
 <20260323104948.844583-5-johan@kernel.org>
 <2ef1dcd6-68f0-4111-b8ac-fdaf4aea36d9@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kEtwZOqXjaTSmXhQ"
Content-Disposition: inline
In-Reply-To: <2ef1dcd6-68f0-4111-b8ac-fdaf4aea36d9@sirena.org.uk>


--kEtwZOqXjaTSmXhQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 04:35:39PM +0000, Mark Brown wrote:
> On Mon, Mar 23, 2026 at 11:49:47AM +0100, Johan Hovold wrote:
> > Make sure to deregister the controller before freeing underlying
> > resources like DMA channels during driver unbind.
>=20
> Fixes should go before any non-fix patches in the series to avoid
> spurious dependencies and make it easier to manage applying the series.

Sure, but here there are no inter-driver dependencies (that is, the sets
of patches for each driver respectively are independent).

And I didn't expect this one to go into 7.0-rc (no stable tag).

Do you want me to resend a reordered series?

Johan

--kEtwZOqXjaTSmXhQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCacFvhRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQC8XNwux9ZQgYeQD9Ev9bFlg146D4blrVAOpa
VAF5tGvMug34jLpxxKXV+QUA/jS9aXUpfeN1vtmI4GBTsRfQsUxIDszYqHmZuUO1
Aq8N
=cwzX
-----END PGP SIGNATURE-----

--kEtwZOqXjaTSmXhQ--
