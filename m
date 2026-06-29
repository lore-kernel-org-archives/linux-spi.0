Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC0241B357
	for <linux-spi@vger.kernel.org>; Mon, 29 Jun 2026 16:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782750777; cv=none; b=IqrSYjfdkyQR8cLqyWPt4ha1mFBZjpjlvKnRJpeyusz7RvwpjZG/w6krf07bM/l/Yeq9eKJ3SwVXqG0E43CadcsNSJ5EbUcZ2WIzR3EUAky8tgCVMV90BfOrlmU1w7V5mTqTGlzfaXAlqVL393LV89/naoEQqf2QAH6KV/KNDuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782750777; c=relaxed/simple;
	bh=k/KauXLDb+4VD4NJZORmKp/3CbnFt+OiAQC1meEkQnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnVCJ1J125NQTx7f1OhawjM4+QhVDASrTFI6ZhRwwqH13o2N+QlQGjhLWBaOYs9QlwaUU5JMeSTqPTBe5P4xWS75EBugfSuvjycypb8CO8SkFgYlzc5J/j49Z8o8GUvmSKl2vmPtAbgX7ov7C3Z0S3fNvwBCpCoQLJ2vSf9VrN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Ef95RGgS; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Ef95RGgS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=k/Ka
	uXLDb+4VD4NJZORmKp/3CbnFt+OiAQC1meEkQnc=; b=Ef95RGgSCjr7A+1nVofa
	edr1RhelLp+qLRs26oZrJe2tbQ5kK44EdOXEviBvnuf34xFDsH6ybm4pWtQ3COeL
	tO+Q8oyHR2PEqdv37aUJk1VBpDIf9C3RjpH/esk7tazR7vTnQr0Y6/30jxaoO9Ev
	tj6a/oebq4k+sJ8Vt8sPo9a7F8V+c+kJWQ0xaaXjuAp0QXxK+Luz04EdPSU6Q/VO
	9oRDcmjoF+Ki34FWxKo4Sy7VGQRSNUOiHZmsLKXzMcgmq0Zgjpkv5sfFSUA3uttJ
	ftSIncR+eCMH3EGXgYVBQmcRlFn7cqkUNZdQRjcxuaszJXARr6pVRtsk2SgjVOhG
	og==
Received: (qmail 454215 invoked from network); 29 Jun 2026 18:32:50 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Jun 2026 18:32:50 +0200
X-UD-Smtp-Session: l3s3148p1@06lhAmdVkrMujntC
Date: Mon, 29 Jun 2026 18:32:50 +0200
From: wsa+renesas <wsa+renesas@sang-engineering.com>
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Felix Gu <ustc.gu@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: rzv2h-rspi: Fix DMA transfer error handling for
 signal interruption
Message-ID: <akKeMo_VeUm9RB6o@shikoro>
References: <20260627-rspi-v1-1-170c93ee14da@gmail.com>
 <aj6sEE5y62SOVsRb@ninjato>
 <TYRPR01MB156197735CBABA1699843B9B085E82@TYRPR01MB15619.jpnprd01.prod.outlook.com>
 <akJJ09zjt_dXp1jS@ninjato>
 <TYRPR01MB156195CB900B9054C94E4FB3785E82@TYRPR01MB15619.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fam5c3vWWx9TE0aF"
Content-Disposition: inline
In-Reply-To: <TYRPR01MB156195CB900B9054C94E4FB3785E82@TYRPR01MB15619.jpnprd01.prod.outlook.com>


--fam5c3vWWx9TE0aF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Reviewed-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Tested-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Your explanations were very convincing, thank you for testing!


--fam5c3vWWx9TE0aF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmpCni4ACgkQFA3kzBSg
Kbbs2A//W8NYlkF+ERbUE2vrVSh77k0U49lnIJs0jfTNkJFdvAPliWJfoAh8oEfW
URuQ+bIz5N3XlSglfOfUwp+jBCCrm/pDD14DMUPS6AYVG+pVe93zqDT6Zkhu95r8
4MjVdKbmpxguGbMsLwhVEFOSggNiGajp3QnpPDSfbekxuQLGEI9VrHJ19hRavCSN
g0GQIHI4URyRxHyZoF1uXm5CvLD10bNoAH4/lR4wd1dO/VJMH7as4k+HXPdDiNOJ
S4t0LwTgX41Ane5TtP52EOz+pU1ghZA18CaN31ZCtzIaQI3iFle85Xtff60HTh4E
05/SCgIfOInw4WAOIbpsviQQ+inibpT32jHbD+Yl98sDxZOIy4QICWdgHB0lrHFK
HCCUjoM0ex9lVIgKlSrREjvkWQWadskfFk/M26Af955CqSjJd1cBkCuXwxDtzkDv
5l89Lb1kpQZmE81AABejtZ4a3f5NRhZ8176axQbB87vrP8G1RYN7mo8zK+lhoOcW
Ok8zUstte2e58WWrGeFMuwujTrMRkmJHMLhWaQd2nmQrT48IpQTM3UKFJrO2PmrL
qCqbdRWtovMew+D/jd3qBJ1xG0NRpatVKTlA0FmtfqQpj03+5UD9J8V5HPXaXF+C
YwZjT7erqF4OrL9MlXIV4U+NQZy4RWXHiFvAD/AIPnn/XYQ7Vu4=
=ZkOV
-----END PGP SIGNATURE-----

--fam5c3vWWx9TE0aF--
