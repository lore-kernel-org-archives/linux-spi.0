Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846662609FD
	for <linux-spi@vger.kernel.org>; Fri, 13 Feb 2026 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770973298; cv=none; b=tjhQIryoEczO2Bfk2KqC8garpoA7XUattf8CLFcNy0DwIb9u/0k+2zYgTZOSrXM0J47lVi1N/pReBYXLbZtVFXW9JtCwdhzq0zV19RzNTeZvv4+3rKuE5Acrq0db1YsA4LfraWKSUJtLnKy0pFe0qi5MaNRBZLIWwf0voKc6BvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770973298; c=relaxed/simple;
	bh=jNO73u+i65xkf0YweV1puplp8BRnzGz5roCr1o00jwY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EdU3M5Dn9y4kP4OtFz9Yx9+IjbBjxseXCFwuWxGxtFUPPBszki8q9gw7hfUoslu3f+sBHd+VlyHXL/FbW7+MoAoMhAEkbzFbmkoZXxd9zIIVqrw16pY55LOlVEQ0bFsUGi2ifuP9IEncypkzEkk5r0eytkLKqCXYnHklPaqBjLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ajnFwvyb; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ajnFwvyb"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id F1B794E40D27;
	Fri, 13 Feb 2026 09:01:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C2E35606CC;
	Fri, 13 Feb 2026 09:01:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8D05910368D90;
	Fri, 13 Feb 2026 10:01:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770973292; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rp1eDOIRhaqWCkYz+NWbK33lJyO3gCS1N2c/2rJWg/E=;
	b=ajnFwvybN/0XFrBUedxR74LHa2roePtEFDzO102eE0A34vTv8r/teN6VmAyqa5UaQ3PAS5
	nCSZFLxbHzsN0+Gwxsk0vV/Fc7Gp3KOXPPhgR8ATlUbvlAkNk1BRb9AFPJHWbKennAVtes
	zWj8QxYJpIFfqHx5V6o8iIA62QSD5hwxd8lacmpYG2mNdSFsf5m+bhEUXxzM205MJYcIQ2
	4Ac7speu6a2fbuuV1FGAoHu7eNwrOYxfnMXTCrKA9B6ng3mv46LV7UmvhFkMzbz4GyiELR
	hOn/psaAkqctQA8IQUKxZTjiRERWxnwFnwZh9sKNQ0ft1qzBvDK/fVTVembZKA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <broonie@kernel.org>,  <robh@kernel.org>,  <krzk+dt@kernel.org>,
  <conor+dt@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <tudor.ambarus@linaro.org>,  <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <linux-spi@vger.kernel.org>,  <devicetree@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-mtd@lists.infradead.org>,
  <praneeth@ti.com>,  <u-kumar1@ti.com>,  <p-mantena@ti.com>,
  <a-dutta@ti.com>
Subject: Re: [RFC PATCH v2 00/12] spi: cadence-quadspi: add PHY tuning support
In-Reply-To: <775d8dce-b567-4f21-963c-a843e409fea5@ti.com> (Santhosh Kumar
	K.'s message of "Sat, 7 Feb 2026 00:58:03 +0530")
References: <20260113141617.1905039-1-s-k6@ti.com>
	<87343ghkek.fsf@bootlin.com> <87v7gbdwdh.fsf@bootlin.com>
	<775d8dce-b567-4f21-963c-a843e409fea5@ti.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Fri, 13 Feb 2026 10:01:28 +0100
Message-ID: <87y0kxvwyf.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 07/02/2026 at 00:58:03 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:

> On 05/02/26 21:18, Miquel Raynal wrote:
>> Hi Santhosh,
>>=20
>>> I am surprised by these numbers, I would expect these to get higher for
>>> SPI NANDs. I will test the series and report my observations, especially
>>> since there is also ODDR SPI NAND support now (in nand/next, should be
>>> part of my upcoming merge request to Linus for 6.19+1);
>> I just tested the series, here are some numbers I grabbed on TI AM62A7
>> LP SK with a Winbond W35N02 SPI NAND chip (so in the end very close to
>> your report):
>>   +-----------------+-----------+------------+
>>   | SPI NAND        | no tuning | PHY tuning |
>>   | Unit: MiB/s     |   25MHz   |   166MHz   |
>>   |-----------------+-----------+------------|
>>   | Octal SDR read  |   13.8    |    34.2    |
>>   |           write |    7.2    |    10.2    |
>>   |-----------------+-----------+------------|
>>   | Octal DTR read  |   21.2    |     N/A    |
>>   |           write |    9.0    |     N/A    |
>>   +-----------------+-----------+------------+
>> Please mind I used MiB/s and not MB/s (so kiB / 1024), I don't know
>> which one you used for measuring, as you marked MB, whereas the most
>> common unit seems to be MiB.
>> However PHY tuning failed in Octal DTR mode (your series applied on
>> top
>> of nand/next) with the following logs, can you have a look?
>> [    2.261647] spi-nand spi0.0: Winbond SPI NAND was found.
>> [    2.266956] spi-nand spi0.0: 128 MiB, block size: 256 KiB, page size:=
 4096, OOB size: 128
>> [    2.285257] cadence-qspi fc40000.spi: PHY tuning failed: -2
>> [    2.290835] spi-nand spi0.0: Failed to execute PHY tuning: -2
>
> Unfortunately, due to a known erratum in the Cadence controller, PHY DDR
> mode cannot be used with 2-byte addressing.
>
> Refer:
> Errata i2383: OSPI: 2-byte address is not supported in PHY DDR mode [1]
>
> As a result, the Cadence controller supports only the following
> operating modes:
>  - PHY DDR mode with 4-byte addressing
>  - PHY SDR mode
>  - TAP (non-PHY) DDR mode
>  - TAP (non-PHY) SDR mode

I do not think we have 4-byte addressing capabilities on SPI NAND chips,
esp. Winbond's chips. So there is a down side: the core will pick-up
Octal DTR modes rather than Octal SDR (with PHY) mode, which is not the
fastest mode. Maybe we can guess that once we have access to the max
(tuned PHY) spi frequency, with an extra flag in the driver indicating
that the PHY speed is not accessible in DTR mode. But this again
requires different handling between SPI NAND and SPI NOR, as SPI NOR
IIRC may have 4-byte addressing capabilities.

Thanks,
Miqu=C3=A8l
