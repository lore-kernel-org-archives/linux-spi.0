Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29053839BD
	for <linux-spi@vger.kernel.org>; Fri, 26 Jun 2026 16:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782492184; cv=none; b=SVj6xMoQ+pRrEuXxCfasz34/0u5cb+fFVRO7qmKLgqt3V0VZrOVPdEoac5J0BWr4H/916zzq6WVGWmoABwCWRaytRRe08484H2tSRYIQN38p5XBlQ7wdHH9xF8ryByKImU5ktNmdoHbiZjZnKi8zbWsUbYq2PlAlIwxyO8V+A28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782492184; c=relaxed/simple;
	bh=HZIutF/qbFch05C/zlWBWbGIy5yPyo1kQgpTuztNWmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cm+BakBSiRAYSwdEaHpRJwAFBXFEANfr6HEtSabss7IQp1eElbNMp7UikQM8mDYAktPh6ny90+ExzdkcHNg5ncIstRoQu+TgMm14NMAKFYWcGA5WD1atrkgySQB4uRgzWQDQ2RFI0I7xWJB+v9Neoo1WeYC+lAcOPZd3hsdsycw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=eGu+h1Rp; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="eGu+h1Rp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=HZIu
	tF/qbFch05C/zlWBWbGIy5yPyo1kQgpTuztNWmo=; b=eGu+h1RpM5TsOADt4hy1
	Cd8NfEM061DOXhUn4NJhW0obMeHecu/Erxtdkd/oqoyH0fwOQ9VUd5OXhVP1nclI
	lxYRE0TpcGhJTvb4Rgrw1ezOjK2fuvVZNZP67m0Pbu8PvomvuqsMecuiTI1ih/06
	YWNpd3BMwTg8oggwxj+dN5A6hOMOfIZFkPD0iAGWCla6VL9hzqIFnPXoN8bwcf09
	BMOvLV5RenMWuoyRbo/tcUEafEcieOH8aBU/4/JJSbIn01Vv1fXGEDrsKUDzJTg+
	0wVw9ptCsUB0amTOdE2At4ca9FhHujyiHyClYqZRlgqaqKQ0RNgPFPEVMIxJGHV8
	BA==
Received: (qmail 3631532 invoked from network); 26 Jun 2026 18:42:56 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 26 Jun 2026 18:42:56 +0200
X-UD-Smtp-Session: l3s3148p1@DtT+zCpVPKsujnsl
Date: Fri, 26 Jun 2026 18:42:56 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: rzv2h-rspi: Fix DMA transfer error handling for
 signal interruption
Message-ID: <aj6sEE5y62SOVsRb@ninjato>
References: <20260627-rspi-v1-1-170c93ee14da@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="S6TrlP0SK4iUxrQS"
Content-Disposition: inline
In-Reply-To: <20260627-rspi-v1-1-170c93ee14da@gmail.com>


--S6TrlP0SK4iUxrQS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 27, 2026 at 12:02:29AM +0800, Felix Gu wrote:
> wait_event_interruptible_timeout() can return a negative error code when
> interrupted by a signal. The original code treated all non-zero return
> values as success, which would incorrectly synchronize DMA channels and
> return 0 instead of propagating the interruption error.
>=20
> Fixes: fa08b566860b ("spi: rzv2h-rspi: add support for DMA mode")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>

Patch looks correct. But it makes me wonder if interrupting the transfer
has actually been tested? Cosmin, can you recall such tests? From my I2C
experience, I know it can be hard to get the state maching back to a
consistent state. Sometimes, it was preferred to simply use
wait_event_timeout() instead and drop interruptible support.


--S6TrlP0SK4iUxrQS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmo+rAwACgkQFA3kzBSg
KbY64g/9E9u3AY4oLsAt3b5d20q7KJBghFUSTZFyS5kzp/KTE3ayS+ogmnkapgOa
gvAmy1twoo4AviO62TxmlZ2XUkfDdGrJOyPjrQYRrbuAoyRF+hPQ8Ck5N5yezyly
uPIh0YUOfRP2i4uzs/z+gqNP1O6/wrKZ073fPrdICyufuG29CZNlc+PhHeiHR5+m
xW3B0Yyf51duoO8twv9uBm4Ld8dvtFb7ZkBeu/8qkcmCouGtHfxQdg1rOg5OWPBC
h4R04qbrg1tYbQCXI+QBgARZ0KRct7RCZa0xBfOnJHWRQoo68x/Yx12vD3YdvhWQ
vLYxzBYrfjPo29D8VvPhV9KGluSjMqjKpZAApTixql2nuADWQLuueZHyGLh6Krpf
lXSa3Y0cpD5DJUdQP4LuAMgWn816r3ymSTr5eaaV4fPfrMN2pXDLRjBGNhJCapbc
o79wIDhuLudgUQKXO+NF1nD9NsaR+Qf7+NCc+kEgnfVj6WvcbEL7rRNtXXghWpEu
E+H8fwJujev3bpF0pAPRvScr8qq+8CyHJsmHh7EcxKkFy2bdvIfftlhCZY/t6oBV
FfFYRTmrl2NJO7KcvB/jj4zbZi8XpOzVMtgkn2Tjr+Fj2m73l+PC+DV/pvnpVsEL
NChdHLw7WrMYeSuY/NvmyUDThxR3O41uKLGUu2pNkhHfqvK33Cw=
=roNK
-----END PGP SIGNATURE-----

--S6TrlP0SK4iUxrQS--
