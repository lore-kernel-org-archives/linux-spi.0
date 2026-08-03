Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADB53A900B
	for <linux-spi@vger.kernel.org>; Mon,  3 Aug 2026 07:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785743371; cv=none; b=Q0JHEIx8qc5ISRBN9Q+vh+/XSziyAENLsTGd+/IjLUsO4BVhaQLYv2zqADr3E3Oj8SEmb87GIp9CrKjw9v2edwsPuh5HGffcbRs2oaTPtGZv3p9mNo/WRDZ8L35VEd8epQJPTuhm1VjsuErwvKYUhDvFaLdtLP+G/QHeekn19jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785743371; c=relaxed/simple;
	bh=yHW1wsbgoNB8oOaneusOQL3QP1qAp1nDgynqeSs3TsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IoT/1mj3U+Gac8k4iTBNsVoo4V4XmPzgrTR7XcoZaFu6Gf7s8WT6/hkbREZ7JadJ+wlz44oiyzIOwg6kiHyQtWHvmWyzrZXkRS7tiVrXNX+nPsgZk1zwfHGspatwCGhpuD2C0LKHtlm7tZp7gHqaIEwnnZlSf1MrMvli1MDHG2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+4tl+vZ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+4tl+vZ"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d02b4c3601so33703495ad.3
        for <linux-spi@vger.kernel.org>; Mon, 03 Aug 2026 00:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785743369; x=1786348169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pW77Oks0DmStB3RhQ+Zqom030xkJ3DGvFIDhxb6Oa34=;
        b=c+4tl+vZ0nT9watw/Oqq+2hxYQdpegTv1dXsuQ1I+qqN/YhtdnLu3LoyEWvwcCH7gg
         wYUIfH8nm1Dh6hGUlVGNWJjehpwVvzLWTlYbkKhGKjNzS5VzcytughIOsFf4tosGWBMn
         j9IjST839KFSS5jItuK+B4pz+UjmCzmRHRMjyEfOhxYIDYbiWeJA+02KFAJFomDFqVPZ
         OGmaUQuTFgiL+0hOncd/xkGB4qVgisIWtdi8IgTo9y9HdsF5vRA4EUoOwPjJyaaL0xAA
         zVWZKQHcCMs7WRvx8qjxjzjtG2HPA2USYMdRgItSD73SQuS3cESMBs2LJb/6JlohLrOQ
         nwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785743369; x=1786348169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pW77Oks0DmStB3RhQ+Zqom030xkJ3DGvFIDhxb6Oa34=;
        b=Sl36jQEirX8dKOwy1oCCq0WzyCGNwCYwpNmJYTgNrg1RHWKnI6qgkm3r5xTXQhxJ+Z
         x9sWvnRxfEOwAX2XmjNe0/QdIugs3bSj99dLIqWcdJBLWVv25q9M3+GHO1qCnSZzoHMn
         YJ1+RSetLRuDptN3otSZ02GYkVmhSPxRppHT5Z+fRHqt/og28ir1t3IMnq2hSy3PKvw9
         xFBZjkQ2V8HBykm56/Pqn7nGmkkN7uKc4/gTsiRKjl54Du2RvQEPGOTlKAa+14v8HocO
         uZJZCyf20NMwHWZItS8A/B8CF7bDVrP+D1ZUrA6IAUCJwcpVAq96PMGBclkgJ2PyKQhZ
         hQYA==
X-Forwarded-Encrypted: i=1; AHgh+RrY1UbsjXiUNRcHosipO3v88cryiBw5bxk5GkBHl6A8Tiwa48VA0fXPFC+goqopGpYq63/XE0VHY/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvTQS6gD5WAG+Vz+9ouBTOl0R6g2crB1aR9r4fWc/9Qxt6j8cB
	tmPECz6/mwJJ8tPeLPcwFMTPl0X3HpPgS3IrOiMktY3LxWY22f9gbNWR
X-Gm-Gg: AR+sD11T4KBEaSFO8uUwoYnWV+rKs98RIMotmDLiuGgf2Lm4tTWCwvhPks8kuqGF1Fd
	rIcyR2IFf+FVRr94u06yS5UpSP0LRvyU0OOH8y4rWQxQEfIKbkF65xk6T9WaRMyT/AVxY/Q/fxv
	kJ8qerOOhz8dspvYaEQ2QiRpOd3wuJtBuUAR78tDaIkyKhZQs5J1L7xvWRc5u1SVpoy5Ks4KJXM
	qaAb+T65odNAjC7NieSMKOFAlW/LoARr+vDrF3KSzuMsfw3OecP8GQMMndVvaBW91r7a0bUoKPF
	HZdVk6dXbhIMdqCxI9rCZNwbseFzknbyQ0u2llCwGjgjC6a9MYUGqCI9QuEP/zWsX4gOfOw+Ylk
	CBEyNYzmJAdOJ6fTgw/T1W0kw5jdeohxHFcNlDePL3mPMPfPGRYVfjQhyV908pcF7OwOxQ6Fti2
	oNWDM5DQwpjiVxrriSoCWwKAei/9V4ua8wBKqXD23bXePRDEc+E+7wNqGttGOzkAqwOqERplCLz
	iQbzmXIR+gouBhoffpjDXwqazWrPNfiIR1GV5Cb1qdOWRhebOZzBBKGAiH1RL4=
X-Received: by 2002:a17:903:184e:b0:2d0:401c:2ebb with SMTP id d9443c01a7336-2d0521e93a3mr93702125ad.4.1785743368712;
        Mon, 03 Aug 2026 00:49:28 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b120f2fsm33679845ad.64.2026.08.03.00.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 00:49:27 -0700 (PDT)
From: Chi-Wen Weng <cwweng.linux@gmail.com>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cwweng@nuvoton.com,
	cwweng.linux@gmail.com
Subject: [PATCH v3 0/2] spi: ma35d1-qspi: Enable GPIO chip-select support
Date: Mon,  3 Aug 2026 15:49:11 +0800
Message-Id: <20260803074913.1656675-1-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <5769eae0-1b40-419f-8311-0d919bf619fa@sirena.org.uk>
References: <5769eae0-1b40-419f-8311-0d919bf619fa@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chi-Wen Weng <cwweng@nuvoton.com>

The generic SPI controller binding allows GPIO-based chip selects, but
the MA35D1 QSPI driver currently supports only the controller's two
native chip selects.

This series enables GPIO descriptor-based chip-select handling in the
driver and updates the binding so that num-cs can describe the total
number of native and GPIO chip selects.

Patch 1 removes the native hardware limit from the binding's num-cs
property.

Patch 2 enables GPIO chip selects in the driver while retaining the
hardware limit of two native chip selects.

Changes in v3:

* Split the binding and driver changes into a two-patch series.
* Allow num-cs to exceed the two native chip selects when GPIO chip
  selects are present.
* Remove the driver's upper limit of two from num-cs.
* Rename the native chip-select limit for clarity.
* Reject out-of-range native chip-select indices in the setup callback.
* Retain active-high support for GPIO chip selects only.

Changes in v2:

* Enable GPIO descriptor-based chip-select handling in the driver
  instead of disallowing cs-gpios in the binding.
* Set the maximum number of native chip selects to two.
* Reject active-high polarity only for native chip selects.

Chi-Wen Weng (2):
  dt-bindings: spi: nuvoton,ma35d1-qspi: Allow additional GPIO chip
    selects
  spi: ma35d1-qspi: Enable GPIO chip selects

 .../bindings/spi/nuvoton,ma35d1-qspi.yaml     |  1 -
 drivers/spi/spi-ma35d1-qspi.c                 | 32 ++++++++++++++++---
 2 files changed, 28 insertions(+), 5 deletions(-)

-- 
2.25.1

