Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EE747A89D;
	Tue, 22 Sep 2026 11:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790077574; cv=none; b=ffeVs5waEhFMEMiM6VOQLEAUzFMQy1yvW6vWfTrFxCcOva/3y/uc7KJCTJukoCh3wPQmjhGQzuUqO5GPcH5KvbKuli4XCbvLkDe49Tj/cz8TCfl4HuVnFVHdLd8UUra9EJqceC3mcTtZiG6Fhm5rVAmqJIS6nqu6JvZfzaC77Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790077574; c=relaxed/simple;
	bh=3UYk/QnAXxw91rI4sft2TJ0jYbJ/Ix0F6UGke6vi6M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GT6/MMCSwYYcBYB9tlUTk8avj3Gl+46IRcWJr8oveYxs3oHyuijD39sDPVdpFOU77WSetO5jbkZl2kd//YWnd/0EK6yS1CDylOIGj/DolFShMnjdHXf5KDQwNcAJw+cRMfKq5lCKuWBbC3ZoZnfp+fgIGVyXIX+DykQxmpXiEM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYg+rVrR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYg+rVrR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389471F000FF;
	Tue, 22 Sep 2026 11:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790077572;
	bh=3UYk/QnAXxw91rI4sft2TJ0jYbJ/Ix0F6UGke6vi6M4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gYg+rVrRot7mwkqKYUT0GVmODTR/V2xigY+0DIllIkNHQI064eCYjshHcFeTr1sUt
	 9XrjNbydwWUWzRTmgGyfthuwQpDJNSNcTyUz/sZnMh0bmYSP8+gmi/YTXaVo9cv57e
	 WdCYvVJ+1mpqJkGgBVU8pzT8g979rpkaWXkeKD5X0b9AJMGG7a7lIWvwButeksyHlv
	 ujj8L8uYTxggzbUHc3dWFeYPpoezUvFPI4dexiaABOazpenogNQgS1BK45ke+jvQZD
	 nWqTheV8YrHTH3vo3zfIR1Qjq/7ZQdEojG8dICRtwutSXzGETrbDGPElY2zAktGmuh
	 nbxMDBTL1rKcw==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 276A71AC56BF; Tue, 22 Sep 2026 12:46:08 +0100 (BST)
Date: Tue, 22 Sep 2026 13:46:07 +0200
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Thanh Quan <thanh.quan.xn@renesas.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: renesas,sh-msiof: Add support for
 R-Car X5H
Message-ID: <arJqf03X2Kd7fP4u@sirena.co.uk>
References: <cover.1790065451.git.geert+renesas@glider.be>
 <b8f4648eb1151b75d41e561c6b2adbd9bc4c0782.1790065451.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tZ7lf9opbW2XKPL6"
Content-Disposition: inline
In-Reply-To: <b8f4648eb1151b75d41e561c6b2adbd9bc4c0782.1790065451.git.geert+renesas@glider.be>
X-Cookie: Too clever is dumb.


--tZ7lf9opbW2XKPL6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 10:27:00AM +0200, Geert Uytterhoeven wrote:
> From: Thanh Quan <thanh.quan.xn@renesas.com>
>=20
> Document support for Clock-Synchronized Serial Interfaces with FIFO
> (MSIOF) in the Renesas R-Car X5H (R8A78000) SoC, which is the first
> member of the R-Car Gen5 family.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--tZ7lf9opbW2XKPL6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqyan8ACgkQJNaLcl1U
h9D1mgf9GSaOaiBxF9g0Hml4p+e8qP08Mm+wk9eckH0jRfOU3xLXV+1EaEruqGe7
U+tmn9ty6Q4QPpLTfBrbqKOZI/oLCazgKGfi5ZIApOnXxmlho8hlZv1cKiK5MoXz
ly6BBPyaeoaJ/NmiuJ4b0UkJotgpin8/zl2KGrrFw13Mv7/IcfMuxJ9vAhncrz8C
0o8ZC8fkAYoCfHBPQ24IkJSZkaOkrU3zkRVtDw8SsdygD3EGxFBBwUHkB+IFqMj1
0eo6NMHMWa01A48qPm2Q0G4R+iqp01N0r3Vu7GYMGIrr/ED8epsUmPGY1s8Soc+W
frXARjpcY+ITW/xucxlzHXU2OBZQwg==
=xSm2
-----END PGP SIGNATURE-----

--tZ7lf9opbW2XKPL6--
