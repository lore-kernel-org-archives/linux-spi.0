Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502E03FCB3A
	for <linux-spi@vger.kernel.org>; Tue, 31 Mar 2026 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774970783; cv=none; b=LL3XIBHEPhWBxnB1x5qhbpPfuxEFKyn4r9vUA9xm4Y9tPH/nTxcoH66J5n2kWh/Bznyi08i333Ju/7brEg+tq/q3H4cUCbHtnFrp5+uKAJF4eihHNid+rlXbLlyAA92YHbczRSr0TvtrnxVYO8bhFFdctv7Z/pvSYqbQaQtdGY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774970783; c=relaxed/simple;
	bh=eK5dGg65CGb94A/wEx0yo49sGIlrvKeB/Y/mHd4ngNs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nqBMcedu0ZF/V8LyVP7LcxfQ3bPEcC7jHzudOq1hi8wejFQncei/iTpEeTvXw63MWoa6Cxszx9kwDveTTAdKC9Vl9TzOBnbhzxbkSUW/u86YZQPFZyOXsDr72XsN4rlU5T80UymE3ZXBWZW/j8LlTbIvYbewyz4EULifbboPQYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SBYnse5B; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SBYnse5B"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A635BC59952;
	Tue, 31 Mar 2026 15:26:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1202B6029D;
	Tue, 31 Mar 2026 15:26:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 44E6010450349;
	Tue, 31 Mar 2026 17:26:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774970777; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=eK5dGg65CGb94A/wEx0yo49sGIlrvKeB/Y/mHd4ngNs=;
	b=SBYnse5BpxBUFO2L4JeWzsooEAaHJTXxKl2yuUBLP75/mlaqoi7j/aCoopSs48uEcYagKS
	Dhvrt17i6qCC/IRZxtJ6/rlmBPFbVfhHE7X6Ke8hXaRa/6I+lzVRUAHYr8yNT0nwEq1dDl
	dtAjaBBBbuNdmmMXpCoFB7wiD42x2d2lYuOvzN2PRCrv8bHLphN55rFpggTsaM9V4C50pT
	XbFKuoqJZ1llUCIGeWj6Rua7mnE6XOW4d8rbPRVVrw26VyLrhhOPqHUjJ2aXL2Dxe1cRrC
	M4M5npnsvJ06jMavG1OvTNQ0WWEbPgS9P2viifNcQSAUvYqE9ygYqOJXhHTs/A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Frieder Schrempf <frieder@fris.de>,  Mark Brown <broonie@kernel.org>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Han Xu <han.xu@nxp.com>,  Eberhard Stoll
 <eberhard.stoll@kontron.de>,  Tudor Ambarus <tudor.ambarus@linaro.org>,
  Pratyush Yadav <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,
  linux-spi@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org,  imx@lists.linux.dev,  Santhosh Kumar K
 <s-k6@ti.com>
Subject: Re: [PATCH RFC 6/7] spi: spi-mem: Call spi_set_rx_sampling_point()
 for each op
In-Reply-To: <633fee13-a397-410f-a595-db95e04b8110@kontron.de> (Frieder
	Schrempf's message of "Tue, 31 Mar 2026 11:58:11 +0200")
References: <20260303-fsl-qspi-rx-sampling-delay-v1-0-9326bbc492d6@kontron.de>
	<20260303-fsl-qspi-rx-sampling-delay-v1-6-9326bbc492d6@kontron.de>
	<87wlzlnioh.fsf@bootlin.com>
	<a1a711c4-d9df-4bba-8831-2ec787f84cc4@kontron.de>
	<87ecl09wtv.fsf@bootlin.com>
	<633fee13-a397-410f-a595-db95e04b8110@kontron.de>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 31 Mar 2026 17:26:12 +0200
Message-ID: <87ldf881gr.fsf@bootlin.com>
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

>>> For example on Winbond W25N04KV this leads to detection failures. So we
>>> should maybe introduce some kind of reduced clock setpoint for the
>>> initial detection, that is safe to be used without RX sampling delay
>>> compensation.
>>=20
>> That should be the DT max frequency, no?
>
> Hm, I've seen it the other way round. In my perspective the DT max
> frequency describes the maximum clock frequency supported by the chip as
> given in the datasheet (assuming there are no other limitations
> introduced by board design, etc.).

I believe that what is in the datasheet should instead be statically
described in the SPI NAND vendor file.

The max SPI frequency DT property is here to tell at which speed to use
the device, and this depends mostly on the routing.

> The RX sampling delay is a timing parameter specified in the datasheet
> and it is relevant in order to interface the chip at maximum frequency
> within spec.

If it's not design dependent, then we should handle it "statically".

> Your approach would mean, that we need to manually calculate the maximum
> supported clock frequency without RX sampling delay compensation and use
> this value in the DT. Then let the driver increase the clock if RX
> sampling delay compensation is available.
>
> This would have the advantage, that even before initial detection we
> would use the correct clock by default. But it has the downside that the
> clock value in DT won't match the datasheet value.

It never does. Winbond chips can run at 166MHz. I know no design capable
of that natively (ie. without finer tuning, like what Santhosh
proposes).

> In my approach we assume the driver is able to use the maximum clock
> from the DT (same as in datasheet) by using RX sampling delay
> compensation and only if it turns out the compensation is not possible
> we will lower the clock dynamically.
>
> What if we do the following?
>
> 1. Add a parameter in the SPI NAND chip driver that contains the maximum
> supported clock frequency as given in the datasheet as this is clearly
> the best place to keep this device-specific parameter.

I've so far avoided doing it, but yes, this is something we can do. It
is going to be simple enough to implement as all the infrastructure is
already there. You can provide variants with speed limitations (look
into winbond.c). I was writing "0" in the fields which didn't need a
limitation that is something else than the maximum speed the chip can
sustain, as anyway the DT property *will* tell us what is this speed, if
we are ever able to reach it.

> 2. Allow to leave spi-max-frequency in DT unset for SPI NANDs in case
> there are no board-specific limitations and therefore the maximum
> frequency supported by the combination of chip and controller can be
> used.

In many cases, the limitations are board specific. Anyway, this is
already the case, you may just not put any value in this property.

> 3. By default limit the clock frequency for the READ_ID op to a safe
> value that works for all chips and controllers, even if RX sampling
> delay compensations is not available.

I am sorry this is not going to work out. There is no such harmonized
speed, differences can be an order (or two) of magnitude different, we
do not want to pay the penalty of a very slow identification on all
designs. We currently do the read several times with different
parameters. What if we were trying one more time by cutting the speed by
2 (completely random proposal)?

> 4. In PHY mode, check against the DT max frequency (board limitations)
> and chip max frequency before switching to this mode.

There is not such thing :-) the max frequency in DT currently would be
set to the platform limitation. We need somehow another parameter
indicating what is the maximum speed if we can fine tune the timings.

> I hope this makes at least a bit of sense. I'm really not yet familiar
> with all the different use-cases and limitations.

If I get back to your own issue. Is there any chance we could avoid
tweaking the DT for handling it? Would there be a configuration of your
controller that would allow reading the ID of all the chips with enough
delays? Currently, the spi core doesn't care much about other parameters
than the frequency, but there is perhaps room for improvement.

Thanks,
Miqu=C3=A8l
