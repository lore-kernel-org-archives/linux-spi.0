Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792675678;
	b=lbYm62Ze/LVxSi8MOD1g+1/nBJ51bDokM/uCvPTKlp2fHhsuvPofDXUvUPl82wzamFqI
	 jpoyiYxqWbYiElswQhfxuBhbiIAyUb7m4uuTe7WjMlqcpa2RrPsLYc1F6vtAV374gUjaK
	 fvAUvd/JW0QHq5q7u7Ery+YOwBIhpsEm/bxzTLiRG9gqC1qUP345SjewlhF3D/5V+ujo4
	 PlrWk9V6u913Zamb4wIgT5F+Po5KEZQF2D7epBqLp6v53ZnFKT2i1qKq0IIFgqhnDy6+N
	 Uw5CIgx7IvbNKfIWWvkDo4CusToCr9uzOZJnQAjtmJKBlIRlcZU3ypUgZGQV2+dRvQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792675678;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:X-Last-TLS-Session-Version;
	bh=/RgtJAwfFxMYwKRHR6ym49yRh7I5Fuz2Xy5zLf91xb0=;
	b=FRdEE27z78b+FJmxORTgVG2Z08n0cyp1mGQ1l37sVWJOTfNwWWmMtWWXC9OM4IWcgA1k
	 smdNfsZNErq+AMXLfx5oEX4TlRcgtbnv12CrP5tPd1WBm+n8gCD4IV7RivT/ujAtfow7O
	 RY3RvyaHm0URDGUbAS+WfoI0a7xHACRs+uJQVghRefee9z8YQZo/YCEHl8Hkjq3h5wpWb
	 YGl2wx3HuJMS0VtlTkBer+m6yRbwEcULgtTgi6Qt/AbnKayZ/+2+UXWvJbvevd/KvpFSV
	 8zW/3wLtrtCam1PmAj41Li/rzw+DKTfYfrwYuaUNgjzfIJDa0Guj71972D9BBCaK6Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Ru3JWSa4;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23C3606A31D
	for <linux-spi@vger.kernel.org>; Thu, 22 Oct 2026 13:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C23C3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Ru3JWSa4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 260881A12C5;
	Thu, 22 Oct 2026 13:27:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E186660360;
	Thu, 22 Oct 2026 13:27:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 09DEF10328E5A;
	Thu, 22 Oct 2026 15:27:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792675674; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=/RgtJAwfFxMYwKRHR6ym49yRh7I5Fuz2Xy5zLf91xb0=;
	b=Ru3JWSa450e+Pfh7Wr17MJeuBSndDLoX6yuq1Glk2pUuKCdE1g4SjrOYTy2wcqGbi8Im44
	6FBKurVqPmB8fnoWsPyKf6mZnMyI86GP8R4S12gtVfD54xLKf0sHmb9+uxtHlFGRtUzQ5/
	qYaXjWHsbgHVJvd5OdKM6JPqrqFw+griRskl1Hn0N478/R7oIdsLavPNBmZLY/cnQon8qg
	2WrJpEFPRLkpUVnXPP3SHARlEXMdHbuiDioYFO0apGaJPyp6EIKek8VimAaDejD8vyT2jo
	KdJIrleI4voqKPvz0C47SBNgZLW646ZZnceeyj4p9E2dhJHkW5aMMbhORDQUYg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Michael Walle" <mwalle@kernel.org>
Cc: "Changhuang Liang" <changhuang.liang@starfivetech.com>,  "Pratyush
 Yadav" <pratyush@kernel.org>,  "Takahiro Kuwano"
 <takahiro.kuwano@infineon.com>,  "Mark Brown" <broonie@kernel.org>,
  "Richard Weinberger" <richard@nod.at>,  "Vignesh Raghavendra"
 <vigneshr@ti.com>,  <linux-spi@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v1 2/4] mtd: spi-nor: Support mixed 1S-xD-xD DTR
 protocols in spi_nor_spimem_setup_op()
In-Reply-To: <DMBD190498R4.3PX7VO4SXKU3C@kernel.org> (Michael Walle's message
	of "Thu, 22 Oct 2026 14:19:27 +0200")
References: <20261022102614.75696-1-changhuang.liang@starfivetech.com>
	<20261022102614.75696-3-changhuang.liang@starfivetech.com>
	<875wyuqaj4.fsf@bootlin.com> <DMBD190498R4.3PX7VO4SXKU3C@kernel.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 22 Oct 2026 15:27:42 +0200
Message-ID: <87ik2tq301.fsf@bootlin.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 22/10/2026 at 14:19:27 +02, "Michael Walle" <mwalle@kernel.org> wrote:

> On Thu Oct 22, 2026 at 12:45 PM CEST, Miquel Raynal wrote:
>> On 22/10/2026 at 03:26:12 -07, Changhuang Liang <changhuang.liang@starfivetech.com> wrote:
>>
>>> Currently spi_nor_spimem_setup_op() sets all four phases (cmd, addr,
>>> dummy, data) to DTR whenever spi_nor_protocol_is_dtr(proto) is true.
>>> This is too coarse: the 1S-xD-xD DTR protocols (1_1_1_DTR, 1_2_2_DTR,
>>> 1_4_4_DTR, 1_8_8_DTR) send the command phase in STR on a single line,
>>> and only the address, dummy and data phases in DTR. SPIMEM supports
>>> such mixed DTR modes.
>>>
>>> Split the handling:
>>>
>>>   - For SNOR_PROTO_8_8_8_DTR, keep the existing behavior: set all
>>>     phases to DTR and use a 2-byte opcode (opcode + extension).
>>>
>>>   - For the other DTR protocols, set the command phase to STR and only
>>>     the address, dummy and data phases to DTR. Double op->dummy.nbytes
>>>     since DTR transfers 2 bytes per clock cycle, matching how the dummy
>>>     cycle count is specified for these protocols.
>>>
>>> No in-tree flash currently declares SNOR_HWCAPS_READ_1_x_x_DTR, so
>>> this is not a bug fix but preparation for enabling these protocols.
>>> A follow-up patch will enable 1S-4D-4D for the MX66L1G45G. The
>>> 8D-8D-8D path is unchanged.
>>>
>>> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
>>> ---
>>>  drivers/mtd/spi-nor/core.c | 21 ++++++++++++++-------
>>>  1 file changed, 14 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>>> index 90524c58602e..43e506e728ab 100644
>>> --- a/drivers/mtd/spi-nor/core.c
>>> +++ b/drivers/mtd/spi-nor/core.c
>>> @@ -97,13 +97,7 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
>>>  	if (op->data.nbytes)
>>>  		op->data.buswidth = spi_nor_get_protocol_data_nbits(proto);
>>>  
>>> -	if (spi_nor_protocol_is_dtr(proto)) {
>>> -		/*
>>> -		 * SPIMEM supports mixed DTR modes, but right now we can only
>>> -		 * have all phases either DTR or STR. IOW, SPIMEM can have
>>> -		 * something like 4S-4D-4D, but SPI NOR can't. So, set all 4
>>> -		 * phases to either DTR or STR.
>>> -		 */
>>> +	if (proto == SNOR_PROTO_8_8_8_DTR) {
>>>  		op->cmd.dtr = true;
>>>  		op->addr.dtr = true;
>>>  		op->dummy.dtr = true;
>>> @@ -115,6 +109,19 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
>>>  		ext = spi_nor_get_cmd_ext(nor, op);
>>>  		op->cmd.opcode = (op->cmd.opcode << 8) | ext;
>>>  		op->cmd.nbytes = 2;
>>> +	} else if (spi_nor_protocol_is_dtr(proto)) {
>>> +		/*
>>> +		 * 1S-xD-xD protocols: the opcode is sent in STR on a single
>>> +		 * line, only the address, dummy and data phases are DTR. The
>>> +		 * opcode stays 1 byte (no command extension).
>>> +		 */
>>> +		op->cmd.dtr = false;
>>> +		op->addr.dtr = true;
>>> +		op->dummy.dtr = true;
>>> +		op->data.dtr = true;
>>
>> Still to coarse IMHO.

too*

>> What about xS-xS-xD?
>
> Is this a thing? Are there any NOR flashes which support the address
> being SDR? That doesn't make much sense, does it? The command being
> SDR makes sense because you don't have to switch modes and thus
> you're stateless.

I honnestly don't know if it's actually a thing today in SPI NOR, but it
is in SPI NAND. Just rising the flag.

