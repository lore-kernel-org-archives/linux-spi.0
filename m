Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2879E364EA3
	for <linux-spi@vger.kernel.org>; Tue, 31 Mar 2026 13:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774962665; cv=none; b=iSz48RGgG4HbXPTQGQuKUBEEpbC8Aimk4YRiEa88fNzX5TA9HFFZe7Cge4LkWOGEWXdmClnd0eZB/FEDM6ZQO2aAUta0KTsjrdnMmc+xczNi4Q7e1BLgrfcCdHUD3WhQ2zXVLt1pOqwK5KyGvuSFY2iSrBBoWCPqF4SCui2eamQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774962665; c=relaxed/simple;
	bh=fW/Zt99SwF5fsdeJQGxaFYt4doZMwjVpyKU23zZ12Xg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=chNyaln+Ml44f55j2sLlDS3iUMbUMqWp8ql3N55p7ONq//RUwCTQVquCL3Tu7MPC01Z7qEcKs9wofeCS8glIGUjdNAuP+1yjD87SCERu5GsCM+rS0i2Wv1ydR94xa1he8+6OIHhnfWK5j3yOU2avarAYR2LRg6jNVdsgnfPhUhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ouRJ5xJ4; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ouRJ5xJ4"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 970311A30B9
	for <linux-spi@vger.kernel.org>; Tue, 31 Mar 2026 13:11:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6B1786029D;
	Tue, 31 Mar 2026 13:11:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E770810450296;
	Tue, 31 Mar 2026 15:10:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774962660; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ELupFm7LxfI5QZZz6VO1R1UcaZEVYhl8VuglRvEa5+Y=;
	b=ouRJ5xJ4llWREzrvTnuL3rF3Hc0tN0Zfxwk8WPTVLijVROVUGVOSZIl2ekh2R7i6KcAHlx
	R/3yvEgEOXTQ+xAwoT6prY+vW4DQKklJWJCwdT6iXgFCKcUJ3ok6rOZsDFDS3Gn+m0WW3A
	1kNBZ0MtauhB4uXBeYAijjXzSpH7QeoyXzhkZmUuV3ZFh06jGxPCqnBauzX2jXjAAK4xPu
	QL34zEr7/aNpEPqZv3/P5zoBVU/GYq2c6EHT4O3+I+Uc3Rox5JpOrRapsHbOsK/KhBbrd2
	o5zzl2HQbeKcyGLnWEtB9781sBEVHwbCV+si9Nhne+mA/IO30G/fEVrn10amdw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Ron Economos <re@w6rz.net>,  linux-spi@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: cadence-qspi: Fix requesting of APB and AHB clocks
 on JH7110
In-Reply-To: <20260307-spi-cadence-qspi-fix-jh7110-v1-1-c9f37b8c58b1@kernel.org>
	(Mark Brown's message of "Sat, 07 Mar 2026 09:50:35 +0000")
References: <20260307-spi-cadence-qspi-fix-jh7110-v1-1-c9f37b8c58b1@kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 31 Mar 2026 15:10:59 +0200
Message-ID: <878qb89mak.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On 07/03/2026 at 09:50:35 GMT, Mark Brown <broonie@kernel.org> wrote:

> The move of the AHB and APB clocks from a JH7110 specific quirk to the
> main clock init dropped the specification of the clock names to request
> for the AHB and APB clocks, resulting in the clock framework requesting
> a clock with a NULL name three times.  On most platforms where the
> clocks are physically the same or some are always on this makes no
> difference but the reason we had the specific quirk for JH7110 is that
> it does actually have separate, controllable clocks.  Update the new
> code to request the AHB and APB clocks by name to restore the original
> behaviour on JH7110.

I know I'm late, but I wanted to understand what was wrong. Clearly I
misunderstood the clk bulk API. It only works with names, not indexes,
and I didn't got that right when I proposed the switch. The fix from
Mark is correct (thanks). The RZ/N1 platform was also only getting a
single clock instead of two, but the one it was getting is derived from
the other, so in turns both were enabled.

It eventually makes sense. Thanks Mark.

Miqu=C3=A8l

