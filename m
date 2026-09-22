Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7923C6600;
	Tue, 22 Sep 2026 11:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790078231; cv=none; b=HQGqCbQNTENaX7LP75VZg+CsJnn+/1fAWG4iF68+hsV7O5ATs+ynFXDR4pIkFBZ0kDlopqlk6ozP3R7hFCIHcfiJjHnLCFp2Nn5LH03JvLvIoqX4idfiksdBLQR4TX2NwMgl5gAbnC5KFLHR5uJHF9v/Cu3hUx4rgQRu0IIOjf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790078231; c=relaxed/simple;
	bh=NMyBdlhXmtAkDp+6q0xQ9FL4HwdykiA94lyLYtqapqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pu0zzB4pPyah5+Es951Zw+SaElgFdb6e1jIvfMLWMCpoZvsoK5Ga6UsoTMJAEgZ9+6BkxEYXHJKcVRKz7MbazZnJ1WtqiDukIe5tQBiiR6uN/+GRXhlo5QZhXFc9WqAeH1pwteFDAqwtUB5DYsLjru0uHxr+2r5YqoFmnAZgih8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIg+Rziq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIg+Rziq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE07B1F000FF;
	Tue, 22 Sep 2026 11:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790078230;
	bh=o3bM/Hk1HrSRVnMRCJ1icr/iMqSzCI4TYcYVwyGOd54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XIg+Rziq9opVBAQk7yr7nIfnei5WZXiHzrgNQrTcC1XotDC8IKdxP/FZon2fBtbNn
	 He8NmoEFTNpgRzMMW7Kkz4K768Ypv0tAshmvWBhe7yynyMLgxWbKAS9gZbKYj6dcjf
	 PqBPJwK/nWDkmlKvPJgfyflmQA4rnn/JLzCu5tPcNafV+iUb1Qk/Wthte4txoZax25
	 ZzBCn5omnNfxKCIQWJIPbCa2vzXzRt5F3FEqKE16jhrivESax4hSgPgi5pAiy014sb
	 9yTFa37wG3k1D8QN0sEJ28um1dyknlR1eHkRZIWwkIVZghF5qq3oQ6j45CkGYM1geT
	 fLDv7yT2p/Qvw==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 4DA211AC56BF; Tue, 22 Sep 2026 12:57:06 +0100 (BST)
Date: Tue, 22 Sep 2026 13:57:06 +0200
From: Mark Brown <broonie@kernel.org>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de
Subject: Re: [PATCH v4 6/9] spi: spidev_test: send predictable data
Message-ID: <arJtEvBA-cM7FB0l@sirena.co.uk>
References: <20260918-spi-sun4i-spidev_test-v4-0-5ffacb1a4ebd@pengutronix.de>
 <20260918-spi-sun4i-spidev_test-v4-6-5ffacb1a4ebd@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nysYpUDE0Edby9Zc"
Content-Disposition: inline
In-Reply-To: <20260918-spi-sun4i-spidev_test-v4-6-5ffacb1a4ebd@pengutronix.de>
X-Cookie: Too clever is dumb.


--nysYpUDE0Edby9Zc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 05:22:52PM +0200, Jonas Rebmann wrote:
> From: Marc Kleine-Budde <mkl@pengutronix.de>
>=20
> Introduce a flag to test on a predictable byte sequence instead of
> random bytes. This is useful when comparing multiple runs with the same
> option set e.g. with an oscilloscope.

> +		case 'P':
> +			predictable =3D 1;
> +			input_choices++;
> +			break;

-z doesn't increment input_choices, seems one of them is wrong.

--nysYpUDE0Edby9Zc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqybQsACgkQJNaLcl1U
h9A/oAf9F+gkdpeezweL2DebjCUS/n4Xh0b+uMbRp+o9cZbNChApJmUkVJ549oBc
89GmSMIHGYPAKZHfw6k/W6oREK7pCQt0WHYDICCypAAyGyAFTaOptRMlt/+aaEES
K/uwtFL54GCYvu+G8luTyvm6DVLGiIgvRE2LU1Pr4brDHO3UPo0HYpZYLP/C5M4z
ph2K2txT7cPkqmiEOBZ1yX5RdodMMe/2kHdfvV5EqCKUU26mYK8zctgXNSGVcmaJ
xqOznGS17gpqdkYQ5qPqE8cB6bW39tt22nfdfdaxMbiyZ3CrapodJWNK3dGzvCIV
7tPOemiIG+02MJA7QvQc5an9LkqPkw==
=Rxfb
-----END PGP SIGNATURE-----

--nysYpUDE0Edby9Zc--
