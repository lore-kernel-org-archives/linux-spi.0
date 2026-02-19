Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C50329C7B
	for <linux-spi@vger.kernel.org>; Thu, 19 Feb 2026 10:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771497293; cv=none; b=JdCqiardl1zCiSVrhoU8mfoyAWtgoNCazoz22KRqhmOLJRO5p3yM1+yXiHCcnj7OuzesNKNfh7a5mdfwFFcFq16zvneVNulsVJQdIVtzlhMXsReKFqC9xWO0O7LZH1Fem/NPOJkuPFvhC7F11W+aeYOS4PZD7Z8uVmZZHl2RXLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771497293; c=relaxed/simple;
	bh=1glZqOj/Ip4WcewqM1qhHJGZVtVQOqhtv7j/pQlJEeo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T+nvF1TdzYJ4Gq1VXlEq89LUpNAEIIHUWdQLGKlvJVZpCuLHb8Qn2Ocpe6aeOHkNVZEKTIbZiND49LlbeSSIGb/d9D852mjwDJTbBW2C8QYZznEQ2e2lDBdw1gyv+ihPrvt4qVJoNyxddhh4Gj8MmyWYHQ2Zc/ivmbl3L9Ww6CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cW98++mQ; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cW98++mQ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id F2AC4C2F4EF;
	Thu, 19 Feb 2026 10:35:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9CBF55FB45;
	Thu, 19 Feb 2026 10:34:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D7E05102F175B;
	Thu, 19 Feb 2026 11:34:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771497289; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=S/icmQtLFk7NKlE6/ITNmjfkCaauJszmzt1HAFFFVM0=;
	b=cW98++mQOsRHtNGKlHdBK2Ni8lc9CQgCiVv+uI60rXe4NnFwjLpkEHOxQxjZ4abdFSNSCy
	03fdbIfYnpvw26AC6hpr37UrjJqaihno22zsGzrOurg0wF4GsoVQG56Fv28eaH9uxVoHK1
	6BHYSEBwJXrYXoMBi9v6vaDHYA4nmdhJFGUEuBradbcCIyCWmydlwWV3OGWoczxmK7snkm
	8OINAM7SJXJPBUrjwTLW1C05/xd3gdREV/Hl44/J5dN6HWhf4+X4MMMdKh9iOeSjXxCVkh
	Z6esTw2vEvVvqBYnLEcPk3Vl6Gcp8XIbYPgJZcmG+uZv2WWOcksmMwxGwyhDEA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: Michael Walle <mwalle@kernel.org>,  <broonie@kernel.org>,
  <robh@kernel.org>,  <krzk+dt@kernel.org>,  <conor+dt@kernel.org>,
  <richard@nod.at>,  <vigneshr@ti.com>,  <tudor.ambarus@linaro.org>,
  <pratyush@kernel.org>,  <linux-spi@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <praneeth@ti.com>,  <u-kumar1@ti.com>,
  <p-mantena@ti.com>,  <a-dutta@ti.com>
Subject: Re: [RFC PATCH v2 09/12] spi: cadence-quadspi: add PHY tuning
 infrastructure
In-Reply-To: <54964ad3-64d7-4f4e-bcf9-f0b92b1df034@ti.com> (Santhosh Kumar
	K.'s message of "Wed, 18 Feb 2026 23:37:00 +0530")
References: <20260113141617.1905039-1-s-k6@ti.com>
	<20260113141617.1905039-10-s-k6@ti.com>
	<DGAC4N62UZQQ.3R7TLX87PECU3@kernel.org> <87qzqqxml7.fsf@bootlin.com>
	<DGCXTWSCAH6R.22SIL82AUVGYI@kernel.org> <87fr76xgsl.fsf@bootlin.com>
	<54964ad3-64d7-4f4e-bcf9-f0b92b1df034@ti.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 19 Feb 2026 11:34:46 +0100
Message-ID: <877bs9t41l.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 18/02/2026 at 23:37:00 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:

> Hello Michael and Miquel,
>
> On 12/02/26 18:25, Miquel Raynal wrote:
>> Hello,
>>=20
>>>>>> +	for_each_child_of_node(partition_np, part_np) {
>>>>>> +		if (of_property_read_string(part_np, "label", &label) ||
>>>>>> +		    !strstr(label, "phypattern"))
>>>>>> +			continue;
>>>>>
>>>>> There was already a review comment on the last version. Moving this
>>>>> into the driver doesn't make it any better. In fact this might
>>>>> create a (bad) precedent for future drivers.
>>>>
>>>> I remember complaining about it but not if there was a solution
>>>> foreseen. In SPI NAND the solution has been found: the pattern is in t=
he
>>>> driver and we load it into cache before PHY tuning. But for SPI NOR I
>>>> understood this wasn't possible. What would be an alternative?
>>>
>>> I'm not complaining about using a partition for the pattern but
>>> about the hardcoded name of it.
>>>
>>> It was proposed to use at least a device tree phandle to point to a
>>> partition (or so).
>> Ah, yes indeed, thanks for clarifying this up (again) for me. I also
>> agree the hardcoded name is not ideal.
>
> I remember this was discussed in the previous version. As mentioned
> in v1, using a phandle may not be ideal since a single controller can
> be associated with multiple flashes. Regarding the suggestion to
> maintain an array of phandles - consider a configuration with three
> flashes (NAND, NOR, and another NAND). In such a case, we would not
> need a phandle for the NAND devices, right?

We could have a per-chip phy-tuning-data phandle?

> Also, I'm trying to understand the practical difference between using
> the partition name versus a phandle. Since the phandle would still be
> named something like "phy_partition", it seems functionally similar.
> Please let me know if I'm missing something here.

Functionally, yes, but conceptually I'd say it looks cleaner (and
somewhat a bit faster when there are many partitions).

Thanks,
Miqu=C3=A8l
