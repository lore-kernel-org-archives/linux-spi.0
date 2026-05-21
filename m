Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2C82F39CE
	for <linux-spi@vger.kernel.org>; Thu, 21 May 2026 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374720; cv=none; b=FlV9k6aCvNoQoEmXhaFz2t3XGjVuKRHSpZaY94tA8o9JKbbOIVCyloXco/9i9A1hwFJ7ftVMZAWuJJdpSKv4IGfo/QtULMNj2wrIuD9y2qp7MfxNkC2e69qUbTNP7BKOi0mdjEP5J+2T7Y6TJFyvTnq6XfM9gk1ypHLwi9421Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374720; c=relaxed/simple;
	bh=niGbdLtWYmxOuaPaN43bokPEuaiPAfLAecgrPZ1TUoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=amSrhe3ybjgmxeZ8pXVgaF/AdY6+7lqPOKC8tXLG8giYZ5V7KJv6HcRDNLv4zqxMcX9erW8wYlywees82Ua6ZRJ1R/O8tlcimwbrmDhk83C+bIHgW5n92hzPa+G39P4qB+9yhthDgUUfAMqi0mvd+u7lyVjG3g0r3X46W3P1rUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ut6AHM2I; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ut6AHM2I"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ba4efedbeaso45425245ad.1
        for <linux-spi@vger.kernel.org>; Thu, 21 May 2026 07:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779374717; x=1779979517; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3LTiYFbcU6wC49KHcSNJ/mVq4ewVk4truPy8q0vUtbk=;
        b=Ut6AHM2Ihl/PMuzE/Tukrn5x/rKVQQEQfYrsUZUeSI9sOzjBrLrPXfkHUwcGaceeod
         RAojmeqmKghsIrB0RawdJj1YT6DKVo7h9kdZrcRg3eSubPMYJtn1KMrEwoSX4m7J4B4t
         mBX395ma6QZi6Zqxbua/XR2uz1W59owdHBEOtr5d56CRhMFJ/o67YirPwWMQ06gHyV+d
         RZ5TldqsPOVJj+9Qh2DqafSjW7YNx4HevwZbRf07uYBVRzuWj+yzakS8NQhhHXfx/9sH
         C17gMynmEXZwCZhY3v0BpzL734K8Ps5DoKNMI1tWxMGNxdl0CP1Q/0ZHGNU2/hNRFOsz
         ipQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779374717; x=1779979517;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3LTiYFbcU6wC49KHcSNJ/mVq4ewVk4truPy8q0vUtbk=;
        b=kWoyavz3+EqdfH/rWXZMHQhPRITWQ3aLOpCoz1M+S267+z8f0lwVghItMx39qP6s4q
         JdZphmvImCUdoggo3OVLsACXqqXzeNf8klDmSVRjHuvJJN7P5Q2UB9n98GMr/yh56MmV
         u2jMlSs3mDGav6JBtXJKBq7eRspX4JCTImm83sqv3LpUFSi5xr1p/LWt1vfWDyIhiqDO
         IEs+YrhF0yEqL5qdh4eI6YfFYxL0fBuHFaCOzU4iwyfCNE/1nk0ZOkflIpY5JrzgG8o2
         5djoJqtzjIkvpTMWDs1cn/Pt4Iau39ooFk/x/P1QG1WQ3ruuW70kAsTEnVr2WBIl48PY
         5Sng==
X-Gm-Message-State: AOJu0YzwYqkLggV67mV5cjjBdq2K08RAwMFkmfx3Y98Petn4sV8wPJQ7
	eePyjbUTFgMqyvbL3hv9iN6JR4/kn5/OfaEG1A7rzzBKl6vPXWO/DdiJ
X-Gm-Gg: Acq92OHyTNL9cQpRcU3pwmsgAmMO5ots9V/JyCKVj3RiPw2CVtR28JkzEmHhpGEfWTl
	+H4qSJwwpR56A4O+OI4ciG9wXX90WT2eQbV/sY7Vui+9tgODawyse26IEeU5bOFJR3c1QNZjT5p
	yG7n1t3aRzUWfKmuxBWQ84/E8de19Tc+84ryAdnofWSJRPCAjgCP1KKZpTR2ms6WDAsXAj4wnEB
	kW9vj8AjNYmC+UiTtIhHFvhkHPwDS1+JoVLnkB/lLPkNplnRg5nxve6G1MLIT0/Z8G78QwS1heU
	B5jHtRFYoI8TxErvQCuMRll76ZgvOpsRIuf1d5XadSXBuOpBPzNesc48XwGiXCYdPJEtL+ECGXB
	DUryCNWluaT42Ma6Ujrof1nOYRBW805iElcamb5IPNbWBghjbj0Eh0tfDX4UwQxvDYarxnK8IYg
	SpdLJHL7tDT2X69k3pjMzKGbA9Hl4dbQ==
X-Received: by 2002:a17:902:ec84:b0:2bd:c5f8:504f with SMTP id d9443c01a7336-2bea35e13bdmr34721505ad.40.1779374717456;
        Thu, 21 May 2026 07:45:17 -0700 (PDT)
Received: from [10.240.146.115] ([2.27.148.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea990f667sm13261475ad.62.2026.05.21.07.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 07:45:17 -0700 (PDT)
From: Zhengyu He <hezhy472013@gmail.com>
Date: Thu, 21 May 2026 22:44:45 +0800
Subject: [PATCH v2 1/2] spi: dt-bindings: fsl-qspi: support SpacemiT K3
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-k3-pico-itx-qspi-v2-for-next-20260521-v2-1-52bce26e5fd8@gmail.com>
References: <20260521-k3-pico-itx-qspi-v2-for-next-20260521-v2-0-52bce26e5fd8@gmail.com>
In-Reply-To: <20260521-k3-pico-itx-qspi-v2-for-next-20260521-v2-0-52bce26e5fd8@gmail.com>
To: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 Wei Fu <wefu@redhat.com>, Zhengyu He <hezhy472013@gmail.com>, 
 Cody Kang <cody.kang.hk@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1125; i=hezhy472013@gmail.com;
 h=from:subject:message-id; bh=niGbdLtWYmxOuaPaN43bokPEuaiPAfLAecgrPZ1TUoQ=;
 b=owEBbQKS/ZANAwAKAc32nDaAuA3YAcsmYgBqDxpvWmnMnZ47DBxJRrP0paCNfmcE8KttLsrcO
 fWP+VpDyxiJAjMEAAEKAB0WIQS9XD2kxy1NmfC2u/XN9pw2gLgN2AUCag8abwAKCRDN9pw2gLgN
 2EDjEACF70KrGYUz1B8eIr18DxEfVXeO3tv1w2uDnROb018ze368iFdbCEj3A4Wumpzc5w8kcJc
 TMa+xI7ZxJUOYkBY4oqlM9XFzdPtjHJHDmUeIiIXR8uu9o6IXw/ijjK02N7Kgj+GxvLPrjCjFSO
 eDtbVSh5gX4/zb/wl85yojEjGXyedk+jQ1XXzd1j8PtmSFe+oS27v81jTI0cW/iIKMuZ6ZVfZY2
 F0pDcaM5eCgZgmIr3AjDWJMaWmD+N7x8expa/8m6kmfcoBxmckIHD+UN5axI7fI7a2yrNmV3bWl
 pt1PuuopiusSOTV/3cnvV1XOlydtpzfTyPysZVIBwI6iluzeiS387jd7j0jw97l7pDx/La4k9Tj
 v3WSw+LoJc/L1rxwgjwmSfvbsQQ5t/PiJnNMFvSaFkvJnSvHjUGCMiAzeQQBtCjxLjwluczk9hk
 J2XZDVEo6hkQxnd2TZ1dAX4yBp60YDqeY42HfZWTWVc9EqoVqBR8qebOcfrQShLr4F1rAK7n+y7
 DdaZDUB8yvdQvTQE9wHPgYkm0DZxmW4LOZhKO0wL5O8ZtNhjxXTjaf1nsrZV0/d2n0n6ag9TQF+
 nlYc6ZcDfLLpHjr4Gh+IvUYlErDGiT0GrwzRO5gi50BZNfL1Ej+MivsjgarP28XsWaCzNbqUHQq
 HGCObBeI2tXNlDw==
X-Developer-Key: i=hezhy472013@gmail.com; a=openpgp;
 fpr=26CA97B1A229C229822278F254AF850165158959

Add the SpacemiT K3 QSPI compatible to the fsl-qspi binding.

K3 and K1 use the same QSPI controller, so document the K3 compatible
with "spacemit,k1-qspi" as fallback.

Signed-off-by: Cody Kang <cody.kang.hk@outlook.com>
Signed-off-by: Zhengyu He <hezhy472013@gmail.com>
---
Changes in v2:
- Use "spacemit,k1-qspi" as fallback for "spacemit,k3-qspi".
- Reordered Signed-off-by trailers.
---
 Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
index 1d10cfbad86c..504df31a4f90 100644
--- a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
@@ -20,6 +20,9 @@ properties:
           - fsl,ls1021a-qspi
           - fsl,ls2080a-qspi
           - spacemit,k1-qspi
+      - items:
+          - const: spacemit,k3-qspi
+          - const: spacemit,k1-qspi
       - items:
           - enum:
               - fsl,ls1043a-qspi

-- 
2.53.0

