Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B2733F594
	for <linux-spi@vger.kernel.org>; Fri, 31 Jul 2026 03:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785467480; cv=none; b=Jksm5KpmSDm36JwfpNO1V9ePhyPcz6JCbg6Z0e1lkLqAuyQK6hPkPWrC+5CuKXQ1OTmKKgXo7IVx1jL+f9f7ufDXkBR2BmSWy9K0yjenVVlDfA00HqC4Eo9r9K/zcJQ9WWtR78rrZFo2tR/+JbOHHYfxvIUZ4ET4ef+tgwkn8zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785467480; c=relaxed/simple;
	bh=GWIkI1eD5Bk27NjXEiBgjczmLe76dOHKjqJoukzr3qM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=if8qlgmn7Hgl4Mv3W3hkdYlUDGuVxHUb24jUlTtIvWmtVVtaCCg6owEHqUR6+yTmLocsxTCAtrPFjbrATfp3Vxyg8jCnOO+KPlEnG8RQT9ZMwb3t4h2q7J/lrEp4B2aOJlqgZd+nCMX4zGmPWwQQe8yrvTh4paBg+1YUgRGORDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maticrobots.com; spf=pass smtp.mailfrom=matician.com; dkim=pass (2048-bit key) header.d=maticrobots.com header.i=@maticrobots.com header.b=Dnxwnknn; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maticrobots.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matician.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maticrobots.com header.i=@maticrobots.com header.b="Dnxwnknn"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2caf228a910so3046365ad.2
        for <linux-spi@vger.kernel.org>; Thu, 30 Jul 2026 20:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maticrobots.com; s=google; t=1785467479; x=1786072279; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+jDUeV37G5tAArJc87hK+jR2T1SQGY2xbZAynKmfam4=;
        b=Dnxwnknn8WmYsztDCENlyfdapOUfYUPHAuieOdhBbVXJZowXPaE/b60CFOhDeTqxym
         iCFB9CXkdBLP2tJu6U7/s1NnEpuzPbyH2GzfN+pMvACdpjB4XeRnKWS/kH7rJt57zHcm
         1wjqLeYEOLvArXnJxOyjm/m7LjydNH5x3NqgatE698uj5nDTUmJL/vwSwDQ+QhU4q+qc
         eCzYIaEp1jQa8ygKxW3fIsamkCuZI/Eie6JeJCYTuMYOZreOJiqlIxN1gxtvdx5slUpu
         vJYn8bs6jSdt0TsfDggi3B45mUtCEoqdeb1gfm5p3NWxGuDuyG52vBr6B63s1EMwK9AD
         ktJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785467479; x=1786072279;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+jDUeV37G5tAArJc87hK+jR2T1SQGY2xbZAynKmfam4=;
        b=WsaEZOUQWverCQoDywCfRmSFw+C233rOM35b+8dtU1hnOiJCBOR9jNEp2lfvBgaNTp
         yH05KkI78ndyQU+SKmesfyNmFOJBMIK7ES/AQWHvLIYFLUfeENi6GlwzTczV4Tbc2MhN
         59RwlnVDqOOJvL62Z8cuMRTVGX/5CNBs9B3CqUFy6tDWMb0JBYjUSxctPB+h8sBmVSBR
         Bc+ECrbZOt0Y2sm8dOJ5o7pW8nXNLes36YHHTUf+a4cQZ2nsiP/0jvowQaYFzGrKmqwm
         RVzo78Em55ajiB1ugs/d6PiKyOpMF2+g77u2WXfaDAxYwoHMw5fwmZUdWGhLLPWYUD3C
         x9WA==
X-Forwarded-Encrypted: i=1; AHgh+RrxdAokczmbNzshM2fpWen3h99UycSfRVvS70zj4vjR/q/uea+jUwrOGdVTkDcZ8xXxcFFOcssjj1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMLNJ8vCpIExZvdGDxd7LnbuCnnIILND/sQG9Ti1QISi6F+Fzp
	0kTDw9EsQmaWewR64cKN9QjlChinP9nDM2YsKTh0XY8aLxVN9FDKoEf+Tp5q7hJwJiI=
X-Gm-Gg: AR+sD11PHwVDxlX5wr0JT5a0i0BdDm5swzP04q9u5/W5T6bxTJvsn5YmY88+qFpqDSC
	o8JN6gMMxI0wKUNBcznsJAQPnswismkmuQDCiGZFtwakbxaAKFnV34GxjFa08ino2y5+nksNO/P
	z39dkSWFAtMu9hP/dJXIii0FnTmJJgjo+hClXORhy/PZCmdfq6OaKjemaMPWrcrxdswkldaWdxN
	LR6Rx03my1C67K9PUQ3WGj8RETPACzNZg5F267HXIU4NZwmFb7mivgtbNSaGosahgeuOL4O2/Rt
	qFFdTiMoBpK/aL5im9BWdJ5wmDTpC4bCtU4yvGHrr99Kdpr9osiA7lVF7ZuJCdIkfr5bYY6AwWt
	eS8VYeBu9ejj36oKbnRJaYUyplxEtrnStPBeX9TaM/yxG56vK5UGLRZy/HpOspERkiIP1c0/pMf
	hcZDleuqy8RSUv0vNEpiJBGx3kUHhRXDlHelxr5SPxkHggDTEzYtKSuN7DW2SGEO7BRfrjqHXzW
	WUKK0elzQQU5xV1NkBfSqdqyjwbAoClwDn/2g==
X-Received: by 2002:a05:6a21:730b:b0:3c3:83e6:c705 with SMTP id adf61e73a8af0-3c91b346a1dmr164358637.35.1785467479007;
        Thu, 30 Jul 2026 20:11:19 -0700 (PDT)
Received: from abeMaticDesktop.1020marsh.offices.matician.com ([2600:1700:471:807f:4328:dce4:fe00:16d4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd4f0f0sm1287eec.2.2026.07.30.20.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 20:11:18 -0700 (PDT)
From: Abraham Zukor <abe@maticrobots.com>
To: Jon Hunter <jonathanh@nvidia.com>,
	Mark Brown <broonie@kernel.org>,
	Laxman Dewangan <ldewangan@nvidia.com>
Cc: Abraham Zukor <abe@maticrobots.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: tegra114: initialize native chip selects inactive
Date: Thu, 30 Jul 2026 20:11:11 -0700
Message-ID: <20260731030827.4186208-1-abe@maticrobots.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <0513a557-762e-4390-b5f3-84ac26a38de4@nvidia.com>
References: <20260725042944.1204409-1-abe@maticrobots.com> <b2a3d65c-d3ef-499d-b56a-82018804f4d3@nvidia.com> <20260728025503.162543-1-abe@maticrobots.com> <9c196ab1-1945-49fc-a89a-5588d1e50046@nvidia.com> <20260728200316.1363536-1-abe@maticrobots.com> <0513a557-762e-4390-b5f3-84ac26a38de4@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/07/2026 22:09, Jon Hunter wrote:
> I am a bit reluctant to make this change after 10+ years of this driver
> being around.

That is fair, and v1 deserved it. I have sent a v2 that only touches
chip selects the device tree describes:

  https://lore.kernel.org/r/20260731030134.4182688-1-abe@maticrobots.com/

The steady state is unchanged - tegra_spi_setup() already programs these
bits for each device, so only the window before that runs changes, and
only for active-low devices. Nothing the device tree does not describe is
touched at all.

> Right. Although this patch is specific to Tegra, I am guessing that
> other devices could also face similar issues and therefore, it would
> seem that having a generic facility to scan the devices would be ideal.

The window exists because __spi_add_device() calls __spi_setup() and then
device_add() per child, so of_register_spi_devices() runs setup(0),
add(0), setup(1), add(1) - device 0's driver can transfer before device
1's chip select has been configured. The comment above that __spi_setup()
call already notes that devices using SPI_CS_HIGH "can't coexist well
otherwise".

Splitting __spi_add_device() into a prepare half and a publish half, and
having of_register_spi_devices() prepare every child before publishing
any, would close it for every controller with a programmable chip select
idle level. The awkward part is that the duplicate chip select check
uses bus_for_each_dev(), so it only sees published devices and would
need to consider the pending ones too.

That is a larger change than I want to put in front of a fix, and it
would not help a chip select that never gets an spi_device at all, such
as a disabled node. So I do not think the two are alternatives - the core
change would subsume the declared sibling half of this patch and leave
the rest.

Thanks,
Abe
