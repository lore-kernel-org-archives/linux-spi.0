Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459DF3E716E
	for <linux-spi@vger.kernel.org>; Tue, 17 Mar 2026 15:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773760636; cv=none; b=s7TEHLViYHwvxxlT6sN5EWjJ5nvZeHiv3nNzuAmoKPlB5V2sJIVvnKSV/zhoK2+157+KCMPp1BRZz9dMWO+4VC32lunl4On+8Hqb6z4kewp7BgTUVp+kIAUBx7k/FGz5NgYe9phO6fAXBf5R2lJbTKJVzfEHh0AZZSuvPs+hiCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773760636; c=relaxed/simple;
	bh=30310tFKIh8x/3yyzC42vNsJR/nPWZblvYY82XDZEqw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PYtPefI2df8dpzOvQaqZvRA+HQCaLDBg3Jt+VSw4I4IMPwFCo5Y6oHSWkyv3qaOjwxLqkjnszJT25VXMXhc1t1R9ejFaSnMJarMdJZCj9hmkIiGH/1ycHHouS70mrfJkL6DSbg+j5biaRfbY0lw23GrKOP/5coPcSsFzKeNvjvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QQvpvM2E; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QQvpvM2E"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B74C74E425F5;
	Tue, 17 Mar 2026 15:17:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8548C5FC9A;
	Tue, 17 Mar 2026 15:17:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2B4E010450613;
	Tue, 17 Mar 2026 16:17:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773760631; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=HpYyC+ESVa00QuajRPpqFr8FQgzikq4Z2svdSNuwJ88=;
	b=QQvpvM2EbLtLTfmSDKs3yu9GXEBWBukP/xZdkwHdilmyi8kUSnR5ookupTpLcgFw4sTxiF
	0KQCD5WzB/rQ+RSbzB5nRtZnrttb2pvF7JUmteDrxdMCHaypTp+L39l789GzARM0WX/lqc
	HTRDHrjqCuS4tEsJWb+23I154wt64EOqwd0bJthZBDLnLzm6+OZtK0hXvOp+ZEANoH4QoI
	uLXFIPnbAKE2zMuDfdrVbeTRF9LrZ174/HC7DiB3PuNW9vTczrGWq/yat1ci1ljXQg5Ev0
	2w1t+pFmH9lvZSL/iL/kHcfycUmJpfFg8KMJHhVaeFFa2u0U0TY0mQ61QpS+RA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <broonie@kernel.org>,  <robh@kernel.org>,  <krzk+dt@kernel.org>,
  <conor+dt@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <tudor.ambarus@linaro.org>,  <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <linux-spi@vger.kernel.org>,  <devicetree@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-mtd@lists.infradead.org>,
  <praneeth@ti.com>,  <u-kumar1@ti.com>,  <p-mantena@ti.com>,
  <a-dutta@ti.com>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 Eberhard Stoll <eberhard.stoll@kontron.de>, 
Subject: Re: [RFC PATCH v2 11/12] spi: cadence-quadspi: restrict PHY
 frequency to tuned operations
In-Reply-To: <874inlxde0.fsf@bootlin.com> (Miquel Raynal's message of "Fri, 13
	Feb 2026 09:21:11 +0100")
References: <20260113141617.1905039-1-s-k6@ti.com>
	<20260113141617.1905039-12-s-k6@ti.com> <87zf5nf5g1.fsf@bootlin.com>
	<fdcb19ff-c949-4538-8819-88720e514f04@ti.com>
	<874inlxde0.fsf@bootlin.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 17 Mar 2026 16:17:06 +0100
Message-ID: <87zf46cwp9.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Santhosh,

+ Frieder and Eberhard

On 13/02/2026 at 09:21:11 +01, Miquel Raynal <miquel.raynal@bootlin.com> wr=
ote:

> On 07/02/2026 at 00:57:04 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:
>
>> On 05/02/26 23:17, Miquel Raynal wrote:
>>> Hi Santhosh,
>>>=20
>>>> +	/*
>>>> +	 * PHY tuning allows high-frequency operation only for calibrated
>>>> +	 * commands. Uncalibrated operations use safe non-PHY frequency to
>>>> +	 * avoid timing violations.
>>>> +	 */
>>>> +	if (cqspi->ddata->execute_tuning && f_pdata->use_phy &&
>>>> +	    (cqspi_op_matches_tuned(op, &f_pdata->phy_read_op) ||
>>>> +	     cqspi_op_matches_tuned(op, &f_pdata->phy_write_op))) {
>>>> +		cqspi_configure(f_pdata, op->max_freq);
>>>> +	} else if (cqspi->ddata->execute_tuning) {
>>>> +		/* Use safe frequency for untuned operations */
>>>> +		cqspi_configure(f_pdata, f_pdata->non_phy_clk_rate);
>>>> +	} else {
>>>> +		/* No tuning support, always use requested frequency */
>>>> +		cqspi_configure(f_pdata, op->max_freq);
>>>> +	}
>>> Shouldn't we handle this at the core level? We know what kind of
>>> operation pattern we provided, so it is easy to set the correct
>>> frequency in the operation structure.
>>> Can you please make this happen? Perhaps you can return the operation
>>> frequency once the calibration is successful (in the read and write op
>>> templates maybe?) so this can be picked up by the core and used for the
>>> following operations. This way the controller driver no longer needs to
>>> check if the operation has been tuned or not, it can just look at the
>>> frequency. When using the highest frequency, PHY tuning must be
>>> used/enabled, otherwise not.
>>
>> No, Miquel, this may not be correct. There can be cases where an
>> operation does not require tuning but still can run at maximum
>> frequency (166 MHz, for instance).
>
> This is currently not the case. Currently you tune for one or two ops
> (read/write) and you enable PHY tuning only on these. Do you plan on
> adding such a feature? If not, I would not bother with this now.
>
>> In such scenarios, simply setting
>> op->max_freq to the maximum frequency value and deciding whether to
>> enable tuning based on an op->max_freq comparison would not be
>> sufficient.
>
> If there are such cases, can they be listed? I am sorry but I fail to
> see where this would not work. Any examples to share?

I don't know if you got my feedback, but I would like to have all cases
in mind to decide in which direction we must go. Especially, I would
like to make the bridge with Frieder's work who is also "playing" with
the maximum frequency.

We need to clarify our mental picture of the max_freq handling. How it
should be derived, how autonomous shall the SPI controllers be wrt this
value, shall we flag operations that can go faster and if yes, can we
attach a meaningful value to these operations, etc etc.

I feel like this is the part that needs extra thinking. The rest of the
series is promising. I would like us to clarify the needs, maybe propose
some kind of drawing/slides or even take half an hour to discuss in a
call once we have all cases in mind.

Thanks,
Miqu=C3=A8l
