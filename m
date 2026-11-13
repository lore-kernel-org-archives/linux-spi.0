Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794610830;
	b=WTxMNguo0Nq/h4OoiZCnM+W6eHPLxqvPL75JgjwDvon5VYCyVoEaqT3pgLW3SNPg9rHv
	 /yErwXzXrpD4uZkEv37T0zEazOgiforKbwfhRHGHr0E324YMHXWqpY7kxfbzg49kgEsLn
	 xCd2CAllnQ07y34eg5mF3M3wgtSB7CPCOE0NQbL9SgbvXHWlK2elwGPbeFAbTBGGWsNQF
	 js4Ke4001SOJ0ZNDAs/teX3/G6pDc+4wJdMy3XfksjRAKsbaGQl1MDFFcLXzn6R35NVkY
	 exLhFs2mbl5gIQQc9SiwqN2n1tfLSOjadNkGOtPYr60cGPKJi11/A7fDCoUY4A0dAoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794610830;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mKIWbOpPGbaTuqqJlqYK8lewW5w+kzLONOp9Gcd8l6M=;
	b=LYJSdh/9RwdPU4tofQ0e7aAluBy1NNz3XssQmzM8gJzSHy51/Zzn7RWBNsDXtbVbD1yI
	 +DjwEkvlOrRwgeutnkwLuBYzSFeI60JKeaxoxijeboBDNteQX1I9esng/JOBus+hCL/6H
	 +QO7AnaqW5v9dkWmMVMIQ/W/pM0AIwSy5FyQnNV4UpJXuPxtWeXnGSWkPkFXvSosmtNPT
	 ErW3h9VVso82z9mgp+G296oR7lDLGuzdpjcTpQPLejDfYozPZMY54g95Sb798E7i4NuJu
	 0Pr46kDacJjLxSh7reXfdFi1CfuNMsiwY6hhhvmMfWfL2Rk83QgIdFAzrOmRNHUZhxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t2ZwaqCM;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9139E606A338
	for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 23:00:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9139E606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t2ZwaqCM
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso11527985e9.1
        for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 15:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794610828; x=1795215628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mKIWbOpPGbaTuqqJlqYK8lewW5w+kzLONOp9Gcd8l6M=;
        b=t2ZwaqCMllU+1+/NOjW17LZT/w3ub7sKoiDH41UTjJFhAptpinU7vdAZCEuF3R/3LE
         CrfSM5a9jBXQ8coju9TypFqqXzp0TpCUrcZ85WexHznw2X023GyEsLKvqfr9/1rteP8U
         LVyHanl6WyXSPt3EmKvZFk+HGddI8OKErjP4/ogYMl2xYvXJ/oVP2ie1pbA3CgIZznr2
         p0RE/7YOa+U+2RQbTV4f5d2NfZrGJA/OQw8DkYP6TW8cnKGlBDTJYs++7jEFWgIrqTtr
         b7woz8dDhzdFnsGEX0d7sJHkBd2p1cKmp9DGzaAO5i7HW4/B97QWo0P/VcVC0c5pIQXx
         mhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794610828; x=1795215628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mKIWbOpPGbaTuqqJlqYK8lewW5w+kzLONOp9Gcd8l6M=;
        b=blasa8p8oZmvqqaADWMaGfJ++V6QbLlD9i9I1bdC5xI2Mq9kDS002SoEe0ZQDGzeOS
         disbh3vptDd/8tJM918OEp0NRKT6RhRuVgMd0fMw0G6hSZhb7d1ROvSfqXHLhjTwi9xe
         nEsKOV3sgWHCLHQkmhAvQD9sZJY1Sr4ZGZGgOfVy8gPNCR+2MXsjPR6HVVgoKf5yMA7u
         U+Kyljx5w+ZSUZxLnGb0c6Kd4DOTbipw27OWEvdPOVTil2OAsagszKEN7X6P/dK2C+K5
         TLYOW7oH7OAf0Wmihab/AwfDXRt/nldm3Nqw1Hi346MBIM68wjQQfVahkV36yeW1rBiG
         J4Rw==
X-Forwarded-Encrypted: i=1; AL+hErFClQNQmQbVAY5RwBDieOJcBojnlUxyNXZh1+voWKbiTx5QUOzQEyATJkpVqxsMEq1QmwPZ3pMxRMI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+UvNmjPOlnBwqfO3whyhgw0DYtNyyG6fl6QJ2Z3MPCy0Xx8+qf
	Melrze6+viNIT1dw3e0pOj+3z/qE8hF1gRLevQB0Own/QyjH8KDh0jBe
X-Gm-Gg: AYBFou2kToB0OEHouQavVahcrvPOb4A761gL2CHDbT6kWZQaa94UzZHPvC1WWept1AS
	Z4d1aWDIH03IYXjuXgtTbFnIMRI5aEjjEDC4jSWJ/qzRZ0YbuYAsjH98hLbJSg/Wg3onxsmq5Se
	MNOvm05YhXNmvyZyc94Xmgz8vWobh3Q5RUn9uR2DXjLIO24Uprp0Spt6L/JYBd6VB4lQrEUj8s0
	W+P5hlF43MkUF4ToF3Nl32tl6c0aAyz87y3joMpfacS5JXzsrABqNsLrfDtUSC1UkoLyCYIXFgy
	0cVVU88BoS9f1Fxp5MTtJxZUSmOb85i7OoKygRg/UAXb7SFdTmwQ92KZeKXnlbp5qNYm7PeBFY7
	4LJy9VDhROY5Y/pnDV9RZdT+82RffSzKEW6yyZPGDXCL2n6qvNwkglPVeWsIe9gcrGzpEH+0HIi
	9DqyieIpq45+nycIT61j9YpYR9CEQz1cZvLr+c+a5/W1ujlw0W+nwMk8LyOujmbPQC8zmyS642D
	WgDz/CuwfCafspyy7H55mHKkUwbCSGfYkh3NMosJHLZrHlRLet7rghSJvSZDpfsWta2eNP+NXGk
	R2Kh4thkkB3WUcHgc2Mz196IrTtvVLkrnd8ejpYOnNhPpG8E3Fca
X-Received: by 2002:a05:600c:628c:b0:4ba:6d8:dfad with SMTP id 5b1f17b1804b1-4bb55a6b67fmr89886695e9.14.1794610827678;
        Fri, 13 Nov 2026 15:00:27 -0800 (PST)
Received: from angelo-Precision-7550 ([94.154.175.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f1c1797sm8617592f8f.11.2026.11.13.15.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 15:00:26 -0800 (PST)
From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org
Cc: Ryan Wanner <ryan.wanner@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Radu Pirea <radu.pirea@microchip.com>,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] spi: atmel: keep DMA chunks to whole 16 bit words
Date: Sat, 14 Nov 2026 00:00:14 +0100
Message-ID: <20261113230016.4144717-1-angelo.compagnucci@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PDC path cuts a long transfer into chunks of max_dma_len bytes, that
is SPI_MAX_DMA_XFER: 65535, an odd size. With more than 8 bits per word,
a chunk takes 65535 bytes off the remaining length, but programs the PDC
counters with 65535 / 2 = 32767 words, that is 65534 bytes. One byte is
lost at each chunk, and the next chunk starts in the middle of a word.

The SPI core also cuts the DMA scatterlists into segments of max_dma_len
bytes, so a segment can end in the middle of a word too.

The chunks were PAGE_SIZE, an even size, before SPI_MAX_DMA_XFER. Make
it 65534: it is even, and still within the limits of the PDC and of the
DMA controller.

Fixes: 7910d9af000a ("spi: atmel: Use core SPI_MASTER_MUST_[RT]X handling")
Cc: stable@vger.kernel.org
Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
---
Changes v1 -> v2:
  - New patch: make SPI_MAX_DMA_XFER even, so that the transfers and
    DMA chunks cut at that size keep whole 16 bit words [Mark Brown]

 drivers/spi/spi-atmel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index ffc896e4621a..c762e28407d8 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -288,7 +288,7 @@ struct atmel_spi_device {
 	u32			csr;
 };
 
-#define SPI_MAX_DMA_XFER	65535 /* true for both PDC and DMA */
+#define SPI_MAX_DMA_XFER	65534 /* even, within the PDC and DMA limits */
 #define INVALID_DMA_ADDRESS	0xffffffff
 
 /*
-- 
2.53.0

