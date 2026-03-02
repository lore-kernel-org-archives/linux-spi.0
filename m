Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D99379EC8
	for <linux-spi@vger.kernel.org>; Mon,  2 Mar 2026 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772440034; cv=none; b=icgbIWn/R0Yc3xqldvHixHN7iX7c8col008wSpx2lnhd7ZrfV5goSzbNQT1Yr/inQf319MWOW3t/IRC/kz47RWoHkS58v9vxOEM5ny9DflfhMu2n9XMSRE+OOao2UZSYjIM9/15U1zVn4+/Uk0L/he1cOQX//atR33E4V5w7BCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772440034; c=relaxed/simple;
	bh=4EDPzMQs9s0xoGOmYO3Hy/ns6tnRn1u1H08EbTb+KFg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZqgTiCHV79jhjLjc2k+m//EkY0K0eBAJtoQ4uTo3aZ4IrLSZKLs4gGwlxtlSetqt7KTKG05sN+DHo2OoofNufwRXrUYEltnly36PWlVMfa2K98kwYoFfZoj8ghqLNOz1IzrWyAqHAK/zt2oaLvbCR7Lgy7Ph7x3XLSB1t2aKjfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WA0uayCj; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WA0uayCj"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C821D1A12C3;
	Mon,  2 Mar 2026 08:27:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9CBC35FE89;
	Mon,  2 Mar 2026 08:27:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A012D103694FE;
	Mon,  2 Mar 2026 09:27:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772440022; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=piYK+ohE4FXRykqJ7bVz4XSAKhvZE7Spq+gUotHbweI=;
	b=WA0uayCjxXlgNNNFzZ4/Mw9MID4Eh7paEnNedaUShTOhNyZ/ZMJv47shjESHlQZqr+dwSd
	YrDtwaAYIxpPY01spYATUiyeK10ezei8/CpVOQxw3fvi29uZJbhRe98O75vaRGcrWftmoZ
	U5WFzY7rfjyDenPlQeoXxTbJytpJI9CBnOqGnxBmQ6LZHV6NpjvjMVy1Rmd0RCYbIj/nX/
	3vhHfPmJo+hRjfMC2pyy248EsEgGrt2a4LbKfW6AUol11eJBvH6l9I0KCxZKFCcGZK8mAi
	XhVZTla/F5LXFFDwgCriXV1Zw8qVXYV5Z7ebEq004vg2vkZreIcIBJN/zvetGQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Conor Dooley <conor@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,  Ron Economos <re@w6rz.net>,
  linux-spi@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-riscv@lists.infradead.org,  wsa+renesas@sang-engineering.com
Subject: Re: spi: Regression with v7.0-rc1 on VisionFive 2
In-Reply-To: <20260228-defuse-extenuate-cf2a90ae66ea@spud> (Conor Dooley's
	message of "Sat, 28 Feb 2026 15:39:01 +0000")
References: <a3ca5e9b-7446-497e-8df2-7ef2b42a02e9@w6rz.net>
	<aaL2WVO_7bl6vNp5@sirena.co.uk>
	<20260228-ragweed-theater-b02967937353@spud>
	<20260228-defuse-extenuate-cf2a90ae66ea@spud>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Mon, 02 Mar 2026 09:27:00 +0100
Message-ID: <87seaiocvf.fsf@bootlin.com>
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

>> > > I'm getting an SPI failure with Linux v7.0-rc1 on the VisionFive 2 R=
ISC-V board.
>> >=20
>> > > Feb 28 00:29:33 visionfive kernel: cadence-qspi 13010000.spi: QSPI i=
s still busy after 500ms timeout.
>> > > Feb 28 00:29:33 visionfive kernel: cadence-qspi 13010000.spi: detect=
ed FIFO depth (1) different from config (256)
>> > > Feb 28 00:29:33 visionfive kernel: cadence-qspi 13010000.spi: QSPI i=
s still busy after 500ms timeout.
>> > > Feb 28 00:29:33 visionfive kernel: cadence-qspi 13010000.spi: QSPI i=
s still busy after 500ms timeout.
>> > > Feb 28 00:29:33 visionfive kernel: spi-nor spi1.0: operation failed =
with -110
>> > > Feb 28 00:29:33 visionfive kernel: spi-nor spi1.0: probe with driver=
 spi-nor failed with error -110
>> >=20
>> > FWIW confirmed on my system:
>> >=20
>> >    https://lava.sirena.org.uk/scheduler/job/2504026#L715
>> >=20
>> > (which I didn't notice as that was just buildroot and not running
>> > kselftest-dt...).
>>=20
>> This probably constitutes random speculation, but I am curious if
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/=
dts/starfive/jh7110.dtsi
>> index 6e56e9d20bb06..390fa87edbaf8 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> @@ -873,9 +873,9 @@ qspi: spi@13010000 {
>>  			      <0x0 0x21000000 0x0 0x400000>;
>>  			interrupts =3D <25>;
>>  			clocks =3D <&syscrg JH7110_SYSCLK_QSPI_REF>,
>> -				 <&syscrg JH7110_SYSCLK_QSPI_AHB>,
>> -				 <&syscrg JH7110_SYSCLK_QSPI_APB>;
>> -			clock-names =3D "ref", "ahb", "apb";
>> +				 <&syscrg JH7110_SYSCLK_QSPI_APB>,
>> +				 <&syscrg JH7110_SYSCLK_QSPI_AHB>;
>> +			clock-names =3D "ref", "apb", "ahb";
>>  			resets =3D <&syscrg JH7110_SYSRST_QSPI_APB>,
>>  				 <&syscrg JH7110_SYSRST_QSPI_AHB>,
>>  				 <&syscrg JH7110_SYSRST_QSPI_REF>;
>> has any impact. Going from jh7110 specific code to bulk apis is an
>> ordering change, right?
>
> According to Ron, it had no impact.

Thanks for the report, and thanks for the try. Let me have a look.

Thanks,
Miqu=C3=A8l
