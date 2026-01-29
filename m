Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855E8312837
	for <linux-spi@vger.kernel.org>; Thu, 29 Jan 2026 19:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769714622; cv=none; b=RzXJsHyCHfQIB3IFMZruUsZz/uscHyoB4ZQdfKev6QwQS7qn+6Q92RGkbmvR4Fy2XyIMwZkiB4+z9DmUeOHSt8LNMsSSTq+51kiTCq0nHKnsIOrmO8TOAKaTfu2kfrApCCAoeYH0q7ixHLdUpM3p4TvsnV9RJwRKU9h8a2iZYuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769714622; c=relaxed/simple;
	bh=3h18MXcv7FLSoQRnlCqA7PGpmOGvq3lOZnMX/1ADDII=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l2OG1aR32ZIwDtS6RxR9iGX7/dYRxqZzf4b6GdeiiXiMXGrHr5aQxV2Jy9XWSfidYqLSwII72ByZPh2LyrA6A3ns214nXwoSDayxkC0y0IgJappjxSrM8unlNrOSvbereJHwLA14sFyqconhE/oQO00iOmzwF7GB9zqYROP9H8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=r90XEPuL; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="r90XEPuL"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id F2A5D1A2B03;
	Thu, 29 Jan 2026 19:23:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B60C460746;
	Thu, 29 Jan 2026 19:23:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 346A4119A880F;
	Thu, 29 Jan 2026 20:23:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769714618; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=V4sMXfQabzM8ew4a1pHZXG0oIC/3oBNgcTNU5oZGmoU=;
	b=r90XEPuLuPgXkQegwgnFNxAjLw8xlg/WgwDlwHS93WDObGkqtZ2KjpDu15VUAgPYchP3g5
	qkVyrs8NhFxT8DZ8yab022HRn1SCXihmGhQymQ7anFCXliFt+j55uzqEdc872dlmfkaqJM
	Pg9ANqP7E8NvXxP/ycRet0bsXMB+F1kORIiwQ2a1a9vSr15uyruNki107kcnGFcrAwhQ+I
	HaFI/ewtCjjeYWbJk8T7qM7kq+yLm4L/WinJL1cLQR0qS4GvEs689DUZmEWEjMXfgm3TIV
	k9uP4ImDWcgi4EwWqAd7K+nUrtrFZIiynBK0qeZB5uNPIJEIKyOtJiDiaynWKA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush
 Yadav <pratyush@kernel.org>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Steam Lin <STLin2@winbond.com>,  Santhosh
 Kumar K <s-k6@ti.com>,  linux-spi@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 00/27] mtd: spinand: Octal DTR support
In-Reply-To: <61a547d0-592c-4cf5-ae4f-54456b08e83d@sirena.org.uk> (Mark
	Brown's message of "Wed, 14 Jan 2026 11:25:32 +0000")
References: <20260109-winbond-v6-17-rc1-oddr-v2-0-1fff6a2ddb80@bootlin.com>
	<61a547d0-592c-4cf5-ae4f-54456b08e83d@sirena.org.uk>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 29 Jan 2026 20:23:32 +0100
Message-ID: <87y0lgjk97.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello all,

> The following changes since commit 0f61b1860cc3f52aef9036d7235ed1f0176321=
93:
>
>   Linux 6.19-rc5 (2026-01-11 17:03:14 -1000)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/sp=
i-octal-dtr
>
> for you to fetch changes up to 8618271887ca10ac5108fe7e1d82ba8f1b152cf9:
>
>   spi: spi-mem: Limit octal DTR constraints to octal DTR situations
>   (2026-01-12 12:40:30 +0000)

Pulled in nand/next!

I then applied the rest of the series on top of it.

Thanks,
Miqu=C3=A8l
