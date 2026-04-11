Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C0E3AD511
	for <linux-spi@vger.kernel.org>; Fri, 10 Apr 2026 15:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775833493; cv=none; b=bXwVm0zcZGs9aS0Tw/Lnypz4vqnUPibVEULVa3a3q/9w/9taMN/g7BXTikR+RRDJT2bPG8lls2ntieD9H2MG6PR0yagb1Xytwx5e8paXUliIp9prJjta1caPinTtXcEGHIw0Soo/WkfA7acn8oF86xrTwRCpmcZGyhOpYZsTQGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775833493; c=relaxed/simple;
	bh=LOamkOoU4OVVI8X9g75MJ4lPXrvJuQtSV7WWo3C0igs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TATqNDzPj1Sg+heLiZCYzzDzp49y4j/OUU+XL/UaJ1S+uLgT7khBDp8O1FcNqgoUTV9FEB5USiTgZmwePZcXkWl4aasoMccEJjyJuFpYfMK72jVBl/EBKImufLKosaolpnaOGcv2xkEtQ5Q7kAtZSI6xbTC6wO5LGYW6iBit8HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=xpDKd8rV; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="xpDKd8rV"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82cec955160so1588489b3a.0
        for <linux-spi@vger.kernel.org>; Fri, 10 Apr 2026 08:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1775833491; x=1776438291; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nyFmM55+8nwlvhnoFbA02HWarg4SN6Bckaku3Nj5Ch0=;
        b=xpDKd8rVRn8jw0GkYKrT9km7fQWxnzB2SAnSspjU9pFGuE1HpcQSDU7eTt0pIc2Enm
         thHlzwcBsOaSsLd9bn8JIRyQJB43R1trAqTaKthEvrujJC5DUCKRy1+XQAmaXMIyMAoy
         RpDEd+PANkFS6eNZvZgvA9o5qBdkpMK+t0sIf5118mACZI54EUtYxr1F33tJgE8R+lOa
         e/3T608sU22ywsOHp4JqpUKjcVKFID/AI5gvoVK7SmBCAfMED24UKaJey/9kNHVtJwZf
         yEomSPZT9Fiahw1xPzvvGDJIiff2OuyXhZfF7jODwFe6oUsLWIWU3CWpQSTNLGq86vaO
         wgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775833491; x=1776438291;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyFmM55+8nwlvhnoFbA02HWarg4SN6Bckaku3Nj5Ch0=;
        b=UL6nA6rvKZsUwNMBoV7vcwksS9RdBCNBbryVIPWQg60TzL9SIaZchPEhlFor52x0ns
         /4Y5YRUzMkJxVWMpDLbHTzD9BfwM3hTBFq9w3DmNsXzrt/FRA2ZvMztSJ6hQ32ZUFjj2
         A8+I2Liuv3NFatmyGVtGvz6Orq1/t66OKBldze0DTXNvOTpAkKondy57yWTZ1+s/GdUQ
         A4R2JwSLuLpVvCBjZDgxVhtkqr+J6rQVAzg69yDl+pCXmEiNLK/j7t0TqSl73+8PogHC
         YR6SQ2rWzHGEElHnZ9BQq7MuHzLIPuCD5QgLNcUOvr4IFDjBONzj7zmVPVKQj3DMA8et
         4QYg==
X-Gm-Message-State: AOJu0YyBwL04D+qcXuVLQB8RYgYt/Tl6UtBNbbEhvNGwBg1p5LtjenJ5
	P6annB8J0FzicPnXr4W30vlCN6fYT5vJfiW9gcoMbq4c0ZMnoQdNXaPNC0kGaYC59yk=
X-Gm-Gg: AeBDieuzvxNEqL+B9D8j0uglQs/zoYB9ntPgbbhXRZ1LgwXzvAw34g1pAbVueMt/zW0
	EkSv0ytMnm0eA5EG0s8EIJbPMUC/pH7hX0coeCv/Qja8l/rjWWn8EEDVPu6/soLlooYz8PLnz1W
	rjXPk5T7X1eWQ3g9QUYIKigvpNi1+ozeRArlY3pW8i9rUiIZMPLnvjQFL6HK5XNfleGvHnepGHV
	qiZWL2ge7whDy3Vq2zmWxRNWeub+aeyqcH6adxWfbErZ4xTcVpVNpRUan4s0rncTdZdOR7rVeTL
	M9uynq2VZJyHGxNdiy3eMFt76xPbultK+dqVJpWvWu8jKb9yhXIR4ZGXfegVVs4zqVHotsgZu96
	fvWtvbkSF2sZLV38MxS0dJY+RJC/QYB3oXKVtgBs1Z9mONG+P+HETDNJ0VZGMJ7shM0GaMEvSX5
	XQw4BhHtSXUQw6yhJZg4wA7DHSQEFHySEhmgfOzidmofz09BjH3gKxVfnE5SvsWNpb
X-Received: by 2002:a05:6a00:400b:b0:82c:6b46:271d with SMTP id d2e1a72fcca58-82f0c2efb17mr4220868b3a.48.1775833491374;
        Fri, 10 Apr 2026 08:04:51 -0700 (PDT)
Received: from [127.0.1.1] ([45.8.220.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4d5413sm2970532b3a.40.2026.04.10.08.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 08:04:50 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Subject: [PATCH v8 0/3] spi: support the SpacemiT K1 SPI controller
Date: Fri, 10 Apr 2026 23:04:19 -0400
Message-Id: <20260410-spi-spacemit-k1-v8-0-53ebb48a4146@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADO62WkC/yXMyw5AMBCF4VeRWWvS1t2riAU1GOKSDiIR765Yn
 MW3OP8FjJaQIfcusHgQ0zI7pL4Hpq/mDgU1zqCljmUoE8EruVUGJ9rEqATKLEpMoJSKNLjXarG
 l8ysW5W/e6wHN9mbgvh/8TjubcwAAAA==
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

Version 8 reworks the driver based on Mark Brown's review of v7, making
much better use of the SPI core framework.

(Note, this is a distinct series from the QSPI driver, which was
merged recently.)

 -
 Guodong

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
      dt-bindings: spi: add SpacemiT K1 SPI support
      spi: spacemit: introduce SpacemiT K1 SPI controller driver
      riscv: dts: spacemit: define a SPI controller node

 .../devicetree/bindings/spi/spacemit,k1-spi.yaml   |  84 +++
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts    |   7 +
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi       |  20 +
 arch/riscv/boot/dts/spacemit/k1.dtsi               |  15 +
 drivers/spi/Kconfig                                |   9 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-spacemit-k1.c                      | 782 +++++++++++++++++++++
 7 files changed, 918 insertions(+)
---
base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
change-id: 20260407-spi-spacemit-k1-e0957c311152

Best regards,
--  
Guodong Xu <guodong@riscstar.com>

