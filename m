Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794678533;
	b=XjiA0pXwQvonUtTK2ALE9r1hTXqBmoDebZyvUB8hrwm2rj8YKTRr5FTbWAKdZ+yNg/CB
	 tQut4tHf90ksTNL5EXesud2zO/M/eysonWQs0tTJK5kIfyKGGyxYwShnnsRG51gmQ6tIw
	 UVJC+lZAm9my4U+JIUh/n9JCgAgPhHELf3F546KVVZjvWCTznVyjH4NqEoO+Ax6GDTe9t
	 x6UohemLfUf0gPSOngO8uLcNTfI0D7/RNaSp5WHehNa+Rml4F/NjnbfExa6tK0Q0PftJy
	 hKq3t5Cf4eycFjG86CVYLbKlSygMfVuPLavkoMTSvuGn3G5wYqhCTcmCIp5RQPJvb5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794678533;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=Z/UcwHcKXUqaXtKk/lpD8kvZeZD8k73uW8qTCjwCp54=;
	b=1G/K6Sju+zqJ072MGE4CzqVuju74Xcu7dUUEk2qSiUa6Mf65BVGMAS6+AzV5QdxHoyU+
	 XcFzgyVpAWnAiOW0cPPKEKkriV7Ewab/jR/s2r922QTADbpy0XNRFTkbUYn5IkK9dd7O2
	 UqW83eZr8d4afxoY83VKEHKyUUEgMKTOuRoiK6zCPPiUBaZQyINVbQMSHIURcPLAcZ4Y2
	 yzPIHUn33U3SWMlXCO0SJbmbBXTZCgKhv+OtEi/PGAxJY1WWiMu77rfEsNR7u/V015Um3
	 9XUW1jWlX29QZvyauYUqVL5rBpDKCou77NR4FxgRQJvRSub5DUbCfvya7PvpiNWL7lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rRxj0ctq;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5993606A32D
	for <linux-spi@vger.kernel.org>; Sat, 14 Nov 2026 17:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5993606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rRxj0ctq
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a070755c8cso1256168b3a.0
        for <linux-spi@vger.kernel.org>; Sat, 14 Nov 2026 09:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794678532; x=1795283332; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Z/UcwHcKXUqaXtKk/lpD8kvZeZD8k73uW8qTCjwCp54=;
        b=rRxj0ctqpPtesi/Omr/um2Z61N/3D7qp882DAP9S1NCCR8QNyqo52R9c/iXb9q35Lc
         wBkDdAXhVY7dKlCcCRu54s6Rw27XQKmcPaIacL4r1OJQ0OS/6D1XSO3hYiNyEMGUeW+c
         YQEgWGk5c0ehv0Vg0eugObUB8lFMW1vADrq77DK3rPrM1TBLURk3bzDA0AQvSj3OYITk
         BrUxj8wRR7idJX+JzDgpu9T67rEMPrsdbbqFcX8UugxC2ZODiXHJ3UUg2lTq+EBii9Yh
         BIOtwQSAwVgHfwUfwEZmbms4UAkpn8cZ+O71VwOiHWklyT3tQIOeLmcQ4meHSXJu7H/D
         4c7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794678532; x=1795283332;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Z/UcwHcKXUqaXtKk/lpD8kvZeZD8k73uW8qTCjwCp54=;
        b=bzrQwFuXQdpSZWGEZBs7HZnWnJfR/f/xRjoYXrq9wuhjtg0VSs8W57KO6ts6nLKWHt
         wQ6D8IU/q+iCYOB4jmhB8JkoKhVZ5xKqtZkaclz3iR9KzvEs345f4ylMV+8XXPPZKMwN
         HgP8+s1whdP+g28rHuFcCJsHA6zcjEb7H6666LuR3WwyW7H18hnw2HzVfXWZSQ7TSWjO
         +2C0aO8Q60av9wK6rOI4ygMdVnTsC7LcgCAu3sHTzSXvbFvGxiZJn0yYZt7oXq1gGoIU
         4kEPuZl9x19lIj8SVG/muKvFsYxhL8cMPpwOnUE2Trg2kgqOjQ/3Ttz/dcRTXJt/S6dG
         CwAw==
X-Gm-Message-State: APuU4Z8uDEHxO3RH/MIM/FD20UpH6+9Ez5FWPnGLbaAbi6TA4eT4mtjm
	ZlG84GnRzQJ1HDh3pdAfTdSaUZyhClUKy9aNkA1g0qirHuIKlQqI9iYqnx9S8t78
X-Gm-Gg: AYBFou12Mvk3byndtU0GVuOrR7d+ujeILGdItYJSo6299uxan0ZleG//HtrcYnUCNIV
	TAK2BeFM9g0h1TQWfRcvlMVSfbDVNRWW9vZ07tqnb89N/X+g13Lp5LZiPfRJx4rfY2gqp4CXZlP
	V8eEpLwhB52O2bPTFW5oCCEM/vsmKyoki2d4su06n79oB3h5wwnvgVh/kognXI6NVG2M+P5t09n
	yYkHqvCe20Wt///6l97SZLzk3gg3nrJ3G6nZs4zepMn+lT7wQAbOAhkyw+UPisLfhgQ/7zLfnvS
	Li9HoFIQXthcI50PhcueyPe4sGYsfRsSCLCJjpQrEmk0BQpBu7bcWE4Oo0Q4fPNO7EX7NCDjV5f
	j62uxkgWJ2EJvcDatet7NTC6qxCY3QCFEQfAan1DST6LcTrNDhfa7anUjaP+cikrwdz8LJhfMfR
	YvhT8JNxhyk8LPVhgG7fLYIARvO4Jwa7JL4EYEmBF1dSGoZvRfyrIaGZJ4wqdWwACG4nVZ9vaT/
	zipD7b65R7qq3OEoB+zXC6ZbTBfQ+QT7VpvATw8Bm1Da9vyV5/YgPEoyKEucAmj94prVP5JyU94
	2R67deBMeuN3pzbxZZ04Q909JCNBd75NwgDhQDrAmpqBiw/AbrPT31xD8waVxkphHM6sb6o2BGH
	Vzqqin72WV0CqqQ4oOJzFkhnbfIvJLQ==
X-Received: by 2002:a05:6a21:8203:b0:3e2:490d:5127 with SMTP id adf61e73a8af0-3f7a4dbe495mr6706402637.2.1794678531850;
        Sat, 14 Nov 2026 09:48:51 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9009:b6e2::7dee])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-cddc18b4352sm2670802a12.24.2026.11.14.09.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 09:48:51 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sun, 15 Nov 2026 01:48:42 +0800
Subject: [PATCH] spi: spi-qpic-snand: fix DMA unmapping on probe failure
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
Message-Id: <20261115-qpic-snand-v1-1-74df634096ee@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBBA0avIrDVpCUldRSyqpoxF0UEkjbsrl
 m/xfwTGQMjQZBECnsS0+ASVZ2An40cUNCRDIYtaKVWJbSUr2Bs/CNSuRCeNtqaCFKwBHV3frO1
 +89HPaPf3APf9ANXl5tpuAAAA
X-Change-ID: 20261115-qpic-snand-e9f3ef0a9ca5
To: Mark Brown <broonie@kernel.org>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794678527; l=1199;
 i=ustc.gu@gmail.com; s=20261030; h=from:subject:message-id;
 bh=PW6c9S/gzhT1sfHRfpQ0G/XwjJdB33xWHslK5WJM/Mg=;
 b=wat4but5y2s3u9Lfh4bhf/ILk8tlX+ZbL5jq8u2nhvZRjeLummejFXOWVqRDdm2yr0HimJEWD
 ZZ3YOS0ZfyoDxfsTB/wzrGls5bwE7glQnT0i2QSBN3rvMWambq5yTNB
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjDJtbnSeysEBjmOfNYqYUUDS6g7Tfov9W5oGngTBfo=

The probe error path passes the physical MMIO address to
dma_unmap_resource(). This can differ from the DMA address returned
by dma_map_resource(), causing cleanup to unmap the wrong range
and leave the original mapping allocated.

Use snandc->base_dma to unmap the resource, matching the remove path.

Fixes: 7304d1909080 ("spi: spi-qpic: add driver for QCOM SPI NAND flash Interface")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-qpic-snand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index b03e2e4f0f0b..6cb6e02d2498 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -1668,7 +1668,7 @@ static int qcom_spi_probe(struct platform_device *pdev)
 err_spi_init:
 	qcom_nandc_unalloc(snandc);
 err_snand_alloc:
-	dma_unmap_resource(dev, res->start, resource_size(res),
+	dma_unmap_resource(dev, snandc->base_dma, resource_size(res),
 			   DMA_BIDIRECTIONAL, 0);
 	return ret;
 }

---
base-commit: 793807ca13bf3072fc6d16ce6d90e9ab9beff2a5
change-id: 20261115-qpic-snand-e9f3ef0a9ca5

Best regards,
--  
Felix Gu <ustc.gu@gmail.com>

