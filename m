Received: from mout-b-107.mailbox.org (mout-b-107.mailbox.org [195.10.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234E344DB98;
	Thu, 26 Feb 2026 23:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772147591; cv=none; b=UhyjF3jmgqbtIQKSW1x/er/ynbk2UcoCymZ7is/h2kE9boEXFC81L6RP99cde3xn5HjsJT3AB8GdDpZhITI6uQ88Qh1uZRD2l1zUGOiSCqEHXstaj3WMGbGTnthHds81Vh/D0o61uMwItg8tm+8KptK1ZuHQNEIeeQOtMj8Sje4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772147591; c=relaxed/simple;
	bh=nRxv6c+jMV1lHnGpe/FKNt+zLRvLll0QrqrtERorXD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mG1j2/UhyDm6PaKBpOHt8iZNY02YLyhmemvmrtpzNNFvxu+0LLoJPA1fg/UN3bMwnxdzGzD824khLVfakC/dTaCuYAggT8cMMI6vyaIBkKE9hcq6hOLc48BoN5g9Zl8qFPN9FpjHn/9D8D1dijm7TZc0X2RnkoTi1eM7m7DBglc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=o2DpK13t; arc=none smtp.client-ip=195.10.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="o2DpK13t"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4fMRpq6JCKzDryh;
	Fri, 27 Feb 2026 00:04:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1772147043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7v5avoGOleuykikPyFzz717Uwgm0oyh5TKNI4z15XhE=;
	b=o2DpK13tVS01D5w7H1q7+YcyRyDt3lQULFhP/3N/Jqyz6v88rH863uQvftAv/Kyzew+w7i
	XaiFvQxO1EUB+rAfWo5+PsKp/DY5ctsCOHKu4gQnuvQ4A132k+HY9Q3bNaMUQvzvhz4Tfq
	MkFq53mX4CkODLV4OxmGnwqlRx946yUyoNlFd8sb11JWHS4+igW60SHg6S9WKw9VSW774i
	yW5HefTqzlxAJzY9IzUHkGYqDf58drb5T7n1pQSJhIquDilfsSq2tLvdIkhEq8CqowaphZ
	r+51dVZxMcNE7hfdZpIOBqQ3DjRUL93O1aeWHHfyqPynTFBF5EjHPGnVq/oWRw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
Message-ID: <eb249987-55b6-45ff-9cca-3ed198ba84cd@mandelbit.com>
Date: Fri, 27 Feb 2026 00:03:58 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] spi: stm32: fix missing pointer assignment in case of dma
 chaining
To: Alain Volmat <alain.volmat@foss.st.com>
Cc: Mark Brown <broonie@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Clement LE GOFFIC <clement.legoffic@foss.st.com>, linux-spi@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260224-spi-stm32-chaining-fix-v1-1-5da7a4851b66@foss.st.com>
 <d14f3943-b97a-4940-95dd-39c6fc240130@mandelbit.com>
 <aaB4z_A4aTqirDGb@gnbcxd0016.gnb.st.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Organization: Mandelbit SRL
In-Reply-To: <aaB4z_A4aTqirDGb@gnbcxd0016.gnb.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4fMRpq6JCKzDryh

On 26/02/2026 17:46, Alain Volmat wrote:
> Hi,
> 
> On Tue, Feb 24, 2026 at 04:25:14PM +0100, Antonio Quartulli wrote:
>> Hi,
>>
>> On 24/02/2026 16:09, Alain Volmat wrote:
>>> Commit c4f2c05ab029 ("spi: stm32: fix pointer-to-pointer variables usage")
>>> introduced a regression since dma descriptors generated as part of the
>>> stm32_spi_prepare_rx_dma_mdma_chaining function are not well propagated
>>> to the caller function, leading to mdma-dma chaining being no more
>>> functional.
>>>
>>> Fixes: c4f2c05ab029 ("spi: stm32: fix pointer-to-pointer variables usage")
>>> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
>>> ---
>>>    drivers/spi/spi-stm32.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
>>> index b99de8c4cc99..33f211e159ef 100644
>>> --- a/drivers/spi/spi-stm32.c
>>> +++ b/drivers/spi/spi-stm32.c
>>> @@ -1625,6 +1625,9 @@ static int stm32_spi_prepare_rx_dma_mdma_chaining(struct stm32_spi *spi,
>>>    		return -EINVAL;
>>>    	}
>>> +	*rx_mdma_desc = _mdma_desc;
>>> +	*rx_dma_desc = _dma_desc;
>>> +
>>
>> Thanks for catching this!
>>
>> Indeed my fix lost the pointer-to-pointer logic, which was needed to pass
>> back the computed values.
>>
>> This patch looks good, but at this point I think you can also remove the
>> lines:
>>
>> 	_dma_desc = NULL;
>>
>> in the error paths above? Setting them to NULL makes no sense as they are
>> not going anywhere.
> 
> I agree that those lines can be removed. However my feeling is that this
> is not part of this fix since this is more about removing useless lines.
> If this is ok for you I will propose another patch on top of the current
> one for that purpose and without the Fixes on it.

I agree.

This fix gets my

Acked-by: Antonio Quartulli <antonio@mandelbit.com>

However, I'd let Mark (the maintainer) decide.

Regards,


-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com

