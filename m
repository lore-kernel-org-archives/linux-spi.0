Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA654392807
	for <linux-spi@vger.kernel.org>; Sat, 15 Aug 2026 22:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786832612; cv=none; b=c5Z9zOJaVhRkNIJD+7nGi8aomPhap72ybrlceVkBevLkvYCmrqZYcvu3rin7er9S4M3olCkmrHEZdZg9tVF7ARxkJW8utNYFrJp2JVJ3lsXALoXgrlJ0Va/sF6B354gS0blgGaOdrEEg9+SBVb7NiB39NqT0mzYQwinV/ujj8iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786832612; c=relaxed/simple;
	bh=4ckBX63+NOyZ/eJp7AxHa2Rxky0Dx8vI80R9iWBVhrk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hNewEJ6fsDPpNnW04qa329ZJkBv/Jr6NTzi5iJiVxzQrIxnpXi3Cq0G76UH0qrXm8CYrfAMWPvRJaV25nycrF5A3YvB2I4WCE32K9ec3nrlx6IM3jx9VJksWHwR3BNOC1U0yh3EHpe9kD02fH5Mn9uHyxLbbOBCblsD5KMbuaEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSzO7M5B; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSzO7M5B"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ceeee8c46bso5146955ad.2
        for <linux-spi@vger.kernel.org>; Sat, 15 Aug 2026 15:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786832611; x=1787437411; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IVlwDg86TsAdjwUtIMmjPl9UXf3/uKtMhMO29Xp8TOw=;
        b=eSzO7M5B0nHxs6ldYSYplAYumMcd6QmRej9F0G2zTPh84vCIn0biMHqAnxIMI3F6oN
         CmYuLwgEM0l26sI3ps8fuNsHTlql6rQiwSWO5piX2j/M1DQp1mbZTPvaR7g+qDDqdBcl
         1zniMA8O0zo0uoRvPtBcpxiE0jl/ksh1UWCpZ+hghl+UkJiHOdv7lAGbozagGCvitSj2
         ICuBzNnE7CCB4PcM4nDeTnu+GwXWrRkX4ZP3l4/8Ses9oGkoCh7IdMfYkSrdjE3WNIdj
         MBIiKB4R6oHC+3bdHAcOz9Gge1LrDn5x8+ss6owDalJDNRMSEzrM2N/YnX6yIrZyhtxY
         vsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786832611; x=1787437411;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IVlwDg86TsAdjwUtIMmjPl9UXf3/uKtMhMO29Xp8TOw=;
        b=pbvHhl0wLGLZmtAYT04QmWTv/PU7w/BuMGr93DkrbI0WVXzCXZ9tfKAAV1rH7dumMD
         CfyGLLPN1CDPr8lry85pLGWBeqq9zrVjZdqMh26LPYg5tHZc1qIzxogTweyMHWKBwiFk
         6X/m19ybrQZpQZpZUsGiZuI4ktMkkWrIDav1rutJpDqoFpZNQyP40ZGIMOjXlpj8xC9j
         yeG7Mxc4+Bp9R1mHa0qZ5lWDgUOq2TDWaBZGhFPzOxEOS8DLm5BuMkq069KugPlbWdXb
         Qxmh1bJ3LtYNTtk/R8Zsxh9TgFGEF8EcumYwNQKzWVRZtmNmw2EuBLvZDd78ZKv6AzqK
         hzGg==
X-Gm-Message-State: AOJu0YxXnNROyNqhgusHR+/JGvXAgxYYkSG1CWY+WdrvcNkQFjp1VRnq
	lDwwN2wHtf/qAb8r3XisIfGSoPi0kP48V0JsA/ea1hLAhvOS6HVVLUzf
X-Gm-Gg: AR+sD10PfUfCu7J+WFEq83bV7zXNPMuX3IkCuWu59eK6gG8Cu0ZlIVAqsZ0PfjQNRgR
	ZdnMrTfLU/c2EbhGpu/zqmrc3fNbNyv42w4M78mqE6eoNk/18N30Rxwpca5URn4v4rU7vVxh3GX
	A8O9TevpIJ0ukksNdJ+SvF/o4ynVH3yXbuebBtLUmdfEx37HbWS6s+5YmhpkVdF/PZf5hlDv1NZ
	rLMSt5oO9HXLrvGEaOooN6fPqQ6MJzjltYwCi3BZFjGGM2vQ/JtecrGoi7JMfIDmyVWw7Dh2NJW
	at95cpyEhnslTdlyxkBR/VnrMwxSgKduyikei3931lGirY3k1sPuoxzhkUInBVLNIwUvZ5bc5C2
	m6Ih5Zr5mn9Gz1XJth4vBBZ730U8O/dBGYpGSbf9Tcl80ROiXsiEIHmguge4W0n4MTAad6/lyjw
	ZOB0Le2LqMDmDRUBbIs+j9xw2/hJKgartHjm7LxJmphewP+vsJS0CivmBAayFMRkwpC7hgdPfFf
	Yw7+gKfW4s=
X-Received: by 2002:a17:90b:3b42:b0:38e:c140:2a0b with SMTP id 98e67ed59e1d1-3933baae9c6mr11425880a91.3.1786832610843;
        Sat, 15 Aug 2026 15:23:30 -0700 (PDT)
Received: from [10.112.173.252] ([2409:40c2:505d:7e1:7f19:edf4:38f3:dccf])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1413887ee70sm23418743c88.11.2026.08.15.15.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 15:23:30 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Subject: [PATCH v2 0/2] spi: davinci: Convert bindings to DT schema and
 clean up DTS
Date: Sun, 16 Aug 2026 03:53:05 +0530
Message-Id: <20260816-ti-davinci-spi-v2-0-6c6f5171422b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WMQQqDMBBFryKz7pQYapSueo/iIiYTHaiJJBJaJ
 Hdv6r781fvw3gGJIlOCe3NApMyJg68gLw2YRfuZkG1lkEIqMbQKd0arM3vDmDZGUjeqGyY1Kaj
 SFsnx+ww+x8oLpz3Ez9nP7e/9m8otCtS963rrbCeVfMyr5tfVhBXGUsoXnNKCB6wAAAA=
X-Change-ID: 20260816-ti-davinci-spi-e64e4e48b6b6
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com, 
 simona.toaca@nxp.com, j.bhargav.u@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786832597; l=1463;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=4ckBX63+NOyZ/eJp7AxHa2Rxky0Dx8vI80R9iWBVhrk=;
 b=0jZetumw/hBAWJ6bsumj+VSpoyX2QRHHJeO/LyfQh6xvLb0gD5cucwCjfa7mVF0ydPqlGAEzf
 dhZJ/HbLKWnA+YS2AqOiscOOVJ0ZBVr3jvm0tod+sEJfBiyUiIdN4Eo
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

This series converts the TI DaVinci/Keystone SPI controller device tree
bindings from the legacy text format to DT schema. 

- Patch 1 renames property ti,davinci-spi-num-cs from keystone-k2l.dtsi,
  as the driver uses the standard num-cs property.
- Patch 2 Converts ti,davinci-spi from text to DT schema.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
Changes in v2:

- patch 1: Instead of deleting ti,davinci-spi-num-cs, renamed it to
  num-cs to properly preserve the hardware's intended chip select
  limits 
- patch 2: Removed  maximum: 6 constraint from num-cs.
- patch 2: Add standalone support for ti,dm6441-spi in compatibles.
- Link to v1: https://lore.kernel.org/r/20260816-ti-davinci-spi-v1-0-a7f57dfd5262@gmail.com

---
Bhargav Joshi (2):
      ARM: dts: ti: keystone-k2l: Rename ti,davinci-spi-num-cs to num-cs
      dt-bindings: spi: ti,davinci-spi: convert to DT schema

 .../devicetree/bindings/spi/spi-davinci.txt        | 100 -----------------
 .../bindings/spi/spi-peripheral-props.yaml         |   1 +
 .../spi/ti,davinci-spi-peripheral-props.yaml       |  25 +++++
 .../devicetree/bindings/spi/ti,davinci-spi.yaml    | 118 +++++++++++++++++++++
 arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi    |   6 +-
 5 files changed, 147 insertions(+), 103 deletions(-)
---
base-commit: 3eb40771c00a8488fa6ed2cc1fe203477908bf38
change-id: 20260816-ti-davinci-spi-e64e4e48b6b6

Best regards,
-- 
Bhargav

