Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4478330AD00
	for <linux-spi@vger.kernel.org>; Mon, 27 Apr 2026 13:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777295421; cv=none; b=hkl6cyNivHBD8mv67B9/5ZeWAf/704lT4/CmGBfdh0DeU9abeALnUzCMJBwKo/F2EZkl/gnYupjkxeJGzdl3ivDt02rz4b5o8wW2MAh3xQ0Y7R6TQLNIdz0q4oX0M3Rt2fNLLVeag9yYzcJNWQ/nUl01OiL5VVPxeOZZ/Vzv03g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777295421; c=relaxed/simple;
	bh=PiSS/yFr6lyqA6jPYdI47iScsnxeDllRORE2euFTiCc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rgySy/rysHkGpRAnPaAbztrKyPtC/V7jBLrjaWft+AR4I4lRrCQ01pJ4dKfcKIF9Nb1XhG3lni2unhEc/uRiWopk0co/uRaH9oz8CdHiV9b+WtaXg8oVSqeRZmxS/UKAMgsUvHyuy18QKZP3L7V/64ykjiJMrbeRH7TlyXpwkQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RdPOVtow; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RdPOVtow"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D60E31A3442;
	Mon, 27 Apr 2026 13:10:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AC662600D1;
	Mon, 27 Apr 2026 13:10:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 73730107281F5;
	Mon, 27 Apr 2026 15:10:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777295418; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=KbSewh1KEQe103QabR+kkgAxSdXaSeUSFmLvF7jxFgk=;
	b=RdPOVtoweKEtUdvuut6ZZ/jSBiSnmJkAqhzbnauw2KYTInyw8M0jYWKTFLdiC7bzSW+MQx
	WgHxFlrG3gElWWp8GciAvRGo/B3L7GAriv01tGI4pCJm5BSWheczOWooUMtDBisyW2KWzm
	160aB7jNcGch9FOtKoNinmEvKRZdFEsdha2fHap46wtHRGIgJ4Kf872xK3J8IaoOVdKmcl
	a8ilxSTaA6F+guFKYRdsp87fpUu7Csa9JKX+hdrbR4MJpysM1AMFaYOWqC8LWnbtwCLH6U
	pJeoGwW4BqdD6h+zfNuTmlubWOe/qlk9pXN5AcBgIyU2J4NfvSwleyXQsQqqEA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Pratyush Yadav <pratyush@kernel.org>,  Steam Lin
 <STLin2@winbond.com>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  linux-spi@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org
Subject: Re: (subset) [PATCH 0/5] mtd/spi: Fix Winbond W35N02JW / W35N04JW
 support
In-Reply-To: <177590483913.1311359.6081286854444459409.b4-ty@b4> (Mark Brown's
	message of "Sat, 11 Apr 2026 11:53:59 +0100")
References: <20260410-winbond-6-19-rc1-oddr-v1-0-2ac4827a3868@bootlin.com>
	<177590483913.1311359.6081286854444459409.b4-ty@b4>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Mon, 27 Apr 2026 15:10:17 +0200
Message-ID: <87se8gh7ly.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3


>> Winbond chips W35N02JW and W35N04JW differ slightly from W35N01JW. As
>> they have more blocks, they require a couple more bits to fully address
>> the whole device. These address bits have been stuffed at the end of the
>> command cycles, which is non standard, and this is something I didn't
>> catch in the first place.
>>=20
>> [...]
>
> Applied to
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1
>
> Thanks!
>
> [1/5] spi: cadence-qspi: Revert the filtering of certain opcodes in ODTR
>       https://git.kernel.org/broonie/spi/c/5e75c1d4d386
> [2/5] spi: spi-mem: Add a packed command operation
>       https://git.kernel.org/broonie/spi/c/f79ee9e4b232

The 3 other patches have been queued for the next mtd/fixes PR.

Thanks a lot Mark for the responsiveness.

Bes regards,
Miqu=C3=A8l
