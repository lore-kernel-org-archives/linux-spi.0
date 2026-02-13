Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71118313546
	for <linux-spi@vger.kernel.org>; Fri, 13 Feb 2026 08:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770970750; cv=none; b=Q3GpFzp9HZ6QiV4P2Wa7aDzSxI0pPJr75Uf0cSBGTy2rSvCjlPoi3EGVpUL5Ccg/6WMEyyEcQtDiLDsuNdd/tfDgUU5zEVm7i4m0ydh/eSCrcELZz2IOY/SwYTGvNeAS5D6eNYnb3vdW3LYGiyJ7FVKvJkYXXkYayDnLEG+XEWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770970750; c=relaxed/simple;
	bh=75NWZpzG3PgHqXnpAb2JqUhfWyvzCwxFFpQ5zHepM6c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KLdg/n7aVW19iAXjahorl05pg8riumtTOP/eIBPC2R1RJa4niEZPLtV5A1WLngXDGmUwmEDHO9IyBHWm03w/ZOWJ+C893+rEYXgW6CpwTFCnbkvJ4IMR7oSIxL0KaQDjkiCZGrlR/FZADwZT/OYHoKEVA84MUeGKWr2/q0mFhx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R/rh10fv; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R/rh10fv"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 27F64C237F7;
	Fri, 13 Feb 2026 08:19:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8A815606CC;
	Fri, 13 Feb 2026 08:19:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C830710368E05;
	Fri, 13 Feb 2026 09:18:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770970739; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6yDp974LQrt0MDs5mJhTng5R7kqy2mlSjAEqesT+EHc=;
	b=R/rh10fv12ZrMWg0slw6wc48DOkSeuVDzW4lm8J3U750kw3QXJaYY2JMIDvuKx7RCtBT6e
	zEngr6rKknPHs/3rzngK/zf6s2b+p1F5BcuJ3Wq2PsdSZNC+tfjkn3SJJY5TgV1topTCHM
	E2MKb0oDbYlhU/LKhrA7o3VbjHzm9lh0j3hSLH8iZzmC9YDU7UhYXZfheJR3F1vU3CBKGr
	tMQJpIegyGXz81nU2eyg651tatAv/r/9iTuKtyTTSAiuZgCp6qpcimtRpddZfPT04lddha
	KrwYagkq9XaW6ZkXwYmdW5T7kzbnkymA0MI8u33A/3zIa0rClONyWUWgv7di6w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <broonie@kernel.org>,  <robh@kernel.org>,  <krzk+dt@kernel.org>,
  <conor+dt@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <tudor.ambarus@linaro.org>,  <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <linux-spi@vger.kernel.org>,  <devicetree@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-mtd@lists.infradead.org>,
  <praneeth@ti.com>,  <u-kumar1@ti.com>,  <p-mantena@ti.com>,
  <a-dutta@ti.com>
Subject: Re: [RFC PATCH v2 09/12] spi: cadence-quadspi: add PHY tuning
 infrastructure
In-Reply-To: <012a44f3-973f-4f34-be69-286cf924a6c6@ti.com> (Santhosh Kumar
	K.'s message of "Sat, 7 Feb 2026 00:55:49 +0530")
References: <20260113141617.1905039-1-s-k6@ti.com>
	<20260113141617.1905039-10-s-k6@ti.com> <87bji3gkda.fsf@bootlin.com>
	<012a44f3-973f-4f34-be69-286cf924a6c6@ti.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Fri, 13 Feb 2026 09:18:54 +0100
Message-ID: <87a4xdxdht.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 07/02/2026 at 00:55:49 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:

> On 05/02/26 23:09, Miquel Raynal wrote:
>> On 13/01/2026 at 19:46:14 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:
>>=20
>>> Implement the spi_controller_mem_ops execute_tuning callback to enable
>>> PHY tuning support for the Cadence controller. PHY tuning optimizes data
>>> capture timing at high frequencies by calibrating the read data capture
>>> delay through the controller's PHY interface.
>>>
>>> Tuning algorithm functions (cqspi_phy_tuning_ddr/sdr and
>>> cqspi_phy_pre/post_config) are placeholders to be implemented
>>> in subsequent commits.
>>>
>>> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
>>> ---
>>>   drivers/spi/spi-cadence-quadspi.c | 241 ++++++++++++++++++++++++++++++
>>>   1 file changed, 241 insertions(+)
>>>
>>> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadenc=
e-quadspi.c
>>> index 0df286d24256..b8b0e85f4f68 100644
>>> --- a/drivers/spi/spi-cadence-quadspi.c
>>> +++ b/drivers/spi/spi-cadence-quadspi.c
>>> @@ -32,6 +32,7 @@
>>>     #define CQSPI_NAME			"cadence-qspi"
>>>   #define CQSPI_MAX_CHIPSELECT		4
>>> +#define CQSPI_AM654_NON_PHY_CLK_RATE	25000000
>>>     static_assert(CQSPI_MAX_CHIPSELECT <=3D SPI_DEVICE_CS_CNT_MAX);
>>>   @@ -65,6 +66,7 @@ struct cqspi_st;
>>>   struct cqspi_flash_pdata {
>>>   	struct cqspi_st	*cqspi;
>>>   	u32		clk_rate;
>>> +	u32		non_phy_clk_rate;
>> This is the second (and last) main issue I have with the series as it
>> is
>> right now. We cannot set this type of frequency in the driver IMO, it is
>> too board specific.
>> We currently have a DT property for the SPI maximum supported
>> frequency. I believe this is no longer enough. Why not making this
>> frequency property an array? First frequency would be the default,
>> non tuned maximum frequency. The second would be the maximum frequency
>> reachable when tuning the PHY.
>
> If the concern is only about where this is set, we could introduce a DT
> property such as "non-phy-max-freq" to carry this information. This
> would allow us to avoid any changes to the existing "spi-max-frequency"
> handling. Let me know your thoughts on this.

Naming is difficult, non-phy-max-freq is too TI specific. I was
proposing the evolution of spi-max-frequency because it is backward
compatible. The naming can be discussed after you send a proposal, but
do not include "non-phy" in it. It shall reflect the fact that with fine
tuning we can reach higher frequencies on certain operations.

Mark, any take on this?

> I'll also test the approach you suggested and share my inputs based on
> the results. By the way, where are you insisting to adjust/switch to
> the maximum frequency - within the controller driver or in the
> spi-core?

It is preferable to make the decisions in the core and avoid being smart
in controller drivers, if possible.

Thanks,
Miqu=C3=A8l
