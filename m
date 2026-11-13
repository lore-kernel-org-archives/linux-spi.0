Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604184;
	b=Ueful/gKqQYwUBEcdmC7zCYn8BIYgC5XALenAUonuHYJEWBjNX3HAwhed8W07df0ZLwY
	 SLosy+AJRX4FLXirQRF0bzDq6tC5tVIVBNUiDNoLrjZGGkweePUg4AdxLNN8lXIpCrWlP
	 psxzwLO2tQORAJpB9NjYD5yQAG9P3fWF2ZcuZ0nIentonMSOhdBzQi2T2q6MDcppNJrA3
	 45mzjDrW4Fzwl0yMZZIO2851vLSS1zXv3fAaxDCogMOTklwSwGLI5Pu12pPh6bZNXAelI
	 5aUOtLBNtC/0XWpeCo+oRGNBtTw/Q3PXpphpaJTusAwP+EsqZjQtzsQ92AhmyqqtEAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604184;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=6eOjhLOcX7Bv8sWhvREEGpmTmpCGHPEaE+aEgOt23XQ=;
	b=Y18ggZnQsRpBOdP8W4kcCwdwytAAL1fNv9tNZ2Em2qnRvbIR4oVe7jw7Y2UVU30l3JU7
	 7pUPQpgGSvKN5RASZoW18ItVQ2l26S+XD3dGIHwZ9GKX2VyTwbyI1n7cCcCd9vYLHvDh/
	 aIKomku4tK9hr+s1GmurhLXpsnLB3w1z2oGdY5M1Ym+PpUfIvXhX0NAiRMj5E7xbPBNeL
	 o9blVI05hdpbMuU5ga6BiNXHK/g9bZwlAGhnU9nWoP07RQOc4g/z1JFpxSEr82aXggSk3
	 BGMONZhEvzAm+e06A4nQQP+IuYbUwPjROErILsC46oRjwzSX19JBz+nJSO7ZeGj/J1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nqCUiSpG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4325760A383A;
	Fri, 13 Nov 2026 21:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nqCUiSpG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3F01F01833;
	Fri, 13 Nov 2026 21:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794604183;
	bh=6eOjhLOcX7Bv8sWhvREEGpmTmpCGHPEaE+aEgOt23XQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nqCUiSpGxbHUSiczAUVv8s3WBnLLog8MtDYzaia8VJOSPs1A20eO0lDDUfbsw3AWG
	 KYEgBs9ckxGaA2r7wdDrMlBeVrPq8X8eh3mkfs61wG9T01TUoB8IML3HaAfUPu/U3k
	 FAnrErQXGEBL8xkVlROZnlvFQkdYChMO41TcTGCMHCPHq/fKU1H1xlL8Kmxb4eEHkl
	 HdSlvnmJaAj5OVt6WG+k7bT0SUy4aaoGKXjQYww28Fyt5LaPslx+2mwZf8mctiUuT/
	 SP9S9l9MPqo+fwbwwFoE+fjjMrnx9H+vPpkXv+JvcuDU1OrJIhMHq3nyhqfC2Qg7h2
	 aKhgWMZc0M+qg==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id D62E031BCD1C; Fri, 13 Nov 2026 21:09:38 +0000 (GMT)
Date: Fri, 13 Nov 2026 21:09:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Navid Ghahremani <ghahramani.navid@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
	stefandoesinger@gmail.com, krzk@kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 19/24] dt-bindings: spi: Add ZTE ZX family SPI flash
 controller binding
Message-ID: <d21858d5-70c3-4c5c-afa5-ff0bd3e6afac@sirena.org.uk>
References: <20261014072109.1759502-1-ghahramani.navid@gmail.com>
 <20261014072109.1759502-20-ghahramani.navid@gmail.com>
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
	protocol="application/pgp-signature"; boundary="RhwkDzC4iL2Rric6"
Content-Disposition: inline
In-Reply-To: <20261014072109.1759502-20-ghahramani.navid@gmail.com>
X-Cookie: When in doubt, lead trump.


--RhwkDzC4iL2Rric6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 14, 2026 at 08:20:59AM +0100, Navid Ghahremani wrote:
> Add Device Tree binding for the ZTE ZX family SPI flash controller,
> supporting both ZX29 and ZX279128S SoCs.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

When submitting support for a new platform please make the base series
for the platform a *minimal* series, then send additional drivers for
the platform as separate serieses.  This makes things much easier to
track, avoids confusion about how things will get merged and avoids
DoSing people's inboxes.

--RhwkDzC4iL2Rric6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCavd8kgAKCRAv73Ows9A4
icX4AQDW7X4GJZGS91gcQnmi5cktf3ChuG4n1WJrZdXPKnjMNgEAls22Dv2oXK1s
xI0aJ5KhbZkYCNWWpw3IctuvFu6a/gI=
=eTNj
-----END PGP SIGNATURE-----

--RhwkDzC4iL2Rric6--
