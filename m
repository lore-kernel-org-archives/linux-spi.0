Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981013BF69E;
	Wed, 20 May 2026 10:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779271847; cv=none; b=LiOUTB9RIJU7tpL7NJVRsm3fx5Pl32SMJhiRNQd92caB54hXlVcoYFjVsLjd/W7XxsaKYD/2/w4jHxqq9tRj0grvUup5IX5Z4MMc0UocfVY7ohp6+u1u3HwMFKyEB8I+2rx0x5YbLhUBSreaCsFkcDVkn48U+fd8s1ucjOC8wUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779271847; c=relaxed/simple;
	bh=clfN8zzGuM2JLlskiKaryiHpGZFRPHTvvLG2H5TPM9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tx5mRVnrhoDxCkX+KYHiz94RgMtbHxfSVtwzwGO6wJp+mK254tKcIMj31Ks7mN0Lphdt+Lp4LvU0nsMD0DY2fsGwJLRx6FfPJOX0y1jcworHmuHVBtci2wURF768KE5xVD/4KPrDwFUWlyihgbs/NGyAF8SDQEyeHIiaEdR8ST4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqzyR9ia; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqzyR9ia"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04BAF1F000E9;
	Wed, 20 May 2026 10:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779271846;
	bh=8/Nk4vPQPh0CW8IIxSh5GD9J7BcZmYtjb7vHxo1Fj6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kqzyR9iarPoVRPZapZy1o91ByBc5CmJZZ1xpTdT2vRSRwBSf0TtB18tSB+Uh8mKRM
	 /mVD4QHz6XlazB8ms3CjXQ8yxVtPzWCFwWYKDxag41kPFbhMAU8kiBSuPK7h8x7lA7
	 fTW3cWzof75A2x4RXGR79xVMK5FI6CoejoTSEfj/Mc3Plp0PWM7amSzapYHEmgS0Qg
	 pAotSBhZ4lT4RQPE4oc//Rhb4qOg8YWjjY7oRmDlq3kQ5z5nh/fS2UDyCi3jPncf5K
	 BJ44bQaRUg3as4vSafa8HLa3Wqed5w7ptmPTeTirZFz2b/WpLc2kVGMk+sbhLwizUK
	 ANXHF1UvN+a0w==
Date: Wed, 20 May 2026 11:10:41 +0100
From: Mark Brown <broonie@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, clg@kaod.org,
	joel@jms.id.au, andrew@codeconstruct.com.au,
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, BMC-SW@aspeedtech.com,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] spi: aspeed: Replace VLA parameter with flat pointer in
 calibration helper
Message-ID: <b629d6bb-fb17-4c17-9a79-d96d39ed0d0b@sirena.org.uk>
References: <20260518095708.2502537-1-chin-ting_kuo@aspeedtech.com>
 <20260518095708.2502537-3-chin-ting_kuo@aspeedtech.com>
 <659a6593-0223-4a26-830b-1390326b84e5@sirena.org.uk>
 <20260519181348.777f7dc5@pumpkin>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KmowL/JuPoFq42Ku"
Content-Disposition: inline
In-Reply-To: <20260519181348.777f7dc5@pumpkin>
X-Cookie: Natural laws have no pity.


--KmowL/JuPoFq42Ku
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 06:13:48PM +0100, David Laight wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Mon, May 18, 2026 at 05:57:08PM +0800, Chin-Ting Kuo wrote:

> > > -			while (k < cols && buf[i][k])
> > > +			while (k < cols && buf[i * cols + k]) =20

> > This really needs () to make it clear what's going on; the precedence is
> > well defined but not everyone is going to know that off the top of their
> > head.

> Come on, it's multiply and add - everyone is going to get that right.

No, I have to stop and think.  It's not just "what is the rule" it's
also "is that the same rule whoever wrote the code thought there was" -
implicit precedence is the sort of thing that flags up as an alarm bell
when scanning through code.

--KmowL/JuPoFq42Ku
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoNiKAACgkQJNaLcl1U
h9BIxQf9HkMWU0/J36NRwMFjRutEI7x1P5sg8Sloy12eLKK6LBY1hzsPKyZ4ZaIw
vVtbThixSNpcSL6oBndIVKdvWoWyYT/o3x2bfTnzKHbdKT5Ok9heXD6aSc/f1ck4
k0Xp0kN9MptpXrEEVBr15nBjhkUOOyFVnlsFotYE9TBzhGWBWxJrQrK1w+eBYu6r
MEd0mR0/FfuUwFm27aMR6Ur33GRUPs/pVN5/2ndfNGwtIXrjKICYIQ5/lJyONp+5
nCIorPasL6Yywp5B6+p492omJxkuUpkq3EhWhwowOwTD/zlpnglzkNyVuIp3E3Wf
jyCptDj/7h3ujYiwLZ80EgTAcxFF4A==
=pk4f
-----END PGP SIGNATURE-----

--KmowL/JuPoFq42Ku--
