Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393F13C13E6
	for <linux-spi@vger.kernel.org>; Fri,  1 May 2026 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777644006; cv=none; b=hY4odbjcE2PWQGRzNxASHoBml8P0TDKXbia9I2PbTjLYrwBiR52UmOB+vILFLd/zNE7myket14n29BXzELQf7ZJ9qHd57oW6EOMpXOgUySFcu9HcpgqRsr4e8xJ/n131y8RFwn+KT/2P1wdvItI8LOdMZdGMxaR00tRyZ6x306U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777644006; c=relaxed/simple;
	bh=jJjc9mSsrPx/NmfZcqGL2yYaLbyjJmbr1/4K0E8A+5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LVJjqGxRwycnUKAEUSwnBy/uA0yiRD0Hh92fzctPrZ5LPiUML/a9Mijg8H+lA/4A6xzBcqI15CQ+57a6lkQLd5tJjQ4p9ZRgBCKzKY9dp6G3usIXRqxbJFX9SLZNK4rR+VohNc1wBdbAaY+nVSe/H9bCCH1gIdznQY2c8+7PL7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=La/EMFcm; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="La/EMFcm"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-44a5174670eso452137f8f.1
        for <linux-spi@vger.kernel.org>; Fri, 01 May 2026 07:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777644002; x=1778248802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgCd/8OCqeyYKCVUvRrf/jlOcP1suVHYVb2aR3GPrKU=;
        b=La/EMFcmOAN/SOrahPkXF3e1bgWrauLOYTjjPaNvo53yWotmYUpRhz2J1BHysHu9Zf
         wN5ueQo6wf3TZES+KAD/f9kNkX6eQJ68SOspnw+/+CFBErDvplCowp0RhCh2i4OlzjdM
         XRZyKHVrLZLVi+a2NKPpzn/v3B58sihIguGX6sJatJjS008UBWECEoxqa941fVObTlET
         vRZduJxbHIwDAfWWfMcAFnJW2kersJE7xwbtPEvSz4PIwycAb+3mEDBxpyxS6u05o6wf
         UjpUWWLXdRk/b6vwEKL3I7mrZc1MyDmXzfi8KCtJER+pXAhNfH6Hrs8CdHZ4Nf6WG4tB
         bHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777644002; x=1778248802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wgCd/8OCqeyYKCVUvRrf/jlOcP1suVHYVb2aR3GPrKU=;
        b=dAVTsn+iNPEco9U0y8yYJuczr1SBkchskwzT4Hn56d2wrIqk/z5wK+gztRBMzUHqD2
         BltX7HRnSCjfbqKDzddIo19NsaQFvW8eNrc77rIJ6fJmH+1gjWTmdQeDYO4yObmwBjHE
         9ZMHIHHAhB0QCOkUuNw12OY6WV9TwgtNAUzshBdH0mbZosohF+tLn7oVnyl70yYfOT/t
         yp3e88loD+FvprLVamrzJc5ZU9Kg575WL667GCWajflWfjv2AnDuEwN4fBqawMIdcr+g
         f+AgFKsjVpRVx4QDyHYazjGSjkUXCD7vj2vae/cig6RRuaQkJM5SZFcV8xsIRoKv0416
         MVVw==
X-Forwarded-Encrypted: i=1; AFNElJ9ApvWqvIgf760xbUy0AxbhOLO1adI1sj7pO2j6biGGuwqxFaLEAFGIn4dH5vKUGCo0WDOBkmG89e0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfNkvFfC9psZH2c3jYFlK3M1vHZQ08l/wxxAqNWmmaXumnIfp1
	uy1TqfY2yZ7wO5ckwmE/0XAL4Z31FZB85Po9ZOJaOZk/hlKrrcBjFw4Q
X-Gm-Gg: AeBDiesMAM760HNTefqZTP4x43J2H+SDLpdU0FUQQ9T6LqpGTY5z8K4P+WmAN0A/fuF
	5tG/ULwv7+/TMYFcb4CuHly1Pbd79oydlwhw4S/CgMONxw7AiLapEhDbodyuUuxh9gxkNamSSIo
	GT51ybxKVH0gVZi7OzZ9HC8X1Fe7hgyrJ7jwSAPuEhPIv2bMLM9eSPqzFr9ii4Y/1I1+TGN92DY
	po7oBoyg61CXNN4wgxByIqpXI99M8MWc3RiTusKicFE89WTw3g1cN8i3asIx+9WC9auNEll3uOF
	xUVlUwBQY+3TILsksjCrv/MoxN+0EnCi8Fmprcs5jZiOO4QAFsGVrSTlcZududs4SnK4/RqQ3Ul
	x3yDTMbKcTCGaeFkp/K9ABVWG6qUxQvxY8pBM8jowk2EU4lfEI8Kp/uH+78tckh85Z47c6o9b+7
	CWcAyayCIjsG4uRVOY7gfARKhbnEbqkW+EFRc2wuYYklYHggqRnNI3rLu5MakKsKiZhVzH9UdgM
	jll
X-Received: by 2002:a05:6000:2b01:b0:43f:e2b7:7160 with SMTP id ffacd0b85a97d-4493cf2d5e0mr7464637f8f.4.1777644002422;
        Fri, 01 May 2026 07:00:02 -0700 (PDT)
Received: from localhost.localdomain (ns31537009.ip-141-94-163.eu. [141.94.163.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a98b768fdsm4823539f8f.33.2026.05.01.07.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 07:00:01 -0700 (PDT)
From: John Madieu <john.madieu@gmail.com>
To: broonie@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	carlos.song@nxp.com,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	John Madieu <john.madieu@gmail.com>
Subject: [PATCH 2/3] spi: imx: Fix UAF on package-1 prepare failure in spi_imx_dma_data_prepare()
Date: Fri,  1 May 2026 13:59:50 +0000
Message-Id: <20260501135951.2416527-3-john.madieu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260501135951.2416527-1-john.madieu@gmail.com>
References: <20260501135951.2416527-1-john.madieu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When transfer->len exceeds MX51_ECSPI_CTRL_MAX_BURST and is not a
multiple of it, spi_imx_dma_data_prepare() splits the transfer into
two DMA packages. If preparing the second package fails:

	ret = spi_imx_dma_tx_data_handle(spi_imx, &spi_imx->dma_data[1],
					 transfer->tx_buf + spi_imx->dma_data[0].data_len,
					 false);
	if (ret) {
		kfree(spi_imx->dma_data[0].dma_tx_buf);
		kfree(spi_imx->dma_data[0].dma_rx_buf);
		kfree(spi_imx->dma_data);
	}
	}

	return 0;

the function frees the package-0 buffers and the dma_data array,
then falls through to `return 0`, telling the caller the prepare
succeeded. The caller then dereferences the freed dma_data array,
producing a use-after-free.

Return the error from the failure path so the caller takes its
existing failure branch.

Fixes: faa8e404ad8e ("spi: imx: support dynamic burst length for ECSPI DMA mode")
Signed-off-by: John Madieu <john.madieu@gmail.com>
---
 drivers/spi/spi-imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 7ae8078c10ef..4e3dbd01d619 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1709,6 +1709,7 @@ static int spi_imx_dma_data_prepare(struct spi_imx_data *spi_imx,
 			kfree(spi_imx->dma_data[0].dma_tx_buf);
 			kfree(spi_imx->dma_data[0].dma_rx_buf);
 			kfree(spi_imx->dma_data);
+			return ret;
 		}
 	}
 
-- 
2.25.1

