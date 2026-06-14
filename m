Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669C71C84D0;
	Sun, 14 Jun 2026 10:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781434522; cv=none; b=m6loiNwZ79hZlJX4QGNPIxCDMi7AkrxxTmWPV7kdoGNKsNYBLFtd8+U/67k8EDC2TPLEvqrUsCtD4A+G3o7p+2/fE/2llUmBH07REa8KGqY18f+aoe/NUPv/2D3AujdKg2+qOlLzmNtQmS2LuToQNWszA+VY/VVum72TLK7uAYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781434522; c=relaxed/simple;
	bh=vyBHfavMEG2AJu68aDC9eikYb7Xnl8YNTMGJezJAJ88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FF0M2go207AOFuEGj6SOsfqbiAAn/qHsYn5fyEnLxe2lvU5vEabAgTGNjeGpGQQ2flGtOWUpxm527oYTxuBKcJl4DiYGWA28rfzP3earJmZSj/H1JF4okydxieeZyEqoYmIt7v3xf8k67q49rT/Vb5YrHFsXMde+yeu519bwIN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jz6zlDM9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jz6zlDM9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB561F000E9;
	Sun, 14 Jun 2026 10:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781434521;
	bh=dKwyRbKTxaslTpb3ZAqL3emqIA6Fbw1/6vGrU/BeSUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Jz6zlDM9MTa3JqH+aLRu6XAiZut97zXGsisbXR6gl3TjBKzrO+O+A20QrfpoCdg7d
	 Dbr3qyFBl8qyjJU/H5XOzceYaDcHxseepwuy7Sn/+mJaqqv8IasSwTcQH2hCpAb6Fa
	 j5V5o0snxO5AYdy3/vxZGZVzr+Nzs9865iqLE3SZ2+ODkSj4qfb3rj9jT883/06KeA
	 MhEOER2zoXaA3ZdUKEgUXlty2aaguZAn5yN2vrzu4ebMVHZCO+6CTiMmxs/jtGd23Q
	 R+wErGj0SQRoWnIag199EnkS+82Wj5CH0UeQJPJELa2bqqTGD6ROBGqwULc729kcDe
	 PPKMLVP8lEuKQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 4ED4F1AC5AC6; Sun, 14 Jun 2026 11:55:17 +0100 (BST)
Date: Sun, 14 Jun 2026 11:55:17 +0100
From: Mark Brown <broonie@kernel.org>
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: dt-bindings: qcom,spi-geni-qcom: Add property
 to force GSI mode
Message-ID: <ai6IlfGZL9kAYpwJ@sirena.co.uk>
References: <20260614083424.464132-1-mitltlatltl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m6CVO7kLlwpdAouq"
Content-Disposition: inline
In-Reply-To: <20260614083424.464132-1-mitltlatltl@gmail.com>
X-Cookie: Price does not include taxes.


--m6CVO7kLlwpdAouq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 14, 2026 at 04:34:23PM +0800, Pengyu Luo wrote:
> Some devices (such as gaokun3) do not disable FIFO mode, causing the
> driver to fallback to FIFO mode by default. However, these platforms
> also support GSI mode, which is highly preferred for certain
> peripherals like SPI touchscreens to improve performance.
>=20
> Introduce the "qcom,force-gsi-mode" device property to hint and force
> the controller into GSI mode during initialization.

This is an optimisation not a fundamental part of how these devices
operate.  The DT should describe whatever it is about these SoCs that
allows this mode, or this should be triggered based on the compatible
for the variant of the device that can do this.

--m6CVO7kLlwpdAouq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmouiJEACgkQJNaLcl1U
h9Ch9Af/afKgdlUtQvVkG3nt9zzAdtJTeIgZyyt+C13HEOVuekF9IWmX13/aF2Dy
RyeqArGAB0SGiSsXV7Ml2+XQuQjRhhwbE/d3uYvNb0W9LiHbY9FJKHCt2jc2SRja
CdOYBlkdFcUKwhc+yfY4Cub8hBagezLedvIn6TJ6rnuUMRbsNOLcAEOOcizMZ29C
YjNweKOrFQ7dOdPQCEfh9Q1Z5/e5nFuacKC5aVAfGr6hvJCrUiEyG0dsGooeQBCG
9XiMtmFao9sLPmKyrW3MGKYuH9weZDWNitF3gZHTfJhErDyLk0Xl23gHJRiwp/Ev
BcApOWYVGI4m6FirMobmfCHVfRxklA==
=XWIg
-----END PGP SIGNATURE-----

--m6CVO7kLlwpdAouq--
