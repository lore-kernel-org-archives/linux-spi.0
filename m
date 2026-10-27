Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793084258;
	b=aRjf3hrWeZJ/tE2O0SJg2GLr/pf/58cyFgmE1NBlMUUFL3HCEa+BpRgDHfSSuWHt6J94
	 K5N4T4Ea2PEN0Vv34QMiSUrPkoB41Wxie94mGQYCWGUBWpVDTzPpZXIcSX6mRDHjOhSwV
	 B4DWSlBiRmjyuwdSJGYl354frN/le2VrfUT9sAXEMjxFdQiOzATfGPfIvFV2+ltPhOIAv
	 JMY6cKskSWs2uNACIc5ZB38V2uNN8bsPE4uj1MA9Xv+UdUK/ehJFm+vuke19kW3EfrNOK
	 DyKhsvY/o0oA9x8SDOymqBqewjWHUbPubho0L+e7eSMgdfispghpVh7mLXNwvih+Nkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084258;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sA/soCd+jAxyVyCbYpE8ZxQ51mVTYvjC6BPEoSaY6Pc=;
	b=v3DN8twyUEJhF9OfslUpdj76jWfej+Nx1BlU0qOAExW0B+Yt6y069DrdfKvX041IpOBG
	 8kzn8PzSR0reNZw58rJXxC0iEOXWO478vwSlXH+Wda7NFkpNjj7I5/cfjCPIEllHoHXZW
	 c2vCWU36yRMqWIP+lFxJVXaxkvtnGj1jb/ckFfYRpEn2wlQQgrEWuHz5al12fMkuUZSyl
	 RCba1YnUmwRX6GLL6XFwwRcxV+Ri5wIwaU0FmoVvWrwl/Yhu2zbJDjB6ouIwYl2i28Uv7
	 K7y742pEJjDwibU6uHPpUHDCX4Lyy+CCACsiCRD4o3NF4EduDW6+39Y3UHbZRhMI2uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UWuJ9Lit;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88884606A321
	for <linux-spi@vger.kernel.org>; Tue, 27 Oct 2026 06:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88884606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UWuJ9Lit
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso18511055e9.0
        for <linux-spi@vger.kernel.org>; Mon, 26 Oct 2026 23:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793084257; x=1793689057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sA/soCd+jAxyVyCbYpE8ZxQ51mVTYvjC6BPEoSaY6Pc=;
        b=UWuJ9LitCKkGTEaaIUGD/Wghisf6auEQWKjaR9IxA8JMPvQ2KKQuG4HUqYD9j+3VD+
         rjFQMVOw+k5S1ZQcw5QE8SjBC3mETwLhM5bih+1WI4y4EoTKsJvYvelUDtThKY8qYneg
         /V72cKKSdPk6XPP+RzrYGJpKkzMrHr0z6rs/PBe+WSuRVXRc8/KasiTjlKIrNCwS9xhR
         nnZaTdNS7VUM4PaSMfgqLTrCAE4EU/8lmCy0IlsbcweyoZ77CwOOl2yv8RDH9V5srMZp
         ghmT153AfKK6H+jbHeFRZv6/Aj0EQT2xNW+PAeDzEoFfuqWxk7K+kse2XsIS2gZk3182
         J8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793084257; x=1793689057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sA/soCd+jAxyVyCbYpE8ZxQ51mVTYvjC6BPEoSaY6Pc=;
        b=ZS7b6kxO0NKaMpmOlYHZ6+TOkm/Cfw6mOeFF4iamWvp1VHUa7r2LevASG1XdvsPoK6
         Dsi52A2hVGR+eYz/4x0r7P4ANjbhOiTw0aFsUcOT3Dq64HfttII3uhmzG01kmPfn+IG2
         NyaGkNgODx42II9ht7Pn6uGM/xc5Brw0jJeh1c3deB/sIIauTxLoqgkxpljeCelCa/mQ
         XcgyOM5ehXC96PA7xVMJfdsyHxd39Nb1RS6sjSaraX4DPWc3nMH1rhN/w+6CtklZS+mX
         dRjN5VYQVZcuPzAJTnIDvC2hnmQpGvxcjKlEy01SFnrrq++o1YlEytC/tfnMK+wlnHuZ
         Y4fQ==
X-Forwarded-Encrypted: i=1; AKwUvBzwL5Q1T4eTaPGMNlJmPL88SjIGM7yeQL4HnHELsCkLVRFb+1W1y+mXufJykjofsra2bE/BOSieSMU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKsIXERC9PC6uIgsX+giX3TvKRzuY9YDmuvXRD5xd+k5zuwcpWi
	szqlr0kOOWWeGq1VAWTE7pPSb2eexSratAlgKsrPxqku/+fMpb0Y17Jd
X-Gm-Gg: AYBFou3h13XGYpOQEQxQ8boalVkjRsOQQx53QCabFLof1RT3oWSCi3mfJcEBcz3UZa5
	ARixCuFgDq50xZk31UDzaUKS8ZUZnBSGpInidL79jR/IEapBV1nCbqo1/dVoUwNfd2FpKgKALt3
	v7mn1kqphoEeyIcPGwod5A27lxkhcwNRLIKiF+EKlfmAbriiI95Dp9EMh2s6F0hvE4ubG24lE54
	mh53No0i4iKNonurVQLXKq0z0z6bbUuJxLDlm5XlrZ9bDJgL+n2iwiYyqi9OmNR/0opCYWwHlPQ
	ZccIOp01d5c0qAPp9PxS20SkkvzuqLqbShpblLWRCNnrEB5n96PdxK7cuoYJ1guJjbXZd7bH9mi
	epUtKPdVMhDe1afPIf866B7WxuhreNzlHuafKv1OSNNDJOKEbxzieeXPjSatpOzFoKuouNREWhc
	Bgt90E9196vgCj0qjB6HC5MjNjrO87ngBQG0q4+RDX5+NbRxzKgadLYaBJx6Fsy03b6K1fH88/A
	ScejrzRDEhTZNLl/6eL6YLRjqLxsVwwlRnlQgfcL9MxepBpqUM+VMAZOjwgJd6TxUuJk2SvmrJq
	dHk8J7vFkD98S4ZGGAlRHpRnsjvCe3A240RgM7I2e7caiHn+o4dgnqzLKag8pNZZTI6EhAir6a0
	07Rab8Pbm8QByyna91USUn4Y97S+uZziJaqXIMznSPxJd4IFhwRO5E8tEIpI3JRTH3E6dpayw8u
	8eFx07
X-Received: by 2002:a05:600c:474a:b0:49f:e772:6ddf with SMTP id 5b1f17b1804b1-4a35ace28e0mr174280915e9.32.1793084256726;
        Mon, 26 Oct 2026 23:57:36 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b2ac-9b01-6900-1f92-d182-4435.310.pool.telefonica.de. [2a02:3100:b2ac:9b01:6900:1f92:d182:4435])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a2c0458sm243490115e9.11.2026.10.26.23.57.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 23:57:36 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Vishwaroop A <va@nvidia.com>,
	Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Rhyland Klein <rklein@nvidia.com>,
	Suresh Mangipudi <smangipudi@nvidia.com>,
	linux-spi@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] spi: tegra114: chip-select fixes and PIO-only probe
Date: Tue, 27 Oct 2026 07:57:26 +0100
Message-Id: <20261027065726.98396-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <179258895296.403962.3492255118456900623@nvidia.com>
References: <179258895296.403962.3492255118456900623@nvidia.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Oct 21, 2026 at 10:14:06AM +0000, Vishwaroop A wrote:
> The delay runs after CS is dropped. A mid-message cs_change drops CS
> and never drives it active again. When the last transfer holds CS,
> the next message can turn hardware CS back on and drop the line.
> TIS-SPI under spi_bus_lock() needs CS held across those messages.
> Multi-transfer messages already use software CS; patch 4 only moves
> that choice so patch 5 can keep it.
>
> Patch 1 is separate. A missing "dmas" property fails probe even
> though PIO works, so fall back to PIO.

Tested on Jetson Nano (Tegra210) on v7.3-rc2 (5b0764a53235) with
7000d400.spi (DMA enabled) and 7000d600.spi ("dmas" omitted from DT):

1. PIO fallback (patch 1/5):
   - Unpatched: 7000d600.spi fails probe with:
     spi-tegra114 7000d600.spi: error -19: Dma channel is not available
   - With series: 7000d600.spi logs:
     spi-tegra114 7000d600.spi: 'dmas' is required by the binding, falling back to PIO
     and completes 128-byte PIO transfers on /dev/spidev1.0.

2. Mid-message cs_change reassertion (patch 3/5):
   - Two-transfer SPI_IOC_MESSAGE(2) on 7000d400.spi (SPI_MODE_0,
     active-low CS0) with cs_change = 1 on both transfers:
   - Unpatched: SPI_COMMAND1 (0x7000d400) after the message is
     0x40701827 (SPI_CS_SW_HW = 1, SPI_CS_SW_VAL = 1), leaving CS
     deasserted high during the second transfer.
   - With series: SPI_COMMAND1 is 0x40601827 (SPI_CS_SW_HW = 1,
     SPI_CS_SW_VAL = 0, CS reasserted low before the second transfer).

3. Per-transfer delay order and keeping software CS across messages
   (patches 2/5, 4/5 and 5/5):
   - Immediately following the cs_change = 1 message above, a
     single-transfer SPI_IOC_MESSAGE(1) with cs_change = 0 and
     delay_usecs = 40000 was submitted while sampling SPI_COMMAND1 at
     15 ms into the 40 ms delay window:
   - Unpatched: SPI_COMMAND1 at 15 ms is already reset to 0x40400000
     (SPI_CS_SW_HW = 0) because tegra_spi_transfer_end() ran before
     spi_transfer_delay_exec() and the transfer switched to hardware CS.
   - With series: SPI_COMMAND1 at 15 ms is 0x40601827 (SPI_CS_SW_HW = 1,
     SPI_CS_SW_VAL = 0), holding software CS active during delay_usecs,
     and returns to 0x40400000 after delay_usecs completes.

Tested-by: Karl Mehltretter <kmehltretter@gmail.com>

Thanks,
Karl
