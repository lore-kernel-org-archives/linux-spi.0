Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D233932FC
	for <linux-spi@vger.kernel.org>; Sat, 11 Jul 2026 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783775508; cv=none; b=toG9MwmODWjKU8gA0n58sJZgUMISnR+ThkmL+RxyNWRSN0JIFUTcOMwJndUELSpvqHeI0+LCcqo+1YbpDpPN82Ro+drwlRg7s4Sf4kEh02Qh7+PY37ZVJnTpSnvtaprM4+2D+eqk45tNpbjstA1pbDuZk59reDYOB6dJ+sGGmrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783775508; c=relaxed/simple;
	bh=Cn6yGw5q9/Z0212RFdCF/Qhf73gxRfIE4bUedXUKP7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q79mWIu7/EZyLFodl/myjm9vyAqRkSFmla67BXUscdXu5zERZ+m5/mACRXHNmHhqiP2RFUUg7jsb8jAApZVnF06Bk2TuGOvkGfPCH9MMTKXqv0xGTQsOBxma/dLuatVGr5Z/E/aORDQ3svioC6nD0b/BBniZ8hGWx4ACZxvmH5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36b9d265355so1446765a91.2
        for <linux-spi@vger.kernel.org>; Sat, 11 Jul 2026 06:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783775506; x=1784380306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wB9KtAsHUlHpaPuJBonnbCsh7/wGYO7fHNabzQOq95U=;
        b=TM54lO/uaS2xnE++M/N840QYx8HnFMxe73aNxZWKUfovIlTXISt1pJ1dZmm4dutfqu
         fvu1cLUc8IAMdzipPDF4SYcqlDswI3AgFdz2Z2ggh7t4DyXUZbOghX+QidnQIdRNS+WN
         An/MunwXpJqZyYiYQQCd84AQpQSoaMkb6k9/uTQB4B5HouhJOMbMpkO7LoK0i60I8Gdc
         p8tPmIY4jysQUFTfY0TLhoPoTTKJAIhaRqqCit0o+oZ4ZYEMdDHR78QlElIcN8pQmQ7h
         JHKscGxyIte5BLcKNlQVmH+JN+CakoRVZCz0f7wM0ke9edfH8oVzDQAWNH8xTbm3PxmC
         xSMA==
X-Forwarded-Encrypted: i=1; AHgh+RrMDgMssnRlwDf96Sswv933yB8An5PCBGRr1rkztepujwirfQv7OQpBrTdKntcR4tRAUuERDVkp8R8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXIwHrQlzCR8zx0Ii1OsaQCQMxiZ0FpKV1sMH2zq3HquwDLf+W
	j1Zs1GOsfVscuj3JgxyiJGRCS57Em+aYSkwa5Qe8mZ1zcNQe54qGJIo=
X-Gm-Gg: AfdE7cl540kgU9ICU+dAcp1kIZdMP2zHiz6BZRL0GOXjOSS2sebWPvZYQWrC9SKK3dR
	YLxcy1OK648TGXlpw90PILXsUkTMRGHkT6SzyKM9n/LPPxR6374iwfxQVduGiN6Fy5yrcGt96UL
	+Zrrxnu9JZGX/UCIpnUh8im4FdK3aDdR1QhKMakTP/SayFSkoofqoYuILISsoyA4vghMJwl8WxX
	GeYUIDHkzUkFazsEimFwPjfNZr1Tki0Mz/fOjiuMdtRa1NoFZlSANqD7BQww1o3uzZoVU3gbLq1
	IyKR4/+bWnhAX5UTkuj5EhoxWdMG0U5j2+kdSkqxAxBUq06wUjCm79nglocxlvwQpwZ1qgY53SI
	SgyyMI1KjLyO9jCZXen1C9rBS/Nim8URZUBxhQI3hEDjaHk0TBhs3GTShExX9fc5iX9TZOPdguI
	Q6UioJAameQ28YxePyLiu5ghoSoTK5/MZ0fNZxaXcePctLLCtMe+WeJm7XMJwn82WOCAicRjB5V
	LQr3R+Nz5ba1JcxRQR8x/913A==
X-Received: by 2002:a17:90b:560f:b0:389:8f6c:4d59 with SMTP id 98e67ed59e1d1-38dc7779d1bmr2946328a91.24.1783775506362;
        Sat, 11 Jul 2026 06:11:46 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-52-13.dynamic-ip.hinet.net. [61.228.52.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a55557f25sm4136221a91.5.2026.07.11.06.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 06:11:45 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v5 0/3] Input/SPI: fixes for MacBook8,1 DMA timeout, UAF, and NULL pointer dereference
Date: Sat, 11 Jul 2026 21:11:37 +0800
Message-Id: <20260711131140.18777-1-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260711055247.5412-1-fourdollars@debian.org>
References: <20260711055247.5412-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Dmitry, Mark, and the linux-input/linux-spi community,

This patch series addresses a long-standing DMA initialization timeout on the 
early 2015 12" MacBook (MacBook8,1) on any boot (including cold boot), as well 
as two pre-existing, high-severity UAF/NULL-pointer bugs in the applespi driver.

Changes in v5:
  - Updated both `lpss_spi_setup()` and `mrfld_spi_setup()` in `spi-pxa2xx-pci.c` 
    to consistently respect the `force_pio` module parameter across all supported 
    PCI devices (avoiding hardcoded DMA enable on Merrifield systems).

Changes in v4:
  - Reverted the runtime `can_dma` callback override from `applespi.c` to avoid 
    architectural layering violation, data races (TOCTOU) with concurrent SPI 
    transfers, and execute-after-free vulnerability upon module unload.
  - Moved the DMI quirk forcing PIO mode for MacBook8,1 to the host PCI glue 
    driver (spi-pxa2xx-pci.c) where LPSS setup occurs.
  - Formatted the DMI match using a structured `pxa2xx_spi_pci_dmi_table` and 
    helper function `pxa2xx_spi_pci_can_dma()`.
  - Added a `force_pio` module parameter in spi-pxa2xx-pci.c to allow other 
    users to manually force PIO mode for debugging.

Changes in v3:
  - Added a `force_pio` module parameter to applespi to allow users to manually 
    disable DMA for SPI transfers.
  - Resolved the execute-after-free vulnerability by unconditionally restoring 
    the original can_dma callback (even if NULL) in the driver remove path.
  - Fixed the probe timing issue by applying the can_dma override at the very 
    beginning of applespi_probe() so that all early initialization transfers 
    safely use PIO mode, and properly restoring it in all probe error paths.
  - Documented the Bugzilla link in the commit message of Patch 1.

Changes in v2:
  - Fixed an unbind/remove execute-after-free vulnerability by storing and 
    restoring the host controller's original can_dma callback in applespi_probe() 
    and applespi_remove().
  - Split the fixes into a 3-patch logical series.

Patch 1 fixes a pre-existing UAF vulnerability in the driver unbind path by 
explicitly calling cancel_work_sync() on the asynchronous registration worker 
work struct before devres frees the driver private data.

Patch 2 fixes a pre-existing race condition in the debugfs interface where 
userspace could open the tp_dim file before the asynchronous worker has 
finished initializing applespi->touchpad_input_dev, leading to a NULL 
pointer dereference. We resolve this using smp_load_acquire() and checking 
for NULL.

Patch 3 introduces a structured DMI quirk and a `force_pio` module parameter 
in spi-pxa2xx-pci.c to disable DMA on MacBook8,1. This forces the controller 
to use the rock-solid PIO mode from the very beginning.

Best regards,
Shih-Yuan Lee

Shih-Yuan Lee (3):
  Input: applespi - cancel pending work on driver remove
  Input: applespi - fix NULL pointer dereference in tp_dim open
  spi: pxa2xx: disable DMA for Apple MacBook8,1

 drivers/input/keyboard/applespi.c | 10 ++++++++-
 drivers/spi/spi-pxa2xx-pci.c      | 35 +++++++++++++++++++++++++++++--
 2 files changed, 42 insertions(+), 3 deletions(-)

-- 
2.39.5

