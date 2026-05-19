Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB96121C16A
	for <linux-spi@vger.kernel.org>; Tue, 19 May 2026 06:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779171425; cv=none; b=AZtnnECHbvF0RSATH+2OGreOCx0l87bE+l92hyk/2ZtCswPZWKtA4N7j1z20C0JvefgD5CUzKgpiOh9+zoBxTulGLD+Q9flrFF4hcVD1lmYvyLLt4XZLpvakumxfUbUNr/0Wxh/oah1ZKDd1sLzQnlfszNQI3nYtPhS4h0UNpyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779171425; c=relaxed/simple;
	bh=IRf66rMUn0EauExfU5hPO+7wssB+4ZO7/x8sY0FiJIk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RPdEPOS0l08etInnaLfXMfCp/f/KtWizzw/RpAaa30qxLGu6Ayj/L2q4s5N1v3CTWwlNhY1ypNOWMricypf+VN17lKkb+ldZYcY7a4hZ+X0kUumHjjFid+jtaWSUkDd48SX1u9oXA5RU4zGGVlWddra2gkKhW76+5XmdC1k+QN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XF91ZQsy; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XF91ZQsy"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8353c9f24d2so1526142b3a.3
        for <linux-spi@vger.kernel.org>; Mon, 18 May 2026 23:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779171424; x=1779776224; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l4dJkPtRJlrakoxNtYsMbmeYzTOO5LSMpVcjFeyWMwk=;
        b=XF91ZQsyiObH/rcqi+wWzh2c+XdhYjP/YDHp1Yo4rzrgPeoVRyjt6UGa48dHHagY7C
         ymr8YQ6f7/tgB336QbLN/Nc0BR0ycxthm5uEC2QyPJyLL1zuezZPXMTXnQs35m3HDlza
         DCM4uKQ/xgWQp1B3B8FtI5rK64eR0guAB30viejPVz0PLD9J7kh7iH/rr9bXpz+2S/n7
         QIaH0o8M6aq53ezc5slt4vsqrCMvBrmpe4o9Os8/WfqmFrtsYHcYHYZ4OoK9/Xulx22t
         fVn64Nngah1frvgE6IIZcarJ/dGFpJUbIpSw2n7BNdjI+cJHhXbhOTpYvAXQuSxjl70I
         dKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779171424; x=1779776224;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4dJkPtRJlrakoxNtYsMbmeYzTOO5LSMpVcjFeyWMwk=;
        b=cqHEpzrvpiZPFkWnLbsxfBncVHdmqmekqdfpJlGzZU3uYGQFfgrLeq5x+RNGWG1R/N
         dJInr4AJXtak7Ah67DbIxw4W/8XXIHwcRQxsAQNMDOiMj81i/8EsFr+i1O3Lq043hrt1
         xGBvvKS+t8VRFlZOrjfxs3D97Qdt6pRUM5eeYhxAqi4SYZbUKFyj9DRx+yv2TGS+zzXl
         VbD5MV0tAWuihEUWHpcwvK2a9ZUOjF4c9l6Nzbs1c8qggXCT4Q76HkjURiSCSkSKhOvP
         yln4mFiCNTslanPL6CMSnV7q64uiuVDbbjPzDULfzcOzVn1jQDmqFOE02qUG8HHh5rPN
         fWng==
X-Gm-Message-State: AOJu0Yx5pb/9e/GmlOYenUd3lq//WHLse6IoFgeVvSfwQqYqTsSEctb3
	EcOwwilg6yIznGT3Q1Z3pv5FgIqfD+pUZqRlhybTd3vwBbceTTs82R3s
X-Gm-Gg: Acq92OFXbttnfumZZHwtsgC4MKWbU6NCq9JiAfev6VTmDGJSO1un7V97CezT0rqGB6F
	HAwLX3k6X/wxPZX+D52P3bKPS/FQWeTPQh4HeoS7dZT62r55VeJLatMrT9cg1BPnMcghFUyZ5+7
	MOLPAwEo2y170G4k2krL9HMfuv8lF/evjCT8dmv38YD5Q770XEh2AAAxCfjco8Lz5z0spH/zp0l
	3Sh4mskHv51RGUumZ2WXy5eoS1hPA6mhMq5GHxdfVeU8DeTfB1ZAm9oDEmm/S7fr3pJdycVPvvw
	DuUkjArgw6vWAL3JM8lnFw9sYknhnQ9aNDvZ6drce4q3o72Ml4ohNVJM0LByHNNSUfr+GnSv/vd
	ikUX/i9+jltPM+gQtqpf8AwlBEmKnQ6Jz71E8+ygvmjFGGJNFKuQnPeuwxfEjfdgZiU5tHI8e4R
	JV9rSGXBGpxYVs9sS+OcoIVXKgFC0GdXcqS+duq7oo
X-Received: by 2002:aa7:8882:0:b0:82a:6f69:7f72 with SMTP id d2e1a72fcca58-83f33f0fddcmr18309030b3a.47.1779171424126;
        Mon, 18 May 2026 23:17:04 -0700 (PDT)
Received: from [10.240.146.115] ([2.27.148.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c7f202sm16112266b3a.43.2026.05.18.23.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 23:17:03 -0700 (PDT)
From: Zhengyu He <hezhy472013@gmail.com>
Subject: [PATCH 0/3] spi: enable the SpacemiT K3 SoC QSPI
Date: Tue, 19 May 2026 14:15:54 +0800
Message-Id: <20260519-k3-pico-itx-qspi-v1-v1-0-c32afeeaf741@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvyJ7bkGtPPSV6BC21hKoaUgQ/j3pO
 AwzL2RKTBkm8UKiwpmDb6A6AfZY/U7IW2PQUhs5KoNnj5FtQL4fvHJkLAodyaFJbYfRQStjIsf
 Pf52XWj8cBcVXZQAAAA==
X-Change-ID: 20260516-k3-pico-itx-qspi-v1-fe040512c45f
To: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 Zhengyu He <hezhy472013@gmail.com>, Cody Kang <cody.kang.hk@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1315; i=hezhy472013@gmail.com;
 h=from:subject:message-id; bh=IRf66rMUn0EauExfU5hPO+7wssB+4ZO7/x8sY0FiJIk=;
 b=owEBbQKS/ZANAwAKAc32nDaAuA3YAcsmYgBqDABSfcnC9ZjpkklceVU1Dc84Db35p/VpVrwwE
 QDGds/SgceJAjMEAAEKAB0WIQS9XD2kxy1NmfC2u/XN9pw2gLgN2AUCagwAUgAKCRDN9pw2gLgN
 2HqzD/0VAmqmljFG81AwhK9sHmx+W7G0+tQQEk/jObuf+VKS7IU2TNYECbcuBa/u6SMRj0B5R4v
 mas/Bvw0fsXZ8tUPIoblkQNY6illXhaf4Ptj+k/atW51oI7U/6A3o3Fm+3mypFodkn1bLzNoKXH
 SOuiD+fKWCg6LqOMKhkIGSwQ59akev0vQCKY3UV0u0fzC13IdjEFyVfadZ6pw1z8tYVQkPTmt0Y
 ryg3W44kH75nsUbpIEPp3gl35SpGNrK6eVAwUJn8rFryxFcIXiiyhNhvOQ6Szn5PtJrAcRJ/Vur
 fJwYIceLo3QSBxv9yFttP8SjD7Et9BFN2V9bC8htLx39j5Q53pqJWpfbW0/Ul1QuG+PNm92dbPD
 tliQeDh3FbQgvfX8HPO7Ca1c0AVh7+HolFliXHliJK13cDsN3rGTsljCdqtLJBjJ+wHtNsUk6/i
 qIFs2XgDOjBepZq2zwwndBURVG6gYRI7MBiqWPnraOjZgcJ083gVbxwiOXLlpf7unGoWDZ4C/ks
 INTULC98JS7VaoVJqBUGys8eIetJoB52S20S/JpxLCikDKkFXXh6hePzehXnIAYB0Hg1TxmIRvE
 295eKmyvRMfiX7X//ERs8MSS9yCA/sg222P5Haf5mgRz+O1AAsRCVwi6Y54Pn3fWg5QSV5Lqzrd
 PiBjAzVbs7knGjw==
X-Developer-Key: i=hezhy472013@gmail.com; a=openpgp;
 fpr=26CA97B1A229C229822278F254AF850165158959

This series adds support for the SpacemiT K3 SoC QSPI and enables
the SPI NOR flash on the K3 Pico-ITX board.

The K3 QSPI controller can be supported by the existing fsl-qspi
driver with K3-specific device type data.  The changes are:
  - Documenting the SpacemiT K3 QSPI compatible
  - Adding SpacemiT K3 device type data to the fsl-qspi driver
  - Enabling the QSPI controller and SPI NOR flash on K3 Pico-ITX

This series is available here:
  https://github.com/imguoguo/linux/tree/k3-pico-itx-qspi-v1

Signed-off-by: Zhengyu He <hezhy472013@gmail.com>
---
Zhengyu He (3):
      spi: dt-bindings: fsl-qspi: support SpacemiT K3
      spi: fsl-qspi: add SpacemiT K3 support
      riscv: dts: spacemit: add QSPI support for K3 Pico-ITX

 .../devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml  |  5 +-
 arch/riscv/boot/dts/spacemit/k3-pico-itx.dts       | 58 ++++++++++++++++++++++
 arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi       | 21 ++++++++
 arch/riscv/boot/dts/spacemit/k3.dtsi               | 16 ++++++
 drivers/spi/spi-fsl-qspi.c                         |  1 +
 5 files changed, 100 insertions(+), 1 deletion(-)
---
base-commit: 6916d5703ddf9a38f1f6c2cc793381a24ee914c6
change-id: 20260516-k3-pico-itx-qspi-v1-fe040512c45f

Best regards,
-- 
Zhengyu He <hezhy472013@gmail.com>

