Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE8537B021;
	Thu,  6 Aug 2026 16:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786034903; cv=none; b=YNyqgHHJt8QzyIofnvCekJNiJcJhJB7matuETl1c2yo8WJmF4mUXJFUny8PtY2cGcOgS4AeUBzJKyMwswAhKT0tM4Ve84HeHcXM99IntzAoi/ahwOc7dMsXtXjV8Nv68D9Vd5VvyTSwS2I/Alnd5YUnMLNrcYV3MP7JSWr6BxU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786034903; c=relaxed/simple;
	bh=Wc4gnv8DquQhu28/lYZSm27tLoSvg9yENhK3oCIJuEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHWCc75p9jTv3A/w+n+C/xOYhK3W6WdY7WSzTzTycdEui7cGULXeXGCkNoOa2UsqTmY9FhtoP7ytJeROaWlexdx8Fpmj8udFejyWJzPdfEcSTP1jgY2Ils+OWiD28QLKPCvv/dBVB8zz0Kjk3p7aFTYhJ7VNgq0xi5YUXIMg5EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FI7jMf6N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FI7jMf6N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6401F000E9;
	Thu,  6 Aug 2026 16:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786034887;
	bh=Wc4gnv8DquQhu28/lYZSm27tLoSvg9yENhK3oCIJuEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FI7jMf6NrGR/3CoFMCIq155vv3yeKTcdU1Wn5aR3k774GQPdNhP2bS/LVYi7RNTij
	 MsfCYC5h3oclS6an4m6C6Uehjoixnc73xIUm/bi2Ea1410FQ4ZxJX048qcHZpGrdyL
	 OLYvgdpvWug5w9rwF24etTUuPQeS9iCOsr5bTfKVLTxVkNfZMLz6nDrfPLAye6v0i2
	 YTxYUmwrAKhNRk9c1PRctINIWEtOm3X3TCqJ3A/xSzcKnkV5q6R9Gpvj0sqtU98guP
	 DM37KzW+gPtym6Slt3u8l7ko/HlhJblChu5/MP4Hf5/IVTN/jfBB0QENb58Dghs601
	 siaFcUbjI/dlQ==
Date: Thu, 6 Aug 2026 17:47:57 +0100
From: Mark Brown <broonie@kernel.org>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: konrad.dybcio@oss.qualcomm.com, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	chandana.chiluveru@oss.qualcomm.com,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: spi: qcom-geni: Document device-gpios
 property
Message-ID: <50834ed2-a3bd-40c6-bfe5-98a7f81856e6@sirena.org.uk>
References: <20260806-use_gpio_to_notify_master_of_spi_target_activity-v1-0-c363a9b5df69@oss.qualcomm.com>
 <20260806-use_gpio_to_notify_master_of_spi_target_activity-v1-1-c363a9b5df69@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N8SVibxcyIJIXZIv"
Content-Disposition: inline
In-Reply-To: <20260806-use_gpio_to_notify_master_of_spi_target_activity-v1-1-c363a9b5df69@oss.qualcomm.com>
X-Cookie: Brain fried -- Core dumped


--N8SVibxcyIJIXZIv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 06, 2026 at 03:43:44PM +0530, Praveen Talari wrote:
> When operating in SPI target (slave) mode, the GENI SPI controller can
> use an external GPIO to notify the SPI master about the target's
> active state.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--N8SVibxcyIJIXZIv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmp0ur0ACgkQJNaLcl1U
h9CzawgAgrRJiB/a+0ACojoiex0a8Ny5N5SGq+msxZtuGPdJjwMchvBnPrCOhYmP
NbPNuzbOAFwMlCe5bcMMnvuttBcTCJ75g4ZvMJGbhbTOmFjeC24SQaTF9aCHtosz
rXNP1vllbXJu10fIj6rtdC+lqYImTdWxrPaS5BQIKhg0Z3RwdlH/abwvZwy/nThb
SBlT28lUnDTVX+kCf84hjuEM72YMzGAxfK54a47K10JLQWwkk9JXr5o/q6imJPBI
N3Xp8dgGoMg8S0HfA1bs1VJ+9EPBxh1+N720EUPNBI8lFwwPkaEUM/C29UGb6Gwh
MftYjqp7lLyZEeuJQ9aqgT/LGohyYg==
=Crns
-----END PGP SIGNATURE-----

--N8SVibxcyIJIXZIv--
