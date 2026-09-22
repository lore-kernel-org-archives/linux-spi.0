Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B1C53A394
	for <linux-spi@vger.kernel.org>; Tue, 22 Sep 2026 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790076446; cv=none; b=XVjitw9Eqem67Re4RHM9zB8BZ0XgM9djQzJvteX/c/ajMqtRf4Ym0kcQImHQ+xGqHgAzr+OkEX+gqyRyX+3E9kIuCgkao2WqShq2we7/4eYGuPlEqbrRT8xxStbXCwnr9Vn9eyfxya5fKgiwkSSmMcgp+nFPfHDmqY1Q6lQd4Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790076446; c=relaxed/simple;
	bh=TGqFeXqvkqxWEiMbhmFjpiBSMEdTTRrR5iHT5pp5FVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gksK6SEekJ0rx2Hn0UBgAwzc8NYb+ysvXkCJ2jbReZeuRyt/t8E862b9xbzYfc6DbN92L/0RdUGeIz5MdwwU8iZDATdPvNDW5cer0HIGlMuBA0YQnN+u31/t7rdkcu5r+rK1cKJzHNR3u07hLpTNZEg/Vl4H4+tbmeQ2yA5GdqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Zx6opBbg; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Zx6opBbg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=TGqF
	eXqvkqxWEiMbhmFjpiBSMEdTTRrR5iHT5pp5FVk=; b=Zx6opBbgBcv0GwHcx6db
	BobxQyPVD0dl5jeWZV04LlYXVFb+aU0P0vW6yJkIVr2Jc7oebHddsnDWka3a52Up
	lDq+Dy9Rq8yV96He2mtHnJ4wPYiLdpm/3Skij+f+1tb92tHyH7Dxcmp5RxPc5+5N
	G+tt5k1RbMXVeOWRm6tjRDb3yJWlpEggehRDubMfF9fwzNZnvTXVfraa8JRuD6QB
	m//po2R0wr++JjUcObElLZ6q7MP/iwVoj4j9JsSkzxdMYXf0lX1C1MR1rIxKiVOB
	xzj53bdYq/k2ZAIBmKpIf0r50JApVU7xExRg8Tx3FX1vjKetPYJRpkEBZiCsvP4K
	aA==
Received: (qmail 230940 invoked from network); 22 Sep 2026 13:27:20 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Sep 2026 13:27:20 +0200
X-UD-Smtp-Session: l3s3148p1@h4JZphBcYsVQT+F6
Date: Tue, 22 Sep 2026 13:27:20 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/2] spi: sh-msiof: Add support for R-Car Gen5
Message-ID: <arJmGAIUiaryuBUA@shikoro>
References: <cover.1790065451.git.geert+renesas@glider.be>
 <a254e27481716a07a49b10db31523fcaa3114afb.1790065451.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zRtuqjMCgk7Z+Mfi"
Content-Disposition: inline
In-Reply-To: <a254e27481716a07a49b10db31523fcaa3114afb.1790065451.git.geert+renesas@glider.be>

--zRtuqjMCgk7Z+Mfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 10:27:01AM +0200, Geert Uytterhoeven wrote:
> The Clock-Synchronized Serial Interfaces with FIFO (MSIOF) on R-Car Gen5
> have FIFOs with 256 entries, just like on R-Car Gen4.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--zRtuqjMCgk7Z+Mfi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqyZhgACgkQFA3kzBSg
KbbUGg/9F/rSanR6sSXhtEs/A7XUCzgn+nBheLLaSyT8I33T8E26naPtmi0IcKRA
Frr9aN/LZ5LeDx2q2707TEuk4W5ZsQEQjzGY4XpZorYrQKx9KGIE0M1pydZXARMN
bzWkhS8Lv0ZfqAEhpWBzLaXPyD8gfGOm1CbGgrU6hTilE+LnlvcieLnyU/hutXfG
ZG8jiIc27FffaP6hEaYvHzujCk2FQX7y00bqRPbqYaiY2A+dI/CWa0dD6IKFLFlh
/si4zN/VQT9TJx/rJsEW+/WAyUfHOdGka5tZ6yu/jBRE1/pI6Pk5XfleUBMXGO+U
Xrddb1NjPGhMPYMCcRrf2IF3re/D/0qJIXDRl9tWtpTMCqnzASzKA9UZQbhQbC+2
zzNkxRj8QWlA62hYPlfv2AjYrFRPA5jgLO+5UAvDPIAxVIERryCDc9DOE4prvJiZ
4ligQw2QrcEFCQ3IxBOgabzV5Z1dTjRM7QvxlbV8+X+s+Z9/0PAH9p7rQKc3ZD/K
PHNmAxFNJDDbfishW1h2/2ChUECpYLQALF0If2rma2gJOYG1iPgUNrwwDD6tuuYH
0CclU1N1NKTLWgoFqHvOPzn7D7PBo/Zn/W8LSzD/QgN5KQYGYzcjSs1zJqLO1N/e
HfG3IrguAPGXtkxJ2YISGrg6EV0O0jw8F9USFydwOGclNvWOWV4=
=71Ql
-----END PGP SIGNATURE-----

--zRtuqjMCgk7Z+Mfi--
