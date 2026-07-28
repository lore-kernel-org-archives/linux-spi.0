Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51AD3C457D
	for <linux-spi@vger.kernel.org>; Tue, 28 Jul 2026 20:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785269000; cv=none; b=K8IzeV0pBs6FOXhubitfEK1x/xt+v6lsqxVn7+5jUNVplcFVKxPYSqyF+a2Nj3YNSi0hMkAgJ/cWJmgvLBAwfofWRcNw50Yy2WzYnDLWEDQ4hflNNoRdM+zasGFC65nCizTsDeQypIWlpLi7J282ZoixJJwisohB01mvqRMGLik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785269000; c=relaxed/simple;
	bh=9iNjrrVtL3NNUry5XR4/x0JtSnWNg24S//oMYnqZvp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJTh8dsikVud4pRuJu91GRe/B03B/RpBFBB9mf61XR1zD2lyRNyoO4ThNtQhRvdj7Bzqv13dW0uHB/KwjDZZryqWeb3xcWSXhnbpBILHXQV4Tj8BjC3jdju0uSlWYpaDN640+J6w9DFgdP56EgfNcQLfzY/aWmA9fPa5G9G5dwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maticrobots.com; spf=pass smtp.mailfrom=matician.com; dkim=pass (2048-bit key) header.d=maticrobots.com header.i=@maticrobots.com header.b=XC++u4ph; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maticrobots.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matician.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maticrobots.com header.i=@maticrobots.com header.b="XC++u4ph"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2caced6038eso2954695ad.0
        for <linux-spi@vger.kernel.org>; Tue, 28 Jul 2026 13:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maticrobots.com; s=google; t=1785268998; x=1785873798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9iNjrrVtL3NNUry5XR4/x0JtSnWNg24S//oMYnqZvp4=;
        b=XC++u4ph5xROyX+DsNdnzheTuXpUDCte7rAz/p++3I3ts4C1AAtQ42cbu1bP24gHTS
         P2Ds0aDpTmzekYrMCn4u1PpatJikfYCIAh9X57IfD+ufQ3T3My1CTICNq6K3MdZhu9fV
         sfeXJRfnBwQchTdRKiiYmR7X5RR4jZ9TfEVARgBwHn42F5RjNfhI8xLSYj1q2q7M6Oow
         a2KoXZwz1i4TyBEaHNY6pO3RdafHp2ewopJOqdm05/n+CGQn6Ovnn7LPi7AWBCbBYm6U
         1NWYt5kWlwsRZHn5cUjN5MSn5N3TerDPYpRFdce52pfuW+0FYES6ElQz6CpKs09haFXR
         1l1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785268998; x=1785873798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9iNjrrVtL3NNUry5XR4/x0JtSnWNg24S//oMYnqZvp4=;
        b=fiB+5Mt/0qxNoGh/XCOnHadcCsZC3W5NovClzeOqoyizxwi5Efd1vl4l2dAHk+XfKn
         nUQ880udLVC1WBFKMyRVFsaJJAyOX5TaAMcFPjn9BrIeTvutDvFODXdjo5Ttg4wLaklJ
         YoMu6oEpuidwmFNmbVJ/4aelC1/xBDpC8wTBCkkHeBR4X6Dv4H6AIlvMCBnaBa3qRrus
         3XQ6/RWyO3gFfxdXlhNYuNd97CdEzziqsNEUztYsmFFoDfQCdDxY7rAtL40G68RGMu5C
         1OcjUBjIqa6+mNBlAiUWc8KwnBjHEdKzbuvDK7Pur/bnvuSuE4ql6FI4++rf7+GlTn8j
         /6Gg==
X-Forwarded-Encrypted: i=1; AHgh+RqcLPWKirVeV7Kp7DlriE0uwli2aKvDJCsYCBy5NGUyiXiMYBfanbjYnaIjQE97n5gJpTmFcdhBJF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzZ2WKzmfxTMn4TgQSPSnG2JcTJgHcIhVhyQwOipwMmzsCmp3j
	a7Lha9GJV3Nw3i6uskXxFiM94Rms90KoNr3uUCbxBVSEyLYs+2KlEtmR7NtL89f46Dk=
X-Gm-Gg: AR+sD12IZ+0sNDDRDM2mj9DuAS6nEgcaKiggwX33o9lwnVio8++kXXCstDmxEkUw7UZ
	0Wfn0lIgZpU8XVVORREyVHhq8WxYW2hwRfJx5t9yrIqjM+KL9k5JA15dnIjVOfYiXEP8YbpjQaW
	Z9MCeaOHyeu1AnxSzhJVofwWKeSf6lB2De6rjyP5AOYnKB8NclTQ/ys+/GzoEv0WFw0Md8YOPo+
	UkWAMSt9KpFjY4U2BYjhlw17tiN8XCLI0oDmUSBnpcRSm58yBC5QBxAzNKkdDBSifK80NU3KmyZ
	AqMefN82sXZjdbsEGtcyOfbSpMoKjNnxZmslwlkNkHR2QwASc4SsACSKU38YyhIVFv/XK6vgWxi
	Yip2IWDjKpm3qmyMVlVveUwKcwF4lccJiY4BIovOZ698uAlGKi/C8ERYr/B4v8VzcuBwv7YnRxo
	IbFoxH9Rr1XfFA7FbgoY9XGmhEpAcO9QKOPUzDnIhhN1vHluiWqCVlU3bS0PSXX2N/BIavk2vLR
	acJz+uyFbffupnOfhBKMQayKN3soc9BTOWFAg==
X-Received: by 2002:a17:903:41cf:b0:2cf:4c37:d955 with SMTP id d9443c01a7336-2d015f082famr40755285ad.27.1785268998323;
        Tue, 28 Jul 2026 13:03:18 -0700 (PDT)
Received: from abeMaticDesktop.1020marsh.offices.matician.com ([2600:1700:471:807f:68c8:458c:c1f7:4115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b125bbsm1810890eec.5.2026.07.28.13.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 13:03:17 -0700 (PDT)
From: Abraham Zukor <abe@maticrobots.com>
To: Jon Hunter <jonathanh@nvidia.com>,
	Mark Brown <broonie@kernel.org>,
	Laxman Dewangan <ldewangan@nvidia.com>
Cc: Thierry Reding <thierry.reding@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: tegra114: initialize native chip selects inactive
Date: Tue, 28 Jul 2026 13:03:12 -0700
Message-ID: <20260728200316.1363536-1-abe@maticrobots.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <9c196ab1-1945-49fc-a89a-5588d1e50046@nvidia.com>
References: <20260725042944.1204409-1-abe@maticrobots.com> <b2a3d65c-d3ef-499d-b56a-82018804f4d3@nvidia.com> <20260728025503.162543-1-abe@maticrobots.com> <9c196ab1-1945-49fc-a89a-5588d1e50046@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On 28/07/2026 10:34, Jon Hunter wrote:
> Exactly. That's my point. Which is the right one? The answer is
> probably neither, but whatever is present on the bus.

I think that defaulting to active-low is correct. The Tegra234 SPI
controller hardware defaults to active-low (all bits in CS_POL_INACTIVE
are set) so an active-high device is already asserted before this driver
initializes. I checked the controller drivers under drivers/spi/; they
either default to active-low or preserve the hardware default.

A more complex option is to scan the device tree children, check each
item for whether it uses native chip select (as opposed to GPIO CS) and
check for spi-cs-high. I found no other spi drivers that do this at
probe time, and I don't think it's worth the complexity, but I can send
it as a v2 if needed.

Thanks,
Abe
