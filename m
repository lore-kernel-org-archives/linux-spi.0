Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA00C374181;
	Wed, 28 Jan 2026 20:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769632884; cv=none; b=J8sgCpFPJCS5Nm23sONZM3gzk1VFZ/vvC5rn4zojZv1RtWEcqGORIZ9Vq9g82ZWez1c9PUsQScpec2Uz16fgOMERImeT+KJ7tzFR27Lbr7PE4+CZayfy3cogPWuiknb3QMKO+oxdOsUZ33oepbXhTwUkCJB8ILZnh8Gfo1O38hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769632884; c=relaxed/simple;
	bh=zV0mvyMMlSBD4q7aPG43OXDxun9Eac0uTnkg5zP5ky8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zosv5NzmsXwLlSV/orrQypMaqQtM+ZAza94VPHc8Vs4UrY6IBDmwWH5Zrx7R79JrX0dRmq8u1LrkHfEaPH2+au465bD301ITUwWbq0LK7lu1SSphtmYqFoBAFfzjRxCdKt764jV3tllbhH7lcEJo1R9iLxcsWgvxKqimAVBWm5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+w+EKTq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+w+EKTq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CEAC4CEF1;
	Wed, 28 Jan 2026 20:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769632884;
	bh=zV0mvyMMlSBD4q7aPG43OXDxun9Eac0uTnkg5zP5ky8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g+w+EKTqfFc5MspnBFGc9n6lMh5F7L4tOZoKDDK5xFcZe+9FAtNNYskh4QUVXUsRP
	 4kNPopBrlVYKoZb7G4EoVG8n2v0i7oeOfYN8h2hcb8O8a70KnzpgDzorI3Mf918mGM
	 E/AjqIEEKMuU+Kf5QeVhkl/EF0FhSYdHICxGQTyhNkuF6k1jlCyw7+hKMOw+jda1TA
	 6iuJJIyQNVEITwDlIZhkmpMykWA2NlKr9Td8U9jecV0KN31avpdX+5hgdq17KONQaO
	 ocUc8qCfLlBf0A3P3BmP+OhyCnnEVLK6sliScCSOyqj3hBr3XOkkWw14lcw+xrdFuj
	 0fTRhWK3iZPtQ==
Date: Wed, 28 Jan 2026 20:41:18 +0000
From: Mark Brown <broonie@kernel.org>
To: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Vaishnav Achath <vaishnav.a@ti.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Herv=E9?= Codina <herve.codina@bootlin.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Santhosh Kumar K <s-k6@ti.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pascal Eberhard <pascal.eberhard@se.com>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 10/15] spi: cadence-qspi: Kill cqspi_jh7110_clk_init
Message-ID: <919c7a9a-8341-4329-9fcc-630a2a3d0b91@sirena.org.uk>
References: <20260122-schneider-6-19-rc1-qspi-v4-0-f9c21419a3e6@bootlin.com>
 <20260122-schneider-6-19-rc1-qspi-v4-10-f9c21419a3e6@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9gp6hdOn2aMXkGnv"
Content-Disposition: inline
In-Reply-To: <20260122-schneider-6-19-rc1-qspi-v4-10-f9c21419a3e6@bootlin.com>
X-Cookie: APL hackers do it in the quad.


--9gp6hdOn2aMXkGnv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 22, 2026 at 04:13:35PM +0100, Miquel Raynal (Schneider Electric) wrote:
> This controller can be fed by either a main "ref" clock, or three clocks
> ("ref" again, "ahb", "apb"). In practice, it is likely that all
> controllers have the same inputs, but a single clock feeds the three
> interfaces (ref is used for controlling the external interface, ahb/apb
> the internal ones). Handling these clocks is in no way SoC specific,
> only the number of expected clocks may change. Plus, we will soon be
> adding another controller requiring an AHB and an APB clock as well, so
> it is time to align the whole clock handling.

This also fails to apply:

Applying: spi: cadence-qspi: Kill cqspi_jh7110_clk_init
error: patch failed: drivers/spi/spi-cadence-quadspi.c:1829
error: drivers/spi/spi-cadence-quadspi.c: patch does not apply
Patch failed at 0009 spi: cadence-qspi: Kill cqspi_jh7110_clk_init

--9gp6hdOn2aMXkGnv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAml6dG0ACgkQJNaLcl1U
h9BFWQf+P8ddwp/xT/k7H9zUa3MSzlN2P2udlPLiMZ933Hi8s1bTMBrX4XXbpbaL
i64dZ2JP+aW4SZkCNyNMiTZdNd3lMEXanGLm6Y0qi520SA7jMQNdXxI7+cdctJnr
STr2h0kyTJkNoWKI0PKGoUNhlggyIiuZq6U/gj4TuSw21z27QbHnfScneoAOz/7Q
eaE/e2UEsaia583kN5UgbwhoP070vGQfvI2W9A1Yp/ZUUhZRoNZlip2923YowicQ
ozhXwpfCw4zz4imH8ZOuW/i5ZKotmnQMx3Un1OxlpbWXcoHp7UzAD5UEZAN7mHeE
BAXQdgm7lCKXRJ9+w2VMmYcOOpkWiQ==
=d+Ej
-----END PGP SIGNATURE-----

--9gp6hdOn2aMXkGnv--
