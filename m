Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38752FF65F
	for <linux-spi@vger.kernel.org>; Thu,  5 Feb 2026 17:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770313654; cv=none; b=ghTyKqhqn/yv/KhsQJymifgTpIo1BZTJcOhwCK6ebkA9m9KayZhCXV6JlzRMqZ3u60VO8Tu2Gc/gES2AqsZ4n2J4Sx/Suw9KJxVfkjN9tHAlLeRaLmRj4Oo3tTVOVDwbDaeJOkQxIfRAp8y1xq2ZX4S2vDK6uou1iQ/IFU4gd7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770313654; c=relaxed/simple;
	bh=o/l4PibdVelPlAccA7QM9epJk+yNm1YFqeucEPyjm6I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UdquDtlcjWobhDB0kxW+ACQl0FcFq16hm7coQfi9tEuw3XKzaonK6f3tAfGSgUtbe6ahq/RujMybtU2sNRggttSt9eCQ3HrsqfgpP5nXVjvOwe0BtjWLY4xeOhcnTnkuFqrds9J/VM4iX5XVNuiZQ27eDcNh+wOymmxGoFuLuLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xcz1K2qt; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xcz1K2qt"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 53AEE4E42424;
	Thu,  5 Feb 2026 17:47:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 295CD6074D;
	Thu,  5 Feb 2026 17:47:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F2FE2119D16C5;
	Thu,  5 Feb 2026 18:47:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770313650; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=V7bxEkRAtCnT9zU9zuvhxCFwkCKSUQxYHkKN7TjR5ZQ=;
	b=xcz1K2qtsOGLWJ2JkEZu6PyuPKSu6fE8XhI5yRP/Q/jTq/nAAojDNwuMhM/8BeD/3S5HXC
	yw1M3CJki/NDYTGSIzBOKfj49Bwty5iRocM05Ag1sAQm+mWzyEMdZnkWo115eV9wdYUcBz
	tXEWvo1YJ9voChSAujvxdRwlFifR/dIzWMGfdJgU/LtEnqBmg4NPC3HYyjA3K+kSVSPhFh
	oZp9tzWT41nlkBb8ina/Mj1CiFZvjI8Ao4fGjzL0BHwSz9AHS9u4O/qiXHdg+BDlPp5pqo
	UGTI+1iogAhoyaee8AjaRHY+Eb01YorRk3kxUHJD7cCJlS6t/Qm9tqqZirr8tw==
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
In-Reply-To: <20260113141617.1905039-12-s-k6@ti.com> (Santhosh Kumar K.'s
	message of "Tue, 13 Jan 2026 19:46:16 +0530")
References: <20260113141617.1905039-1-s-k6@ti.com>
	<20260113141617.1905039-12-s-k6@ti.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 05 Feb 2026 18:47:26 +0100
Message-ID: <87zf5nf5g1.fsf@bootlin.com>
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

> +	/*
> +	 * PHY tuning allows high-frequency operation only for calibrated
> +	 * commands. Uncalibrated operations use safe non-PHY frequency to
> +	 * avoid timing violations.
> +	 */
> +	if (cqspi->ddata->execute_tuning && f_pdata->use_phy &&
> +	    (cqspi_op_matches_tuned(op, &f_pdata->phy_read_op) ||
> +	     cqspi_op_matches_tuned(op, &f_pdata->phy_write_op))) {
> +		cqspi_configure(f_pdata, op->max_freq);
> +	} else if (cqspi->ddata->execute_tuning) {
> +		/* Use safe frequency for untuned operations */
> +		cqspi_configure(f_pdata, f_pdata->non_phy_clk_rate);
> +	} else {
> +		/* No tuning support, always use requested frequency */
> +		cqspi_configure(f_pdata, op->max_freq);
> +	}

Shouldn't we handle this at the core level? We know what kind of
operation pattern we provided, so it is easy to set the correct
frequency in the operation structure.

Can you please make this happen? Perhaps you can return the operation
frequency once the calibration is successful (in the read and write op
templates maybe?) so this can be picked up by the core and used for the
following operations. This way the controller driver no longer needs to
check if the operation has been tuned or not, it can just look at the
frequency. When using the highest frequency, PHY tuning must be
used/enabled, otherwise not.

Thanks,
Miqu=C3=A8l
