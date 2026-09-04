Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BBC4EE857;
	Fri,  4 Sep 2026 18:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788547112; cv=none; b=kOEJEfiaR43VgTLSwCi3p/5z4Zy+VPV7154fDIyjyyIo+2I5lfth0TiKaqQtuT6y3YmHAV3w7bLIYpRUL/xN7KKrjJmFznLavCy1ZvIxEqmcwPnT9vG0KYHsUMTw3RLLc5aXwgROfTNdbB8QEKmeb5WpN4vwMFz5QgINO/4Hnm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788547112; c=relaxed/simple;
	bh=jm8TQq+VoLXhUDvyZ3/ObZBgI6lhHh+1ts1w0UFMm0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQvr9C6032P+IaHX7LXaGir8nt8MiVfo9nUla90mmMY+Aw5qOFay+OoSIrMN6VIGoEEQPL5a5SNfG6QiogA29A5TKBGYs13CX+vzl2eY4yrKEeGOdzU6wrUdnYjB15ZdoxMx6fR7USQKWBNCAYpw4GulxZ3qXDccsoMLkM3M1uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9OQ+/Np; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9OQ+/Np"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CBB1F00A3D;
	Fri,  4 Sep 2026 18:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788547111;
	bh=SXyJ6920QF42qa44IDGNS2RwOkKRcWoyi4Fs69ey/6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l9OQ+/Np5chFEKzkkf9owVEKIy1jBhY/SCNIhONzZxq3sLpywfgcl235vLcdkeU7r
	 84nTwWplQ1gVBxYuLbUpbLqJEL1Dyop0VPXFzVOGYV8JLU/atJtmI8Jma/cmfOB8YL
	 B61EphGC5Y5xTCOadDipz2Zm6Rah/RFjGmU39HmYO06UmSCJ0pg/BwGA5877MWou2x
	 f8H9uq9nikzvQfc9ngRSmmSTZZmRL284/xQAzmlSohrNXfkLVbAFfkJ7hyMZ1NRiYV
	 VcSnYyQbwPbicwDE4cj1usl3s7h3Rsi9KU+M6frObJP3bSMt3j6Uyui+gdhQH5QzQC
	 oJXAf76DSZJZg==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 4EFC11AC52F1; Fri, 04 Sep 2026 19:38:28 +0100 (BST)
Date: Fri, 4 Sep 2026 19:38:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: md.alam@oss.qualcomm.com, Johan Alvarado <contact@c127.dev>,
	konradybcio@kernel.org, pengpeng@iscas.ac.cn, j4g8y7@gmail.com,
	quic_varada@quicinc.com, quic_srichara@quicinc.com,
	linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-qpic-snand: publish the ECC context to
 snandc->qspi
Message-ID: <apsQJFvhnI-1V8DE@sirena.co.uk>
References: <20260825013848.1056946-1-contact@c127.dev>
 <178854349408.1467647.16557341714581809344.b4-ty@bootlin.com>
 <apsKiRC-bn7oPS2P@sirena.co.uk>
 <874ig4zx4o.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mXqNAXms/6jab0lX"
Content-Disposition: inline
In-Reply-To: <874ig4zx4o.fsf@bootlin.com>
X-Cookie: My vaseline is RUNNING...


--mXqNAXms/6jab0lX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 04, 2026 at 08:31:35PM +0200, Miquel Raynal wrote:
> On 04/09/2026 at 19:14:33 +01, Mark Brown <broonie@kernel.org> wrote:

> >> [1/1] spi: spi-qpic-snand: publish the ECC context to snandc->qspi
> >>       commit: 93bc7c4d2f4198586a6dbd7797c3bbf1ca845761

> > Oh?

> -ETOOMANYKEYWORDS ._.

> Dropped, my bad :)

Ah, OK!

--mXqNAXms/6jab0lX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqbECMACgkQJNaLcl1U
h9D9lAf+IZaw+kwCDRnV/MFBJfEhRpBMSvA1Py8PNv+9liGULZ1JWolFUk4gjThw
hLGJuDu7Pvt9rsK82ONydDPMVHxi3vGJwrgo21NLF400e93nof+s+C2rbvBZC0H1
RIl4Ja3jG5jd9/s50HfXzqA/qQUiDMyRINZz8I3LKcbWzxzMZt05qDU02LvA1vp/
mE9vo7+AcpGTcuFt88ncnawuXxyQJrKQ+xb9jTUovhkSkOjxjbVdCwf+LhkT+Q4E
pjgsYj3ZgSimphapOn4nApeuZv6eHjHKzocc4L2tGmO+vuzSgUbQYjbEVp8EkkTW
P2PZzsX9KKsbHhBAwkoEEltuTgWdxQ==
=OfTx
-----END PGP SIGNATURE-----

--mXqNAXms/6jab0lX--
