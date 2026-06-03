Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD4137DEAB
	for <linux-spi@vger.kernel.org>; Wed,  3 Jun 2026 04:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780461360; cv=none; b=J8YocEp/j+iaN8dMu7vRlLm4Z76qEWzeJAS9CNFzm387X1fjOsSGNxJu4K+g8MHkFC73F2Lfanc088j+zfE+06YGeCGXXmHrDmIIl+29o6UzWhuMi961pv6dodXcUb3rGzs/KZNdAtHtypX69FDzU/4MaudnyJw7VxcxUa3ew48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780461360; c=relaxed/simple;
	bh=68R74o9VrBEMJwdcK66v6DldbmYlGyNpbQtvPuKnu84=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=flZ08ldxqMZY4nNJbK/wH8QdkfR0RUup/lZpAYNzvm+0tv8lKnTuQNATiNjaJByq44h2BjyN0xsWoVzGCgKEFnzAVY90uN1NG3ojzfpZcWdBzpn9MLJ+kS2YVBjwBkjAX3BX98XORd2Iuku87yHapnCmuoCRLpGfPkko8ppz+NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f526pfRu; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f526pfRu"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8423f869421so2373156b3a.3
        for <linux-spi@vger.kernel.org>; Tue, 02 Jun 2026 21:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780461359; x=1781066159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iQaGls+cCUTlqsfODIVaPJ5QJAcFj3/QMHEsorpgOH4=;
        b=f526pfRubr1dhquordR3WbfrmXrdTN+5ILVhdmcfT8n5FjwWqZNiHrfw8nr2mIUKtZ
         xbfZkJSDIMcn+6n3fPbTYw1tDdw4sBtyJqAYv2HpT281+otOWu9bumWUr4664+aF4U/J
         HURXSrLgzBJYMcdQdbT4oISPaV/cHPJ0OQViwdBx8p+bI8T9Zv2rlPXa//soqT78ihFG
         E+5ZNbyos4jivbaeyrtxacRaRS+5oolX5aDv1eK22qf3zm/QFAhH1rpKHAI+tm1Sy98V
         2EgTvVwBd7f7riRXtjQhsI953vJJ1vF0HE4lcs6szGIPkPA8JsfwGSpbnKyyR9Y7l6eA
         OS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780461359; x=1781066159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQaGls+cCUTlqsfODIVaPJ5QJAcFj3/QMHEsorpgOH4=;
        b=GRD50ltrjpz1s6nnV3Q8zJNNH8GBlk9qIW+PUWXBR7eYAQh1x+WHnjzx9zFKxEcbnZ
         w3s49aG2+5VVay2crDChmr+JEzVmGd4Jlg0rKph1zc3gkqj75ZbJdLZ8JnL1/lIa9AF5
         XwJUXq7Jb+Kb3pFQPsEglij2XEMYedreEYuqkN78wrFJR5jG2GUjt65uK6pBmpggC5df
         flFDzx3/u9004gbg26FZmN+rJrn/0tChmp+bwryDblXnsroiUQYk+C7kihoY6Dye9Mbu
         iaMZBSZW24TtIHBEr9w82I49KEJxke8zyUFrt7hhOZClUUSI0tPm5j+FCm7avO9dOlhv
         mZMw==
X-Forwarded-Encrypted: i=1; AFNElJ95UVWugbbvoL3nqelGrvuyIbu/9W+Ceum6UOKgMqYK++OeoMSq7UlpmAsiIHaEOdfqiLOMfJ/8B0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7bGJT/IE7s0EsxnvPWjseZJEh+vIo+vxlhhpsR50ucMp9YYVV
	0LqXNg4r97lxtABpYYS9mYD7uMaCBUqLUZGXxJEL1uy7vOBQPsaV4Wf4
X-Gm-Gg: Acq92OF5SLUWjJFisVnmfr0qKVk3ycIQ8ZTp5QHPO6L62meMeCEgxr2nyjUiNleLLXz
	CGzjMBP9HUZTb0b4ip6cW4ZFvWFs6e4VfxlGkghBPnd53K8zEvnm2gAUtCl8wrJR2hOwS4vd3yh
	BEHhaKMPltK0T8uNBC87xlfLiqBGfEevZBM5pu0BkSMsXUITFNg6qqg2pw20SveXM696PL4D/kk
	2ajyTHZVNdVr1FeeA79wxi2Sco+bqxIpU1ZxtbXLDP9qmQF0AOGPXNceuk6ZeBf6HrMb4LutYmb
	skwydDGeL9OosYCDdLMe2dFBeFYYgan4mONZvmKbntfHdazslvZUagDAMZiNA0kE75Zb3RVttu9
	mBFeb35KQBnl0wr9KCtYezeRR8OBaMfIXiWHF3BXdC0duRami8L3sbZDfixfZbvM7IoL+wKspc+
	R0ViAWM252yiYR5Vhrsg0jR0RGupuZsacYP+svJSlCmzzduaDNZljpBjzggFWf2hH6oOiJnVS1n
	vj+Lj8IZ677K2zuMUvqy93t
X-Received: by 2002:a05:6a00:4085:b0:835:443e:4bc7 with SMTP id d2e1a72fcca58-84284da6fd5mr1639543b3a.13.1780461358687;
        Tue, 02 Jun 2026 21:35:58 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282904889sm1478742b3a.55.2026.06.02.21.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 21:35:58 -0700 (PDT)
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
	Chi-Wen Weng <cwweng.linux@gmail.com>
Subject: [PATCH 0/2] Add support for nuvoton ma35d1 qspi controller
Date: Wed,  3 Jun 2026 12:35:49 +0800
Message-Id: <20260603043551.1062112-1-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds qspi driver for the nuvoton ma35 ARMv8 SoC.
It includes DT binding documentation and the ma35d1 qspi driver.

Chi-Wen Weng (2):
  dt-bindings: spi: Add for Nuvoton MA35D1 SoC QSPI Controller
  spi: Add Nuvoton MA35D1 QSPI controller support

 .../bindings/spi/nuvoton,ma35d1-qspi.yaml     |  61 ++
 drivers/spi/Kconfig                           |   6 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-ma35d1-qspi.c                 | 579 ++++++++++++++++++
 4 files changed, 647 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
 create mode 100644 drivers/spi/spi-ma35d1-qspi.c

-- 
2.25.1

