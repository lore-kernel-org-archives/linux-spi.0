Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACCE1DDC1D;
	Thu, 18 Jun 2026 15:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781798099; cv=none; b=nRzUR/cuwC2eILc3KmxJ6M/gz3XWljAi2CBAI5gD5o4F680PT3T7mIwZORxKXTdDo0tl6MtwJu7aZ3aGKvbRCfd0EQNTi0U3z3bT4C6KQsvt1xz5UwtezF4nYCkuHFQBFKvcYwl9qBbOFrPSUgqSUjCRATJT2r9KzIQoPwDzkeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781798099; c=relaxed/simple;
	bh=cEo2H5hPXP7wiwlAi8r1q5W+2AonGUAeCyv2FcsB3Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApYh+4upHNw0pg/gOUuZvga+NmRT4cpg9aCxuhYATt83KeHVjvIchCkBDKRgWjMErIgx4RyRHrYhT0vgPLljmIK3xlpmafOOpXp4caRA0mSo38yGx7VUEs16c0/iir+/IgNKh5AsqGtFrQdSntwkp5JY5i2fhryr2vu42SrlhFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAHndvHT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAHndvHT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D19C1F000E9;
	Thu, 18 Jun 2026 15:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781798098;
	bh=cEo2H5hPXP7wiwlAi8r1q5W+2AonGUAeCyv2FcsB3Ts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cAHndvHTgH7xsgDq9U73etZp+681CtliqAEu36HI1QzOWh1HxyT9At83/hweDyiKb
	 xb6X8GYrQ4yKia8uHOVg9IeJaNM+T+IMoRe62xIo0xr78jZSfg2yaFuNbeeKTv1YM2
	 70hDFZox8lumOvxviceVy/NGxaArMkbQX2XooEOOLXh47TyUtyPaKLTio+/hZ6bwlN
	 2ibZXdfnix47KdUA18XxnI7K187ocx7OT5+dLLT4tS9Ayz2UM6oVb1FQLWZjEb9jh4
	 MymIW7Q1sxYLtd5IelO/VxzRWk562dgPDDPscz2mVmCs3u7SLuHgplyiEQ6o+3ksme
	 zBb+wlo0pAhZA==
Date: Thu, 18 Jun 2026 16:54:52 +0100
From: Mark Brown <broonie@kernel.org>
To: han.xu@oss.nxp.com
Cc: Han Xu <han.xu@nxp.com>, Haibo Chen <haibo.chen@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: spi: nxp,imx94-xspi: add DMA properties
Message-ID: <df5eed08-3be3-4ddf-bde3-97d5d02cf865@sirena.org.uk>
References: <20260617215520.3327836-1-han.xu@oss.nxp.com>
 <20260617215520.3327836-3-han.xu@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yxnX1CTfXzVl5TLQ"
Content-Disposition: inline
In-Reply-To: <20260617215520.3327836-3-han.xu@oss.nxp.com>
X-Cookie: This unit... must... survive.


--yxnX1CTfXzVl5TLQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 04:55:19PM -0500, han.xu@oss.nxp.com wrote:
> From: Han Xu <han.xu@nxp.com>
>=20
> Add dmas and dma-names to describe TX and RX DMA channels for the i.MX94
> XSPI controller.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--yxnX1CTfXzVl5TLQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmo0FMwACgkQJNaLcl1U
h9B0IAf/QVSaTxukEen1yvTKMq6oJ86umcRRPCGK0btvDvQrNLogVv+/AOqZpjz3
5eyYCQ4F08jn3BoBFQI86/2Hld9C0pefI6XE1zuQt6yLNn6iks2oXu4KZyIp+Ae0
QXUz0eXIWZtZFpJWgOoEp9TsO1D03xi9UOyzXBiOPHAPfNEDpEKa1MRp6t2/V0XK
9Wf1lVqkOSn+YSwJhIh9ic/fBB7NjN2wR4YjPDoAel6g8GY37wMI1DDKK8uJ1r/0
dhl/yWklxqirmX2/YC5pq6jGyEHgpHYIqFc1vTaE7spOsKec1NNkfhGRzH2WxbUS
utYfVKotCNqFm45IMmlQTiURwsTUXA==
=yx4k
-----END PGP SIGNATURE-----

--yxnX1CTfXzVl5TLQ--
