Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE1F428470;
	Sat, 28 Feb 2026 12:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772283315; cv=none; b=Yw7FJor31eKxc3prJinReaa56hvdl9tvG3Ur3JTuyTlgOpyDB60zQ4LLsxoK/w3J3g3JVPCDIydt+35xBxj8tqvqtHWPNwYZoNZtMR9ylhi4ywSTP+NoChA5DJ5Tg9dvonjbe20jeqhMnuFM9PiLVeLtUslzL52pl1yxoyt56Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772283315; c=relaxed/simple;
	bh=ILsuvpu34TptHZIsDyYLy7kIz5rYs6MyQQFKOpyiEM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsuYiVniC9rHf86+s++BDzExHBZFET7WUkAcktqN4vvfd4N0nlMWuHlB/etwYQ+9ZdS/9yR5sb2YRjWRBBp4EgVSh84Togw3WPnQn5GvcXCtYJT2KoyUNybrR7NZ10KZmEZLP9DlZOkTU92kYO25ObAB2aAoOvpCxpaKdvsqn/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNbycovW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNbycovW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC053C116D0;
	Sat, 28 Feb 2026 12:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772283315;
	bh=ILsuvpu34TptHZIsDyYLy7kIz5rYs6MyQQFKOpyiEM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HNbycovWG1VG0yXlJZilZfcO+jggSPDYDJc0Zzg6nt3P95gX1UteyPS1McYtD1VZ7
	 tHvnERElvMLNe7PIVLmxOHJU+i2XWsa0KQablTH/U87wHbyJgitjm7jCsB1/LRsKyL
	 EOLE5IsZ/eP3pd7hBjlpv/gT3fott8/fKEnUQKrLpJQVV/J8smKnZKwEJyh7Kb6ZVB
	 4uKByLEFBqVqfGmmwL62JBjsIbDQm9LjjNAUlRlVroz5mLehL0QZIGBRoQbva8RYOP
	 XIoLo3WvaKdVcnz40L8it7Q3ZRu2ym9sElcJ9mKOfQfdzh5dKIWYCcj+M7n09aZxmJ
	 MeZaWRaC/P5Kg==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 889D81AC58E5; Sat, 28 Feb 2026 12:55:09 +0000 (GMT)
Date: Sat, 28 Feb 2026 12:55:09 +0000
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?B?yKvvv73vv73vv73vv70gKFlKIEhvbmcp?= <yj.hong@telechips.com>
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Possible circular locking dependency in spidev (buf_lock
 <-> spi_lock)
Message-ID: <aaLlrRjiHrr4NEIB@sirena.co.uk>
References: <PU4P216MB11829B6BE6520C897F0DCE0EFF70A@PU4P216MB1182.KORP216.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n4+/nfwjbbCP30zZ"
Content-Disposition: inline
In-Reply-To: <PU4P216MB11829B6BE6520C897F0DCE0EFF70A@PU4P216MB1182.KORP216.PROD.OUTLOOK.COM>
X-Cookie: Think big.  Pollute the Mississippi.


--n4+/nfwjbbCP30zZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 28, 2026 at 03:38:17AM +0000, =C8=AB=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD (YJ Hong) wrote:
> Hello,
>=20
> I am seeing a lockdep warning in spidev reporting a possible circular
> locking dependency between buf_lock and spi_lock.

There was a change just applied to Linus' tree recently which should
avoid this, it removes buf_lock and just uses spi_lock.  I guess it'll
end up in stable, not sure.

--n4+/nfwjbbCP30zZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmi5awACgkQJNaLcl1U
h9CNdgf8CUH2ouI7+ZsbO8vihOCFjpacJ26h9oOTABYAW5Bwzog3IhGdjxFzoTog
4Es4MWrBHZ5nwW9shF/x8mjHFo0Yf6TOQH+h1JOruO80Emo1A5Wbz+NtVnshQv8B
30umbh0TrdeCyYtVQdFUWf3bxueIVgK3wXNVrijinEwD3lPAV3YFZIYT8fUW/ayR
E1LCKqBoqOS8euHmg9kDJk845sq26FZBQ1fiepLQEpZc3boLqEZHIcJFTqxRhYGg
rdgvh9LnqrnV7sZm/UpVYLGnsCwGXIp4kEXSpSldNELtlkNunBZyaM5WPh7/+G2f
PkguPvrO/Wb2QH/dzMlhIm3u31SwKQ==
=pp+1
-----END PGP SIGNATURE-----

--n4+/nfwjbbCP30zZ--
