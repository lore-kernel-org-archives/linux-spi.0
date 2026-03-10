Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3FC2D3220;
	Tue, 10 Mar 2026 19:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773172082; cv=none; b=AuoicUO1lDvW62wuhoGT9vm1GZ6rdlfr/E3pJSENJW7y6BfGWSfiKTkR6bvOdwwJ+k3+BiCKuvwLp3tvQ87nJOX5lIJcUjGlqIwQlWvAlMOEjIBVTrApVn+RljiCrpvMQA8ooQSkMsuBvyr8YjNg7gYchOhj8N7prWSVqIqAfb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773172082; c=relaxed/simple;
	bh=VI6ZvLC6UF3rgOFQkIgQV+oj3OlilD/SmhASpV5TwOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHLxvEHmxQ0Ap8R+UWhAgRsg1ipfCOF8MxWGDzm0VIMzjbhZVkfgUDB9PapHP3UsyOaA7okyDdjSW8dcVDDvyp7uMxbaUMbfGuLpitJX01a2cay3R+H681yi3EKWm42dCfZtY/+PwQa62lJc7RD72abePvsXpooOD52Pjpn15eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeHQ3U4v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeHQ3U4v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA35C2BC87;
	Tue, 10 Mar 2026 19:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773172082;
	bh=VI6ZvLC6UF3rgOFQkIgQV+oj3OlilD/SmhASpV5TwOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UeHQ3U4v/6LhbapgAlvooAzANS1wi/NvslUd/X9P9rYduDrKU9yTrMrWgDPouc7Sy
	 WHVINVdZcnnOLlGlNhDRBzo2Tg8DS+NgNRs7EsRgB717BqsI33dnpJhbTekHdaq10I
	 ZQh1LVoEVzgQAnFGlzLEW6V4HsC5n8He3X1lJIPQBmefUwBKMcMZQTRGYibObCpyH/
	 dfcd5zoKCE5JrZVYxSzrCy0oywgYOdWbZncFlv+vLU0DU1RTGOOAfxoBTCUYDy4KAX
	 KnIqDoYh3nlmI2O6Cc25x5TB0/72PSnNiGUJAPsWami6+xgxNJBnGV50azjYxm1mhh
	 d2cF2z5gHuzfA==
Date: Tue, 10 Mar 2026 19:47:57 +0000
From: Mark Brown <broonie@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-sunxi@lists.linux.dev,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] arm64: allwinner: sun55i-t527: avaota-a1: Add SPI
 NAND
Message-ID: <33204e68-5e65-4486-a473-79d09def88a8@sirena.org.uk>
References: <20260302153559.3199783-1-wens@kernel.org>
 <177317166704.379398.1719490251066452420.b4-ty@kernel.org>
 <f3ed7b81-4e43-4baa-8a56-b18fa7f56436@sirena.org.uk>
 <CAGb2v65TyEkirWpfynKnSCiuOAyTW1FZQyXncnTFEHGGOQr_Fw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GZBDzLwXazKSzeVm"
Content-Disposition: inline
In-Reply-To: <CAGb2v65TyEkirWpfynKnSCiuOAyTW1FZQyXncnTFEHGGOQr_Fw@mail.gmail.com>
X-Cookie: A fool and his honey are soon parted.


--GZBDzLwXazKSzeVm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 03:44:01AM +0800, Chen-Yu Tsai wrote:
> On Wed, Mar 11, 2026 at 3:42=E2=80=AFAM Mark Brown <broonie@kernel.org> w=
rote:
> > On Wed, Mar 11, 2026 at 03:41:07AM +0800, Chen-Yu Tsai wrote:

> > > [1/3] spi: dt-bindings: sun6i: Allow Dual SPI and Quad SPI for newer =
SoCs
> > >       commit: e2f93f45d38f7b6dacb44203cfc7bb5d7e287b8e

> > I'd have expected to take this one?

> Normally you merge patches pretty quickly, so I thought maybe you weren't
> going to take this one.

I tend to leave a week or two if I think it's likely someone's going to
review.

> I can back it out if you want to take it through the SPI tree.

Probably safer for conflicts.

--GZBDzLwXazKSzeVm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmwdWwACgkQJNaLcl1U
h9Cdfgf/UDOhiKrvijiKCzfW0PzBsGr8Wz9vAwv63v1Pd/hZIXE6abGOgKe2c4Np
/45Z4ibLYbPGy8qUaUmeh62TF/7vUWF5OAAqUrRO3WmyDxhI1jHdWYYjMnnQQGdt
20vOp/Jq8MUTXEOmY1Yb/keztk1BBE+o6BZqug7AsNHlugs3Ah/ClEiE6YAqtyte
VnkLvct4xlV7RHyMB+sEsVmghFXqJRU7Yn3x+DKBbe0Bzr5td2EqH0UHVairEsnJ
KnP1U47KOO4QywBq9zwu2YUDsk8ulI8t8cbv7g7yvzwpDywQGapo78wriOaN3a4X
Z5jdwfUdQzoqJlu17h4GXp42udNCgw==
=w4Y8
-----END PGP SIGNATURE-----

--GZBDzLwXazKSzeVm--
