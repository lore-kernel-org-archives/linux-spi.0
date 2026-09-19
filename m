Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ED4358367;
	Sat, 19 Sep 2026 17:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789837351; cv=none; b=sTiuGcHBZz/Ejl/G0oLekzQAgtFceLMPbeEKfLtjxSOaPp1842n9wPJYiykZuXgDTcoaKy5bkfe34OEc1J961mA4C7RmWcSRFMvAVvp2r8AsQl6RHfCXEjTl6T6/l+dxeEBIlFtbqdBs9jUzK9D52xqBn7D+pGpAGU6cFch1vs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789837351; c=relaxed/simple;
	bh=3e2azH+DoBq+36Da4VBKD14uza4GZ9oThp3l566SIk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvuYxPgh/h3afJIpl5wi9C4uvT+sPxp+1piuBwJwY6RM+tM8Bz+Zu4qkz1zfCquKwYFBFnasUAXwH1ZmxiuQIyNZd0C/HOcY4kWpNBM+kIBaoNUAnC5fOSfPTRLI9eVF/EqO9FW0TLyTMEB2eRvY8UB5xYJQQ1WLGbO+c9WeF68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jonasjelonek.de; spf=pass smtp.mailfrom=jonasjelonek.de; dkim=pass (2048-bit key) header.d=jonasjelonek.de header.i=jonas@jonasjelonek.de header.b=CmKkWRuW; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jonasjelonek.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonasjelonek.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jonasjelonek.de header.i=jonas@jonasjelonek.de header.b="CmKkWRuW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jonasjelonek.de;
	s=s1-ionos; t=1789837328; x=1790442128; i=jonas@jonasjelonek.de;
	bh=U4SmXvV172swQGHXPqsVPSYVArKHf0OZgMVFWw/18jE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CmKkWRuW1/JZR8nVF/hgui5hysfrE1M30OsnUqPmbD6tT/OftNCKq6DK2XkU4SUy
	 Txw87D4X2NWA7C3zMMytymZsp/ywTENNAGw3BKBrfZVfiENl2jHbmkBQE69IxlXo4
	 A+nRWbe+j0KbHWIED0heYrkP7rXbuP4U5OVg15B/olofx70sNdIKgSCJiAgN4UKrs
	 6+KaolXjbj4OrYHMTuE8zN1Z+Iu5HwfNDuP9EEKEYCjUhFnUgdG7DJoXlkRPesD+4
	 r4seu9CGpzCyfRryOu3JxtOLdyA66WmlcVJjQQZ6wcCK408XoflRZ8PKB46U29X6U
	 rBiBvT08id/GpltYRw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue107
 [213.165.67.113]) with ESMTPSA (Nemesis) id 1N8GAQ-1wlp0h3dMO-00tSJl; Sat, 19
 Sep 2026 19:02:07 +0200
Message-ID: <027f8dea-2661-4ece-b4f0-d772e81cc6e5@jonasjelonek.de>
Date: Sat, 19 Sep 2026 19:02:07 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: realtek-rtl: add support for second CS
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260918214740.3963349-1-jonas@jonasjelonek.de>
 <aq68SNTdUKzIm0K5@sirena.org.uk>
From: Jonas Jelonek <jonas@jonasjelonek.de>
In-Reply-To: <aq68SNTdUKzIm0K5@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:PrQKRlp3fAOg8/gDDk9yfjyrBEzFu9UzR0dsWCGLlORGNXuWRsN
 +bi05vs3il+lzqVkWAcuyhH9TuzTnj1EoQgqjn6xMUhhSJ+5zNsrhuyEEi05bog59gHiOi+
 NJe2me/CXUQQ1T+I7QmdD6tBLeDBClVYEsUNVwVQxLBKe2ZMbEeBZZydBlU5It+/Ru/qql/
 OSB9WkczYUoLT4+YfI9yg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2emmWZEc5gY=;IDHloUwQijANXdJPz83pFshWlEO
 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

Hi,

On 19.09.26 18:46, Mark Brown wrote:
> On Fri, Sep 18, 2026 at 09:47:40PM +0000, Jonas Jelonek wrote:
>> The initial driver assumed that the controller's second chip select was
>> vestigial because none of the devices examined at the time used it. This
>> does not hold for all hardware: there are devices with a peripheral
>> connected to CS1. Since the controller only advertises one chip select
>> and keeps CS1 permanently deasserted, those peripherals cannot be used.
>> +	/* CSB0/CSB1 are active low: deassert both. */
>>  	value = __raw_readl(REG(RTL_SPI_SFCSR));
>> -	/* Permanently disable CS1, since it's never used */
>> -	value |= RTL_SPI_SFCSR_CSB1;
>> -	/* Select CS0 for use */
>> -	value &= RTL_SPI_SFCSR_CS;
>> +	value |= RTL_SPI_SFCSR_CSB0 | RTL_SPI_SFCSR_CSB1;
>>  	__raw_writel(value, REG(RTL_SPI_SFCSR));
> The original code would ensure that all bits in the register are
> initialised to known values, the new code sets some bits and leaves the
> rest with whatever value they happened to have previously.  Probably we
> still want the initialisation of the other bits.

Yes, you're right. Thanks for pointing that out. Indeed, bits setting the
data length and the I/O mode sit in this register too. Zero is required to
have one byte data length and single I/O. I'll fix this in a v2.

Best,
Jonas
