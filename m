Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795191226;
	b=x0d7dufenalygkT/mGurE2uzW66t92mMCeqRR+razaxX58TsYq2cHV+aBvH87pHZJOXA
	 1DspCH7k0IRQ7QLP/yEIzbSCsU/ZxlFYE7YNiX1HRDCosFk7HVguobz/BhDLTRFEtfJNT
	 QXnb9PpdmUyJ57mtaSyAbjVeNOJtlwiADdlx2mOuP9y7t1/eIMXSYhNoJ41wykk0XYNRl
	 5NireYHMmVYWMzjTTVMDnRRBom3xIWlMgHETFsAFDpELA4X2FXlqG4p55Owi2RmgbGO+l
	 graZ9VDlQugl13bXzfXU40MxFQRLkrMmRXTL1GkhelgFeMcY/NjbhZ+uaImYkrYKrJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795191226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=zGFcMrIjJLW437tud2rtF8VQKm0JOFYCFRIPivRW3qQ=;
	b=sXfO3iMs/CVi4CN4vovNPxX8DXovhXweuE2e/H1U4hp/tTumh602ZaC/0ctG09KE5FMU
	 y5LZFsj5mM5T/xXEiozsb5x1UXLXMwnmwlqfyeVqd9W/KoD3guGUtpXAWW0hwtZ1AVpSR
	 mMkKU42RBULAMyr45cyzWqKyTa3HmedLPTfFcrAalg+4zWNnTk8g1xXjKTPLwHaI4cxxv
	 6sHCT8B+LHor8fm62pkqK7P0Bf2mJycpEyGpGUqyizIAMvMV0SLkrjzNkAAJU1XS4T9PS
	 AosV/2lfbqfxeYyOOGaIwpt1MdlmLK2drM72pjrEzdPNZbosGUARX/Uf6TXmioH2ong==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="a2/dabyU";
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AB8606A338
	for <linux-spi@vger.kernel.org>; Fri, 20 Nov 2026 16:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10AB8606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a2/dabyU
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cd8ba7c2694so493027a12.1
        for <linux-spi@vger.kernel.org>; Fri, 20 Nov 2026 08:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795191222; x=1795796022; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zGFcMrIjJLW437tud2rtF8VQKm0JOFYCFRIPivRW3qQ=;
        b=a2/dabyUf74rh194g1AEE0MEUS4LPOzWQfFDISeiIB9uOWoF0wHN7yHGdLOYIg8X+x
         0EdbggZ0JtVxqslyYzLPxMp9PukWX4BoyOiumlRBzmEo/NjYu4MJdoHDGp+kt6J87RKU
         deIOC6/O4+cy6NDqCchQfcpLLxskFWRTIJck2BtcH3+ABtaFJI0WMD9J3X3ZXoWQSAqQ
         Sf4s9e8adecjr9/ESfC3lnIlsv2E05TDzeJzpo9tfhrY7Bj8MsAu8oE4Njy9c3NdcoE5
         PLxAUiSwE7JDBVlFLxn/IOPXQ8+b3NmYkV37V/PIaNT4UC2gaj1b57IdYHuIelNFJYbp
         O0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795191222; x=1795796022;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zGFcMrIjJLW437tud2rtF8VQKm0JOFYCFRIPivRW3qQ=;
        b=B2qKGKZ70KZeJkEO4tEvth2x6BxF0Nny/QBisQYQvnU3aQsGf8ZEhUYRPZiB9osAYK
         xpeLMG2YMYyYzsx/6eHgqim3eoRsL45QFVH1XK/InInDsi0g08QJhODmf9vZhBAeV9hl
         QWkqAk4ZbCuhBP2xoyarYZGJ+OveEY/XONFPMIp1BkrxmihG5uUDAgw0QuTCl2btnSBi
         snsq0aGcdqP2YnnWCGceO6/qkbrZq0PS+7Q70qZGuiUcQ5h9IRzaYt+6coMwRQqmkkb7
         Uroo2Ck/zHZYQt0lRWHWMr591THB0PFLrkFbPStLnvuBoFb0KOUulYheg/HayrSi0wPM
         DxTw==
X-Gm-Message-State: APuU4Z8Jc/zYkXsCTqC+hHFwf3lrvaQK8PWSsfNQOMbZjPut0sJn+3QR
	1X56a0P02eQLOhFG+CfkAXYzykDYytZ33JRNZbyaVYU3ZKHsm2/d3SiO
X-Gm-Gg: AZFdTZd8Gp3aMTdd45uB+0HgkwA+cnJ2TJcfG/+F7DPOBrKUTUv+ZG4oVQmO19PXnWE
	//2BeAK//qg6h9XpAKxn9ArBwhcmPQSK9MOo9+seNdhg9YV769MqAE1uawTShjQWk6Zove/y1hT
	Mf1Y2oqRbkFDcHckkqOcfHt3c6Ig47tac+1tWK532dtaDYgnlKZlqkjEI01sV8LQCT7xCT+C+S8
	K8J4jafQrA0XccHPLG7hYUrcEdAJYvJSCwg+/RR5Ru20wXGa42GbsmnsFrcv22WBFMQW1NuMbyd
	jQ1MlVIIzeVvyZOEr71OUy0S+CcifHkx1i8kSWzhVCmBR6ulSuPkvhKx+WWzImQPs9EIIGA/0m2
	DXrSWM4J06jJKWsbXLEYlTBw6meq9jYAu7GBh4Wf/RVk50Cv9NArQwOLTveMrWMgVxUDZ/RW6lZ
	v+L/AIKszOWtzZwbPxd4kYBrw5JTYq2ZwNWONMA5wRBfPvCIaMKosUODZLxNojLdVc10ojViMq5
	Efv8Vakm3s7o2kAXFjclxppPVnr0/gm3VyjuzGVvYB0TnNlqYeTO/NMVfOCVYQqPbqoExd5ixaC
	labdF6boTrIwXrytwcr/MG5ajeHJPs01Xhd2dPTxLVtM3oJjryVHy4tySKZDfgX+Hoxq7PvfWl4
	JpujOpbLzVY8ocTqzxuMgpXdT
X-Received: by 2002:a17:90b:35c3:b0:3b3:cb22:72cc with SMTP id 98e67ed59e1d1-3b41c8ff73fmr3334841a91.32.1795191222234;
        Fri, 20 Nov 2026 08:13:42 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9009:b6e2:dea:3892:877:4c42])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3b420e1307csm3848534a91.7.2026.11.20.08.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:13:41 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sat, 21 Nov 2026 00:13:26 +0800
Subject: [PATCH] spi: synquacer: drop redundant IRQ zero checks
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261121-synquacer-v1-1-9e14702ce84b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBBA0avIrDUxTVi4ilhUO2Usig5CxN0Vy
 5f8/AuEIpNAnV0QaWfhKSRgnoEdTOhJsUsGXegKUaOSMyybsRSV75xHZ6zGqoTUz5E8H9+raX/
 L1o1k13cA9/0A7gZHDW0AAAA=
X-Change-ID: 20261121-synquacer-fbdf1dac2165
To: Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795191218; l=1177;
 i=ustc.gu@gmail.com; s=20261030; h=from:subject:message-id;
 bh=6qhPO5FfiGjEZI9ohXmxBjxcZP7plkTu3VyHbjgFpPs=;
 b=jB4Dkmq8XY4dQcvWIuC+B37OppC6Cc/dP49KTtDxXJsrDQ2931aRQeJNl9qHdH+ZGLOYGYcJG
 12iURB/uVO6AGynojWgzTpsQn6OlVIT0Pl7DwZPW9ZKnSyhR+Q3BdLq
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjDJtbnSeysEBjmOfNYqYUUDS6g7Tfov9W5oGngTBfo=

platform_get_irq() returns a positive IRQ number on success and a
negative errno on failure. It already converts IRQ 0 to -EINVAL.

Check only for negative returns when looking up the RX and TX IRQs.

Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-synquacer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-synquacer.c b/drivers/spi/spi-synquacer.c
index 6d0cd11637b5..6e1412008ea0 100644
--- a/drivers/spi/spi-synquacer.c
+++ b/drivers/spi/spi-synquacer.c
@@ -667,7 +667,7 @@ static int synquacer_spi_probe(struct platform_device *pdev)
 	host->num_chipselect = SYNQUACER_HSSPI_NUM_CHIP_SELECT;
 
 	rx_irq = platform_get_irq(pdev, 0);
-	if (rx_irq <= 0) {
+	if (rx_irq < 0) {
 		ret = rx_irq;
 		goto disable_clk;
 	}
@@ -681,7 +681,7 @@ static int synquacer_spi_probe(struct platform_device *pdev)
 	}
 
 	tx_irq = platform_get_irq(pdev, 1);
-	if (tx_irq <= 0) {
+	if (tx_irq < 0) {
 		ret = tx_irq;
 		goto disable_clk;
 	}

---
base-commit: adcad7f4e6332cff3d6d7165f41584899f598534
change-id: 20261121-synquacer-fbdf1dac2165

Best regards,
--  
Felix Gu <ustc.gu@gmail.com>

