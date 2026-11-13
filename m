Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583227;
	b=MrSznyph61XbgXo8mWtkms3w5C7R1Ig3yIX7vZImfrPcdrwuGbY918kQXVPTfur8YmXp
	 Puh/aeYZ3sOOfxocoOPPDVLO3wPuSuIc1k1Xt2kDMjM3BrVL7UpPj1ubrUyvHsXaI5zMG
	 OiPsUgZrU3YnQMeuzzbubxnkr7Fze1pX4GC4M3CXr/0FVC4BUEaBTgB2corlU/8wi/TrY
	 0eWlzdTCH411G1iixhwp4Bz9H8mTxsDx7fznWfXGT8Ni1dgWDsQeOvaobtW9gmYsRI+Q/
	 yQSpSrMcreofT2ZmtJbvFLE9f6in08pOXQKz6G9ArFQxZ9pXj+9q93deUWcelTNIk8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=QJq+GUc6PAR3xy+Pfkqz+19LZE/YeqLmKaLV5oi4iko=;
	b=VKraMM8mLZUBf7DcA7DxV6nQzmkQjbEqfS8Bs4j0eONYb4eZz6FPeJQKsxnHhGknJ1P5
	 qURn65plvtWOnRpf817ZYgKOGj4qUXeOx2Ms5cKHi7Ey3VNkVIlje8VEhDSpNbZNTbSPj
	 Vc/CnYPvUMHUaK9/vEMu+C8nZFDTMPNf1saTONFJnHdrfqnpXZ/03+wLZY78rnRjtpj7b
	 pC/TYpTXfPspoVRX2TGSEISCg2Bv5F5SbCVthbUzHHAR4Zd2bR9d2ZinqOuvbh/WNiiHK
	 74fVY6CG6zlK3xmR5f9xlGazZYBkKq2dO1J549Dw1TaZAbHgcWKJHzF3a9abtPKesrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=NnjU6d5V;
	arc=none smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58404606A896
	for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 15:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58404606A896
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=NnjU6d5V
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6f74f6b46abso1265723eaf.0
        for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 07:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794583225; x=1795188025; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QJq+GUc6PAR3xy+Pfkqz+19LZE/YeqLmKaLV5oi4iko=;
        b=NnjU6d5VxM7A0+O4guD0V8fANOGIUq+iGf3jiYWrUO8W0bs9Y90UbrZhLlkWFpHJW2
         r+BfTji7EQkDUffbPgCw3SB3lRIl66kt/GBWpF5/sBULa1TCVPuFwubp16ZHonT1+mMY
         U77t3R3OpIp33QNWWn6UJmgljvsaCZP2yA7MYTykh/Kw+QxN/OrOZVjiNDi4z4RAHXPV
         i8dDuP3eRItU4MQ5XYXc/HdVjf9q1UqhxPAb1IXs5p4aVzMacS7F71GMeae5upCHZR3Q
         MriSbLqAcPOe9sNMQHZqwn5MW80lzKIYQ9bjbvMBq6tu0sz9R8TTHe2r/VreYnkKPPq/
         i/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794583225; x=1795188025;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QJq+GUc6PAR3xy+Pfkqz+19LZE/YeqLmKaLV5oi4iko=;
        b=frL6Qaro6lIreseBdE1F4FRMIVmjaOP2oclbQH9BOgJfV72nO8be7PH8D2ZrJ0eoFD
         ft4vX/E9nuz77yXZw6Sk7F5z+a9HNYbpQBd54BsnqTjNj3n5RG3hcINuKfHQm44aU1fq
         zwT1UY1MG8FLLFFkjzBqQyLfBu6qAH8S8x3B+hY7V+Viqp12JlzqDnhF58DbeQJoSS05
         KWcGrnTuvDihJaMPE7B16lL1YxT19Zx1hLachPgXoGVPH2+MunyrIomu5TYMNEzbzdBs
         TkmQO9S9w5ss/m+bnLXaqSgNvGx3o3E6zKtOQldFRUX3efU6yT70Er/125aZSWblZbSG
         C6TA==
X-Forwarded-Encrypted: i=1; AL+hErEd74HRuf0tkF3fpVbCHsxIeQy4qHdyUoul5SnZRcvN8/Qrib41Big0jJwfcyQbyJ8ZhYFMyrVhNpQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z94QtJe78DvBcC8Y5uYhtmBI+7hbX8VCLc++CPFPllabeIRfbbw
	e3f0wCQhnuBdXhZiOi/H6ElBIj63Pb8ojx1yYi7Jw7km+WMe8PGWhxaNHpZxmKdhrXg=
X-Gm-Gg: AYBFou1Tqpp35LiUxOW4TQnQNez3NxghJbr/b02uF4PB4AAYjNuBDg3Iw1OO3UwtmXk
	gEqyStkTA6z9SztKAu7/XxFmf9p20YhbJTL/q2luU0NuY7HACanw48IxNi5652VwzhRP1Zi7uDT
	qsnQg2gEknc1CZxIbT1BZLAt2RpksWlmJH4Tw3ohPqmyZRtILt9zaxlymIKbgz+1OsMobXTAkrg
	lyvKy3DaE0eT0GvyMjoBk+OKcVIXutslczJ7nRdG66bvIvRTUiAeWAAUQGOcvlhVzgTmW93rerA
	VI6zzqCNYuA4/TxyFyQcyro+/mxAy++Ul/BgAVL1in+VrwKNTc79CfCUk3Ev17Yza45ulVQs2Ve
	sVRDWgFjMo1+fu30DMTRbM8AsnSZ30xt7/7zYkCZ05xgSUxS0SdWbGf/2/9l6cWf9pgvK8YSMr6
	hgjkKzkPqcYZzLe/KYgjizT/cRlGNFCDJMeVI/zmKRsOEvXo7nzBfJt5a8g1PomVPkxpn6uQC8e
	d94AFT2zMawwu1iG3t6mNCs32jumCAV84VdGu7Ex2Sa2qzD2whhJl3FcaLAHXtNvOMiUiHKjLa2
	oZb4Lzz7bQoHRvX17vaRqSd3EkP4Ak7L2+II/hLedl4ggfu4H5B/pmqbRJKqEfmi5frLsLIKVkc
	Ytag=
X-Received: by 2002:a05:6820:55c6:20b0:6d9:e2f3:9b51 with SMTP id 006d021491bc7-71ab5084396mr1064228eaf.66.1794583225149;
        Fri, 13 Nov 2026 07:20:25 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:fb76:8640:983b:6899? ([2600:8803:e7e4:500:fb76:8640:983b:6899])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71ab4338765sm2019311eaf.14.2026.11.13.07.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 07:20:24 -0800 (PST)
Message-ID: <06f0a178-5d98-4c6c-b596-c0eba8ae9234@baylibre.com>
Date: Fri, 13 Nov 2026 09:20:23 -0600
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: axi-spi-engine: Start the program length at zero
To: Kees Cook <kees@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Mark Brown <broonie@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, linux-spi@vger.kernel.org,
 linux-hardening@vger.kernel.org, Dennis Gilmore <dennis@ausil.us>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261113065508.i.606-kees@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20261113065508.i.606-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/26 12:55 AM, Kees Cook wrote:
> spi_engine_optimize_message() allocates the program with kzalloc_flex(),
> which sets the __counted_by() counter "length" to the allocated size when
> the compiler supports __builtin_counted_by_ref(). The program is then
> filled by spi_engine_program_add_cmd(), which increments "length" and
> stores at length - 1, expecting it to start at zero as it did when the
> program came from kzalloc().
> 
> Reset "length" after the allocation, since it is a "usage" counter, not
> a "total allocation" counter.
> 
> Build tested ARCH=x86_64 defconfig with CONFIG_SPI_AXI_SPI_ENGINE=m and
> W=1, with GCC 16.2.0.
> 
> Reported-by: Dennis Gilmore <dennis@ausil.us>
> Closes: https://lore.kernel.org/all/20261112025252.71375-1-dennis@ausil.us/
> Fixes: 69050f8d6d075 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>

>  drivers/spi/spi-axi-spi-engine.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
> index ead5b295e680..9cfee409f15c 100644
> --- a/drivers/spi/spi-axi-spi-engine.c
> +++ b/drivers/spi/spi-axi-spi-engine.c
> @@ -818,6 +818,8 @@ static int spi_engine_optimize_message(struct spi_message *msg)
>  	p = kzalloc_flex(*p, instructions, p_dry.length + 1);
>  	if (!p)
>  		return -ENOMEM;
> +	/* spi_engine_program_add_cmd() counts the instructions as it adds them. */
> +	p->length = 0;
>  
>  	spi_engine_compile_message(msg, false, p);
>  

