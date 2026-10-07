Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B28F46C836;
	Wed,  7 Oct 2026 14:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791382079; cv=none; b=i5eRg5unpZTFqiEC1skUJfke715zU1geCOmKLLpD6e8aunlfTgfa+VU8uNG0KEe+8wyor8Ho8wUj9ZbbyDZU5J33nZScva82QNPPii9zZonzqxJR5hlBPgvENmg1C4tk/XmXKrPLIydhgHgkVnEwdLlS4OB/mNKxVi5AIL85ZLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791382079; c=relaxed/simple;
	bh=ja1Up43SZ/3MPlfP2V7EBtiEvMqxYzjRZu9YPWzQb3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8ROouYyVNGFIQmhpLT5Xw4fUe48XKPt8nGlEfqonq8e7X8ldJFkdJw4Pn0i97Fgs3m9UphZIr+U2FfQtX7rKsdPoRMx/Z1pqCb7DRoMAvGrqcYy3r7q1UhKZGFzXJEEfRghM1j640ttriA7yz9RAyGSYi/pfQxPHnG3Zchsb5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mk/jIbIy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mk/jIbIy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BE01F0089B;
	Wed,  7 Oct 2026 14:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791382073;
	bh=ja1Up43SZ/3MPlfP2V7EBtiEvMqxYzjRZu9YPWzQb3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mk/jIbIyceM5RO3mJbGwp7Qtm9k6cHp3UrgY3mUaBT3Lgi9jG8Ys/+ZlBDF7Ax9oW
	 0Yv9iUwK90lQdcRagmWos/JqoeDqSm5oEQaI+P7Ju8doWtleKLP+ktlr/n+OxmSSdP
	 n11ojH4iMwbJNDSAQ1ekOo+uq2cZW75Jlx1nnFZY+hjq+8joBZlIpFsCWYSWhmVoV4
	 +54u0clcNPye+xmHpzrGBJzLbYobuo99qmxCZZxDtKpX1tWqXKCTOp92Phv8dssD7A
	 y3XEFzxZsgV2I/oDeSkDC2lsDNPGvgeNkJ/4s9ZnEpSgTtsSl4vArzJwBB4D7JLjL+
	 gyNKEpcymvX6Q==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id C04F3191F6B8; Wed, 07 Oct 2026 15:07:47 +0100 (BST)
Date: Wed, 7 Oct 2026 16:07:47 +0200
From: Mark Brown <broonie@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spi: dt-bindings: snps,dw-apb-ssi: Add Synaptics
 sl2610 spi
Message-ID: <asZSM6IjVwWI1Klw@sirena.org.uk>
References: <20261005152230.25294-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="89qQJAeFMQW1Z3DW"
Content-Disposition: inline
In-Reply-To: <20261005152230.25294-1-jszhang@kernel.org>
X-Cookie: Use the Force, Luke.


--89qQJAeFMQW1Z3DW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 05, 2026 at 11:22:30PM +0800, Jisheng Zhang wrote:
> Add the compatible for the Synaptics SL2610 SoC SPI controllers, which
> are compatible with the Synopsys DesignWare APB SSI.

This doesn't apply against current code, please check and resend.

--89qQJAeFMQW1Z3DW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrGUikACgkQJNaLcl1U
h9CmwAf+IaKQ4+jQK5cDclljMMzkYApzHcRnMn5wiIXW37XdULkBUxdn4q++DTS0
m8Pi4EgYdwowG2yxyfomBz0QbVHOX6XoXGjbuK/rKcmK8SL4mimKBgGJGhiSxlF5
4ry3TGvnKSW7YxxLnb3N5BVgHT/CoIDeVlfpssTMgjabUNLpTG9OiHWPUIhCTeZn
YOtXwPLBtbCdmOMfsKahqzAxJN8l9UnryIPOi0dKeC/+4u0HRMrzjfaPzYEJ2x1v
LKwo5UhrGTgbQGJLEj+N9k5CqJr+2U8G0inj9JAUPzs/3lflyAgfQV5E+84Mg6C9
u7tQ8Da2aXVqCZc4nltxXeQssteiSw==
=1SjL
-----END PGP SIGNATURE-----

--89qQJAeFMQW1Z3DW--
