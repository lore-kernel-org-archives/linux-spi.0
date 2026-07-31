Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6766F29D27D
	for <linux-spi@vger.kernel.org>; Fri, 31 Jul 2026 02:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785465508; cv=none; b=HTHlO0F079Snrfdde5Jqmu+xvHDuqtZASj8Py/DMFFzL34bkUds0LC55pMr6oMs+G9cNZbWFt0vxWlrE75Vhyu3RaB3Qr+IkWfXG4tmnotsw/FLBqxOpbgC8jpz7kiQ2GpxHOdWJg4KSL5EDjIf9+q/vCk/X+cAXX6iGYbMQMJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785465508; c=relaxed/simple;
	bh=i2RXd3Nh3cX0+FITG5vAZvuN2a22raGY2IRK4XrFbRA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pkltXeXzBIUBuJmI15UgtZ9igUjFPBLESfgExzy1T3+Cy2b2BAsmYEKW4NIu93ialMCfOaA4eSTEYwfK7xqxD681oxpVSXrHt3NZGAPi8akkYjc6dIwNvbRwHZlwzsAFXXytp13y0dtWIkrau9fDPZyzZhVZuFsZUNYP2SqEuLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhtzFVXg; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhtzFVXg"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8485ef63b68so597285b3a.1
        for <linux-spi@vger.kernel.org>; Thu, 30 Jul 2026 19:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785465507; x=1786070307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a7nGbc39gTC+6W7YyaE7zf4mojKQP8S+x93D9t97UTc=;
        b=HhtzFVXgdrWlbvG2OY/MKObtA1a7u9dBdHT4h/XsLLbJQ61ELTTkyeHGar2UyC2iLy
         skCcitdHUAVgreEmECdX9XHbkr/TE2fSEMuk37Tt95huMN5swNUOxcJIw8wDpzYx4L+T
         B3aRWsvB4U9IYE1rSNFe0idpqwVagIOEp5i7wKa+mliQlhsXFit6EzA+zT/2gJj1BjM1
         ev9EMpev+g9SzQH4n8Hjs3W+OuIXLznwEPoRpbaH8ql3FUhCjjNmBMd8exdMDPkHOj23
         XY5wfUoYd8vOn09iGy1R8H7yGXeu3OtfTjhg6z9o0S79/B0NS5iYSmvoLdE1rtCb5WH5
         hT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785465507; x=1786070307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a7nGbc39gTC+6W7YyaE7zf4mojKQP8S+x93D9t97UTc=;
        b=qgsW2LsSOU2a1DcmPyV4TOKmX/WNb/7voVodRUBFY6B3dPayOMMJonnLCLe1HFZcxC
         UUyk6oZ0pPlKy4NuwbwGdF/mgc8hhpBtjadm2wPzodoly5shf8X/1QMqsUNkp5SIeybf
         PtPPMcmmNW+0W7nXr0OY91VB8zYV9u5Na58L4Vg4GA/hD/OKNjm/jOonvf7ZPgXyJnW3
         Ny/qOBS4Rkd69YnmLmHooc7FC+++1Vctr5GnLIPfQNqqTVMYUSIiTodLDvx3E5YU8Y0i
         3a1Oe/cAwm4NkZBOlepLbu7DGOfTeRyc16HU4yM7DU8EoxVYwyDpFse5yKlgLo8MTle9
         GGqw==
X-Forwarded-Encrypted: i=1; AHgh+Rp4UdCGlfB0JViTlXpcCjXZTW10C+OiK0cFuPEuDEy7HykJ/k+PstYkqwLTIYTfocbq4opxr5G2q6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2NKbEHDHK2cE3jZJsYCzBNO24kAWL5JHX7hPkLUwXB7lulFNU
	Ea+pqIxopAvXn8X2OXsGtHAQAmpqCMJUpiTdKh3pDbxNOl9nK+Gobqpt
X-Gm-Gg: AR+sD11oF+9Q7NANtDMpxSH7xsICAVJdc+G/HQtaWtxT/azIfwySFigKAxslfa6Y9yp
	QyxWw3wDvtP/0F65i4cmSEGpdO6CRUtKyK1yHtgNhBZsEHMsQb6H7SLV9jt7M1/hdsMsHnYTdo+
	nd2E9Qb5W9YZaD/CyzDUotCVJypw5TBuGCluVDN6jaR1epLqxvgBjdKJKR1nkyrDBbMLnjDw896
	YL4Wqvazitc/ZNxrmgKbYb4TSX526+Fc3aHll9lvjR70E0HDfCgKVVK3dsCoeHohivmeteTTkd/
	4yFwPB9o8l4rIWqtNMX30ecNhEhw5jD6Q3Q++jJeJW5stCQQQg4SE6Sy3cJS6kp/jl7It6Fze1H
	2ll4gecUIh5HOieSz0jruJjxL/0bQJGDTRK1y6/U+q/RXSjy4a+jkxoEGHWByBFIxUbN2PeKJKI
	GPTFQjw1D/E1zMWIa55Q81t+AyfWKRxC/iwWT6K0UELRfA7CXSw52BzHVl+O85bLl3mIUMlStGB
	Uyz8KHFojC8nY/IVKhHBqlhypwP+rFAJliUPEeWhRBwNzGIJmYJ
X-Received: by 2002:a05:6a21:4d02:b0:3c0:9c18:d5ad with SMTP id adf61e73a8af0-3c91b526f6dmr45001637.74.1785465506628;
        Thu, 30 Jul 2026 19:38:26 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe3808a8d9sm81938a12.7.2026.07.30.19.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 19:38:25 -0700 (PDT)
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
Subject: [PATCH v5 0/2] spi: ma35d1-qspi: Add Nuvoton MA35D1 QSPI controller
Date: Fri, 31 Jul 2026 10:38:16 +0800
Message-Id: <20260731023818.1626075-1-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chi-Wen Weng <cwweng@nuvoton.com>

Add devicetree binding and SPI controller driver support for the Quad SPI
controller found in Nuvoton MA35D1 SoCs.

The controller provides two native chip selects and supports standard SPI
and spi-mem operations using single, dual and quad bus widths.

This initial implementation uses 8-bit PIO transfers and supports
per-operation clock configuration, clock and reset handling, and direct
execution of SPI memory operations. DMA and active-high chip select support
are intentionally left out of the initial driver.

Changes in v5:

* Changed dummy cycles to use output direction in both the direct
  spi-mem path and the generic SPI transfer path.

Changes in v4:

* Added minimum 1 and default 2 constraints for num-cs in the devicetree
  binding.
* Made the driver read num-cs and fall back to two chip selects when the
  property is absent.
* Dropped SPI_CS_HIGH support from the initial driver.
* Kept separate chip-select helpers for the SPI core and direct spi-mem
  paths because their boolean arguments have different semantics.
* Protected SSCTL register read-modify-write operations with a spinlock.
* Limited spi-mem operations and individual SPI transfers to 4 KiB.
* Limited complete SPI messages to 8 KiB.
* Restricted the initial driver to 8-bit words.
* Added defensive transfer-size validation to keep the PIO polling path
  bounded.
* Kept bidirectional data pins in input mode during dual and quad dummy
  transfers in the generic spi-mem fallback path.
* Treated zero tx_nbits and rx_nbits values as single-lane transfers in
  the generic SPI path.

Changes in v3:

* Fixed the DCO mismatch by using a consistent author and Signed-off-by
  address.
* Added spi_controller_mem_caps and enabled per-operation frequency
  handling for spi-mem operations.
* Added a short delay after requesting FIFO reset before polling reset
  completion.
* Documented that the controller generates one RX FIFO entry for each TX
  word in single, dual-output and quad-output modes.
* Added the missing linux/delay.h include.
* Removed unused register bit definitions.

Changes in v2:

* Updated patch subject lines to follow SPI subsystem style.
* Added a commit message to the devicetree binding patch.
* Added ARCH_MA35 || COMPILE_TEST dependency to Kconfig.
* Expanded the Kconfig help text.
* Converted the driver file header to C++-style comments.
* Added reset control handling.
* Added the resets property to the binding.
* Added a num-cs constraint to the binding.
* Removed the flash child node from the binding example.
* Used op->max_freq for spi-mem operations.
* Split low-level chip-select register handling from the SPI core callback.
* Limited spi-mem command opcode length to one byte.
* Forced spi-mem operations to use 8-bit words.
* Avoided driving bidirectional data pins during dummy cycles.
* Drained RX FIFO entries during transmit-only transfers.
* Rejected invalid chip-select numbers.
* Rejected unsupported dual and quad full-duplex generic SPI transfers.
* Fixed checkpatch style issues.

Chi-Wen Weng (2):
  dt-bindings: spi: nuvoton,ma35d1-qspi: Add Nuvoton MA35D1 QSPI
  spi: ma35d1-qspi: Add Nuvoton MA35D1 QSPI controller support

 .../bindings/spi/nuvoton,ma35d1-qspi.yaml     |  63 ++
 drivers/spi/Kconfig                           |  10 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-ma35d1-qspi.c                 | 657 ++++++++++++++++++
 4 files changed, 731 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
 create mode 100644 drivers/spi/spi-ma35d1-qspi.c

-- 
2.25.1

