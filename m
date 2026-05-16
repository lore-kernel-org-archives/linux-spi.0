Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0511224B05;
	Sat, 16 May 2026 06:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778913399; cv=none; b=Pn6F1PdiyX1eUzM7clyvQPx0mPOpNUJmcsYIKTx5Lpth+l9vcN5K924zc2L86yGXtz3gjSr/r8t9QNe+oAWDaEqWfr0cihVioRmTidR3hDL5xbspxkrHFl5dVHq+LrOjXN8X/4++HmBBl98EO9sXLVZMRJymScv6uakwZbyypfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778913399; c=relaxed/simple;
	bh=wj3pvJUXnApN9duS4ENA6UUuY+zxbbcfEjF+pPbJNq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gu2hmE6wwPXrCZr+MSDb4vObC2qtOHKMP3PURYp83BQMTuwomn1X/9cL0UR0q8ncVaKfjzZNzdmaOK+76IAHYPyErKcPXa7F7x1zAI6KotGKJvhC83NJO27TLJmiPLJJ/JmZzTU7w1AYVGALGOt/TvtwkkNkfiatcqpew6HO0UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PR6K8Jo7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PR6K8Jo7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5023BC19425;
	Sat, 16 May 2026 06:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778913398;
	bh=wj3pvJUXnApN9duS4ENA6UUuY+zxbbcfEjF+pPbJNq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PR6K8Jo7kQyk4nm/tJBIcb+sod/FCvmuK/WpuaxIJN6Pna+qZ8sTNkxBOuYgcp+jz
	 j8vv0D0T8fG9SznD3FVM7msFz9n4Nq64CTmzLIv0aI83qTm0du5opM8ifkMsKG31ge
	 X8cRBFtSWEp2wk21xLed0CeRTXz2OkAwNfM0XIWIQyggOUKj8+/REoE1khynnM6wxf
	 TMgLZ0Bp3m/Y7yndl+ifFr+/PMxxXlXuXLDbp7iqjmN+GpdI+3vZ8ACMm6ueaYsefv
	 BY5K6cwbK3s4QuZFCJuu0GRcut/P5srokXf4HrYXF9JugcIYe/MXqVCBSqEEt0iFLw
	 GWrt1Hg/KlO7g==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 01C031AC5A48; Sat, 16 May 2026 07:36:34 +0100 (BST)
Date: Sat, 16 May 2026 15:36:34 +0900
From: Mark Brown <broonie@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Ryan Wanner <ryan.wanner@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Radu Pirea <radu.pirea@microchip.com>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Wenyou Yang <wenyou.yang@atmel.com>, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] spi: atmel: two fixes
Message-ID: <aggQctV06BI6Sobw@sirena.co.uk>
References: <20260516-atmel-v1-0-674fb4707af6@gmail.com>
 <agfXl-FiZ-PN_cGT@sirena.co.uk>
 <CAN4SLj3H3Sc_N42KnYMzgpe8LcFE-6EHeNxnBY2o35jP74_BkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fZzu6U2uZ2p9oVsc"
Content-Disposition: inline
In-Reply-To: <CAN4SLj3H3Sc_N42KnYMzgpe8LcFE-6EHeNxnBY2o35jP74_BkQ@mail.gmail.com>
X-Cookie: Truckers welcome.


--fZzu6U2uZ2p9oVsc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 16, 2026 at 12:41:56PM +0800, Felix Gu wrote:

> The two commits are already based on Johan=E2=80=99s fixes:
> commit ebf99aebc458391893c598f1caddd42bfcc97fc5
> Author: Johan Hovold johan@kernel.org
> Date: Wed Apr 29 11:13:16 2026 +0200
> spi: atmel: switch to managed controller allocation
>=20
> There should not be any conflicts.

Those are on my for-7.2 branch, we're currently in v7.1-rcN...  I guess
it's probably not urgent either way.

--fZzu6U2uZ2p9oVsc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoIEHIACgkQJNaLcl1U
h9C60gf+NE7mLfYR56Bap6PoYwJj4+q/vXyZotuV8Ir17kP//GySWSh4yCqoJMWf
XgovPBxdODLmX6xWZBqyMhmLwrLvKNfu+Mipw9FtdRlwP7abOlJcKn4dslJs033x
noLnCFz+sAPm8/B43xcgg+ahqhvS7rELeqbEGSD0FXqaGWdkZkVqBOaZFn0rXqnn
vq9tex4y4UzdCAvrtg/7GTJzgcgYO8alyO1NDRI6TWRJ31gydfCsOdegmFwsgSVx
8ny+NhM+EDimsOjEIzIEF0X3/cgxJ8NpNp1wzy1QDbo6hm4ukxow6283a/O+wjHM
vpkf0B/AjDnHHLzUJWEEF0G+WVOHGQ==
=kr9H
-----END PGP SIGNATURE-----

--fZzu6U2uZ2p9oVsc--
