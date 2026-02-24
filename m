Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF3A3A1E88
	for <linux-spi@vger.kernel.org>; Tue, 24 Feb 2026 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771946719; cv=none; b=OXqIj+MWhcyfSKcGwVk6VI6Az4I1P7J9FhG1L+qWdcKJFxpUqhZt/OgTYUXInUyj39FZG0C2h41G+PerY7Uxb0ed4z/zVg+/CGeEFW3+WEx8FyyDM04PVGJl93qzECo9cOo8TxFL+pvxK1fO+J+FT8JYMdrXhr7MA+XP2D2TY1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771946719; c=relaxed/simple;
	bh=GZYAv4SjXgHbPIer5FgzJDRYE/MaCP6Ap9oV9Pzva1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NbUNvZmdMF+tgi3jeEERW+naPe5wAzoP+aeNqKympeDX/VCCorn5Fz3dfaBicyh3D8OLbpAUa4PrDGz4MsPgEmM/6jhg7zubn8XPLxSXTxpJT7D4qYE4p/peh++rybW8NH1vdvtsFTdkkVR3Tm00sIAj4wyR1GrJQsG9f/NqFcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=SRbAktIC; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="SRbAktIC"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-4398dd671daso37487f8f.0
        for <linux-spi@vger.kernel.org>; Tue, 24 Feb 2026 07:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1771946717; x=1772551517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P27+Z4Mn3VpUEFcO0AEZzb62/MrR0GaThwrhuZeI+7o=;
        b=SRbAktICjg7KTyF3+jJEnZr8ALtsn8s/hY/E8JKxtsOIdFAnK28pdpEpq6Y4w81KG6
         tNNrYyabDHYHtWMGzdYJha5i/TzQq/REWbKf9Qx57ZSuyGLPTX69fB1qWpOZdOxp3ded
         AdMbwSsDLqGkGvAsq5H8obDbUrwI7bV5XR5uDaIqStnFoo8CRpDPDlQyRXmJPBCRyiFC
         Kqv4YY3JhfclLik8m9c6Bvt+jX+VdW2iHb5pDy+elZy9FrRn6XIFMPg9hUHmyatIjuUF
         hMoD+0q6Ayr3mW1dS9sPRbtU6fsI/xYl2QjLRcYehHFnniJZLyeWEyBZAgyv+xwhrquD
         /tGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771946717; x=1772551517;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P27+Z4Mn3VpUEFcO0AEZzb62/MrR0GaThwrhuZeI+7o=;
        b=tCdj2BiHrdQZn2y0qTQVsmTLAezROX45g2/Np9bYGwtmHczKgxmhbrJm5D4+jcTx6w
         mvGQDSZNPieTaWbl8QJBedXOVeG3HT/VgBszweH40RUhHybj8WlyJe7L5nDUjvYaZXIN
         BqE0HGgduRaHF1hpTPRDbKA31PkQe7XuPRlxlfrUZnZtvIY3AHrMnAVmJgp+cMldZARo
         xgGgAebAONrlQN22iiPGUUM/B88T1zsSsVB74AhN0wQYKgDB6YU4Ic3GIb8l+/f4oLsu
         2ckx8GiQX26oJCTGW4YhV32ThaDX/USOOHw5MemrFD2CI21qU7mXVdqBkQu3BLc6W1uV
         4Oig==
X-Gm-Message-State: AOJu0YzLyKc6QPP4SoF9Wt3ZBIYGVLg7DNAWkwYfmwQsp2nISE5Ya/YU
	NRN/M0w3qrLavtGioUBcB7XEySi+XSMqllWryXqkQhUF9vRXKI0xriXnfulVoaI2CzQ=
X-Gm-Gg: AZuq6aJ5tYEj0NxUFZIokclYK509lX0tnenPhafVW7CKPm7R5Q3ufdgfyfigTF2Q5Du
	BAXDTLohbA4j26YP/v1wf4sWIWa84NMMlAr5yTRXcaPhE+AySQzwt88C79+dMjQ6RigASfWY/L0
	pIQb9Xv8JcRxwluMj4A3KeG2OXkQXlXXjatHn900LDf09MndCUFD6A5Zv94q98GEhNC50tBgXPK
	pATuNvTIIBnhvWS75W+NdsEpOOEsox2Zhwccf7uR6VjKuESr38j7BtERN8WDGQCB2MWsU5yscVb
	zqBhGjuO4vkNEL9YH0T2QPWD3AnJeyd3bE1+5rET0RAWFsqikxrRcYdi7chFgKwp7J5W2Hr3fHl
	1jboGgHaFCszyVgbLen4wT4KoaEbcTm73DpousMF4YYEU3uACerEJeSxWPIeWeb5gxpx21/0Wyk
	0sh/uoYnP6AP0GX4KHRkvnNi8vYlyaN4VX9Yi6QTmcdMs7nGeRds82aZeVFdJdZHvj
X-Received: by 2002:a05:600c:3b18:b0:483:6e32:50d4 with SMTP id 5b1f17b1804b1-483a95e9555mr240773595e9.18.1771946716451;
        Tue, 24 Feb 2026 07:25:16 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:ede2:e79a:81cb:9434? ([2001:67c:2fbc:1:ede2:e79a:81cb:9434])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd68826asm10632345e9.0.2026.02.24.07.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 07:25:15 -0800 (PST)
Message-ID: <d14f3943-b97a-4940-95dd-39c6fc240130@mandelbit.com>
Date: Tue, 24 Feb 2026 16:25:14 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: stm32: fix missing pointer assignment in case of dma
 chaining
To: Alain Volmat <alain.volmat@foss.st.com>, Mark Brown <broonie@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Clement LE GOFFIC <clement.legoffic@foss.st.com>
Cc: linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260224-spi-stm32-chaining-fix-v1-1-5da7a4851b66@foss.st.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Autocrypt: addr=antonio@mandelbit.com; keydata=
 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
Organization: Mandelbit SRL
In-Reply-To: <20260224-spi-stm32-chaining-fix-v1-1-5da7a4851b66@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 24/02/2026 16:09, Alain Volmat wrote:
> Commit c4f2c05ab029 ("spi: stm32: fix pointer-to-pointer variables usage")
> introduced a regression since dma descriptors generated as part of the
> stm32_spi_prepare_rx_dma_mdma_chaining function are not well propagated
> to the caller function, leading to mdma-dma chaining being no more
> functional.
> 
> Fixes: c4f2c05ab029 ("spi: stm32: fix pointer-to-pointer variables usage")
> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
> ---
>   drivers/spi/spi-stm32.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
> index b99de8c4cc99..33f211e159ef 100644
> --- a/drivers/spi/spi-stm32.c
> +++ b/drivers/spi/spi-stm32.c
> @@ -1625,6 +1625,9 @@ static int stm32_spi_prepare_rx_dma_mdma_chaining(struct stm32_spi *spi,
>   		return -EINVAL;
>   	}
>   
> +	*rx_mdma_desc = _mdma_desc;
> +	*rx_dma_desc = _dma_desc;
> +

Thanks for catching this!

Indeed my fix lost the pointer-to-pointer logic, which was needed to 
pass back the computed values.

This patch looks good, but at this point I think you can also remove the 
lines:

	_dma_desc = NULL;

in the error paths above? Setting them to NULL makes no sense as they 
are not going anywhere.

Regards,



-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com

