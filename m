Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6429D4E06E1
	for <linux-spi@vger.kernel.org>; Tue,  6 Oct 2026 23:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791328820; cv=none; b=KL1j5qtQAMaka8PWvhHFZ3WICKLsvZ8JYyCqqub1HnbK+WE2Uk9Fx9mI2vlqsBi8Ate9HWzRHEyzUMscOYRZyyGbkxnNUGnu0CBKvhgzi7+zwtsl/emB+HsopM68qYUjwgDs512NXDGSInxwhQ1VZc3quGb4AdW1CN1grEWmVxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791328820; c=relaxed/simple;
	bh=sjuSJIbwK+9pC3HVLoTkORP6Bqh+nlExjwmlTCp9g3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWpfBQO8B8dSlDJnrTHr0bmaAzVUVZyvGU/dCT1NneXa5nWDXn4KoEvQMjP0TiVkWw4RyuOa8gR2igtWRb3liwI+B6f74dztvB9EVUjeAqze30oSdVWr20O65Ek/Elz/boqGgX3/RzZNxqkqXTIofAejSJXlSs5j0/iR3IcXls8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=D3J9qWW6; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D3J9qWW6"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3115c4451c8so2692972eec.1
        for <linux-spi@vger.kernel.org>; Tue, 06 Oct 2026 16:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791328799; x=1791933599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5PkD2yI0m8nq8ghTI9DLQE4m/ducagwKY3yX77vxrJc=;
        b=D3J9qWW6k+EMdpdUFWd+4UaHlG69QX5j64a0EX1YcFvTrpStVTCkmrY4Ui11aMHXU5
         oqOix2+E6SqQoZtIp0V7sBFw/FDJfBHiHcq2PpMVbphJxmT6AC36ftec5TH/xUv9gWil
         Eej9Z5HITI5GZiGU6AZp+Uq6m4MjuIyLmzQvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791328799; x=1791933599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5PkD2yI0m8nq8ghTI9DLQE4m/ducagwKY3yX77vxrJc=;
        b=AdV7LLKH23+iILAZSh/XB7PI2EutpRC+FyAPzc6LzezDLKMnE6hragGjVMtJ7GEig1
         3pJoc/ECryK/v0J0E1vsUOnZcK3jmQLsgtriY+vmEcVlXHcLJuTMyERKmCrHk5p4qzSY
         2NTK6ZW3XtRNufOrzkaMEvm7Ex40etvn7MWeKfIsg8qjN8cD5aZ8z4+kTL6FDfJ2m+rr
         s6pZc4C2c66roN1B1V0STO230GqiQ3ZsNE2x1zW6i2sQCJwScSKb3TyYHC7e6eHQ9wVm
         dBBsi/TgiadEbA9XM33ugeruFNQPz2LAPuXQH0v6GanKH4njxusKktVTV70vWwqzCynh
         gNow==
X-Forwarded-Encrypted: i=1; AKwUvBxy7evt4pssHkADCeZM5JmoozHVamWnBHfWTlrqrrKOb76KUeNWimDgaFgHhXjkIQeVCxqCa/WtFCA=@vger.kernel.org
X-Gm-Message-State: AFq9FYI3dX+PV52X0diGVb5EuNqEGEQobSONive1Ypzh0WIOfjJl0/ka
	fV4iPxV9PBSK1K/IxuFBI2Py7Ugby9527CW+qLQTywuUsllFb5d4BPlpdk2Qg/9f0YmD5DvOhAP
	t92g=
X-Gm-Gg: AYBFou1Cn8AjjaKwaJ2NFURBGM3pnPCBTQhFGZZY3u2rSNPTVw9OTk+hWjpXSNUkeAk
	YpRj16rTi3GjLHT6AXmmoPvbqzXSRlWY67uxMqvU4K5+XCtP+zz72AWrXuLKtdisBckjpdnHLku
	1Jqa+KH++dSO5PgsTiBEYWSvz8S1pd+XAg9qWRO1Oa3d1Zk+85SdjJVBK6rhpjrYv85nkY+IWUb
	++/Shz6T4ZwbpG/b1Mp3E0hPdQKCDUGyHzUDQNpphTxl1DQh5cYnwbhS7MTLxheKoT0ntmbK0PP
	6ERHXmaun4vPEqia1AAiReIeJnvLMgXVIe4hDrwywRdetFOegv8a4YTur1Xu7Cj8i1PNVTOjpin
	IZM34EzQa966fgSpnYDhbgBoYjtsVIV2QivMkxEOz+k4F99kiLKt6GTBRXu28IuU2F/n7XNQdmb
	WFdXio+mcAXANkbq4K/bPTmtfrxD7x53zmoZYP/ADOxuhhKfgvxhB+4Hm5BXlhol2Nd6tCLrwEb
	xb9oYHuAWeJ+WTgVlMMcsSGK3xK4/scBKOWFQ==
X-Received: by 2002:a05:693c:839b:10b0:351:4708:9b61 with SMTP id 5a478bee46e88-35147089d49mr4409223eec.19.1791328799286;
        Tue, 06 Oct 2026 16:19:59 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:63eb:e7f9:1d47:7d47])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-3515af511a5sm1977457eec.15.2026.10.06.16.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 16:19:58 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH 06/13] spi: ti-qspi: Discard pm_runtime_put_autosuspend() return value
Date: Tue,  6 Oct 2026 16:13:34 -0700
Message-ID: <20261006161337.6.Ia678a25bddd5942c7f3e11ff0eb807754d7e2aa2@changeid>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
In-Reply-To: <20261006231900.3230373-1-briannorris@chromium.org>
References: <20261006231900.3230373-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Failing SPI setup due to pm_runtime_put_autosuspend() returning a
negative value is not particularly useful.

Returning an error code from pm_runtime_put_autosuspend() merely means
that it has not queued up a timer or work item to check whether or not
the device can be suspended and there are many perfectly valid
situations in which that can happen, like after writing "on" to the
device's runtime PM "control" attribute in sysfs for one example.

Accordingly, update ti_qspi_setup() to simply discard the return value
of pm_runtime_put_autosuspend().

This will facilitate a planned change of the
pm_runtime_put_autosuspend() return type to void in the future, similar
to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
type to void").

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
This patch is independent of the rest of the series, except for the end
(changing the return type). I expect it can be applied by individual
maintainers, and we pick up the end once the dust is settled.

 drivers/spi/spi-ti-qspi.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 34b154922ff2..63b9098ec8a2 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -158,11 +158,7 @@ static int ti_qspi_setup(struct spi_device *spi)
 		return ret;
 	}
 
-	ret = pm_runtime_put_autosuspend(qspi->dev);
-	if (ret < 0) {
-		dev_err(qspi->dev, "pm_runtime_put_autosuspend() failed\n");
-		return ret;
-	}
+	pm_runtime_put_autosuspend(qspi->dev);
 
 	return 0;
 }
-- 
2.56.0.360.g66cac248cb-goog

