Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495CD43BDC0
	for <linux-spi@vger.kernel.org>; Thu, 20 Aug 2026 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787230734; cv=none; b=YVgeZapqklwVQPLjYOVSVlexm892L2CrgKOw4idEQSD7vatMrN/6gmeGtCv4cKWmusQI7Vng2Zq3AmS4ffGF2DG6LQIV8ZfRCa+12kLhNbcSczQLXMEiMmqCpzmtbIkKhswikWGAdIpzJ5O3Yzu2yantEMp2ssxpu8HMc//Xq28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787230734; c=relaxed/simple;
	bh=Q4mSoaoJE4XrNPV62WpY17qq9dhPoOHMyIcXok7UG+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aIdcdUVAppuvsNJsFqMFd1dklvKlRSAFPH9QhhjgPpvMToc7IXoHu3bNSBD7ktkiHxPtKQ2D/dnoHZ8FhHUY39E/k0iKk5Ut7LO0VN/pvqLxD8N8HI8QRQZNhmn8O39LQ08mVFwJ5S/+wFIt4m8BMk64e2sD0DYeJeCvJy2ToLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffroot.co.za; spf=none smtp.mailfrom=ffroot.co.za; dkim=pass (2048-bit key) header.d=ffroot-co-za.20251104.gappssmtp.com header.i=@ffroot-co-za.20251104.gappssmtp.com header.b=FPKYp+zM; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffroot.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffroot.co.za
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ffroot-co-za.20251104.gappssmtp.com header.i=@ffroot-co-za.20251104.gappssmtp.com header.b="FPKYp+zM"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-480033bdcf4so1387840f8f.2
        for <linux-spi@vger.kernel.org>; Thu, 20 Aug 2026 05:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffroot-co-za.20251104.gappssmtp.com; s=20251104; t=1787230730; x=1787835530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KbWAJa3C683yffh0RsfqBofb1SIppeFKhvek2Ax4mqg=;
        b=FPKYp+zMiYWXHVZJHKgXr118WTZtWzdJ6honJXzkVOLBe9vLB93SHfXtXHkq3xo0vT
         gsufLgcPL7MGzA4YuNDw4kTWi7LIQAbJ7L18/wKS+xqrNMp0azPwc3Xsx2Uy8kpWia3d
         yXFQUij7tGomlbF78vbnfuh8/LQmDBe10cUHUMxf4gpGJPkDyu9xvidjkZXUULkC/LKg
         91l5KMnCqFLOEFpvTOjJT9mEqr7v8FgemrrXwbitvi9vfonZ/kGIiOcBeWnINttp/IEI
         21oI2aEmp+dOaY6UWcyL2y87qZ1YjWYppCKW+ukVlXBLX2f0VN9QArh4J5c4AQABDt3m
         QsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787230730; x=1787835530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KbWAJa3C683yffh0RsfqBofb1SIppeFKhvek2Ax4mqg=;
        b=ohPlgRwMGpl71svEaRfGuLMlcGxGOXuV8/NGNNxOulhnZVo5SE9Wdbl7k1K5PlMrR2
         6uOV9A0OyoqoMSsEN3FXXfZZQD7pmb4WGfloaZtjXGNtaV4WwHWJx/OGp6kAhzJL3OOp
         lG20wExVQLiHfoKVhwwuRmAaQoK/twv8SZST0/3vNOpXfATBp074NqBhIMW53ZxMl9RX
         THUg1B29IAHChrZxGQYEb5g4UOPzJyTXlK3Ahe7JDefY2Z1wjwdX582Ie1IVw7SB6e5Q
         HbvPB+rqYM2fP/4N+HMVxLFwnnMtli0MYtzAmktIHmNkXcyXK95nfz9gddMDmELj89PN
         +X4g==
X-Gm-Message-State: AFuF++kaL8y6jwRFllXikOsdm3OsCixQnduogidKBijwRj1kvgI6NU/M
	cCs+whfmJ2LW9eEdwwgZJfQ0GZ8raBu+J0DmWPsWaqqZ7glO0e+FxfYJxCNecVCygqjUwMAx2RT
	U9bvDYtM=
X-Gm-Gg: AR+sD12O0D+5nQn9YnHEx/Q7dgJyGiRyxSyk/8euTzB/jPz9oRNn0ZiBhvL8569l5Sm
	EsZNtpr9auhzoaD4uGJgP6ei/LtUjhk3EPcDic3LrhcSZoGabSx41RDhFWkLyy/n0yaXqw6TFhO
	uhSv8od26ZPbD9Q5OF9rbAhPZ+z4bFO5kI9h27Z4+6o2XQ7z+r66k0GDYhRWxWle702gkN35PxN
	0eKOD6XGppx19ZKjPbK5fAyuNYnntEfc9pCeBrsNFIh5jEjZgB2vtiBidfSVgGKkuhXx2CQMEts
	vRQW6/uAEsEbnwzUhO+sByACJopiwi5uIuvc+ejh/YEvKfjBDKsRW84XlpzaWhDJEcCldFlbseB
	8A4H+oAQV2pFtXJewnqsZpGGaPAjHSdjlKAaK4/zVlpxJlVAZTxccaqDDmAOeeowSpVyiBgwm8n
	udKsaZIxHZNITRg9PUAJgDqx+xNuBOsbr8yBnyK3j0w3ESBMjzT7m2BSoUK7x2TxbKXd6D7pE2f
	nwq7Uo78CnAlaOAwr46sRoyRFkSrx2XnIc=
X-Received: by 2002:a5d:64e6:0:b0:474:530:9d with SMTP id ffacd0b85a97d-482b1fd894bmr21727223f8f.13.1787230730303;
        Thu, 20 Aug 2026 05:58:50 -0700 (PDT)
Received: from dev-ag.figment.co.za ([102.33.165.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14c45d1sm11095767f8f.30.2026.08.20.05.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 05:58:49 -0700 (PDT)
From: Andrew Gaylard <ag@ffroot.co.za>
To: linux-spi@vger.kernel.org
Cc: lhjeff911@gmail.com,
	broonie@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Andrew Gaylard <ag@ffroot.co.za>
Subject: [PATCH] spi: sunplus: handle signal interruption in transfer wait
Date: Thu, 20 Aug 2026 14:58:35 +0200
Message-ID: <20260820125835.1584270-1-ag@ffroot.co.za>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wait_for_completion_interruptible_timeout() returns -ERESTARTSYS when
interrupted by a signal, 0 on timeout, and positive on success. The
previous check was:

    if (!wait_for_completion_interruptible_timeout(...))

SIGKILL caused the interrupted path to fall through as if the transfer
succeeded. The loop then re-entered mutex_lock() on the next
iteration, which is TASK_UNINTERRUPTIBLE. The process could not be
killed while blocked there.

Check ret <= 0 and return -EINTR for the interrupted case so the process
can exit promptly on SIGKILL.

Signed-off-by: Andrew Gaylard <ag@ffroot.co.za>
---
 drivers/spi/spi-sunplus-sp7021.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sunplus-sp7021.c b/drivers/spi/spi-sunplus-sp7021.c
index d78f48bc2b0a..607fc01c4207 100644
--- a/drivers/spi/spi-sunplus-sp7021.c
+++ b/drivers/spi/spi-sunplus-sp7021.c
@@ -338,10 +338,15 @@ static int sp7021_spi_host_transfer_one(struct spi_controller *ctlr, struct spi_
 				      SP7021_SPI_START_FD;
 		writel(reg_temp, pspim->m_base + SP7021_SPI_STATUS_REG);
 
-		if (!wait_for_completion_interruptible_timeout(&pspim->isr_done, timeout)) {
-			dev_err(&spi->dev, "wait_for_completion err\n");
-			mutex_unlock(&pspim->buf_lock);
-			return -ETIMEDOUT;
+		{
+			long ret = wait_for_completion_interruptible_timeout(
+						&pspim->isr_done, timeout);
+			if (ret <= 0) {
+				dev_err(&spi->dev, ret == 0 ? "SPI transfer timeout\n"
+							    : "SPI transfer interrupted\n");
+				mutex_unlock(&pspim->buf_lock);
+				return ret == 0 ? -ETIMEDOUT : -EINTR;
+			}
 		}
 
 		reg_temp = readl(pspim->m_base + SP7021_SPI_STATUS_REG);
-- 
2.53.0

