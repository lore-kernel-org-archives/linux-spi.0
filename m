Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801DB219301;
	Tue,  7 Apr 2026 14:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775572674; cv=none; b=D6DEaTOkZkIAoRx2pWFrAnFZIBXRaQ+9IVE1cDr2GEDv54eLIy4/ZHefQqclS2ZyB/MOTl3m0Wu2353LIW9Ur1aonSFBBtQrAfNVi6MdQ8NeVNQo+gK8RDCIVMjGnQRBKFcRfMiZhbv7/UtZyoyLJSwjz3nF5hP33LMJ9LffFEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775572674; c=relaxed/simple;
	bh=T/KDKryMgCqXCx0E8Jl0ASDFVizGknaKaG7HDX3ojLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2pvuXpAOK4ZiLPwHh0an7AamjXeUeassZhOSBCOtZnx53BTH3bQ7JiBbOBlD2RTrfbSZfgfOItw3SSay28ci6XCxNT9BbbnJPDUk6i/MFue1RX6FJ9KpTfETNVY4rVD5KMwCew3clNFGsRH4RpZdEO4JOkProjZ59Rd5Ab+rww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L78azTwy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L78azTwy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39544C116C6;
	Tue,  7 Apr 2026 14:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775572674;
	bh=T/KDKryMgCqXCx0E8Jl0ASDFVizGknaKaG7HDX3ojLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L78azTwyJRGDhsnBw1hpIOzMvpPtiFVPitLIaj4p+mntRWvzpzSo5GUOmvM/mvY9d
	 xrH5WcUa7N+SRrjyHoAcdiqjXJhSvt9Fb9Gh5kDWZLvrEsumHTO9GeBahgAVYyYKA2
	 CVLtkN2HcNes2WYrQsCKcXG5GSnHTX52kvmTvmNjjAZbyai3DiumSEiZPvOzGd0Ys9
	 yPUw+u0v1qptcaaz0zAtQuP8gjDPhNg0bGb0lTHDZjdU0bbK4EyyUmf1X6afA091rS
	 xYaRYEpBSHNOsoWD+E8if4mjvu+c/qkOIacyYNKZ9v6gjWjQvDIRkhi+1w5Gt6zBhO
	 D5JJpcRVUat1Q==
Date: Tue, 7 Apr 2026 15:37:50 +0100
From: Mark Brown <broonie@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	Krishnamoorthi M <krishnamoorthi.m@amd.com>
Subject: Re: [PATCH] MAINTAINERS: Update AMD SPI driver maintainers
Message-ID: <ada32253-6d8e-478b-a833-b2d574fddeee@sirena.org.uk>
References: <20260406091042.4065767-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w3KcuTWKaiTS1Jo2"
Content-Disposition: inline
In-Reply-To: <20260406091042.4065767-1-Raju.Rangoju@amd.com>
X-Cookie: Now, let's SEND OUT for QUICHE!!


--w3KcuTWKaiTS1Jo2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 06, 2026 at 02:40:42PM +0530, Raju Rangoju wrote:
> Due to additional responsibilities, Raju Rangoju will no longer be
> supporting AMD SPI driver. Maintenance will be handled by Krishnamoorthi
> going forward.
>=20
> Cc: Krishnamoorthi M <krishnamoorthi.m@amd.com>

Krishnamoorthi, I take it you're OK with this?

--w3KcuTWKaiTS1Jo2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnVFr0ACgkQJNaLcl1U
h9ARmwf/QNX8WYubgrFT7gwiB9t0OFfNT2vVvAkC/Sdp+ztugQdtR3G0a0fq3cll
4+1I+bVca6D+7pJF9v65yyTygfvqToku23V5woOun6BLVdvrkuldsTAP/KNJhvMG
Xvi34llDhGFogmHWzjo3rwxRkEeM9iQJckNQb6JXDZOaYppH1J9I9n8Q/5f5GdzE
Uf1SlLcWv7Kn0iHFVw8mvlgIEElplnczYlKtzq22dwpsejfeiwuvRh/P8kRXbClv
7dxNwmIzK7QeJiZAjcURayFd7NpO9bIT7BqL2tPGgPmDdbELoyhFS8nkhZpoqlTT
qDDUDatq6dzsWpIllexVXm+1QGUIRg==
=WG8S
-----END PGP SIGNATURE-----

--w3KcuTWKaiTS1Jo2--
