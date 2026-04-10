Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C79135DD1C;
	Fri, 10 Apr 2026 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775835883; cv=none; b=EQrIGLU71+FyzplNvGCugbcDd1o6/ZvXpd2K26+3ei61n1NRoLFoATYg+jEmLtYNb63mm3nuiztVgOCBzn8AwhPTA9QyLwj9ZQYxBV4LniHovFQVt3PplbCf5yRTJ2umv7EZCNz35HS+b7yDyRMDcnOdmin2z3KxU2zMYnESD6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775835883; c=relaxed/simple;
	bh=fNv4Ok1u3X6cxegGSB+eEUrRYhC1cDsemDV+eTZXlCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3Iu9h/lniQV8+9FD6ZoELtB8/Aj5/p/bgo8ql5498wSCzOTOAth8t6TLWcx8gfTrNBQLGBmiM7p90P1+hJXtBYthSCgwJHCOHzsRXkuyo2Qxyd8gyTGS1a6zULqK1y0K8uR9M/L5UM97yL6Z1/ew58iRkYLVTTYwyFPnM9Sr1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Byix/Nb1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Byix/Nb1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BDBC19421;
	Fri, 10 Apr 2026 15:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775835883;
	bh=fNv4Ok1u3X6cxegGSB+eEUrRYhC1cDsemDV+eTZXlCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Byix/Nb1mnTkXu8LwlES2uQ3Xnyu2b01ANSjWdMtdMaD/Jnf8SmR+Xglj8/1ZIdYh
	 G7UHFtXaTrvr9sIhkruy6col1UvQkmAHPGnFSEEXpFZtN/jvWByAyWEQzTa1nVzWQh
	 qDXbfbO4drXZoB5cBlROFZxxFjOQ7XKiicF2CG0+AULvJy9fPJMSKWGpB76DmKnEwi
	 rY/XtnZoIoUzur92NoKQrQiNfW4OAggDVjCSltLU3dHhxh49R9ZfbzFQkSX8/2D8sr
	 oh2sAssUNm0IhQN9PzGe+u0HhFDQfIxtj8zwsiFSXizpWXSHrgjYoMhxIcGXP4OAhS
	 DVwolmm6TzJSQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 420CF1AC58B8; Fri, 10 Apr 2026 16:44:40 +0100 (BST)
Date: Fri, 10 Apr 2026 16:44:40 +0100
From: Mark Brown <broonie@kernel.org>
To: Guodong Xu <guodong@riscstar.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org, Alex Elder <elder@riscstar.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH v8 1/3] dt-bindings: spi: add SpacemiT K1 SPI support
Message-ID: <adka6GqvRSrZAY9V@sirena.co.uk>
References: <20260410-spi-spacemit-k1-v8-0-53ebb48a4146@riscstar.com>
 <20260410-spi-spacemit-k1-v8-1-53ebb48a4146@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bB/Q26L4bd+03tnk"
Content-Disposition: inline
In-Reply-To: <20260410-spi-spacemit-k1-v8-1-53ebb48a4146@riscstar.com>
X-Cookie: You will be divorced within a year.


--bB/Q26L4bd+03tnk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 11:04:20PM -0400, Guodong Xu wrote:
> From: Alex Elder <elder@riscstar.com>
>=20
> Add support for the SPI controller implemented by the SpacemiT K1 SoC.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--bB/Q26L4bd+03tnk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnZGucACgkQJNaLcl1U
h9D2iwf9Eize17JsXARuOZG6T3Rlw+XdompD+YXGF+QHaEZ9P0b3i5Mb5byebIMV
ptjEEal3lvrL22QcaweS5m0NRMVzYWh3H5gBTJjYsXilcyVB4OkFX3d5Hg9cbzk4
+MT3UcRYMoflWtWxPsaUoRGUn3SZEfoEh8EQXzW9WFe6xZT0jfXATeOa/uw0ijgs
dpUKQBH9jeFUWO9hKsDOlvancLKwRdywKfbEiJkSxkwrxbIMmv7KF4ZLe9WPM//X
g7eVD6XMxctW+dc6XjTcF8MgUs3Wvj9QW1hy7RnKHMNgUWgBQdlSRf8AV0zwd+Ov
p1lDtibQGNmKoDK+m2g3zZhU7XDe5g==
=Gjsv
-----END PGP SIGNATURE-----

--bB/Q26L4bd+03tnk--
