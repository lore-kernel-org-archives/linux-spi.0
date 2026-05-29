Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983DC30FF21
	for <linux-spi@vger.kernel.org>; Fri, 29 May 2026 18:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780080883; cv=none; b=oBPIypX1VshmrTZ1DnliN+68STyF/f1w7tdwy5leBpzvGQaqEGD7UacfBUNN/0DyyQmQxSZTP37IYs6RPM3UzpsmRhn/ZZRTB1aZ0tunSbIpf2mdVz+IJ8s8nDGRQ+jGc5D2eGwQrfelPZkqSKH9f64DpTKs4foOF1HxW/5JDnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780080883; c=relaxed/simple;
	bh=rNT7GRqXnggYft/A5mLGBISOO+u8FcUXQLXMMnXblTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Eri006if/TOKN58PamJCOG4owULPnVFNlwzHVbiv8u1LCw71Rj+qNg535aSWBr8C5rrZQ/T139t7k6RFlptNnPkcJa9iLHbEZyCnlK+Cd+UsZ1ebyZ+0HL/MaKtauP0SUuvoszaFSWHiSynaeMdR9A8RePfXy2ewyde0M3breQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QK8nLzWo; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QK8nLzWo"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36b8e1760ccso1315291a91.0
        for <linux-spi@vger.kernel.org>; Fri, 29 May 2026 11:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780080878; x=1780685678; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TUENhP2KHo/+lI+DBFuVMaFWaMTmN/hgL82LdNJmYVw=;
        b=QK8nLzWokvV+lplfENRhcR9BBzMOHYeSvGU2jbwfhq2ZvnxLTPCymIjPJHYBqyf2Ud
         rBZDpgNVW0pSR6G1gC3yZEqJdPSv26XoaYKR5GXVq3Zdmv/DbERCMtG/E8YPsxzzZtrM
         iX9Kq8woJRhpkCKwuF9+n6ilCTjHuzBNbM2OUohR4Ffjcg6B/t6S4qpGubeg7G3CaaEC
         RHmY6zeX2wM4HM24zuNrKrTHYus1NBMUB0MZoECkYs2S9vsYNmfiIcWuyJaTbU5VTXUQ
         YuGsFvnLtBZcHi7wW9au7JU5n9IMghv8fiOCN/6RO/PZooQHAmEOPsgbxkMXBlA5PYAm
         wkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780080878; x=1780685678;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUENhP2KHo/+lI+DBFuVMaFWaMTmN/hgL82LdNJmYVw=;
        b=WejcqWvBwdq/7Q9C5XpsIrDXE51HLDdS4X5abLlFdLIC1WWXQgj+TCgBL7v0Rt8fje
         SI4jAaSJjHlqjazGZdzGvJFtLX4KsTcmtpMMvd8aJ5kBXth5bccggEwLoQw1qwZWP1vV
         Qy8HGglo5IymOq0yspUM8m6NcPm/LHPYR35GZEADYFOIEdyaaD0CusuvSPIFhe8CQ6Gb
         4XBXK86reLeBFuIYY8cvY+89W9O3L6HMzvROeoVXbQK2W+mMgDuhcMZptzFdItSNYrz2
         NW8HwJmWsVkqlMCrvEVZtu+wfxFWGL7cpp5Q0UEpr7MU0rYWHvf9DzqKxsBFri1m+a4X
         URXw==
X-Gm-Message-State: AOJu0Yzsk7K9XVOij87o2jIfgv4HxnOLcr5/b0j+ZcmVRi0LHTlxUZQ5
	6vj4T8uw02b/t/b+R/TXs7NH5wMJKEc604aAiPZK1amNEJrqAds5TyWO
X-Gm-Gg: Acq92OFkF46HChVw9aJXyIDMsl6bzJ5a7w2HG+gcv1N+STgUbInkhqDLK1mmHFqLToy
	0Se335AqZtPVD+XJMgX+O2PPjswSsCrc1DfUJFIYw0sRScQdeYZ8KZEm6jKJlTBWemUJ6rEtHQN
	W20cMKFmd4xDm+s8oUF4iTR1yKfuGlUtOT+gTzChpVFK/tRdlbdI3Zj0wwhhmyb30suZVed8BXu
	gSZoTSnRv5XPuetAGtCwj5xNOp5czMbhiEfUXAXIaFxsa9U3HMFNspCIR5UfyrY28NsF06TH6+U
	ou53XWoj4uM9t+HWIM8lLqLKsKF0UD+fPAxgdwih85zUp0r4AkYGcG3DuyotmTHbOLF/NGYgleu
	cJIXuerTOZMqgNVGRErH4KjgQhrDmUddNAYRVEZOH6G7+daglbt2C1Y/yeb4EG9x51Vsp4OeJwh
	NKpDfkKQC1dWn7jjL+ZmpH63vc3X4qk2cL3Kv1Ub+RVcX+XqVOAMiTT/xdF1fhIAGjyg5CtoPnX
	jITticZnoHkcQ==
X-Received: by 2002:a17:90a:10c8:b0:368:83e6:ca95 with SMTP id 98e67ed59e1d1-36c2eb8fc62mr285773a91.0.1780080877400;
        Fri, 29 May 2026 11:54:37 -0700 (PDT)
Received: from [127.0.0.1] ([151.242.180.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc0c341dasm3017599a91.15.2026.05.29.11.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:54:37 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sat, 30 May 2026 02:54:31 +0800
Subject: [PATCH] spi: dw-pci: remove redundant pci_free_irq_vectors() calls
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-dw-pci-v1-1-5d2cf798b3c3@gmail.com>
X-B4-Tracking: v=1; b=H4sIAObgGWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU2MD3ZRy3YLkTN0Uc1OzRBOLpDTjRCMloOKCotS0zAqwQdGxEH5xaVJ
 WanIJSLdSbS0ArL0bRmoAAAA=
X-Change-ID: 20260530-dw-pci-d756a48bf3a2
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780080875; l=1741;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=rNT7GRqXnggYft/A5mLGBISOO+u8FcUXQLXMMnXblTg=;
 b=iAnymNGDeWwT6575iqoa5TCzOTheuE5sR8xsquefh3o70OBauQ8JHF6ymRNgfBHIUbVp0ybmk
 uM4edz6KUv2AMBVpof/A1orzYsaM0dxK76LncGRIxMXp+1FqTbz6CSx
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

The driver uses pcim_enable_device(), so IRQ vectors are automatically
freed by devres on driver detach. The explicit pci_free_irq_vectors()
calls in the probe error path and remove function are redundant.

Drop them and the now-unused error label.

Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-dw-pci.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index 7f002d5e5b88..bfb874f96a26 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -120,16 +120,15 @@ static int dw_spi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *en
 		if (desc->setup) {
 			ret = desc->setup(dws);
 			if (ret)
-				goto err_free_irq_vectors;
+				return ret;
 		}
 	} else {
-		ret = -ENODEV;
-		goto err_free_irq_vectors;
+		return -ENODEV;
 	}
 
 	ret = dw_spi_add_controller(&pdev->dev, dws);
 	if (ret)
-		goto err_free_irq_vectors;
+		return ret;
 
 	/* PCI hook and SPI hook use the same drv data */
 	pci_set_drvdata(pdev, dws);
@@ -143,10 +142,6 @@ static int dw_spi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *en
 	pm_runtime_allow(&pdev->dev);
 
 	return 0;
-
-err_free_irq_vectors:
-	pci_free_irq_vectors(pdev);
-	return ret;
 }
 
 static void dw_spi_pci_remove(struct pci_dev *pdev)
@@ -157,7 +152,6 @@ static void dw_spi_pci_remove(struct pci_dev *pdev)
 	pm_runtime_get_noresume(&pdev->dev);
 
 	dw_spi_remove_controller(dws);
-	pci_free_irq_vectors(pdev);
 }
 
 #ifdef CONFIG_PM_SLEEP

---
base-commit: f7af91adc230aa99e23330ecf85bc9badd9780ad
change-id: 20260530-dw-pci-d756a48bf3a2

Best regards,
--  
Felix Gu <ustc.gu@gmail.com>

