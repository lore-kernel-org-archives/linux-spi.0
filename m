Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794610831;
	b=cDbkIamK3hhsJt4CCdKUyhHYk7cltBzOnZ2vtbr+F+Jgq6SnsYJG153aFTzOGwCqkvJV
	 3OM4xtFzay9CJ95d33yB0S6o+GdcBmoVO1J/H8BH/aiIdUO4IjB+b9MnXYNMCQoNlpuqv
	 Zio3kNOdFdbl7eNIWiSbYZ5Fw8IrM2CvHrNrSs2WqobBJbfgpofP570dTrhy2P8iDDIAI
	 Y64OzQkhwLSDm328CSLBbgZXYs0qjMhgwpz+BTgIzNoGXueiisRioBLUtG6p9kF1f6onA
	 Ksq3bC7gYWlcjvPxyrVnn0CIy6JR8OSr0Ns5UImcRe+7cK5pbtyPZEvQpk8qaW6KyCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794610831;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=petBOsoXTfk+b1tP5qbLmuFW7avQr3RYsmHH9OCiX0w=;
	b=qu9IXHKFoh1eq5SdkWgwl+QhHOseustPjmCYfiW2BQAGHefCE+anpq77dNXeUqIReSRo
	 VXD/PU46MAQRPTyHZLWDBsrsQvZbQu/scgn+IGDrWjyfYiN/HnafFF0dOC0wsCMQOfwUO
	 XumF1GdvlWtU/gMDtlNmVCm/l5ThxA11xq4+iGJ1TdRnqBh04zYspF74QA/X4UFcTt02g
	 lrz+xJxq16q/0Y74vV3b9Sn5F3pyrPgZ6K+13IfbIrmsXanyR4LSFsN1b0ObkHILvJLGJ
	 L8aO6G/hdem39AAU+IWgk0N/m1i8HnVO1bxEjJ2f74gfHKjH7ERi4jDuLKnbiTAksFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lwz5yg62;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D3B606A327
	for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 23:00:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3D3B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lwz5yg62
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4919a880834so737194f8f.0
        for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 15:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794610829; x=1795215629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=petBOsoXTfk+b1tP5qbLmuFW7avQr3RYsmHH9OCiX0w=;
        b=Lwz5yg62JgaQRlZiPSOj584M7rkeHIagPOY1EX5+CA9EnvesQJJwgCD4ntm9j72SA+
         /kwNure6yR3wQZB6HEViS6wEYxxofjW/SMUy2VelFXX6L8JY0Dsuh0Kg04dNWKFlz52V
         nvElu5IrGXb4PhhRGCXVuPfF1TbS97pIuh4LAODSY8lLBELeuuf3qluAOTVz7ygczgp/
         bTR8c2iYZUJHCqTKszcAxDkhYkLMIc/ZoVPh90lN8XbVdn2GzvSh4UOls0QSZ4UXwD/B
         Tvo9xL5XsDLNZZpZqRoi7BDTedTpB18zgAT7TdtMz4D2E1LJd+YEhGlEh01pfw61vvNi
         3u2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794610829; x=1795215629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=petBOsoXTfk+b1tP5qbLmuFW7avQr3RYsmHH9OCiX0w=;
        b=PIhgpiXeFCZ0yU1K34mTWX9HC2ObJ5O7RqvjSZWLJzxLAbCVH0lPRg3ROow03Co5zv
         oGNG5zg5z/2BlK+1Yrq+Pw1IbERK0sujpJhWkA0mdssHUj6osRYoe1Hqh9Xw+qaSNj1p
         YOSWr1hFuZHWA1scG1M9wC4kQx5zRxyorQsYBoKQq8hsV0vx/fAs55g0x7XVGTX8NxXq
         VGMPIg3m/A6K+o1GhPRDXYpPpR60N9PaUGg20Ff8svmx9l9VW2B9phyZcJ8RMkBUdnpT
         5L4l6dl4aSAMs7Kkt14RISf2G7XQPsc9RFD6Ozg32UFWpydjDPWjk8YZ4v3u4UiddKyZ
         uZsA==
X-Forwarded-Encrypted: i=1; AL+hErEVMI+zLSbYxvOM36DQjoN0tVMb5sbkJtUTEHoL7VT5ksjvLol5k0GnxU6U08tWmbHTOz70D5ho5D8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/OucUagLqAPCd24944JE9a76SKHKYcO44PPVarZg4EFYHOXByN
	um5w/+gZXT0OfuFvuKQ5Hy3sOdNvUKg3LaUCHvpN/oZxvLKi7BzE6gcN
X-Gm-Gg: AYBFou3eLIb3VKyj9k6Ro36fyjsr/v6uDZrRdQQJiIjd2ZvlYCrqqieCJBTBwxGgKZR
	9gbRidSLuLERDbIUzNabq10Se9HSjAcTQ5cSnNnA7gx5lpDxourQ/Og0oHZBgC2B1dUncRSQhAe
	lSI1wdJ2nchrDg2nw0ZDZzBdzRGwsQeaUL7pZRogPkaOhjTDFNDwfRHgVC7dEFYcVXW64YjFqo1
	oAt13Lmju2MawRE0PDIFEqeYzeR157rZBfBe3GN0x/aauHd6ufninZJ41MHxG2vkGqjsP2yIUNf
	lR9qglD5It2AYFlJImYu2eg6DbMkCXasnFZA/fAj1mpgMEerJqCrtcI38EGeqgXPxz0tf3btVL7
	hBD1qy1tnnqMspMgNC4gLyQ1ZO6mgGQyypcbYm6zqYkvoFfmu6oinNevrBJIzCEBjMlEWSRpqqa
	yjhA5F3wQ+dN/NsQW++9WuZLV7Uip6GAHnpy/5/7LqF93UKhmOqp51c/cNAvn5O/TYQdwRYS8tY
	wv4wW/9+esfV+aWRO4W34bt1D0uj1UQK//3vM4cdvh2JVjiijRVKY+GPzE7R142HhN9FYR9+Mxt
	SwXqI9+FF4mwwuHyyK+zLKHxghPFNl1CfWq+r1dXU6h8McMDZunb
X-Received: by 2002:a5d:5846:0:b0:48e:cd3:64f8 with SMTP id ffacd0b85a97d-49dfd36c520mr1002069f8f.4.1794610829000;
        Fri, 13 Nov 2026 15:00:29 -0800 (PST)
Received: from angelo-Precision-7550 ([94.154.175.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f1c1797sm8617592f8f.11.2026.11.13.15.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 15:00:28 -0800 (PST)
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
Subject: [PATCH v2 2/3] spi: atmel: limit transfers to the bounce buffer size
Date: Sat, 14 Nov 2026 00:00:15 +0100
Message-ID: <20261113230016.4144717-2-angelo.compagnucci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113230016.4144717-1-angelo.compagnucci@gmail.com>
References: <20261113230016.4144717-1-angelo.compagnucci@gmail.com>
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

On SAM9 SoCs (CONFIG_SOC_SAM_V4_V5) a DMA transfer from or to a vmalloc
buffer goes through bounce buffers of SPI_MAX_DMA_XFER bytes. The whole
transfer is copied in them though, whatever its length, and nothing
limits the length of a transfer: a longer one is copied past the end of
the buffer.

The MIPI DBI panel drivers send a whole frame from the framebuffer, a
vmalloc buffer, in one transfer: 153600 bytes for a 320x240 ILI9341
panel. On an Arietta G25 (SAM9G25), once the driver accepts their 16 bit
transfers, the first frame oopses:

  Unable to handle kernel paging request at virtual address c8915000 when write
  PC is at mmiocpy+0x34/0x2a0
   mmiocpy from atmel_spi_one_transfer+0x4f0/0x77c

When the bounce buffers are in use, report SPI_MAX_DMA_XFER as the
maximum transfer size, so that longer transfers are split.
SPI_MAX_DMA_XFER is even, so the split transfers keep whole 16 bit
words.

Fixes: a9889ed62d06 ("spi: atmel: Implements transfers with bounce buffer")
Cc: stable@vger.kernel.org
Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
---
Changes v1 -> v2:
  - SPI_MAX_DMA_XFER is now even, see the previous patch [Mark Brown]
  - Rebased on spi/for-next

 drivers/spi/spi-atmel.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index c762e28407d8..08075c9cc07b 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -591,6 +591,12 @@ static void atmel_spi_release_dma(void *data)
 	}
 }
 
+/* Transfers from vmalloc buffers are copied in the bounce buffers */
+static size_t atmel_spi_max_transfer_size(struct spi_device *spi)
+{
+	return SPI_MAX_DMA_XFER;
+}
+
 static int atmel_spi_configure_dma(struct spi_controller *host,
 				   struct atmel_spi *as)
 {
@@ -637,6 +643,8 @@ static int atmel_spi_configure_dma(struct spi_controller *host,
 			err = -ENOMEM;
 			goto err_release_dma;
 		}
+
+		host->max_transfer_size = atmel_spi_max_transfer_size;
 	}
 
 	err = devm_add_action_or_reset(dev, atmel_spi_release_dma, host);
-- 
2.53.0

