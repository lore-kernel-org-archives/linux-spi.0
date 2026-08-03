Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2400540F726;
	Mon,  3 Aug 2026 13:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785763605; cv=none; b=ejFRA9JDhkl3EZ61KJjoocPznrup+8Ra7tv4353XnAzV3MOkr0LhWyGHanBAaJFUpJCLaJl+5lIQ8JlqmfgKaTMwE3nEwHifB3EubrJzPwrPgJ8W/BOcvlGOUQRcbnNQZSFP3tpCO7Dwvd4ujYHXjakluDVSRv2bWA/UXUz314o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785763605; c=relaxed/simple;
	bh=rwxqF12EdtFJ1hgKVE6whS2NwIy/fDvPhGCr1gt49gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5pecrUOe4ql75rKD+Zv/OwAc91UoxwMj14+g7931cA+WDQ99I1NDsczI2EDk5vRrxbXdZkD+OAbxS/OTC/TGdTs2PDgd8iugVxn39dWXBXdEXYWjN/PEu/ub0f7mPDTeVGCm4I1UdL+izckdr4/Mz+lxW9nMZGPYQdWgm6fH04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkQ1Qzs3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkQ1Qzs3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7FB1F000E9;
	Mon,  3 Aug 2026 13:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785763601;
	bh=rwxqF12EdtFJ1hgKVE6whS2NwIy/fDvPhGCr1gt49gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KkQ1Qzs36sE4gOoPHlllE0w4+vJcEBreSC5U279VHES97zsTmWS8S3fAotOTfZtCR
	 1HslMw2C+3asb5utyAwdwq0J7zeJBvvITVuAYgQyIKWiy1AtzzBEOL1dFXSLETDHLx
	 L5ou0/JMDAbZ7aYIr/lMXxTqrUqOx2mP3Wb44TCgmmI9VXxbgx2oHbP4r3rKgd1sW5
	 NC2b7YU9gV+cr6QGtF6aMe6IIpPKOKn6DvmtZZCKJLyhFEJWH6QviCfNMY8AxMbP2g
	 YZIQ6TQec7oUXSvjxsdnC6mrThyi3GltC/YjuBSU6haBk3a6/aZZERwief4g2PRsTR
	 3MR1twifq00ug==
Date: Mon, 3 Aug 2026 14:26:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	cwweng@nuvoton.com
Subject: Re: [PATCH] dt-bindings: spi: nuvoton,ma35d1-qspi: Disallow GPIO
 chip selects
Message-ID: <060af0c2-c3bf-45d4-9f73-8f761fe1d88c@sirena.org.uk>
References: <20260803024048.1641756-1-cwweng.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SnYGXlnakQ0g76Up"
Content-Disposition: inline
In-Reply-To: <20260803024048.1641756-1-cwweng.linux@gmail.com>
X-Cookie: Natural laws have no pity.


--SnYGXlnakQ0g76Up
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 03, 2026 at 10:40:48AM +0800, Chi-Wen Weng wrote:
> From: Chi-Wen Weng <cwweng@nuvoton.com>
>=20
> The generic SPI controller binding allows GPIO-based chip selects, but
> the MA35D1 QSPI driver currently supports only the controller's native
> chip selects.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--SnYGXlnakQ0g76Up
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpwlwwACgkQJNaLcl1U
h9Ay0Qf+PpX3MDUJS5bXRe5CiOhf9NSZgwwEgG6RR35x6m67C42l32HNHAk9gMzB
RbVVXLQZnA4Oqa7VOQ49FKHRQHDQ40OAkHEG6Jy2LUu7aqm5TSlExqMsYd+BCcR/
vGFgpbqKO4mfUgOTqGsajAvH2ADC0ySXU+l83QkCwb6h+zBJ9cmmZF1kwbcBI07y
rS6zMg96apTi8qmMY+jGj4mLndk2Nwmw9Xwa5qWkRLKTb4/4esir7+Ln9qAzcgJK
oQZiGccEiEmvBMzOypgPpnZuDod/pNfcWWJcnMTyTgqvlMisP0Y8hW3doGCe6cCM
Po4S35plWtE7bDNzNDLmzkFzlCvOUQ==
=2Bqe
-----END PGP SIGNATURE-----

--SnYGXlnakQ0g76Up--
