Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66C2328243
	for <linux-spi@vger.kernel.org>; Tue, 19 May 2026 18:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779215749; cv=none; b=rg6RE556DbveDhOUNW33co0HYKUb+rj10NuJDJHjPCDGhpmDzvpcdp8M2VNDkrCNwBBy7as4ESxv5k+K9woAnpI2z62ylV//IivtlXSVrOj+ZipzlHcoQA8zm7cWaq7PHLrp8Q/xfUk404z9MT7dQvWaG45Wf/QVnGfxoBvq5Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779215749; c=relaxed/simple;
	bh=V/1kSte5MdXY2nTvYP71U2FTwXj4oAI3fWfyHE2JJTY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JY3s5sM9wI9liy4yOF8Tci4T9NDUFWkEr5q6d782wqBorkJ5op8nI7LzA/R/F3m7udV6BSEsfohHMFK69eTSBtBCKOKQonPxv4nGm6uBYoOTK6vDmgfrv2bgKKbjOYH/Y4u5C/TGwZ5Uwgujx7zv+p1zdxcsMrroSID/ODXePUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5pWf0C1; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5pWf0C1"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4526a8170ceso1833710f8f.2
        for <linux-spi@vger.kernel.org>; Tue, 19 May 2026 11:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779215746; x=1779820546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+0I9BOXJckXeN6zN476/tUPeM564YJRs3eJwkJrjuw=;
        b=B5pWf0C1VoLGLEtZ4s2ClZHIKkkIkyybrNNq49tR2ViKCPC68QgejZtwrco1MNgbBv
         eqdBIsOODKyxU3kDN6Rn+el6t9dqZrYfG/eBsx/HrjaTwnVzqv0aYvM76wDcgUb6zszA
         zANWzkx2bAFs027LMTGVxX5EBMV7TXeBXP3Y8MtUoRcINcWVII7n/kmDWdGHg57PAi1X
         XgUq1rU5REOHYrnOXR71Gy4gTGc2XuxsIOYMMTnxaX6Q06TzidarJTk89ipRrncsN+xq
         o5HJoE9RGvcCKogoRVj0JsEkHoLZzrdN6uMXv5EHAFcVm+qTLAQUDdDaVqDXwt8UQus5
         2RXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779215746; x=1779820546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w+0I9BOXJckXeN6zN476/tUPeM564YJRs3eJwkJrjuw=;
        b=GTOG6DpfiRMCNi+OSRpvqeXz0it/NzsMuCX3HJzrQxJVOOvn4KsoB1O0x8BkLW8Ti8
         JghifpfUS3qufuCYnMdLoELrrdAu2EvFdXtdVaqbA7QfbvlLQzy+Ynymlz61sC3XCqy8
         4UAtoTQR+b6/bnD3MoCITZgjJOTHv5EVtat5svn8Bi7JHJv/D/TINXsY3IDBqw4Z1jnn
         UTpLqfekdf/6sJx7ZYN7psgAa2WXi3ka8nPlXTmR/48h82izRa3rUtzk47WNob2Ns9YQ
         yVNrpuxP4NrHmDAN2gH1gB96HiNawPfyx4kG/1FW27LwaSnlZRzlfGOkNvVLs/+oAIRp
         sTAA==
X-Forwarded-Encrypted: i=1; AFNElJ/m94+9lvD5phb+WbU5dZpuLc916k5EmnOrKq+mMz4c/swpu++6t09dRabVO8G82P4fvhwsPSdns24=@vger.kernel.org
X-Gm-Message-State: AOJu0YywkQqFDnc7vdpLS9Ioc8hCBP2DzGfFAwQuuO4fwNHy5+F9t4Ep
	9wW3ugJ6aG6h2kGkHBoRPLAZDw9H8pBbWR3MlL2jD4820VPDknGvB9df
X-Gm-Gg: Acq92OEUE8ICXtq5ORmQpkcJRXsBn/v97Ao9PKVQ0sa45LzFVCOy8/lbsRdYMDsEoch
	fgY+6cpYJsLJBDx+rHoFwH3G/n6pyRs9sNUvAgAQtrRV0VG3TQbW7sMUyHXNuDHC9di+bQfEWlZ
	oF+oSIhDITzgNoVCDaopuJEW4RNFhmbhBpgz8pKCzlay927wOAowYBTeE3sb1Y4t3GB7aSZWrBH
	ajHuMQSCJVcViKH3CWOAykDEIdXmsfQw9LEfX2QRn0ft6xlcFnjJNc2KMKgl3TBdfComQxLrU8j
	e8OO/8cykjXY/rZ125D272yfPU3+IMJ3Nm0xCXPjZhkC9jclWCC3b8LqW1Ckcx0WIJVr8BYzqdD
	LSLGNHlUZ5duU/yN+QmvdYFl6QGMIC7Z79wxcAGTRqFgK9USY7wImuFydEsScFeVgzt1yFiXpur
	X8bBzsKwmXUAG+xvdK853sCLLYQvuhk93hlUFAcdYGn2+QwZz+sfX5oXWH06WDL0s7
X-Received: by 2002:a05:6000:2dc2:b0:43d:1c4a:37c with SMTP id ffacd0b85a97d-45e5c5b39admr33684542f8f.4.1779215745802;
        Tue, 19 May 2026 11:35:45 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a1a22csm46667168f8f.19.2026.05.19.11.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:35:45 -0700 (PDT)
Date: Tue, 19 May 2026 19:35:43 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Peter Collingbourne <peter@pcc.me.uk>
Cc: Mark Brown <broonie@kernel.org>, Christophe Kerello
 <christophe.kerello@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Boris Brezillon
 <boris.brezillon@collabora.com>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>, Ville
 =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Simona Vetter
 <simona.vetter@ffwll.ch>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] iopoll: use udelay() for initial polling
Message-ID: <20260519193543.18f45af2@pumpkin>
In-Reply-To: <20260519102446.209723-1-peter@pcc.me.uk>
References: <20260519102446.209723-1-peter@pcc.me.uk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 May 2026 03:24:46 -0700
Peter Collingbourne <peter@pcc.me.uk> wrote:

> A short polling delay, such as the delay of 5us
> (SPINAND_READ_POLL_DELAY_US) provided by the SPI NAND driver,
> can become a 1/HZ (order of ms) delay caused by the usleep_range()
> call in read_poll_timeout(), significantly reducing SPI NAND access
> performance. Fix it by adjusting the read_poll_timeout() macro to use
> udelay() to delay until 1/10 of a timer tick after it is called, and
> only then sleep.
> 
> Fixes: c955a0cc8a28 ("spi: spi-mem: add automatic poll status functions")
> Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
> ---
>  include/linux/iopoll.h | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
> 
> v2:
> * Fix it in read_poll_timeout() instead
> 
> diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
> index 53edd69acb9b..2ee89b76f072 100644
> --- a/include/linux/iopoll.h
> +++ b/include/linux/iopoll.h
> @@ -19,9 +19,11 @@
>   *
>   * @op: Operation
>   * @cond: Break condition
> - * @sleep_us: Maximum time to sleep between operations in us (0 tight-loops).
> - *            Please read usleep_range() function description for details and
> - *            limitations.
> + * @sleep_us: Maximum time to sleep or delay between operations in us
> + *            (0 tight-loops). Please read usleep_range() and udelay()
> + *            function descriptions for details and limitations.
> + *            This macro will delay until 1/10 of a timer tick after
> + *            it is called, and will then start sleeping.
>   * @timeout_us: Timeout in us, 0 means never timeout
>   * @sleep_before_op: if it is true, sleep @sleep_us before operation.
>   *
> @@ -35,11 +37,18 @@
>  ({ \
>  	u64 __timeout_us = (timeout_us); \
>  	unsigned long __sleep_us = (sleep_us); \
> -	ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
> +	ktime_t __start_time = ktime_get(); \
> +	u64 __delay_timeout_us = 100000/HZ; \
> +	ktime_t __delay_timeout = ktime_add_us(__start_time, __delay_timeout_us); \
> +	ktime_t __timeout = ktime_add_us(__start_time, __timeout_us); \
>  	int ___ret; \
>  	might_sleep_if((__sleep_us) != 0); \
> -	if ((sleep_before_op) && __sleep_us) \
> -		usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
> +	if ((sleep_before_op) && __sleep_us) { \
> +		if (__sleep_us <= __delay_timeout_us) \
> +			udelay(__sleep_us); \
> +		else \
> +			usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
> +	} \
>  	for (;;) { \
>  		bool __expired = __timeout_us && \
>  			ktime_compare(ktime_get(), __timeout) > 0; \
> @@ -54,8 +63,13 @@
>  			___ret = -ETIMEDOUT; \
>  			break; \
>  		} \
> -		if (__sleep_us) \
> -			usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
> +		if (__sleep_us) { \
> +			if (__sleep_us <= __delay_timeout_us && \
> +			    ktime_compare(ktime_get(), __delay_timeout) < 0) \
> +				udelay(__sleep_us); \
> +			else \
> +				usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
> +		} \
>  		cpu_relax(); \
>  	} \
>  	___ret; \

How about:
#define poll_timeout_us(op, cond, sleep_us, timeout_us, sleep_before_op) \
({ \
	u64 __timeout_us = (timeout_us); \
	unsigned long __sleep_us = (sleep_us); \
	ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
	u64 __delay_timeout_us = 100000/HZ; \
	int ___ret; \
	bool __expired; \
	might_sleep_if((__sleep_us) != 0); \
\
	for (;; sleep_before_op = false) { \
		if (!sleep_before_op) { \
			__expired = __timeout_us && \
				ktime_compare(ktime_get(), __timeout) > 0; \
			/* guarantee 'op' and 'cond' are evaluated after timeout expired */ \
			barrier(); \
			op; \
			if (cond) { \
				___ret = 0; \
				break; \
			} \
			if (__expired) { \
				___ret = -ETIMEDOUT; \
				break; \
			} \
		} \
		if (__sleep_us > __delay_timeout_us) { \
			usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
			continue;
		} \
		if (__sleep_us) { \
			__delay_timeout_us -= __sleep_us; \
			udelay(__sleep_us); \
		} \
		cpu_relax(); \
	} \
	___ret; \
})
Which I think is approximately equivalent.
But I'm not at all sure the usleep/udelay test it right.
100000/HZ is a strange number of usecs; for HZ=100 it is 1ms, but for HZ=1000 0.1ms.

Maybe it should be more like:
	u32 __delay_timeout_us = __sleep_us > 20 ? 0 : 100;
so that you delay for (approx) max 100us if the interval is less than 20us.

The is also a mismatch of long and u64.
I don't think anything (except the time_t) needs to be 64bit (esp. on 32bit).

I'm not sure about all architectures, but I'm pretty sure than on x86
usleep_range() is independent of HZ.

-- David

