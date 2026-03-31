Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236601632E7
	for <linux-spi@vger.kernel.org>; Tue, 31 Mar 2026 23:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774998363; cv=none; b=Geu9J/tbwpwC9691l9F2s05OD0D2Wn0Gps7QQIRG7YQQZkL6VLNz/1qXyE6PAWrq15jM7CjAlWZz44FLu4L52sgoQWUSBaxk3pdAIGRq1Kiyn3Uq9oSG/P25slz3cTDmco2L5ncNXGCX74QzMwQ6qMPsrAxsZaQ4x90xgtduL2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774998363; c=relaxed/simple;
	bh=MoPK2dx3HsEGervefe/L/06Az4MP/K3Ebyebk2PUdgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B3aRvGvBGvz3gz6b51Mn0nTkoSYQ1LMSIAxZQb1nq9lvnC0hYqKaZSTgJ+Bh3F7kvtHu+QsnAiWjlTjZsV65BDmLhEhhFe1xgzaQJs46s02U2MZF57NZXLS6wJjPdT/zz6hSNQZsF/fj4m4BH061acDaTWF9Q44I12iFDy6ij98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mind.be; spf=pass smtp.mailfrom=essensium.com; dkim=pass (2048-bit key) header.d=mind.be header.i=@mind.be header.b=YX2CYztQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mind.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=essensium.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mind.be header.i=@mind.be header.b="YX2CYztQ"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-486ff201041so61313845e9.1
        for <linux-spi@vger.kernel.org>; Tue, 31 Mar 2026 16:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google; t=1774998359; x=1775603159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WBT7E5vy18DuNxSA2pNEQ+lsV7Li4nwoMn6+2NbFFBU=;
        b=YX2CYztQzeG8/pWn/+mo+monp14WjJJqbfrw1k10dMwIXEl60sbm/wua4wuA4hRfyw
         FNl78sjq7uN4tGLgMzo4L+EZZ+vdinXMP8HiNz/q0EiasElUfu82ROV7JT6srIyXeQqo
         9cunZYSOBf/gPpD+QqMo0OuTLg9Isb1BG0ao8r6ocF5dW0RqNHN9AbEhEtTbBJjBt4DU
         tP0dLnb4qacJuzYLFpeHBrNE0kS7ImpV/Jljf9p4h3V8EtWktqzpPYml08FOMwheu8Sz
         PvCJfUCgODRoACNeGW5fPuUBVCZhTx8WUFIQbkgaHKWxPbwSJuJ3ctkpjBCyLqU+VG6T
         YyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774998359; x=1775603159;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WBT7E5vy18DuNxSA2pNEQ+lsV7Li4nwoMn6+2NbFFBU=;
        b=mMydMRsPx2PWJReAO+82kxnAJapkuc7uaypPFk8yCddknUu0mNJJgd9A8d/jZQCqUR
         Fe0EhxaYISwzFal9KjecdJtpl+6weAMHs68n8d9PT2EEvwWRSDw6OxzImbP2SdMG6dlh
         RmaEzUmU76VFeNawlroErSw6wZTcxXsMYG11QRq35yYwRyqb92ELvpdJkcdffBMFwmXV
         nYQ/1AoZKniRz9Rf/gloM5NSv7vuBXkbL9wwZckK6B3cdnB/SA2xvnbdYgOlSJiZBtxV
         vkbEhXXtg8QSq3aWcrncfO45uTMLNhKHr7oFdZVsG1+Y5kzJNpm74WSi/0RX10XqcxFz
         Y+qw==
X-Forwarded-Encrypted: i=1; AJvYcCX/9eufnsYr6TiBwUdCcnJP+VOAzPs3UwJMp7rfHGNaRxewcoSAwB3+XzWOsk50sHtkZYHtPA0y9ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBYIZuJmHXzFa4QR2WIlQly/wfaUEnLboR3c+BbeFybgb4ROU+
	4Aqn4dQFloRJmeDF3xlCBPZydkbkSycGFjleEkkOdMhWrC1qXU+CkeSaHxSvl/HM8/E=
X-Gm-Gg: ATEYQzxXm8s73P4NS5Fpw+2lINO+k9a4WlVFUzOPbpRkX4j26emqryukpe/dt8ijD1q
	kvhzpQAqFvMw69Q0b68gD8wYYYWTZz9CyMORkZ8pyQUUog9361ulFTbQ3qM6Ufb3y35cb5eyjL6
	diVUzKXeAIr10E+raDFvsFxQ1kl7Va0kxxvA2WGUzHtrrvz1O/h97zSl6o32beGn5ohB6l/IM+Y
	6LQ/e5aVfDVumL+xD9/KhDrMWbTQv7AEjCPmw0gUiYbbGSei2yEwVetDT/ztCYxgkb7eRtOVVvD
	ZDO2nYcW/Lpqq+PsGTWOREX9PVcMuPUQFyNZeKrVTuzN3+aZumdWeSvl3i8xkvNBcqkqyHMhZX8
	4zS0riIVrF2QoCd19XdgIqDFuVveJjDJqwuuePY1u0LsgxTIGZu5UNQLyPVZCUzmpWeM3FWCjOo
	hAH+Cn2FPm+LDqA0kOxxo11qwRttYIQhB2qLUcBhTwdGaev1TE3lP0qKf+3eqcxwVyPc9jEwqV8
	gJRHDho9A==
X-Received: by 2002:a05:600c:4fc5:b0:485:445a:87d1 with SMTP id 5b1f17b1804b1-48883562a3cmr19738775e9.8.1774998359216;
        Tue, 31 Mar 2026 16:05:59 -0700 (PDT)
Received: from ?IPV6:2a02:578:85c6:1101:1ab9:445:1169:11e3? ([2a02:578:85c6:1101:1ab9:445:1169:11e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887a630922sm107306355e9.0.2026.03.31.16.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 16:05:58 -0700 (PDT)
Message-ID: <855078f2-1b43-436e-b06e-4fa38782d2a3@mind.be>
Date: Wed, 1 Apr 2026 01:05:58 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2 v2] spi: add SPI_MOSI_IDLE_LOW support from device
 tree
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260329125725.2984756-1-charles-antoine.couret@mind.be>
 <ack2dPiLpO0uE2VE@debian-BULLSEYE-live-builder-AMD64>
 <3a9dc8f9-0588-44ee-97ba-3a248d4f65dd@mind.be>
 <acl9lhyuDdugUSSP@debian-BULLSEYE-live-builder-AMD64>
Content-Language: fr-FR, en-NZ
From: Couret Charles-Antoine <charles-antoine.couret@mind.be>
In-Reply-To: <acl9lhyuDdugUSSP@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Marcelo,
Le 29/03/26 à 21:29, Marcelo Schmitt a écrit :
>> For example we used that to communicate with TI DAC161P997 device, where
>> "IDLE low" setting can be used to detect when the device is really powered
>> or not. But this is an optional setting, this option does not affect the
>> rest of the driver.
> Can't that be done with the existing support for idle modes? E.g.
> 		spi->mode |= SPI_MOSI_IDLE_LOW;
> 		ret = spi_setup(spi);
> 		if (ret < 0) {
> 			/* No controller MOSI idle low support. */
> 			/* Can't verify device is powered on. Return or do something else. */
> 		}
> 		/* MOSI idle low support. Verify the device is powered on. */
>
This means we need to hardcode the behaviour in the driver or to add an 
extra setting if we don't especially want to enable this.

I agree with you: there is always a way to deal with it without this 
property in the device tree. However, I don't think this means the 
property in the device tree is irrelevant.

Regards,

-- 

Charles-Antoine Couret

Embedded Software Developer

+32 488 27 56 40
Website <https://mind.be> • LinkedIn 
<https://www.linkedin.com/company/mind_essensium/> • Newslette 
<http://eepurl.com/h-gy7v>r

