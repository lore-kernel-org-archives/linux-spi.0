Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795745714;
	b=wE1mqvXnZ84btPUlQ2pL/Y9eDlcDZfMfHZ0PNZD5rrB6/fDcmNibRedH1zBOciqYULLP
	 KMU/5kEY0oAAbp9uWAaUDQG2EjTIJorAlgelbrRseslGwa/lQfaLGEYHVLvgRZQEnkc1c
	 A3jvk//4OpzvYae+OMScGvU30FdNTYRwO751tYfaOs3VYksaX4sT2rjgz38TuCfAccCiq
	 eQRxToixkDZ2ZfTy40TWCVR5NTge/AVh31pcWwi89MD9Ndjlj9r6MnYuJJVDQyTiKTFvk
	 0aSWBMAFhJZuJh5oVcXOByppN/CGnKjItqecbx6lKAUYh3qBiUBuNiTEndBvnO47kLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795745714;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:Content-Type:Date:
	 Message-ID;
	bh=h1ArAbbh+Nj6+8II10ytomm7q9koo3eQf1sW7tmJxyM=;
	b=cXz3s/t8soTYe5JSorwOLYfIOBK35XzsbC/+me4R2WN3Z5aSn8rlUfm9ssg0JW4+AAJ1
	 g4HQqVoI08qdAwTbeKbLfYVgHKErjvD3mFdnVrO8wuP8jamzIZNRbh6/tD3UTQPxVVQWc
	 bXmgoIbQwqAhL0OIZ0r1kpT99ADVIHJ+8aU3sgINVLFGx+4sn15FhCpdHVtkzX4SWnAYO
	 AcyLqI2cj1+yTi+jqCTFxYUhekqGbeTgok9nccSGV10l5/ZxpEA7ua8F9nbojY/Hupa2Z
	 m0ErxktAphrioQJUqqXSITUoZwTOLVXLGFm/rHueMIv9QxJj8y386lRggFGgF2C3lKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sdsq5qhN;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA8F606A324
	for <linux-spi@vger.kernel.org>; Fri, 27 Nov 2026 02:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BA8F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sdsq5qhN
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8d2d4cdb478so45799b3a.1
        for <linux-spi@vger.kernel.org>; Thu, 26 Nov 2026 18:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795745714; x=1796350514; darn=vger.kernel.org;
        h=message-id:date:content-type:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h1ArAbbh+Nj6+8II10ytomm7q9koo3eQf1sW7tmJxyM=;
        b=sdsq5qhN5dmS7dLj4XnR8rPB3KKvR8KbIHitgjRlB7ObsgQgM4C+622YeHltjcGIaF
         zBJgLrIRJuVzPhP8rGXpv2INY7HE/mx8unNhyIZ+nMmHNkrHc7pD4huKWXoh/uo/QfZu
         8Mk4qcTbBJw5E6CWpI0LvzKm6pRdcnNwJxtN7HNfTVA4JWTHr7osJ/tfhHfe2xTUFyLA
         WH8lcSxnLDpJAfZvMfq4BE5igGr/MbDFYeBLkOQzuFc6Q1pNzCDohFPFf4Ky0CmaaW9C
         DPvN43vMLcU/VFj707tmQ4T1mEbYpTaldm+ZNOqhpMmGJQJ1EhcTsUTe4HIYgH+CgWx/
         w8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795745714; x=1796350514;
        h=message-id:date:content-type:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=h1ArAbbh+Nj6+8II10ytomm7q9koo3eQf1sW7tmJxyM=;
        b=t3bZxX7Y2Ui5Xz0ZvYff+JcZ7YpN6gsmvaovf90a0qaXbCx99husAWSEa6NKFvhVZ2
         NPt+5+7fOs6nz1V2aA6t9r7yht+/noUcqjS2n/eZ309muFcSi6SOjqwLRnzi/42uXxBQ
         5hkMDaWtcMfP9X3qrHx1kHxCloXa3b160k4IQIPy1Ok/os63lEgEAA3Oy+d+WRZv215b
         vOy3gQxawCEnr1Lp4pqCr5L7tMWDwId5sfrSO7amaAu/FeTXEI00H8obX/fC0tkqC1+5
         PeBLVX6oazLoKX65xEHolJ7qqZwhrVZMp3l/edvXktQM+peRoHeK46gYgqIcJ9c2iycY
         uKuw==
X-Forwarded-Encrypted: i=1; AL+hErFXPZUrJQAVosrhvqOb0a7/ImH5f9TTtZd/fxHCKlfXrGQ9uVURzN4GpiwtMr9KwQy500Jibb6dKHU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/8iJPOoEI/3wc1HyzN2yUY+OEIf6wl4rNbJog0iv6UasiAK3lT
	/8eTLgpLMya++J5/sJcZy8DGD7MorUXIOBsGZXTTTIGx4XAz3kRmyC7J
X-Gm-Gg: AZFdTZddDv6KDwizvg84jRjyGXd4yyYOBQVAbz4/JxFZJPW/zpezqpjcNPngWWDol8+
	NLAaivC81vG0FZs1HAa1+1kb4X6nB9nf47+CofZQ+nNq/cxfbBYUPMzGgLMTgdXU3aJbiiDUG0g
	Hz1kFRkDFS6HrpZKtP+YJcgT5l0VdN18AaRNrL1eAJTnsG+CrVQ9e2y6RSNonZuL6zpIBIN5Kpd
	7fI42D18x7jyxiIhFSwjSwdm/Glfd0NfvUxhIlVEJBaDAi47o6b9MX63XLMelvhsM1Fkby5bzCa
	+3ecjMg1FcA1XlMUx37eQmQeHu99JD0gooyBwEQyaDl5fTfdrqEINTlPI3VRebMK3CCsw25kJv4
	rmtG2YyMbnGNAKoICJ5rTEV2bROTbkwd01tid+wnNQTAB8YeuRKydqDKrwtPrCfPqDlrLjrBKX6
	M5LcC3XLr63pmA0czvyN6ffZXMTXF81s2HjwvtcnkVQA/3gdm8xXtG3j7Mn6mibwySsmVxRYV17
	/vAMFAHIIcDgKDytIyW5VL28r9Sf37XkClGxwf+CyD9a5Ly9FhpD7I28htjmUzzUQB8x1zNKqZu
	KWZhu9dHHhE6/cYmJDjouV0ytP9PGsn/A8SLXUrsEf9dnU9MVM08Cfp8E+k5ZU1Vf40M/R+xBS0
	=
X-Received: by 2002:a05:6a00:c4cb:b0:882:2b16:c314 with SMTP id d2e1a72fcca58-8c922b00017mr13559729b3a.52.1795745713852;
        Thu, 26 Nov 2026 18:15:13 -0800 (PST)
Received: from mac.lan (114-45-165-38.dynamic-ip.hinet.net. [114.45.165.38])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077babfsm11807929b3a.5.2026.11.26.18.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 18:15:13 -0800 (PST)
From: Ilia Snezhkov <iasnezhkov@gmail.com>
To: Roman Vivchar <rva333@protonmail.com>
Cc: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, broonie@kernel.org,
 amergnat@baylibre.com, leilk.liu@mediatek.com, me@adomerle.pw,
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v3 0/4] soc/spi: mediatek: Add MT6789 PMIC wrapper and SPI support
In-Reply-To: <0Af_vuU3D7JCxCsHmjyJZCQhptiOPd3Y325yrg4ufwjT3C5cz6cgJxU4CHY4qfES7Hhzcb-sxm0o7dj-diOzMJPCcw5bSyrYi5CWUNsXQus=@protonmail.com>
References: <20261126031001.27288-1-iasnezhkov@gmail.com> <0Af_vuU3D7JCxCsHmjyJZCQhptiOPd3Y325yrg4ufwjT3C5cz6cgJxU4CHY4qfES7Hhzcb-sxm0o7dj-diOzMJPCcw5bSyrYi5CWUNsXQus=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Nov 2026 10:15:08 +0800
Message-ID: <179574570832.2422.15788597758077074271@gmail.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list

Hi Roman,

Good point — there is no dependency between pwrap and spi here. I will
split this into a standalone pwrap series and a separate spi-mt65xx
binding patch in v4, and move all review-history notes below ---.

Best regards,
Ilia
