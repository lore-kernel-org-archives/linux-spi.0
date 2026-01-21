Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73869387578;
	Wed, 21 Jan 2026 10:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768991957; cv=none; b=gTIwdL4hpJSSknwqu+rZXp6651j5HW0LhWPoSD3cpOuh5auW8pHahsA2MZ0N7SQSUfZsTONoWFre9zd5yTTf38zXUEu/uJIb3RYPOoemkPZksovTraFrAfc7X7mtZ32iBO+7v+sWc6Lq/8hxwQSpK6fEpkEOKuE5uXZ15zhNwRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768991957; c=relaxed/simple;
	bh=B1iFdTnWdguGhyY0doGStm07ZJThdPbc6qy3UF/3NPM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X2AvRd+0YUlrfDbMlUUPD5xT+KzxWVOaxbhUk9nPKnSncBxQL1gRLBA42zvafL7JXsStsyqLxXrwXZAKAyNer9CTiYoZGx7TO6gnMYYrxnMWpF1szvF5FEkPIQE6xTwDCsu6iA9eFwKGQXes6/Qp3hBuHpiF8nP3vJWeNd2Wv4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XStGGwYv; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XStGGwYv"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B87481A2993;
	Wed, 21 Jan 2026 10:39:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 87EB16070A;
	Wed, 21 Jan 2026 10:39:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CC935119B118F;
	Wed, 21 Jan 2026 11:39:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768991952; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9C2gF0qyhM8eqSeDpbcnEFwXTWl9i/IdHkoxWX/E6MU=;
	b=XStGGwYvqLbj+oEWCAhnIceDPZDBnhInkkRrEei5Vs6wNH+zoFm8gMKqPBLdm54b1Ybml/
	kOIh85QIQfjwq1h0zSdnpNmIkq8WJ6girq7brMRs0nUlzl2PzNYWnifimrhz82DiN03w7B
	0/QRnF5bbcFB6srKUf20e/M95HMK5ZTPCV6+mMwHSowNh/ftw5f4opI1i+DRu5yizL5YLy
	Ql/9Aj06b1HppB4juBBSJV4bVvHgmH1M/dMvref3bE7Z39p57w5WuBs+5KXCdEL5zRXUbc
	I0oHPWim/qh2lP9QDt77nbAlRv2QVF81X7mQl/2Fx4k8DxbBplyJeNYbNWXEjQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,  Mark Brown
 <broonie@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>,  Geert Uytterhoeven
 <geert+renesas@glider.be>,  Magnus Damm <magnus.damm@gmail.com>,  Vaishnav
 Achath <vaishnav.a@ti.com>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  =?utf-8?Q?Herv=C3=A9?= Codina
 <herve.codina@bootlin.com>,
  Wolfram Sang <wsa+renesas@sang-engineering.com>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Santhosh Kumar K <s-k6@ti.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Pascal Eberhard <pascal.eberhard@se.com>,
  linux-spi@vger.kernel.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 01/13] spi: dt-bindings: cdns,qspi-nor: Add Renesas
 RZ/N1D400 to the list
In-Reply-To: <20260121024002.GA1845406-robh@kernel.org> (Rob Herring's message
	of "Tue, 20 Jan 2026 20:40:02 -0600")
References: <20260115-schneider-6-19-rc1-qspi-v2-0-7e6a06e1e17b@bootlin.com>
	<20260115-schneider-6-19-rc1-qspi-v2-1-7e6a06e1e17b@bootlin.com>
	<CAMuHMdW5hwNu-07-7xvyWdcGKUZy+pCX0=W=JNgd4h7m72wQFg@mail.gmail.com>
	<87qzrpucae.fsf@bootlin.com>
	<20260121024002.GA1845406-robh@kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 21 Jan 2026 11:39:08 +0100
Message-ID: <87ms27qmgj.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3


>> >> +      - items:
>> >> +          - const: renesas,r9a06g032-qspi
>> >> +          - const: renesas,rzn1-qspi
>> >> +          - const: cdns,qspi-nor
>> >
>> > Doesn't the need for (at least) the CQSPI_NO_INDIRECT_MODE flag mean
>> > that this device is not compatible with cdns,qspi-nor, and thus the
>> > cdns,qspi-nor fallback must not be used?
>>=20
>> I understand the question. It is true that I use driver data to limit
>> the number of features the IP can use and this data is associated to the
>> Renesas compatible, but I believe all other flavours of this IP would
>> also not work without driver data attached to their front
>> compatible. None of the SoCs with the Cadence QSPI IP actually would run
>> without their own driver data. For me the fallback compatible is
>> relevant because it describes the hardware as "this is a derivative of
>> the Cadence controller" (and it is clearly the case, and this is also
>> mentioned in the reference manual), even though I agree using
>> cdns,qspi-nor would definitely not work alone. But again, none of the
>> other flavours would anyway.
>
> Fallbacks should be usable on their own. We've generally moved away from=
=20
> having these generic licensed IP compatibles because they always have=20
> per platform changes.

Thanks for settling my doubts. I will drop the cdns,qspi-nor then.

Miqu=C3=A8l
