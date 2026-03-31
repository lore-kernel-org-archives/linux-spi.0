Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746B53D9DD9
	for <linux-spi@vger.kernel.org>; Tue, 31 Mar 2026 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774949011; cv=none; b=pJuDVJufn6z1s9+lTcvfLFOulB/JYIRnIx1YQhRbYVnE5h99S5TdpDmAKb0IcGJ7d9KyULxE7b3mUhkR+QPzf+ImyhjlhTdlokuQpsYllI1O8Lh7ti6ReKaZDOceherfcnEAyZ7APCyxG9JOihcxMyBQra+Pjk2Gm1DOb07cuJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774949011; c=relaxed/simple;
	bh=fkBjjN7bhpG5aw4pPbOMePbSqonLTcmD2I2uQB/bMjk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BsI5dKuKioPYS2SsHAfaMxdiTYEe68tGmPYNavmg53wKJ4J+mCtnljbwZT3zS1Z7GiZJ9J+NhN5g3JGKutBhhrCZd01kjFnesDFxima23g3gq8rlAxWNTobpX007FehTMqxIxR4AL5Ey72U5KpRTNkN1y83s7JfdKuC59uorGiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZHnjeBZJ; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZHnjeBZJ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8DFF8C5994D;
	Tue, 31 Mar 2026 09:23:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EE17F6029D;
	Tue, 31 Mar 2026 09:23:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D6B3210451114;
	Tue, 31 Mar 2026 11:23:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774949008; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=fkBjjN7bhpG5aw4pPbOMePbSqonLTcmD2I2uQB/bMjk=;
	b=ZHnjeBZJluQoayfHtxxX3c10BPU4KWGyV1gVTK5ZdH8P8kFLWrPjaHonn7FVTSNAyaxIPm
	zqA5nCnxGEkINET8MEv8ZAL9d/9AhEQjjKLzEnXKldLrNgstNgHXh/9fouSuUvW2IxkCN3
	7gYwb7rnXrFlSfph/kkH0uXW+SeI3hHVLgrb04DYJnECHUs8pOqOrGDz6zXBdp0yXjWGs7
	i9vfCfmf1ymHpgEbCtpLQqQJ5CElhLbuisSx/EpOpG1oz+1ib94CaSmSvLY2jLWzMlaSgw
	fdHfHt6aeuJhO7pPiEzPH7a58CS8ug5ozTOfb6vMb7LnwtodY/Ufu0Rx7n3yuA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Frieder Schrempf <frieder@fris.de>,  Mark Brown <broonie@kernel.org>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Han Xu <han.xu@nxp.com>,  Eberhard Stoll
 <eberhard.stoll@kontron.de>,  Tudor Ambarus <tudor.ambarus@linaro.org>,
  Pratyush Yadav <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,
  linux-spi@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org,  imx@lists.linux.dev
Subject: Re: [PATCH RFC 6/7] spi: spi-mem: Call spi_set_rx_sampling_point()
 for each op
In-Reply-To: <a1a711c4-d9df-4bba-8831-2ec787f84cc4@kontron.de> (Frieder
	Schrempf's message of "Tue, 10 Mar 2026 15:16:47 +0100")
References: <20260303-fsl-qspi-rx-sampling-delay-v1-0-9326bbc492d6@kontron.de>
	<20260303-fsl-qspi-rx-sampling-delay-v1-6-9326bbc492d6@kontron.de>
	<87wlzlnioh.fsf@bootlin.com>
	<a1a711c4-d9df-4bba-8831-2ec787f84cc4@kontron.de>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 31 Mar 2026 11:23:24 +0200
Message-ID: <87ecl09wtv.fsf@bootlin.com>
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

> The sampling point delay is coupled to the clock frequency. So if the
> clock changes per-op, we also need to change the sampling delay per-op.
>
> In general, if we want to avoid switching the parameters back and forth
> in cases of alternating ops with different max frequencies, we should
> maybe do some "min of the max" calculation and use the resulting
> frequency for all ops.
>
> Is that what you mean?

Not exactly, I am not afraid by the time it would take to switch, I am
afraid by the likelihood that both the PHY tuning series and your series
might want to force a different maximum frequency. For instance with TI
designs, when entering PHY mode, the frequency is 166MHz, period. You
cannot lower it because by design, you bypass the SPI divisors.

> We could even set a threshold to decide between using a common "min of
> the max" frequency or do the switching per-op.
>
> One other possibility would be to somehow cache the per-op frequencies
> and calculated sampling delay values so they can be reused when
> switching without much overhead.
>
> There is one more issue that is not yet covered by this series: Before
> spinand_id_detect() we don't know yet what RX sampling delay value the
> chip requires, but we already use read-status and read-id operations at
> maximum chip clock.

Not exactly "maximum chip clock" as in Santhosh's work, but indeed we
run these at the frequency given in the DT as bein the maximum
frequency. If that's not correct, you must lower it in the DT. That is
why I am in favour of having two maximum frequencies: the standard one,
that just works, which is the one for non optimized settings (the one we
actually use today) and another one, when tuning the bus timings.

> For example on Winbond W25N04KV this leads to detection failures. So we
> should maybe introduce some kind of reduced clock setpoint for the
> initial detection, that is safe to be used without RX sampling delay
> compensation.

That should be the DT max frequency, no?

Thanks,
Miqu=C3=A8l
