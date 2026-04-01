Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0773D3A9018
	for <linux-spi@vger.kernel.org>; Wed,  1 Apr 2026 08:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775032341; cv=none; b=GviOb7wp1mnjc3XhiudO3QnBl79xe/kY2vd1sC1bzoZI73q4/MrCfoCGZeLBVAJAQWZF7haqg8KwBRu2xCLOFPKiRfuSBgFyG7wp6stiNvX9zfIagCN1QiFRjG7Gj/nNte/8r17eSMxcGajegpbJa49SNfL6OvS8UjNHh+nMBsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775032341; c=relaxed/simple;
	bh=Fs+CGKEUt1ElyhYrbunyFdQOzG2qbZr8EbkvS0lQATM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BJozyY3KhDWcxqsdERGd3Q2lzji+JXMA1/hKaT2H4X8cYkU1x5mDXE2QZvI0if9SJan46pGfXlQl+3Vl0z4yUpeAN67O2Z4yEXEJAKl1RsW6iE7iH0q5f5WSn8aoCcdfsv/e0xsggf2kGHp6oqDHBdetysy3zQhGLu6radLCLwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fto/JPni; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fto/JPni"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 11DA9C59969;
	Wed,  1 Apr 2026 08:32:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EFBFE602BF;
	Wed,  1 Apr 2026 08:32:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CB770104509A9;
	Wed,  1 Apr 2026 10:32:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775032335; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Fs+CGKEUt1ElyhYrbunyFdQOzG2qbZr8EbkvS0lQATM=;
	b=fto/JPni0c1YOWLjhCWBPwqKHiMHbfSQuQEZso7ZVx5iqbGyZTPkZ5CKJEX1lZJ4RF8Ykf
	lFZrD8Qr4iUeDG6X0XA2zSiyg0eHQvz2m0+9RUsBINHftygBnlNTTAbENLTJ51vPCnKbih
	+Fr/r7xOpcxaCBMBMtdy2txzIuN7mJjtxjWkU7+VqVrbqBnh5dKB3UUKoMOaKHzDrIiko5
	0ZAsfmCt9JCUykyIye1ju+n8N+OXfDqNBsWqNiHwbpJEAqFhY9iWlf93fP831/Ucq/65FZ
	6DjOSq5kGFuzkUyt3zZc/hGhfU7OKl4dsHFOdZzTF0nDUFyMDS56DOKv3c12IQ==
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
In-Reply-To: <fed5fba7-0536-4f92-8372-f4b47c89b1c2@kontron.de> (Frieder
	Schrempf's message of "Tue, 31 Mar 2026 19:57:21 +0200")
References: <20260303-fsl-qspi-rx-sampling-delay-v1-0-9326bbc492d6@kontron.de>
	<20260303-fsl-qspi-rx-sampling-delay-v1-6-9326bbc492d6@kontron.de>
	<87wlzlnioh.fsf@bootlin.com>
	<a1a711c4-d9df-4bba-8831-2ec787f84cc4@kontron.de>
	<87ecl09wtv.fsf@bootlin.com>
	<633fee13-a397-410f-a595-db95e04b8110@kontron.de>
	<87ldf881gr.fsf@bootlin.com>
	<fed5fba7-0536-4f92-8372-f4b47c89b1c2@kontron.de>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 01 Apr 2026 10:32:11 +0200
Message-ID: <874ilv84j8.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Frieder,

> The RX delay introduced by the chip is not design-dependent, only
> chip-dependent. There might be additional delays introduced by the board
> layout, but that's out of scope currently and I don't know if we even
> need this.

We do, for very high speeds, and this is the purpose of the PHY tuning
series from Santhosh.

[...]

>>> 3. By default limit the clock frequency for the READ_ID op to a safe
>>> value that works for all chips and controllers, even if RX sampling
>>> delay compensations is not available.
>>=20
>> I am sorry this is not going to work out. There is no such harmonized
>> speed, differences can be an order (or two) of magnitude different, we
>> do not want to pay the penalty of a very slow identification on all
>> designs. We currently do the read several times with different
>> parameters. What if we were trying one more time by cutting the speed by
>> 2 (completely random proposal)?
>
> If we try with reduced clock as a fallback after the other attempts,
> there would be a slight chance of one of the earlier attempts with
> normal clock rate returning some invalid data that matches an existing
> chip ID, no? Isn't this a bit flaky?

Yeah, I understand your (and Mark's) concern.

> Let's say for a worst case scenario a chip has an RX delay of 20ns (the
> highest I've seen in datasheets so far is 8ns). In that case the maximum
> clock we could safely use for reading the ID would be 1/(2*20e-9) =3D
> 25MHz. Do you think it really makes much of a difference if we read the
> ID (only a handful of bytes) at 25MHz or full speed (e. g. 104 MHz)? I
> mean this should be fast enough either way, no? But maybe I'm misjudging
> this.

I am honestly not a big fan of the global penalty, but I am not totally
opposed either, especially since you just said you only observed 8ns
delays at most. This is 62.5MHz, which is already above what most
designs use, so the penalty would be minimal. What about taking this
approach and see if that fixes most of our use cases?

>>> 4. In PHY mode, check against the DT max frequency (board limitations)
>>> and chip max frequency before switching to this mode.
>>=20
>> There is not such thing :-) the max frequency in DT currently would be
>> set to the platform limitation. We need somehow another parameter
>> indicating what is the maximum speed if we can fine tune the timings.
>
> So we can exceed the platform limitations using fine-tuned timings? I
> guess I need to read and understand that tuning RFC series.

Well, this is still under discussion. As of today, the max speed in DT
is the maximum speed. But it is in most cases the maximum speed
*without* tuning, which means if we tune the PHY delays we can increase
the speed further. I already proposed to turn this DT property into an
array, in order to indicate what are the maximum speed*s*, without and
with tuning, if ever possible.

>>> I hope this makes at least a bit of sense. I'm really not yet familiar
>>> with all the different use-cases and limitations.
>>=20
>> If I get back to your own issue. Is there any chance we could avoid
>> tweaking the DT for handling it? Would there be a configuration of your
>> controller that would allow reading the ID of all the chips with enough
>> delays? Currently, the spi core doesn't care much about other parameters
>> than the frequency, but there is perhaps room for improvement.
>
> We could use RX delay compensation (one half clock cycle) in the
> controller by default (as currently done by the STM32 driver). But that
> would break if we use a very low clock (for whatever reason) because
> then the RX sampling delay gets neglectable compared to the clock period
> and sampling is triggered at the very end of the clock cycle when the
> data might already be invalid. At least that's what I suspect based on
> my test results.
> And it would also break if the chip actually requires more than one half
> clock cycle of RX sampling delay.
>
> The RX sampling delay setting must match the used clock frequency. In
> most cases there is a lot of room for tolerance before things start to
> fail, but it's not endless and especially at very high clock rates we
> need to take it into account.
>
> So if we don't cap the speed for reading the ID by default, we somehow
> need to know what value to use for the RX sampling delay or we need to
> try different values. And if the controller does not support or
> implement the RX sampling delay compensation, we need to cap the speed
> anyway.

What about:

*SPI controller drivers*
- Enable RX delay compensation in the controller by default, disable it
if the speed is very low, ie. compensation is dangerous
*Core*
- READID at max 65MHz (with the default RX delay compensation)
*Vendor driver*
- Indicate the internal RX delay per chip (maybe we need some heuristics
depending on the speed as well?)
*SPI controller drivers*
- Hook to tune RX based on the fastest reachable speed.

Thanks,
Miqu=C3=A8l
