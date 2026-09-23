Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F74743F8A7;
	Wed, 23 Sep 2026 12:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790164811; cv=none; b=vCU9b8irpVpX05MyoVT198NZ1OsW/kVpE238ak5g3/Ox0a0aNwyxoNBb3RgPvJjKdi9GjqE0AgcQZZYuL4ckQsXiBoyuYAffMznUT58aoVc1nEXsMxII6YA9864di2VQMRF4BHXFEsQErBQEQ0WYbZf1dH+O/ArRZWgSIZUvtos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790164811; c=relaxed/simple;
	bh=IardE9mwTMTgNgf71nb7nB6u9W+250RspRf5bHw4Yv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIfmsXsDrCkcmZT1wQMFQhc3i2aYCz9kp3LkyvjUVC6G4ZR4wCAP+iMc0NljrHdZgCvKusciwHBu2xFy89BVYKiu3MDCaf7lcEAXs0yKV8l5HUJDSAodw44xY3JPp9hIoRdXaF1xbDFgnDZDI8OBRNAf0Zv+cBrpt9FltnLleH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbe4/N+a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbe4/N+a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B299B1F000FF;
	Wed, 23 Sep 2026 12:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790164804;
	bh=IardE9mwTMTgNgf71nb7nB6u9W+250RspRf5bHw4Yv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jbe4/N+a414ufitw6R7WJKMNaOyEGFvwEYUM5QNWgcRccrbow9rAmiIxcHBz3Apnj
	 Q/0/bl16q5Ipl/ntYMweZW2ADvs29vrE94M0Bjc+Gb93v0vMt0mLp41+Tza5Gwxe8W
	 bqb4f66yqdRZYd4ETNohR1bMYKXhqA+j5Hi6z1kn8Os9pTaoxTD7xBhuhQ5/gq/cGe
	 AYNOjpQRRuWsuWaMyLYOgmb8leXZG5iKKXWO5jLFf5c0cof/q3aR/koyMNN01Va5ff
	 /dzRO1F9wA2w5LH0gRPGki82iYQNaKUU5N5G645lRlrgd8GMBWQ/dS8iwgptSShAtE
	 iPnUDLY3S1scQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 189721AC5739; Wed, 23 Sep 2026 12:59:59 +0100 (BST)
Date: Wed, 23 Sep 2026 13:59:59 +0200
From: Mark Brown <broonie@kernel.org>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	cwweng@nuvoton.com
Subject: Re: [PATCH 1/2] dt-bindings: spi: nuvoton,ma35d1-spi: Add Nuvoton
 MA35D1 SPI controller
Message-ID: <arO_P5imHln19iV-@sirena.co.uk>
References: <20260923041926.425551-1-cwweng.linux@gmail.com>
 <20260923041926.425551-2-cwweng.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sUqdv2tH/WyvS8Pm"
Content-Disposition: inline
In-Reply-To: <20260923041926.425551-2-cwweng.linux@gmail.com>
X-Cookie: Too clever is dumb.


--sUqdv2tH/WyvS8Pm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 12:19:25PM +0800, Chi-Wen Weng wrote:
> From: Chi-Wen Weng <cwweng@nuvoton.com>
>=20
> Add a Devicetree binding for the SPI controller found in the
> Nuvoton MA35D1 SoC.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--sUqdv2tH/WyvS8Pm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqzvz4ACgkQJNaLcl1U
h9Dz1gf+NYCOhOIpeWAVJRB3QbcSmYNASO/6KLefUI3xl8grpvex8RMm/fte8r0i
7CmPqopVussH3GKXPFZKYebJtOFCNMyKaMf71hFgoRi+HqRnWtYLvsepk6amqgZN
mQXHo75rJbduC8/3Fhd3MZJBwZHDt51qlqRlh1OKHvEIvaVgcEMkFaGqEq1ehEPA
RKE377KGTvEC2ksHXE/GIt6ewtKVjy7kvALLNogL4l5j/CewNIq4J7nifbjz3Z2t
A5pyOcQVq4PvzbJB7qDR8TTezPlDwm7nFlCmEgwpCyvy6Mdi/2HFT0l/oXW2hHsi
hUVqrqk4mqri4Lxcn07S3DIrcN+NQQ==
=tlAB
-----END PGP SIGNATURE-----

--sUqdv2tH/WyvS8Pm--
