Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D922D063E;
	Thu, 12 Feb 2026 10:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770893421; cv=none; b=FxgSOgRlYj4kQPvHGLgGHctNROAmUvM8HU71OBN9qakdh00/FTofF1sl8PIWfsgUatXU/xdkoWWqfMYIatZk9gcp+QtYgLi1NUhHnbn/i/LqQlQaor4CBAoHXGa/ISCixp3jzJsjnov8M9/gWyMcpcOk6uJZzT+jNcYVlU70NvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770893421; c=relaxed/simple;
	bh=LzQUURllEM3B/sZmgHXdlc/gY6UGnRYOSwnIBxcAe8U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I0nDqi6c7jWlBsjczy8UUgUT07bj7/izZi1KqJjuxI7RseXst0MT/Dfs72H3eSiLHq+oP3TFlV06VtEREvHasU7YEOHFcfIJQQHtFv9Q8poPbmSjV4rw9syRRKXWnSdhzgTcbCtyRgeZguVYY5qqCxB3ux0FEvKkWTqeLmeK8eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=n8gDIjUj; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="n8gDIjUj"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 946DA1A0E2F;
	Thu, 12 Feb 2026 10:50:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 50AA9606CA;
	Thu, 12 Feb 2026 10:50:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 90881119718DE;
	Thu, 12 Feb 2026 11:50:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770893415; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dJ41KSE7bAttPFiYliHfAJ50Lmau9EKSZq3J/XLvPWY=;
	b=n8gDIjUjpViNviAkPVF5jchl7JzMKD3co8b69LorWbq6g0bGnNJ/t7LSfmyUkX+1tnzahl
	dxeDPnb9EHP1sTEhvCMM1j7kGdZ+8zgQPRde3mPxEjHKUN5kHOy0Gp4Mvp9sUNFGcpQG8c
	wcBifgR0l64D9xIjVYFLAsdBAU8JbA0fqONZjZrJZH4c5odgPilsgmwPOfYK4aiwJnsRES
	Pi7otuzcxEyCm3SxVSFcYG2mIjSmgRyJ4oxGUKprPQK7wMOvLkSJb+IHPG8xDUsVEzGULd
	u6SYnFxY3nPhmQKvhE+ZxgR1XhRoMpTOnkBwBstQQIv80xIbkblQssz67pRFAw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Michael Walle" <mwalle@kernel.org>
Cc: "Santhosh Kumar K" <s-k6@ti.com>,  <broonie@kernel.org>,
  <robh@kernel.org>,  <krzk+dt@kernel.org>,  <conor+dt@kernel.org>,
  <richard@nod.at>,  <vigneshr@ti.com>,  <tudor.ambarus@linaro.org>,
  <pratyush@kernel.org>,  <linux-spi@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <praneeth@ti.com>,  <u-kumar1@ti.com>,
  <p-mantena@ti.com>,  <a-dutta@ti.com>
Subject: Re: [RFC PATCH v2 09/12] spi: cadence-quadspi: add PHY tuning
 infrastructure
In-Reply-To: <DGAC4N62UZQQ.3R7TLX87PECU3@kernel.org> (Michael Walle's message
	of "Mon, 09 Feb 2026 10:48:21 +0100")
References: <20260113141617.1905039-1-s-k6@ti.com>
	<20260113141617.1905039-10-s-k6@ti.com>
	<DGAC4N62UZQQ.3R7TLX87PECU3@kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 12 Feb 2026 11:50:12 +0100
Message-ID: <87qzqqxml7.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Michael,

On 09/02/2026 at 10:48:21 +01, "Michael Walle" <mwalle@kernel.org> wrote:

> On Tue Jan 13, 2026 at 3:16 PM CET, Santhosh Kumar K wrote:
>> +static int cqspi_get_phy_pattern_offset(struct device *dev, u32 *offset)
>
> ..
>
>> +	partition_np =3D of_get_child_by_name(flash_np, "partitions");
>> +	if (!partition_np) {
>> +		of_node_put(flash_np);
>> +		return -ENODEV;
>> +	}
>> +
>> +	for_each_child_of_node(partition_np, part_np) {
>> +		if (of_property_read_string(part_np, "label", &label) ||
>> +		    !strstr(label, "phypattern"))
>> +			continue;
>
> There was already a review comment on the last version. Moving this
> into the driver doesn't make it any better. In fact this might
> create a (bad) precedent for future drivers.

I remember complaining about it but not if there was a solution
foreseen. In SPI NAND the solution has been found: the pattern is in the
driver and we load it into cache before PHY tuning. But for SPI NOR I
understood this wasn't possible. What would be an alternative?

Thanks,
Miqu=C3=A8l
