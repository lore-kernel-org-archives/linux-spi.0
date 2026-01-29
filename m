Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147732FABE1;
	Thu, 29 Jan 2026 19:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769714833; cv=none; b=MXzL1Wvt6mPLbnFPhXLdM5oDZHRSNtmObcBSFj85NKIM1i3qpZ6LADGZLjkE64XZMlFVj2AaQ2a+nnh2C4M8YZpDyVCt2Zs3KW2ES3c/RLJ3EfAwAQhEFGb1b5V3JKD+mMMESpunjSSmyxlKnBS9RddjiDIeDmJsLWhppIIhk3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769714833; c=relaxed/simple;
	bh=P/CpqQ1Va8KQ+bDForuk/5CwJLf99XVBWIRctB7o8tg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EnbzhlQTHfty1THaC5Wa4OTlgJLdrS0zp39zv1ODzLEpT1hBq/7H/UFlLMF7toEBGFnGlYcC5WwadUT6NogOIaYQqPEqGzilIf3vokMK4eWfDmAtPG94ZJ/3fAfQDqnFwPBugppurhNKrLCAdPXpy2dicOnaig590lQWzV0EOk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TFSmtDqU; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TFSmtDqU"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 935D01A2B0F;
	Thu, 29 Jan 2026 19:27:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6416560746;
	Thu, 29 Jan 2026 19:27:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 24A61119A880F;
	Thu, 29 Jan 2026 20:27:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769714828; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Ru8ksjKNHNdXsJAL8P7+zHtIeOmioD7a81kSF85U4bI=;
	b=TFSmtDqUhRvJRkmUhK6FDy4SogHujGGBb70slhbZidAwG8w4I6SZ41Hl87JQAtssxJZq7Y
	NB3Cn6DpAFDYMmf90geQCxR8s0VCxIHTPy3hp06icSc2vqz4kBvldGCFdbJadOeJml3hBH
	dhbZP7iH0DAWxLoKUSt0JmqChZNW2+9vaOVyhL6FCZpoHehKuly/hKWua5cCE5EXT/68nD
	ykFZoW0vVrZNDRKlenFFhcOX7jmzP8bppM7OQU1GsJMe1rXNExuJQgkH2zbKo2HZsoAB56
	kCC53GQZCAHuxc5I6h2UvWnlLP1VGNT7kCOQckEcFoJa11J1r5f6mIFPqHBbxA==
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
Subject: Re: [PATCH v4 14/15] spi: cadence-qspi: Add support for the Renesas
 RZ/N1 controller
In-Reply-To: <CAMuHMdU1QV6Ww--D8kycUmL_sFen_Qf+SXHAZJnF31J0NRtsAA@mail.gmail.com>
	(Geert Uytterhoeven's message of "Thu, 29 Jan 2026 14:44:36 +0100")
References: <20260122-schneider-6-19-rc1-qspi-v4-0-f9c21419a3e6@bootlin.com>
	<20260122-schneider-6-19-rc1-qspi-v4-14-f9c21419a3e6@bootlin.com>
	<CAMuHMdU1QV6Ww--D8kycUmL_sFen_Qf+SXHAZJnF31J0NRtsAA@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 29 Jan 2026 20:27:02 +0100
Message-ID: <87sebojk3d.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 29/01/2026 at 14:44:36 +01, Geert Uytterhoeven <geert@linux-m68k.org> wr=
ote:

> Hi Miqu=C3=A8l,
>
> Thanks for your patch!
>
> On Thu, 22 Jan 2026 at 16:14, Miquel Raynal (Schneider Electric)
> <miquel.raynal@bootlin.com> wrote:
>> Renesas RZ/N1 QSPI controllers embed a modified version of the Cadence
>> IP with the following settings:
>> - a limited bus clock range
>> - no DTR support
>> - no DMA
>> - no useful interrupt flag
>> - only direct accesses (no INDAC mode)
>> - write protection
>>
>> The controller has been tested by running the SPI NOR check list with a
>> custom RZ/N1D400 based board mounted with a Spansion s25fl128s1 quad
>
> "RZN1D-DB"?

I am indeed talking about the RZ/N1D400 here which is the "nice"
official name of the SoC. The board I was using is a custom board, not
the publicly available DB.

>
>> SPI.
>>
>> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin=
.com>
>
>> --- a/drivers/spi/spi-cadence-quadspi.c
>> +++ b/drivers/spi/spi-cadence-quadspi.c
>> @@ -110,6 +110,7 @@ struct cqspi_st {
>>         bool                    apb_ahb_hazard;
>>
>>         bool                    is_jh7110; /* Flag for StarFive JH7110 S=
oC */
>> +       bool                    is_rzn1; /* Flag for Renesas RZN1 SoC */
>
> RZ/N1

Crap :-) I will rebase the two patches Mark couldn't apply and add this
typo fix as a follow-up.

Thanks,
Miqu=C3=A8l
