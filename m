Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564576;
	b=xDwQr780Ho3FNtZDoyb/bBqiO7iQ+CiRsnUBlmxQ4ApnssKD+t8VbmbJTuG3eZDwafJc
	 9PX+4/KIBvcJcFBsbQPL8sUT68TnvjXE1X1PeZcV8vy5Ov5G0vhi5J9H+gTcV3ZCqCsbO
	 Ux5Kpayr30umAGZ9EKLTf5v/OM/AGVRf+4l6TcFh2lZPTM850XstnBsbzH9h/IcuM+hzR
	 VAJpMvxhkcs5TftIsQ2M+hKDUkxzFEFht9+HBsPBbUuNdrQc4G1pGdlQ07EJoY+JKpUrG
	 51ekcaMTF0INe9mO37GZZJ62QrfaSRfvlzWL7gxvCWcX3q2e0mCjtQYypg39aicTkEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564576;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-ID:From:To:
	 Subject:CC:X-Mailer:References:In-Reply-To;
	bh=j62tYvTCL3OY1v0AvDAlDk7Ai4ZdN74KnfRG5/OoDtU=;
	b=HsoX+lreOu1fmKbQVOb9oXO/Xaui5c1xIjMJCR0HbTtD/BQs5GT8RH38CHm1bgRoIPd9
	 UWcs68Fs+jpuwWUbN8VQLzmWMOyG/6kx665E/P0gQfEmexVbuhgJCXcFAf/9i1/MB9AZ2
	 UKpOrCE6tqTe1JwcCIO6SkwfnWFE1GRLOGo6wlMd/G4QOPUcgMU93Rq/prTpEZC2uP7YZ
	 raoZBXwt2TH1kIgEE65QlYU3CS8NOYbnELPY62Ikj8FkRPZLbcwF/ySg0xTtfZp4/WeO+
	 9XOBEBwJrCVPL4U+VQLtgoUYYv74cG+FBLbKw8r+NaZ3jHyO6zX+kUF16ib61235/rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=aQLGaDeM;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D820606A32E;
	Fri, 13 Nov 2026 10:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D820606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=aQLGaDeM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794564583; x=1826100583;
  h=mime-version:content-transfer-encoding:date:message-id:
   from:to:subject:cc:references:in-reply-to;
  bh=aGiLs5yg7FQ0TEEB1cEWlhJ5ZGG2wgnap42vcQfu90M=;
  b=aQLGaDeMktSs0tIPyIMkRL8GoR5ANreACWsgawPZSWRfxZBuZvEWwPJH
   VSFeztG1VcGIg3bNCV1vwM4gQ+p8AYIpayk+r8qgGDoYFyh06B8N5E0y3
   APq01tIAPTLreTLISzHZiGap1W4NuPJvDuu8zoIxAngdIu+KDLFpBhIrO
   Wg9H2IDoI1i78c0ZetByIhNiSVUIjdPd4tw+rS5UK/Pqb3w1qC1Olk+Hx
   3Vnly3OAyIl6BIFeNZyg9GeZ4AiYUcBpMM9HakBuaF1dN3k0eM7wD3DFk
   qCEwqqImneEAH4g28qj3+wniM+mD/0/felj+chCJk3P/XjiqKUulG48XF
   w==;
X-CSE-ConnectionGUID: G4RDakIhRGiom2dj40ZyqA==
X-CSE-MsgGUID: KzZ/FC9rTfuDMaz5LyYbrg==
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="66700852"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 03:09:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 13 Nov 2026 03:09:34 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Fri, 13 Nov 2026 03:09:34 -0700
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 13 Nov 2026 11:09:32 +0100
Message-ID: <DMU01RHMAO2W.R0WIEEHWHKZ5@microchip.com>
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
To: Mark Brown <broonie@kernel.org>,
	=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Subject: Re: [PATCH] spi: atmel: poll short PIO transfers
CC: Ryan Wanner <ryan.wanner@microchip.com>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20261112-spi-atmel-poll-short-pio-transfers-v1-1-240ccc868cc3@microchip.com> <179451432977.339049.8591158302502636785.b4-review@b4>
In-Reply-To: <179451432977.339049.8591158302502636785.b4-review@b4>

On Thu Nov 12, 2026 at 9:12 PM CET, Mark Brown wrote:
>> Every PIO transfer enables the controller interrupt and sleeps in
>> wait_for_completion_timeout() until the interrupt handler has drained th=
e
>> receive data. For a transfer of a few bytes, the interrupt, the
>> completion and the two context switches take several times longer than
>> the transfer on the wire. Devices that do their register IO over SPI,
>> such as SPI attached Ethernet switches, issue one message of a few short
>> transfers per register access, so this overhead dominates their register
>> access time.
>
>> Busy-wait on the status register instead of enabling the interrupt when
>> the transfer is estimated to take less than polling_limit_us, 30 us by
>> default, as spi-imx does. The estimate uses the effective clock rate and
>
> How big is the FIFO?
>

It depends on the SoC. The SPI in lan966x, lan969x and sama7 has a 32
data FIFO, sam9x60 and sam9x7 have 16, and sama5d2 has 16 or 32 depending
on the instance. The older parts (sam9x5, sama5d3, sama5d4 and earlier)
have none and take one interrupt per word.

>> the word delay. Setting the module parameter to 0 disables polling.
>
> If this is dubious enough to require the module parameter we shouldn't
> be doing this.  Most likely it's perfectly sensible and we should just
> do it as standard, other drivers don't make this optional.  If we do
> have a parameter it needs to be documented.
>

I will drop the parameter in the next version and poll below a fixed 30
us.

>> @@ -725,6 +736,9 @@ static void atmel_spi_next_xfer_fifo(struct spi_cont=
roller *host,
>> =20
>>  	dev_vdbg(host->dev.parent, "atmel_spi_next_xfer_fifo\n");
>> =20
>> +	if (as->poll)
>> +		spi_writel(as, IDR, SPI_BIT(RXFTHF) | SPI_BIT(OVRES));
>
> We should ensure there's no interrupt handler running or that could run
> in future, especially with PREEMPT_RT which puts everything into a
> thread.  If we timed out a transfer then an interrupt could be
> delivered while we're polling and try to also process things.  A lock
> while updating the flag and checking the flag before doing anything in
> the interrupt would probably do the trick.

Done as you suggest in v2. The poll flag is set and the interrupts are
masked in the same locked section before the transfer starts. The PIO
interrupt handler takes the lock before it reads the status register and
returns IRQ_NONE without touching the controller while the flag is set.

Thanks,
Emil
