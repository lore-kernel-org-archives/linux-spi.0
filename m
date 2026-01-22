Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594D330B515;
	Thu, 22 Jan 2026 13:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769087546; cv=none; b=hMMzE3o46Wu7g0KWH/iDfHA1/l0wDrPZbz5WHh57BgjKl+WpZJ8/7UDpRf6Dk8iqspmBNrxdH2GUFJTgLoCjG51klI+nSH1TLnh+jxFsO104D/72EsnrgQ6LF+R7rh7iGoLcvIJcvIJ2RjjcWVx7isLjZ1KskP9a8n3dxKkzhpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769087546; c=relaxed/simple;
	bh=EdpkpvHVkaLeg84VxprWWsRo+EhUK8ucYp2TIZriiyg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QcbbRfPblj6Lte+KWkuGSwIiVkCsiW/TmDJIQB41U97PVBq3KR26UwDWIqOw0OrNOwcGbrAPqHoQD/hNl+74qJuotP4Gdl+UoiKhuF0HCv0N4+rlKAO3wYKNX01M5kslNwt4LWB2m/9y3EsUSV65CZ/zSB0VS9U7UWOGddMrDcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jzu3WJ/P; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jzu3WJ/P"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7BFF71A2A34;
	Thu, 22 Jan 2026 13:12:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 47C9F606B6;
	Thu, 22 Jan 2026 13:12:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F3E83119B81D0;
	Thu, 22 Jan 2026 14:12:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769087540; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nTfR2sk64gsYNzdklWZH7EIFWs/cDqLkfvUS4wt59Uw=;
	b=jzu3WJ/P60Hn9aGf7N5TOqqR39tvowFDrWaH7BmeWPCQrEQb/YNWNVAwQR8kK5eltAvTOL
	MDoGcNJ73LDTVVpHsKBIp77RjRLS2cfMlNZoZVmgXla6IWt+Mo3bbuo1gQSZRwshW6Pu16
	egO4mU3upMsnc/fsumI8QLzmi8m8j0TKi2Qiou16JEKOQFf37PtVo1ae9AUZ9KBJySziuZ
	O5IzPeh/PvwMJNN55++NATBbApS4v59Y/EsIFbrDoEunptGep7sMsP9xumtW1NyeNLTkd1
	gevGv+r3yE+4Lp+PQcXDIZZDETTYV7NLeXb+yUolDUJXzcMaJPvchSJRB0/wmQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mark Brown <broonie@kernel.org>,  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>,  Geert Uytterhoeven <geert+renesas@glider.be>,
  Magnus Damm <magnus.damm@gmail.com>,  Vaishnav Achath
 <vaishnav.a@ti.com>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  =?utf-8?Q?Herv=C3=A9?= Codina <herve.codina@bootlin.com>,  Wolfram Sang
 <wsa+renesas@sang-engineering.com>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Santhosh Kumar K <s-k6@ti.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Pascal Eberhard <pascal.eberhard@se.com>,
  linux-spi@vger.kernel.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 17/17] ARM: dts: r9a06g032: Describe the QSPI controller
In-Reply-To: <CAMuHMdW=Ynyf=7r0GBv8g+-xi_3=fojnsmOC5AGWxrhcuTM2rg@mail.gmail.com>
	(Geert Uytterhoeven's message of "Thu, 22 Jan 2026 11:59:17 +0100")
References: <20260121-schneider-6-19-rc1-qspi-v3-0-43e70fab4444@bootlin.com>
	<20260121-schneider-6-19-rc1-qspi-v3-17-43e70fab4444@bootlin.com>
	<CAMuHMdW=Ynyf=7r0GBv8g+-xi_3=fojnsmOC5AGWxrhcuTM2rg@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 22 Jan 2026 14:12:16 +0100
Message-ID: <87o6mlpz9r.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Geert,

>>
>> +               qspi0: spi@40005000 {
>> +                       compatible =3D "renesas,r9a06g032-qspi", "renesa=
s,rzn1-qspi";
>> +                       reg =3D <0x40005000 0x1000>, <0x10000000 0x10000=
000>;
>> +                       interrupts =3D <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
>> +                       clocks =3D <&sysctrl R9A06G032_CLK_QSPI0>, <&sys=
ctrl R9A06G032_HCLK_QSPI0>,
>> +                                <&sysctrl R9A06G032_HCLK_QSPI0>;
>> +                       clock-names =3D "ref", "ahb", "apb";
>> +                       #address-cells =3D <1>;
>> +                       #size-cells =3D <0>;
>> +                       cdns,fifo-width =3D <4>;
>> +                       cdns,fifo-depth =3D <4>;
>
> These two should be dropped, as per the updates to v3 of 04/17.

Gniiiiiii -_-

I did it in the yaml example and forgot to replicate it here.

Miqu=C3=A8l
