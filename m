Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD5B1FBEBC
	for <linux-spi@vger.kernel.org>; Sat,  2 May 2026 13:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777728698; cv=none; b=X17oywIyZh3xPTA/XeIVghLQvAK7K6QJEn0Hm6WXjQ78nVH2lOfjCOrLpSY2N+kBs3nDWNtCPupA4L+4quJyvEcsiM3KvyjUOnOUiPwth6SEd3EDAGkR95q6WNNyoyaI+1pNSvufxb6uLv8WwSItnxof7ecXL3VUA4rA1noZXjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777728698; c=relaxed/simple;
	bh=lkmiyBtoSj6syPErmZWpl5ZaHRgasik6AHT5LgoudWA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rEs8vKJP0+71xm/ozOwhaVVPAyJHhjGZWNVEIXo9R4GZTG1UXvfWjucZFttfZrfgZOibvPmQ4Pa2T0SHJ+2pWr26uNZuyjJKj6Iuo893RDaAjVX6wF0MRtVLDXHZfmcHrA2e3+doaIbLYYL7+6ck2BP1+zK9lihePMjHws4ac3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=R614C1MV; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="R614C1MV"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35e576110adso1941359a91.0
        for <linux-spi@vger.kernel.org>; Sat, 02 May 2026 06:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1777728696; x=1778333496; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5MLqLxOUOJNZlsERU0GicRjBWqhmqv+EmlMe22clUuo=;
        b=R614C1MVGR1bF74HUskGFkTdB6Ihd62D8nXwxyN2ndnBpAxlm1RPNVCwYiXOofsvao
         pyTASvzHCOOV/tdf4tw804sFy4rk3Xx4nJhNhy0ed0AjZhEMYaLQPYHfMOHtJmalmt8R
         h1ttxD3mNgxmMvwOzyoEukIdFYqyqUzrTkabBr9Hu7mqlH59VlWi84WV5waxblOcdUNY
         MrG2/mAWVXXp7m7QSHXX1oXZb3tBUiaHDjuc+i/CSBee1VbXUzaGF9A/YAyaFYj2msi9
         JOFQhgYkdlzuRryYVvrza2tAGQUWqnWpkO5GeFwDyEi5nwhg0tEawJOGN6Od+7ARuH9z
         8C8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777728696; x=1778333496;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MLqLxOUOJNZlsERU0GicRjBWqhmqv+EmlMe22clUuo=;
        b=slboTcBJnj6yv5ekdNm1rWy3uHYAR6FH9nFw+Bd5pJVn0KIlVjOrd1zwpNGpRl9OUw
         vfY96jHWOFdL1thSSPAUKbzKd32Vg4WnquM/rS2G3P+7BAkBspNVfZ70SyaSq1wEbbXw
         1OIn4SfByHgX0W8mlNQF6JslaANvL5Sn7268rzl7Qpeaa1ZenxGt/ADuBwTogtqSSd2+
         LFsoEoqvnBg7aYZKoHMd4tBeK5MsMYCWD3UE6UG1YvQPbvbG3OVCxPzubH0o3IHXhJ5K
         b3s/oy6uN4xd6dxC+/u8Bsk5WybgHt6xpdpHV9T1qQi8PLp+7JyAdc9coBN8XHz5RfNY
         w74A==
X-Gm-Message-State: AOJu0Yw7KXUb27Abs08148idx6R4iC+2y15eAzKF14AzYH80CtA5j4Xb
	2yMcIv49KLzUuOWTzqLM+ufRqAT853oop7gxI2Yt2Hl/kcoUVr0CUumOw90H4PYkSMA=
X-Gm-Gg: AeBDieuG0/c3K2Whf6xEcr/eonjeSu8pgoO5+LC3GORCWnfaQp9GQfqwqfEy+1+gYK4
	qHcCphqGW5WLEl/PC0N6Zgq7JHrk5+qfiuhfNrEiMt0EFVR+kIoYg+edVUS20JcKd00ndKpxiqZ
	2qGv6sk3mLG8j/Z6BMdwvRVgseimREOL+UrfTCpG3ANrOFyr5g5lFwdHmo6dG+iWVzP9UpbX1HL
	MC0MsB8Kfbhxy5CBfWGi8wtoNpJJBEmB5ju2f8QwAoqMXabuNJde9vwbeI8JxM6LLZtWGm5wLSB
	0fChjHnUwBX2+OxZYdZlUm+wgPAG44IhyVihx2BWiVuWrcmZWea8oII0kPvkkcwYElvKjKT89zC
	pppDf1nKwii/O4BqMh13TyWwGfjp8z21LykL7/bPhxw9KYZX5P/Id7shOHLiA7AK5RpIK3c/43a
	cL47CnOAeKFNZa/zkWXXPzglJl9j92tIjQYXSOghV0Z+YaDigh0dQSUA==
X-Received: by 2002:a17:90b:44:b0:35b:e4f0:f9b4 with SMTP id 98e67ed59e1d1-3650c4b9096mr2766949a91.10.1777728696153;
        Sat, 02 May 2026 06:31:36 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::3016])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ec02ab2fsm5647937a91.14.2026.05.02.06.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 06:31:35 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Subject: [PATCH v10 0/3] spi: support the SpacemiT K1 SPI controller
Date: Sat, 02 May 2026 21:30:50 -0400
Message-Id: <20260502-spi-spacemit-k1-v10-0-f412e1ae8a34@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEql9mkC/2WPwU7DMAyGX6XKmUx22qztTrwH4pAElxm0dYuzC
 DTt3XFXDogdfLD9+/t/X41QZhKza64mU2Xh+agNwlNj0j4c38nymw6MA7eFDnorJ9YKiQ5c7Cd
 agtH3qUVE74xenTJN/HVHvryuvVziB6WyYBbFnqXM+fvuWYdF90tHeKDXwYL1LcXYDaHDbvucW
 ZKUkDdpPpjFoI5/EO4xYB0VMU29b6P32IL7h7itITOdL/p+WZObGISs7hWya2q/AZsTqvj2A9P
 yVQszAQAA
X-Change-ID: 20260407-spi-spacemit-k1-e0957c311152
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Alex Elder <elder@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Guodong Xu <guodong@riscstar.com>, 
 Alex Elder <elder@riscstar.com>, Conor Dooley <conor.dooley@microchip.com>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.15.1

This series adds support for the SPI controller found in the SpacemiT
K1 SoC.  The driver currently supports only master mode.  The controller
has two 32-entry FIFOs and supports PIO and DMA for transfers.

Starting with v8, I am taking over from Alex Elder to shepherd this
series upstream.  Alex developed versions 1 through 7.

Version 10 fixes a buffer-offset + unsigned underflow on 16/32 bpw
transfers (8 bpw worked because bytes == 1), reported by Mark Brown.

(Note, this is a distinct series from the QSPI driver, which was
merged recently.)

End-to-end tested on Banana Pi BPI-F3 with a GigaDevice GD25Q64E SPI
NOR wired to the spi3 GPIO header pins.

BR,
Guodong

Between version 9 and version 10:
 Patch 2:
  - Initialise tx_resid/rx_resid to transfer->len (matching the
      "bytes left in transfer" struct comment and the byte-stride
      decrement in the per-word helpers) and divide by drv_data->bytes
      where the FIFO burst is capped in words.

Here is version 9 of this series:
  https://patch.msgid.link/20260427-spi-spacemit-k1-v9-0-ff753b551302@riscstar.com

Between version 8 and version 9:
 Patch 1:
  - Subject prefixes in the order of "spi: dt-bindings: ..."
 Patch 2:
  - k1_spi_dma_prep(): nested ternary to switch.
  - k1_spi_ssp_isr(): return IRQ_NONE based on SSP_STATUS bits
  - k1_spi_ssp_isr(): rename reading of SSP_STATUS to 'status' (and
      'top_ctrl' for SSP_TOP_CTRL); stop overwriting it.

Here is version 8 of this series:
  https://patch.msgid.link/20260410-spi-spacemit-k1-v8-0-53ebb48a4146@riscstar.com

Between version 7 and version 8:
  - Use // comments for the file header (Mark Brown)
  - Remove open-coded DMA mapping (k1_spi_map_dma_buffer(),
    k1_spi_unmap_dma_buffer(), k1_spi_map_dma_buffers(), the dummy
    buffer, k1_spi_io struct); use SPI core DMA mapping via
    transfer->tx_sg/rx_sg instead
  - Add can_dma() callback, replacing open-coded transfer length
    checks
  - Add set_cs() callback for chip select control via the
    TOP_HOLD_FRAME_LOW bit
  - Switch from transfer_one_message() to transfer_one()
  - DMA completion calls spi_finalize_current_transfer() directly
    instead of using a completion
  - Add SSP_STATUS_BCE (bit count error) to error detection
  - Return IRQ_NONE early if no transfer is active, before
    acknowledging interrupts
  - Simplify k1_spi_driver_data struct
  - ~160 fewer lines of code

Here is version 7 of this series:
  https://lore.kernel.org/lkml/20251114185745.2838358-1-elder@riscstar.com/

Between version 6 and version 7:
  - DIV_ROUND_UP_ULL() is now used when setting the speed, to address
    two errors reported by the Intel kernel test robot on 32-bit builds
  - Fixed a bug interpreting the resource pointer in k1_spi_dma_cleanup()
  - The driver is now built as a module by default, if ARCH_SPACEMIT
    is defined

Here is version 6 of this series:
  https://lore.kernel.org/lkml/20251027125504.297033-1-elder@riscstar.com/

Between version 5 and version 6:
  - Rebase only

Here is version 5 of this series:
  https://lore.kernel.org/lkml/20251013123309.2252042-1-elder@riscstar.com/

Between version 4 and version 5:
  - Added Yixun's Reviewed-by tag on patch 3

Here is version 4 of this series:
  https://lore.kernel.org/lkml/20250925121714.2514932-1-elder@riscstar.com/

Between version 3 and version 4 (all suggested by Yixun):
  - Fixed an underrun/overrun comment error
  - Renamed a pinctrl node
  - Formatted dmas and dma-names properties on one line

Here is version 3 of this series:
  https://lore.kernel.org/lkml/20250922161717.1590690-1-elder@riscstar.com/

Between version 2 and version 3:
  - Add Conor's Acked-by to patch 1
  - Add Rob's Reviewed-by to patch 1
  - Added imply_PDMA to the SPI_SPACEMIT_K1 Kconfig option
  - Fixed a bug pointed out by Vivian (and Troy) in word-sized reads
  - Added a comment stating we use 1, 2, or 4 bytes per word
  - Cleaned up DMA channels properly in case of failure setting up
  - No longer use devm_*() for allocating DMA channels or buffer
  - Moved the SPI controller into the dma-bus memory region

Here is version 2 of this series:
  https://lore.kernel.org/lkml/20250919155914.935608-1-elder@riscstar.com/

Between version 1 and version 2:
  - Use enum rather than const for the binding compatible string
  - Omit the label and status property in the binding example
  - The spi-spacemit-k1.o make target is now added in sorted order
  - The SPI_SPACEMIT_K1 config option is added in sorted order
  - The SPI_SPACEMIT_K1 config does *not* depend on MMP_PDMA,
    however MMP_PDMA is checked at runtime, and if not enabled,
    DMA will not be used
  - Read/modify/writes of registers no longer use an additional
    "virt" variable to hold the address accessed
  - The k1_spi_driver_data->ioaddr field has been renamed base
  - The DMA address for the base address is maintained, rather than
    saving the DMA address of the data register
  - The spi-max-frequency property value is now bounds checked
  - A local variable is now initialized to 0 in k1_spi_write_word()
  - The driver name is now "k1-spi"
  - DT aliases are used rather than spacemit,k1-ssp-id for bus number
  - The order of two pin control properties was changed as requested
  - Clock names and DMA names are now on one line in the "k1.dtsi"
  - The interrupts property is used rather than interrupts-extended

Here is version 1 of this series:
  https://lore.kernel.org/lkml/20250917220724.288127-1-elder@riscstar.com/

Alex Elder (3):
  dt-bindings: spi: add SpacemiT K1 SPI support
  spi: spacemit: introduce SpacemiT K1 SPI controller driver
  riscv: dts: spacemit: define a SPI controller node

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
Alex Elder (3):
      spi: dt-bindings: add SpacemiT K1 SPI support
      spi: spacemit: introduce SpacemiT K1 SPI controller driver
      riscv: dts: spacemit: define a SPI controller node

 .../devicetree/bindings/spi/spacemit,k1-spi.yaml   |  84 +++
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts    |   7 +
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi       |  20 +
 arch/riscv/boot/dts/spacemit/k1.dtsi               |  15 +
 drivers/spi/Kconfig                                |   9 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-spacemit-k1.c                      | 789 +++++++++++++++++++++
 7 files changed, 925 insertions(+)
---
base-commit: 559f264e403e4d58d56a17595c60a1de011c5e20
change-id: 20260407-spi-spacemit-k1-e0957c311152

Best regards,
--  
Guodong Xu <guodong@riscstar.com>

