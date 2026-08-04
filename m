Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D152E2EEE
	for <linux-spi@vger.kernel.org>; Tue,  4 Aug 2026 01:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785808668; cv=none; b=c3+RVerQtAyB4nxGR4K0jYxiqLLBp8kuqoPZWtQmu6Sgm/oREQJ8xa7o3T1+5zr4hKpkdZEUy63mGrI/hTj0nZgG2lyXxs3Y2zKlbdFeZOjBIprjB3ZDOx01Xk2bc+kG/9YeNNDgUcP25byejCAIoPzQdaH4UsnGLikYJxMnMOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785808668; c=relaxed/simple;
	bh=YKh8EAa7FTgDFF8lgQWLr1vyuejNNIXFIPL4g9vLr6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JayU/gqE1EGA5L4jyT1t9HpYGOq2vqZYWHRyhb3IRE3rJQ7FqOGoNz+uL1wk6NVOEoB6zpSHPwYc8DPytSh1jqDRYWhke+2WZnTiM1PbNGFPgu0e1LKyzanyHQh4So94uWGkFB+LdrFAeR9u34P/AFn2UoHZk7BpTeM4W/yqJGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f933Ubzv; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f933Ubzv"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso43009535ad.1
        for <linux-spi@vger.kernel.org>; Mon, 03 Aug 2026 18:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785808667; x=1786413467; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SQ2+AbYITnQpEf3G7kidcS8ENfHDZJS6JKPhQsc5Y/M=;
        b=f933UbzvQRS/ut0qWF+QoipIubK3kqa8gFZgwh4tLAaHZBRN8KhICPwimbCzjSYu3P
         B8RHIJB9DN4zCPednRJeSkviPo7bO63rsj6zzCvCOWp5kyd2Qfc/GD72D4KL1QBS40e+
         nJFGK/Fy0ZHlj7srXSY58179urE57HJKLZuMSEm8PHywV8Fcy61QMsbt9PvFCIF4ZRWc
         tbgo96Gi8+NSB4bTiYfQdgS++GVN/Q9KzC9o/xfYL6efzQ8LxxdDLbXUX6stdW6fKbKi
         aaTbo9Pqs7a/aci7x7r6ppC05fbD7N6v2FkyWaAKwfze/JNFMyibZrWkpv2QRecgOlbg
         DguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785808667; x=1786413467;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SQ2+AbYITnQpEf3G7kidcS8ENfHDZJS6JKPhQsc5Y/M=;
        b=gYOVwvHUCfjbIcLD3rkutI6pu36mb11aGJ2Um++dFKe/IK4jCidUUBndjIr6pJA/wv
         80+1KBPtdmo3rirAguJIJGqOF5rHzr2xYz0W+6ldn3wCQAkghxTdYD4ZAK3oXmngcQSY
         NZY58/pH8cNSu3ClqcSq/lDS5Zx43movtrN5NVFdpmc6JBBQlffSvt/iCSLDWIOiAb8O
         nGeW365kPk5aqiAiLOIXn1ECr7hCjIfLfoNPHkMSPhN+r1hDEEFqxo6/fymKtk0Gb7of
         Zy9lYSKvW9NCsgY3fKYRLR/q8UpU+5RaILKu2pVTRKlAKNJ4b1kWiu31pk4RDwweB9mI
         XTNA==
X-Forwarded-Encrypted: i=1; AHgh+RoA0P5Aq9iVAO8ujDKUIWqCUHPtle36B5BcoR5I+OOuLGw+XFqj5d97yk/vXVoxuQ4e1LBUgv77Gjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyDW9T8PNyt/+iFMKNLQxqeVqVCYqq8NQHHFaicLekSx0RvhoC
	KBZn92c4TxfdzIM4TFHWSvFvxl/VDDeDgGaxfwd2QQKU00ZdZ8EhOMqY
X-Gm-Gg: AR+sD10JkDJ/pLtHvfULosop8bS1Hpf9FifzXAKUzDVlhndkrp3LJSQTn+XwfRXWWVB
	NzsOVljC+FdzttNwJpMAxQUtFuYRrRZtkQyhcdsM468Rw+HHDftX9nGdvROSYViW3kxIp1sefvH
	Omw7MTrjWWeMzQ4oJecUVuW/x4fx33GViUC52gycZR8xk6a0dwgKZrh1jThhzIAnZKagoEe80yn
	FFEDSQ6gNrBajrLDqBieodalZ11JiAY5Skk6hql3boJoEZgK9/kIV1NrMDQWAiOA5wW+WPzKLQI
	qHX2sQEhIA0znaLhPfjjfhJPvowAQdOB5St1MKYKjygpmgO0YhNapGYR2EEMlhIY5Pb+FoJ60kx
	HvgOln8JTEgp17fCw7cD2teR5RcG8pDkR1D5nT7khlHgMe422Kn7jPDj2HELD8S8c2nHbyZX+n/
	lR0vCGKhH7YYMUbsi7fK62RLH2mcrVRHXjd9Lmyxu88NjZpdSUDdqi5HNAv+0TXlrOHreHzVcEy
	kfYXotKMH9wjyI35faXxv9Z6PxKobqbzwzZM7Cu
X-Received: by 2002:a17:902:c40b:b0:2ca:bb5b:3c92 with SMTP id d9443c01a7336-2d05244ce77mr116332265ad.35.1785808666874;
        Mon, 03 Aug 2026 18:57:46 -0700 (PDT)
Received: from [172.19.1.42] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b15c1e4sm44632235ad.75.2026.08.03.18.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 18:57:46 -0700 (PDT)
Message-ID: <90e97c2e-c288-4417-965c-04565d042261@gmail.com>
Date: Tue, 4 Aug 2026 09:57:43 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] spi: ma35d1-qspi: Enable GPIO chip-select support
To: Mark Brown <broonie@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, cwweng@nuvoton.com
References: <5769eae0-1b40-419f-8311-0d919bf619fa@sirena.org.uk>
 <20260803074913.1656675-1-cwweng.linux@gmail.com>
 <edabced4-b7b1-4b2c-a358-d47e4b7e8e9c@sirena.org.uk>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <edabced4-b7b1-4b2c-a358-d47e4b7e8e9c@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Mark Brown 於 2026/8/3 下午 08:30 寫道:
> On Mon, Aug 03, 2026 at 03:49:11PM +0800, Chi-Wen Weng wrote:
>> From: Chi-Wen Weng <cwweng@nuvoton.com>
>>
>> The generic SPI controller binding allows GPIO-based chip selects, but
>> the MA35D1 QSPI driver currently supports only the controller's two
>> native chip selects.
> Please don't send new patches in reply to old patches or serieses, this
> makes it harder for both people and tools to understand what is going
> on - it can bury things in mailboxes and make it difficult to keep track
> of what current patches are, both for the new patches and the old ones.

Hi Mark,

Understood. I will send future revisions and new patch series as new 
top-level threads rather than replying to older patches or series.

Sorry for the confusion, and thanks for the clarification.

Best regards,
Chi-Wen

