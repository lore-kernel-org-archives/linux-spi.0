Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E493264E1;
	Mon, 23 Mar 2026 18:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774291653; cv=none; b=hqJsvBSOSi6UbywXZWB1SVfQCNCdVvdK2arsGMgP+bm6g/q4foWc13Vzf85Hyrc/wL+fbtkacR1xMmvqGMWcPHI1R+fSilTl98L5j0+U4TWWjAXUGWedGHOED94fReiV8Lqak4Y3zZcoTJFsZeD6vmYQQjpMguT7dnTonyhXagw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774291653; c=relaxed/simple;
	bh=aGZT9X98YDjY8pqmFP7O2DzCiDdM3wiDh3Ke8SYfcAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjpK2htWF/D8s6W4vyecviOi/ZrHeAmPjMfTdq+UqokotVGmn6GtholRcBE+zDDibesuU7GINRNeE7YyW0Ke8/AU11618HjaF1gzjIZXU/A31IMYCdpekXUVQRV5zBoDaa9q+fptqLix9dFOPDkYdyWdDvIN4SDbDKGIJS07wic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPLPJpLX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPLPJpLX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED47C2BCB0;
	Mon, 23 Mar 2026 18:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774291652;
	bh=aGZT9X98YDjY8pqmFP7O2DzCiDdM3wiDh3Ke8SYfcAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qPLPJpLXohqArS19d0Rsl9Tq2Rm0Cf5y8Ng2I5m2KFg7EtoZJdxNLwg/MTJl2W1Cw
	 2feB14MkLRFpbrXw84xdggi3fCpG0AMTwM3txAQ6rXC00YQRDOd4rGZyLjwmq+j25n
	 u+JskI+l2yddBgwBC4tkJLEE9HdAsXMRiFYNxMZadP+st927M7B+FBS2t24RShPfQ9
	 Gcs5ki9PsAov/Ojz3J882p9zKntofTzAYIC1FyDK/2g6rtbjqSAtCRhSwxs+s4AZn/
	 y9RPUlk7ZCKcje3XI/fanUrSacl6u/SSoVjkqn6W0BjckGDMsYUcFgvHV/X7xxDZkf
	 sm1UKd0Vm3Mrw==
Date: Mon, 23 Mar 2026 18:47:27 +0000
From: Mark Brown <broonie@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Felix Gu <ustc.gu@gmail.com>, linux-spi@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	LKML <linux-kernel@vger.kernel.org>,
	Dongliang Mu <mudongliangabcd@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Johan Hovold <johan@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: spi: meson-spicc: Fix double-put in remove path
Message-ID: <0313ea57-750c-4a2f-afa7-c6b2c8896968@sirena.org.uk>
References: <CAN4SLj0P1pAAMBbuWhbnjfwqd-5bwsNroeMzghv0P0Y_myUSqg@mail.gmail.com>
 <47bd50c8-28ce-45a5-ac88-2167b8ec2baf@web.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZHNEvxJ+7aoee4pA"
Content-Disposition: inline
In-Reply-To: <47bd50c8-28ce-45a5-ac88-2167b8ec2baf@web.de>
X-Cookie: This is a good time to punt work.


--ZHNEvxJ+7aoee4pA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 07:44:21PM +0100, Markus Elfring wrote:
> > Just code review, I have fixed a similar one before.
>=20
> Can such information mean also that any source code search approaches
> would be involved here?
> https://en.wikipedia.org/wiki/Code_review

Feel free to ignore Markus, he has a long history of sending
unhelpful review comments and continues to ignore repeated requests
to stop.

--ZHNEvxJ+7aoee4pA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnBir4ACgkQJNaLcl1U
h9C57Af+NqjsImq0bxUPqDXWMASC25bPn1ol/sq+XmMMoLUcffzZ62sKcnKJ0Us1
ZH6Be/oVR+8pwi145jyzw4M3JF0147lCdgKJF2S3nJeYVxWWSrGHGy0gPrHlcLTu
Rvdvs2ULEcYR3ItAiuyux3MHha+x/ZOPyoi7fQDrXJIj0DJjVyqBdJnpt38Ix9kd
v6/+MMO4H3+tBEqUtwMRPYfll9TAPwvt2hVrU2ab5Azz3byqjtW9KGhjazOjCeCG
xc9fCHcH8Up/Gv6yhH519+t8QaAufDgbBFS07g7Qw/txCPHnOBJkGeef4BwUe9iC
j9a/WGJNXuE/GNCo3e1BmLGflUEaeg==
=nwlR
-----END PGP SIGNATURE-----

--ZHNEvxJ+7aoee4pA--
