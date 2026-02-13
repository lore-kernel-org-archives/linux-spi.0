Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BE7313273;
	Fri, 13 Feb 2026 08:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770970879; cv=none; b=ZogoIBtPzo0zEt1R8zdlrvtYZP0VkzXeqQgb1AdjjtsiiiKFvdZDa6B+7GG21G0mVLHA9cC7ObeF0DfbU0QPXtpMQsjz/uW5niaByIksRKwl/haZkRtxvlF8RjxXMm6i+bfsmrg/fr++qPCaJJHiidhcI3YXcQ2uOjlH4dwF4JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770970879; c=relaxed/simple;
	bh=pStBcQI45vcwvpK02rcJ+orFTmkPb+9dA3UTS0rvqzQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qo5Vars+SgjNHuGL/0gwx9YWP+x600S+cjqkSjVbtcvycrvoYEhoPdDgkdxoNS5Zez/IDDXTh9QF7TEGMBUs9RBn3BD6d6Q/PPSXL7H0ssiYpy9V3smH8P9HhTLPBSjYiAZVHtdKg+3/ZzzSjpsFf4qGsznFxEoayVT3Xodah6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PjY2ZIDh; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PjY2ZIDh"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 9CFCDC237F7;
	Fri, 13 Feb 2026 08:21:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EA7FA606CC;
	Fri, 13 Feb 2026 08:21:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A8D0D10368DA6;
	Fri, 13 Feb 2026 09:21:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770970874; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=2Syg4XtkVjAlgOYhpuM1HSgS7vTX5OxBQsvPxk928Fs=;
	b=PjY2ZIDhEBVK0E85C+U9cRH+OvmQJGP0B+KnH1LHllT4Lngr5Wl27NJxYSiSTQ5nN+SoYf
	GcTxOfHZSsPKN3eJGc/v8tD6Ke1ROsZT10nL4111oGYSAg1TcVy1tMKILtazu1I5iB7EYi
	l8uIxz+lDLJRiZoRVl28pcR6QBkQ+nBKCa5L+oLjHFQqlAx5bgn1CUz/ecx1VU8Q2sUHHM
	G4jtLcO0lIhmoLdQKksb7us3tT+4fcceECMSI3LyWrKR2MIbn9xu7K8G3p9jx8hYd/g6b/
	AxEPe6pvJjNc6Ddh0oNleYecvMupvW0Ed7X/BKIdPKMF/vj1CnukoMS+YMLtNw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <broonie@kernel.org>,  <robh@kernel.org>,  <krzk+dt@kernel.org>,
  <conor+dt@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <tudor.ambarus@linaro.org>,  <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <linux-spi@vger.kernel.org>,  <devicetree@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-mtd@lists.infradead.org>,
  <praneeth@ti.com>,  <u-kumar1@ti.com>,  <p-mantena@ti.com>,
  <a-dutta@ti.com>
Subject: Re: [RFC PATCH v2 11/12] spi: cadence-quadspi: restrict PHY
 frequency to tuned operations
In-Reply-To: <fdcb19ff-c949-4538-8819-88720e514f04@ti.com> (Santhosh Kumar
	K.'s message of "Sat, 7 Feb 2026 00:57:04 +0530")
References: <20260113141617.1905039-1-s-k6@ti.com>
	<20260113141617.1905039-12-s-k6@ti.com> <87zf5nf5g1.fsf@bootlin.com>
	<fdcb19ff-c949-4538-8819-88720e514f04@ti.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Fri, 13 Feb 2026 09:21:11 +0100
Message-ID: <874inlxde0.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 07/02/2026 at 00:57:04 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:

> On 05/02/26 23:17, Miquel Raynal wrote:
>> Hi Santhosh,
>>=20
>>> +	/*
>>> +	 * PHY tuning allows high-frequency operation only for calibrated
>>> +	 * commands. Uncalibrated operations use safe non-PHY frequency to
>>> +	 * avoid timing violations.
>>> +	 */
>>> +	if (cqspi->ddata->execute_tuning && f_pdata->use_phy &&
>>> +	    (cqspi_op_matches_tuned(op, &f_pdata->phy_read_op) ||
>>> +	     cqspi_op_matches_tuned(op, &f_pdata->phy_write_op))) {
>>> +		cqspi_configure(f_pdata, op->max_freq);
>>> +	} else if (cqspi->ddata->execute_tuning) {
>>> +		/* Use safe frequency for untuned operations */
>>> +		cqspi_configure(f_pdata, f_pdata->non_phy_clk_rate);
>>> +	} else {
>>> +		/* No tuning support, always use requested frequency */
>>> +		cqspi_configure(f_pdata, op->max_freq);
>>> +	}
>> Shouldn't we handle this at the core level? We know what kind of
>> operation pattern we provided, so it is easy to set the correct
>> frequency in the operation structure.
>> Can you please make this happen? Perhaps you can return the operation
>> frequency once the calibration is successful (in the read and write op
>> templates maybe?) so this can be picked up by the core and used for the
>> following operations. This way the controller driver no longer needs to
>> check if the operation has been tuned or not, it can just look at the
>> frequency. When using the highest frequency, PHY tuning must be
>> used/enabled, otherwise not.
>
> No, Miquel, this may not be correct. There can be cases where an
> operation does not require tuning but still can run at maximum
> frequency (166 MHz, for instance).

This is currently not the case. Currently you tune for one or two ops
(read/write) and you enable PHY tuning only on these. Do you plan on
adding such a feature? If not, I would not bother with this now.

> In such scenarios, simply setting
> op->max_freq to the maximum frequency value and deciding whether to
> enable tuning based on an op->max_freq comparison would not be
> sufficient.

If there are such cases, can they be listed? I am sorry but I fail to
see where this would not work. Any examples to share?

Thanks,
Miqu=C3=A8l
