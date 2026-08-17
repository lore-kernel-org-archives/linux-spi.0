Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BFE44C65F;
	Mon, 17 Aug 2026 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786984439; cv=none; b=Bx/tqeJxVRQdhRSuET9GC/kAv1XLfBOJVyyz2N127mNW2HpukZfaFu4pGlfCsY8OYUb4pSRU28+3jXUBze6nhLEOaSKoz6k4JZ9R+VsW6AL8Z4tpIV4dMxmlyPF0WcYTqJCOhA15IMoWbq4N/zD41FFydYZ5uKJDM11dzB4nCPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786984439; c=relaxed/simple;
	bh=8mAk4FaNsw+5eWKCWmD6aVXwECgq9fdzcLTWmNXpwTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/T74z2wAJ7SQv9NivNVJmo4FzgsRgsrT4k96n3tL4Oa40N3MmixcaeRNZL5SZ+nokNuDzewX6LZihvJXW+zgQUj/AR0QPi/XLZiUajKpZV/dkui2MPCIK7K+htkK2GJbD56gy+b/ulbLoWjEyI0iKdELS1XWMYknv3M6Qtr8jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eiv12yIM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eiv12yIM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860681F00A3E;
	Mon, 17 Aug 2026 16:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786984438;
	bh=8mAk4FaNsw+5eWKCWmD6aVXwECgq9fdzcLTWmNXpwTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Eiv12yIMAbB2FjmvF+xmzVRsS0TFMv+YLWPln+Vj3lvij77A2PLYjMi6G0HcYg0Un
	 bV59unxpZ9eNYZTRwhvCU5RAmhYrOHc7gpiS0AElhngGraBR0lE1dM/4TwMv9CIplI
	 yikdCVafBTDJq8nFIU04NLz8uv1WZ2w+lc/T9/Bl3BKY6ucwtnus5n7rrVu3iM44rH
	 tLjaXbtX2Rms9+Bd3xfEFM1cPZ/lDx98RgB3mwt9/G2ZDeNFYnlOaxAzDZv9kFEg2p
	 n1Kki8/4o2RO7MC+DXYtq+NMEQDv7y2rom3NNzG7RLViApBUp2rgOjWLDQIYw1YAKn
	 rc3sfIy6mwhmw==
Date: Mon, 17 Aug 2026 17:33:53 +0100
From: Mark Brown <broonie@kernel.org>
To: Bhargav Joshi <j.bhargav.u@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, goledhruva@gmail.com,
	m-chawdhry@ti.com, daniel.baluta@gmail.com, simona.toaca@nxp.com
Subject: Re: [PATCH v3 2/2] dt-bindings: spi: ti,davinci-spi: convert to DT
 schema
Message-ID: <56bdd7d5-c81a-4949-8442-b35a85ca436a@sirena.org.uk>
References: <20260817-ti-davinci-spi-v3-0-23844cfb5e6a@gmail.com>
 <20260817-ti-davinci-spi-v3-2-23844cfb5e6a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xtHUDevHVpScS+2G"
Content-Disposition: inline
In-Reply-To: <20260817-ti-davinci-spi-v3-2-23844cfb5e6a@gmail.com>
X-Cookie: Obey all traffic laws.


--xtHUDevHVpScS+2G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 17, 2026 at 03:25:26AM +0530, Bhargav Joshi wrote:
> Convert the TI DaVinci/Keystone SPI controller binding from text format
> to DT schema.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--xtHUDevHVpScS+2G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqDN/AACgkQJNaLcl1U
h9CV0gf/ZvIva2JXndYmojEgJSTSwu/Luqg0Hu/sJQUEDXuwR7e0NkbKl0CJxShm
F8RImOlH7OSewXFQbpchux1RKecAVF6yyYbG3AiR/M2mSAEqMpvDCb7g9HlheM40
OK6hAPmrXyihiK0zhSue75M0K1QYl6RR3QeNt92xDYZP9osWrdT2CVVBVNSODAD+
zrso9vgG1Le6Fgu+3JKDpIlCx1LCogHygA//cGv2MWjoE5lpMyHOrTHOdzNPMhVy
1mBPI+LGSNNpxG1S2kCyh/GXQv7w96rTStYiC+YcpFUTmepJzdnpIABPJ/g6jbaY
ePdAc4q6s1M2QVrx92OlLk0gtwFOAQ==
=QkrV
-----END PGP SIGNATURE-----

--xtHUDevHVpScS+2G--
