Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795001697;
	b=wshdTmNsr0Sjcj1+FBSs1jxTOjV/CHy10NSpAzral8NCcWAuEu4NOkcbELZ96yWC5yUr
	 Lx/I0IoFGsPtb2ob4BbfGBPe31GCY8RKT0chu5zIw6LDACIbvv/U4WgsM3mVPkXWlZI8A
	 ammXB3Po3Dd3kH4hhZY5x2dnX8u1AXBeZ0xLkEgpwx/bXpPSlsoGkJ8oU3un106OxX4nn
	 ybKqiWZzXEEGzRup0hnKRDrg/aq3WeovwpyAeB55TvBsZgVVJPjbGdfH7LEgKYWXf/s0A
	 v+iy7foTcTONg0syIvgPvdGpRncKw3v3vaUf4+hAoMqnpPi3jpZOPk4cOgXNN7kku6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795001697;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=s/D/VlhKyE/f++6euuTUZKtpma4TSAd5zGKYZp5sn2U=;
	b=S7JR8e5eagEFTI/knCQTV8B5njH7l8DKorDgqE42JWXYjemLU17ngNyiFGh//UAsO8N+
	 333GnW8FGxkFFFKd8vIBXL8omeQWtQCOmKE2tNFybErGz8ou47MCJdDVNzQkvfpwOUy2X
	 zZxQJ+GJkXnkwR2K2u/ypzwrbxn3VtRY4NtH0+bHvDlUtx/H3Wh/5UjaxMhj6T/hHDR+n
	 n4eZdSTJr733QtLZ+Nudo2oSrG+vHR+55r3i5l3uz/ORaPluXnbb+K/+xKGPVku9MwQQB
	 GmsN44AHjpAeQ2zMRoCR+MhCmmizWMzJq2s6UOZR9DC0ybgcXixoTx97IRqCsLh0yRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Xls+/V7y";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826AF606A31C;
	Wed, 18 Nov 2026 11:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xls+/V7y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98591F000C4;
	Wed, 18 Nov 2026 11:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795001697;
	bh=s/D/VlhKyE/f++6euuTUZKtpma4TSAd5zGKYZp5sn2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Xls+/V7yk3a50tgiPKhrRcD5Scz4WlXg5NOYS/NbK5wdAVpwk86mdHwdooNSAFKrM
	 dWf9Bxq6V5KfvzkwRh0rHIRc1VPSGgBq/ofHZwhMk5rRx+YkOAtzRVUppF/79GNulh
	 9UBoW44zUa0cMJjb3kiF3iVh91dgE4I47cBKRGbN817EE4f8RM1KATgH09GgTlBQ8c
	 XNu7+lGU1+LJi7DfB5vsZTVea/FX2jbog0n4pb+iIFIf1hz3OMbGf+MSHhpnOrgNUB
	 0QIIwcHHVbLLSeyZfpcd9Dq8i8wam2XCEuG5FRwqA/ex+SADEqKUgjHkoNoncX6e5U
	 7xfxa2V/4/QbQ==
Date: Wed, 18 Nov 2026 11:34:52 +0000
From: Mark Brown <broonie@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jisheng Zhang <jszhang@kernel.org>, Fei Xie <fei.xie@horizon.auto>,
	Pratyush Yadav <p.yadav@ti.com>,
	Parshuram Thombare <pthombar@cadence.com>,
	Konrad Kociolek <konrad@cadence.com>,
	Jayshri Pawar <jpawar@cadence.com>
Subject: Re: [PATCH v2 0/8] spi: cadence-xspi: add ACMD mode and ADSP SC846
 integration
Message-ID: <3c500623-8502-4d67-b53e-1f712ebb15ae@sirena.org.uk>
References: <20261111-xspi-cadence-add-acmd-v2-0-d339046ada8b@analog.com>
 <av1u77DUXulwvkZr@nsa>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8m+SM1RGUofxdss9"
Content-Disposition: inline
In-Reply-To: <av1u77DUXulwvkZr@nsa>
X-Cookie: When in doubt, follow your heart.


--8m+SM1RGUofxdss9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 09:26:12AM +0000, Nuno S=E1 wrote:
> On Wed, Nov 11, 2026 at 01:23:01PM +0000, Nuno S=E1 wrote:
> > The Cadence xSPI driver currently drives every operation through STIG
> > mode, where the CPU builds each command and drains the data. The
> > controller also has an auto command (ACMD) mode where it runs whole
> > sequences on its own and can move data with its internal DMA, which
> > pays off for bulk reads.

> Not sure if you still plan to look at this version? I assume you also
> expect me to rebase this on top of the current work done by Jisheng.

If there's some reason to rebase please rebase.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--8m+SM1RGUofxdss9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmr9jVsACgkQJNaLcl1U
h9ApVQf/c9IAFiatDnfpVQlk1o48vSZDd5rUhHc7laYLKV4AyMDipDYSZfmvavV8
NqZ7QtdjPN1OKa+RarFDMJUsdssEU9KvB6Ia1v4aUsStCXDRCTTzkEH9w1Mj8z65
piW5phEFr6C/Obw0pX4wT2LDRYpsWFeLw8GqdroYmQ/cJ0E9oPw2XR64wGDpuXCA
csRWO28s5EG9y+KZQt64di0nNy/ufBdxC5Ping+qyrku43ToqL8WPxjyHHYw1Ly4
8aCCw9wvP297rAsxto60PZaesvBHOUlOcjn401+dFMV3sWHQhMit4EoVTxk2k5Ak
7rVCMfM2mOs6RTURda5THI1wGFZ9UA==
=HWUx
-----END PGP SIGNATURE-----

--8m+SM1RGUofxdss9--
