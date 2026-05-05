Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EAF39B952
	for <linux-spi@vger.kernel.org>; Tue,  5 May 2026 18:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778005276; cv=none; b=oSg4iMAy6LKyJnaVvdJwLsosiNMIJozixYsg+3qx6CwD2jDy6P4KPFJTZ01L5x9yMaexJl68EkW7gqk4GeFLUXCnPAkAQwi8sVxr/qMGX+nLEqoSAJa3ijN4sr4FliHvDaenqW0E6lTg/5qKYPbvVr9fCyyJE7tSzvBa+t+gTgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778005276; c=relaxed/simple;
	bh=w+Ioz1tjQWfX92hV7FphRnIAnvcQ0m2pdhQNSWwnwV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WIAML2Iya0VrEkagsOqrOS9DivNkGKTFJw0+xkXKaZsLkrP/q3XBq0jTqFDQHIQBeOWyNAF84DutSx2xw/Dy42uSajHemBf/81EHIRfRawNNafvEuX9sHRpi8K9h8/6ufyDbyPDj9OsNBxPXOHqA1i1JRsaiaCTdNf6IjkrASz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=bU5WybME; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="bU5WybME"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-56f75445470so3338397e0c.2
        for <linux-spi@vger.kernel.org>; Tue, 05 May 2026 11:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1778005273; x=1778610073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4PAwVM1Z+cNq31xz020hTCHt7IsL4VWpTOpbAV7HgmM=;
        b=bU5WybME6KzgnmW4VasTCdV6LOWACloimDSnrSmsFU1i4ReJgTE5e6hChWOpyyfPq/
         C7KQJReEDXQwB7Dk6jSfa3vrpCQTy3KIiZ3DDue+uNrjnX223XMfUhPMp+fwUDGNwu+P
         8y6i0lms2GM5oadY8lvgZ2aQ6iy7cG/nf/rG9eP8o/p14hu82AW20OnvQwetMOjpeR1F
         elWWO6YXgwSxdsmx6x7m1CAT4ONh7nUB/fhlNsiTO5rFtUnw8RMNRHIhPSGKJrdhmLzn
         okn7j2xS7wsuSpGHOsnFW4eL260XfVDDgOY4ySkdlCYlQCfKrDNvuUIvSTJBFdc9M40b
         Urdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778005273; x=1778610073;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4PAwVM1Z+cNq31xz020hTCHt7IsL4VWpTOpbAV7HgmM=;
        b=A6L0lZFneYFnCFBGgtp37iSJn5g3zh5N5bfuUREo3B+S+XS/UcbWSF6O2Wy1E8kEDB
         TVM3p98xJ3o/YmJvgPqH3D4p3/3V9aypJD5DGqWm3E78Sq1l2rvAoGlBEHjo67IMNfdd
         Do0tfdLxMT1mGRC7nigpuLeoAZKYdpHVU3WD3etubaQAVCSTGMSPqUw/RMv9gnt1lvhg
         laVXxxaGcnyJbKghtBGIWTWOC0RQDOgzvthnrAreji9Cko6vD5t8hq7ia5ce86YCtvee
         iVBNpYgKT8c5zxirm+jlwc8nTopSEJVtnnEH4qUTivhUpQStdKL5miROiA/SVSpkSp+d
         I53A==
X-Forwarded-Encrypted: i=1; AFNElJ+gi/R6nfs+ibK5NTzGgBhcQgZpMZ7e5L/hgZ+QZ841Gfau7x8x5WJZ1mrfOYDuyctJdZR0Q8qeROE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOxbbgxvl+DawnbY/4sT9XSsu6QWpmbWZ6BOHzX23Bd7QXTvoD
	+W4OiuPNT+ZH5Tl8t8q8PL87L/5LUpTPlFgwSLQTrVP2HNjDGaOawn6usHZiZ5qmNDbD3bEOQkN
	hBaxl2d0=
X-Gm-Gg: AeBDiesN/oVTT+7xgp7dbqXyotwCOstwHgm1wb7TGWmgPo2obm3BNQM8PAwY7iUhd8S
	cSoW9PhOKKq2FnaFF9fk82XZXpVYmxoJ5SyeLqtzTxIqivYWvhekxZSapEaIPu54GCg50puq6wf
	eYKrg8MFvl71PphnR2CNWxga3YN0qzfKoeAiSl/YtZfoJOeY6KAdAus5kz9FR/8zhc+xzUuKcyq
	bSqlxbqw6NQk4ZdwQYhWmVPlNUerdvINcKMNtYAzWmfmDDVBP33FPzBITC6eauHjLU1mGdJ2+oy
	wbAeb+SRGd0mSCwVmT9dSRlqBaebIBlNSjg/B6rRsXAINHdFCThmXr4v3My897eYHMs2jWy2dkg
	sN5eyLJ5QwcjfNAswA34OJvfK+Ws8C3l82KFtaK+6wGsP5gixRV7vw8VYOnW3txBLvWMw9MKdyS
	mBYDLLLOjWBkQpomJDgXC0ZkHuk+W2M/RFbth/YE96ZAHhqVLeVWDzyCst7cxqhIxYlf2+LJv70
	F3D7p/uXUMi
X-Received: by 2002:a05:6102:5a96:b0:611:3bcb:aee5 with SMTP id ada2fe7eead31-630f4e3dab7mr792844137.0.1778005273387;
        Tue, 05 May 2026 11:21:13 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53c0e7f27sm185778316d6.32.2026.05.05.11.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 11:21:12 -0700 (PDT)
Message-ID: <9f655145-2c97-4de0-b964-1e23ab95de1c@riscstar.com>
Date: Tue, 5 May 2026 13:21:11 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: spacemit: avoid 32-bit integer overflow warning
To: Arnd Bergmann <arnd@kernel.org>, Mark Brown <broonie@kernel.org>,
 Yixun Lan <dlan@kernel.org>, Guodong Xu <guodong@riscstar.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-spi@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260505175744.900750-1-arnd@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260505175744.900750-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/5/26 12:57 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Calculating the bit rate in nanoseconds does not fit into a 32-bit 'int'
> type, as gcc-16 points out:
> 
> drivers/spi/spi-spacemit-k1.c: In function 'k1_spi_set_speed':
> drivers/spi/spi-spacemit-k1.c:393:38: error: integer overflow in expression of type 'long int' results in '-589934592' [-Werror=overflow]
>    393 |         nsec_per_word = NSEC_PER_SEC * BITS_PER_BYTE * drv_data->bytes;
> 
> Cast the value to a 64-bit constant to force the longer type for the
> calculation.
> 
> Fixes: efcd8b9d1111 ("spi: spacemit: introduce SpacemiT K1 SPI controller driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd.  I diagnosed that when I first saw the warning and my
fix was identical to yours.  I believe Mark already merged the
fix.

					-Alex

> ----
> There is probably a way to rework the algorithm to avoid both the 64-bit
> multiplication and the following division, but I kept this as a minimal
> change.
> ---
>   drivers/spi/spi-spacemit-k1.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-spacemit-k1.c b/drivers/spi/spi-spacemit-k1.c
> index 99db429db0b2..215fe66d27b4 100644
> --- a/drivers/spi/spi-spacemit-k1.c
> +++ b/drivers/spi/spi-spacemit-k1.c
> @@ -390,7 +390,7 @@ static int k1_spi_set_speed(struct k1_spi_driver_data *drv_data,
>   	 *   ticks_per_word = BITS_PER_BYTE * drv_data->bytes;
>   	 * We do the divide last for better accuracy.
>   	 */
> -	nsec_per_word = NSEC_PER_SEC * BITS_PER_BYTE * drv_data->bytes;
> +	nsec_per_word = (u64)NSEC_PER_SEC * BITS_PER_BYTE * drv_data->bytes;
>   	nsec_per_word = DIV_ROUND_UP_ULL(nsec_per_word, drv_data->rate);
>   
>   	/*

