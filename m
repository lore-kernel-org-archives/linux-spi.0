Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647EB361DDC
	for <linux-spi@vger.kernel.org>; Mon, 13 Jul 2026 06:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783922892; cv=none; b=RbZEQvIT32trLvCQuNIgvmqvpkQafGY02Gm8waShpA4uuK+OeMSyIxpGQFvhnPd5Y4ARH7TgE/ZS2/jP3s5MdtBvNaTFGy6RveBdv1kfUvA98DbN6il6RIpW6/F2LL0Il0827bLnoDUzRYo1k5Sd+spss+6H5L8sLDt42oZVnns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783922892; c=relaxed/simple;
	bh=kMBvknJjnSboIetXJQ4M4kRWIrlDoDcXEHe0zebfcsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sg8h6H7GA76v2fd40BU9MNOjeM+Z7vKSu0ekMwlrhMueSqcWyBLusbDjbH/i+wIRTnX723TOJe7pwlmN4mhVRbuVzm1YTiX+KPzWmlBv/FssJNd3M2QpHLW79EPaQOQBkCT/F6qc6dC3xm383rSThgQBPzrRvrSd90/ExjxVmuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5dDVRNK; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5dDVRNK"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8485b358552so2960841b3a.2
        for <linux-spi@vger.kernel.org>; Sun, 12 Jul 2026 23:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783922891; x=1784527691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i/6Rgs0pEVXuCQ34qkmx8XbjWDlltbPvKllHS0/Tt4A=;
        b=U5dDVRNKoc2FQdNOIKeRtd7y6cU4+tSZxIxgbiOMgzfD+YIdEgbAXlDloy5yglrg7Q
         wWcFduCAD064s85lrTa8N43FzUcscnFP/LXEuPPFnPd+rH+TKjhIua03ypQUWneT/zRP
         TE0G5NbYSVkkrwAB1JlvSWl0r/5FNpXHe1RWYY3eFkGBMNAQnnWVaUPKihapH5yNuR+w
         5GTDKEFGXNz9wY+zVtMo5u6UdVWLYiQdqt75tGA42jg+vnapvd1Zyz93Y5+ljhXdUzT/
         QIxbpGIFdsbyStUUcHziQfLzRfZyIcikLrQgZKsl3m01LVxKIcdg/JfYgd+itQ2XTnl+
         KrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783922891; x=1784527691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i/6Rgs0pEVXuCQ34qkmx8XbjWDlltbPvKllHS0/Tt4A=;
        b=F8D5yJz3kaOE7WBjZegM6km/70nhQzMg3kRz63Bbycp4kF/6KkzhLEr9PSaUI+Urte
         q7kqVrlwgp4zSHq45hXHhFXeICultnJ7lz/oHO1i1aTWOlz2dTED6y18mZkrkSNFyhxt
         HLW75Rtux1PdhIkw04MWiVkfhioN6wY4m9xEmFVsbZ3XV46o5LSwxeqc4oRrHLfS0Rji
         jjTDjh48Horqvshx7CfAdJkhoBkdbvwPdKPKTxaKYyxrP3lm6Wb6/HasMXCyIGWmQayo
         75AJFCmIdMNxzBwPtY+cB/Qwt00jRTHSuTo1aWe34cGwYYTrKVrraZIpwVJumzOds9Cf
         WduQ==
X-Forwarded-Encrypted: i=1; AHgh+RpbrWCP3PmHFSMg6GhFOTCMEfPMBxHelcKf+e9AhX+6kSZrPIh7BbA1/bBViMKmzboOmMFUU69dKs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC1xGStYBiKF263ZruvwsyrgL5oKGtSdhaqcMTHEjjqOZaGaSi
	DxG2B5PdGGmhkjoF5bPUk53dsUT0TLlh5NW8eznPkX103oh3z0Vfer8T
X-Gm-Gg: AfdE7clksCuHhNZRuLZ3qWyBYrSsnfeyJMNBMlsNg3gtuwpSTYGOimMSGnpINTEJNLx
	rf806gFwVeIWGb+s/zBlFTijcZJAxtFHoHVwWtFzhbWRgmsGotsXGC4bYOX2CElI9Keh9w7DXqf
	izRYstqRdKkU2Jw/9dXB78hvTU8M1J1SaJlGSPN2nEIUVOSDzu4LwtvFGrVzGZr73207amjjBMy
	i/bMx9KRe3L9FRJ8QDrRDs063Y8hQsSnzM6Be76mPcKRDPOQTSsE37f9/mXJNhcMj9vCZO/ITZm
	OIO8ci6OjZR1uqQjnA72sRCQ8gy8dZA0zjYnknk+Nxoi0uhAih/dhPIrHr+X00FlbxkqrcWewmm
	8G1OM91TLWDFVZljcLuTq3cbiJgqgQ/OIPc+8iGzn4djHFh38viyHlWufUZtLz+kYnTh3L5er/4
	f4cJnynH4MhD6Z
X-Received: by 2002:a05:6a00:1d90:b0:848:6e2d:2709 with SMTP id d2e1a72fcca58-848898b7899mr6796412b3a.56.1783922890607;
        Sun, 12 Jul 2026 23:08:10 -0700 (PDT)
Received: from kdev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a3c16d1adsm771795b3a.38.2026.07.12.23.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 23:08:10 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Vladimir Moravcevic <vmoravcevic@axiado.com>,
	Tzu-Hao Wei <twei@axiado.com>,
	Swark Yang <syang@axiado.com>,
	Prasad Bolisetty <pbolisetty@axiado.com>,
	Karthikeyan Mitran <kmitran@axiado.com>,
	kernel test robot <lkp@intel.com>,
	Julia Lawall <julia.lawall@inria.fr>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: [PATCH 2/2] spi: axiado: fix kernel-doc comments
Date: Mon, 13 Jul 2026 06:08:07 +0000
Message-ID: <20260713060807.7-3-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260713060807.7-1-bbnpreetsingh@gmail.com>
References: <20260713060807.7-1-bbnpreetsingh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running kernel-doc -Wall on the driver reports 7 warnings, all present
since the driver was added in commit e75a6b00ad79 ("spi: axiado: Add
driver for Axiado SPI DB controller"). Two are in spi-axiado.c and
also show up in W=1 builds of drivers/spi:

  Warning: drivers/spi/spi-axiado.c:226 expecting prototype for
  ax_spi_get_rx_byte(). Prototype was for ax_spi_get_rx_byte_for_irq()
  instead
  Warning: drivers/spi/spi-axiado.c:248 This comment starts with
  '/**', but isn't a kernel-doc comment. Refer to
  Documentation/doc-guide/kernel-doc.rst

The other five are for struct ax_spi in spi-axiado.h, seen when
kernel-doc is invoked on the header directly (headers are not scanned
by the build-time kernel-doc checks):

  Warning: drivers/spi/spi-axiado.h:130 Excess struct member 'rxbuf'
  description in 'ax_spi'
  Warning: drivers/spi/spi-axiado.h:130 Excess struct member 'txbuf'
  description in 'ax_spi'
  Warning: drivers/spi/spi-axiado.h:130 struct member 'clk_rate' not
  described in 'ax_spi'
  Warning: drivers/spi/spi-axiado.h:130 struct member 'rx_buf' not
  described in 'ax_spi'
  Warning: drivers/spi/spi-axiado.h:130 struct member 'tx_buf' not
  described in 'ax_spi'

Fix the three underlying defects:

 - The comment on ax_spi_get_rx_byte_for_irq() carries the name of
   ax_spi_get_rx_byte(), from which it was evidently copied when the
   IRQ variant was split out; fix the function name.

 - The comment on ax_spi_process_rx_and_finalize() is opened with the
   kernel-doc /** marker but has no identifier line; turn it into
   proper kernel-doc (identifier line, @ctlr, Return:) since it
   already describes the behavior and the return value.

 - The struct ax_spi comment documents @txbuf and @rxbuf while the
   members are named tx_buf and rx_buf, and does not document
   clk_rate; fix the member names and describe clk_rate.

No functional change.

Assisted-by: Claude:claude-fable-5 [kernel-doc]
Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
---
 drivers/spi/spi-axiado.c | 8 ++++++--
 drivers/spi/spi-axiado.h | 5 +++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-axiado.c b/drivers/spi/spi-axiado.c
index c4bc7a50d6c9..25561aa9f76f 100644
--- a/drivers/spi/spi-axiado.c
+++ b/drivers/spi/spi-axiado.c
@@ -213,7 +213,7 @@ static void ax_spi_fill_tx_fifo(struct ax_spi *xspi)
 }
 
 /**
- * ax_spi_get_rx_byte - Gets a byte from the RX FIFO buffer
+ * ax_spi_get_rx_byte_for_irq - Gets a byte from the RX FIFO buffer
  * @xspi: Controller private data (struct ax_spi *)
  *
  * This function handles the logic of extracting bytes from the 32-bit RX FIFO.
@@ -246,9 +246,13 @@ static u8 ax_spi_get_rx_byte_for_irq(struct ax_spi *xspi)
 }
 
 /**
+ * ax_spi_process_rx_and_finalize - Process RX bytes and check for completion
+ * @ctlr:	Pointer to spi_controller structure
+ *
  * Helper function to process received bytes and check for transfer completion.
  * This avoids code duplication and centralizes the completion logic.
- * Returns true if the transfer was finalized.
+ *
+ * Return: true if the transfer was finalized.
  */
 static bool ax_spi_process_rx_and_finalize(struct spi_controller *ctlr)
 {
diff --git a/drivers/spi/spi-axiado.h b/drivers/spi/spi-axiado.h
index 6cf0e5bf5879..d24d31c3a446 100644
--- a/drivers/spi/spi-axiado.h
+++ b/drivers/spi/spi-axiado.h
@@ -98,9 +98,10 @@
  * @regs:					Virtual address of the SPI controller registers
  * @ref_clk:					Pointer to the peripheral clock
  * @pclk:					Pointer to the APB clock
+ * @clk_rate:					Reference clock rate in Hz
  * @speed_hz:					Current SPI bus clock speed in Hz
- * @txbuf:					Pointer	to the TX buffer
- * @rxbuf:					Pointer to the RX buffer
+ * @tx_buf:					Pointer	to the TX buffer
+ * @rx_buf:					Pointer to the RX buffer
  * @tx_bytes:					Number of bytes left to transfer
  * @rx_bytes:					Number of bytes requested
  * @tx_fifo_depth:				Depth of the TX FIFO
-- 
2.43.0

