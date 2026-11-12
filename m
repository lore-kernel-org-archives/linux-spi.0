Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794511429;
	b=wsPBV+QvVb3iiCmM/1kpnl0xgO4zcK6pigLA5zl2pJmIDgq2IV0MgB6blAKzeoGEh7G3
	 fPwH/uUi+/LiiZloNQOtO8k0/Q2sywc5s53Gj5pV2qEjW3KKUZ+YR4SCPqYeQDm3OUdVy
	 UB5CJ43hKmq/PvwRVoU1+SqvL8D0o8uAlXTVZ2AHf3tiYU26wFeVnybMSol8rBlYry8fw
	 C36Bpv1lLJg4YBvNaS/99KuLp7bZEPN75hHpqWgWGL4LMRxW6t6v2RSuU5i5OszyJsQQQ
	 WhQBBq8yx0+kUMyAtiCQqhbVU1mW03Q7IOUmea59evzgsTwcyNYA6lilDEVT8RDLjng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511429;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1/JyIzcdfP+G4sJFpml9e8PwacQNaxxoJDK/M4g8mt4=;
	b=YfJMW4koZVgElaEzx9Wa2/Aaqk8EmLu4urIouMOI/wsWbFDyyoe00F7dTkkrI6gHgSO8
	 WV+7aklUIv9yEGsXWCtgMAtFfUGxHR7gdpS8nHAaLhNdDISVXgjDew59YvoblG4S3bccI
	 UkWp6isysfS1/O6v66NZguwninyb0sPW2EekeRwJ+pKb1CL4iFI8nFMPBPJGqqjWblQKs
	 iF8MVDZwNWAhGnY6g8wWZ2Fcks3vk+HBp6Zvk/o8bnh/ou3hxcsMDjL1tIcyYoYdqGLjD
	 JloFyNM3ERmKjMWwpe8UyiHl7kZS5QkrzGqyq707h5mcJfMgU4LLrDnt7Ny27yTUvfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=dqtPs6UR;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32369606A32D
	for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 19:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32369606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=dqtPs6UR
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36dbde64409so347736eec.0
        for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 11:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794511428; x=1795116228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1/JyIzcdfP+G4sJFpml9e8PwacQNaxxoJDK/M4g8mt4=;
        b=dqtPs6URbnv/BkUff0yIwzy+M78+2+4alrPlun7JdSzYxaYQg+KTetix6xPwBoY5vJ
         pROgF5njY2aqLKISsTNewn50Pp6o5elVHmfN4tWXoQHqRK98Mat6LWExDjDnWHMYmXnD
         wska+KlMBH/+JQT1fB5GWa3gU5y0SVwYxQbDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794511428; x=1795116228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1/JyIzcdfP+G4sJFpml9e8PwacQNaxxoJDK/M4g8mt4=;
        b=xShzHN14zMcnQumalcQXImyIN1iMa+HOyOv/B0gU94YK4eyW+g3eNIq52Yl+qPODtI
         6xC1uYBvzPTylYkqpr8fZ0PHhPStshVHUbFFeplMv2ewL7e7c3e+JR/nt8S7QyCQ6KC5
         ZqWsppwGj+LwO0JHhemTMSjwOvzuaU/waMxmVIghE8FlzG1iY3Sm08N6reGXE8dNi6AF
         Rpduk6+kJ7FFUbnlFPy97xlsVgL6CXM/U5lxRbhymC7XuZpuQv/xgOV35H9ONbegI/S3
         NdOQ+7amOg6ABhia1fdqhfz3bgqw/r2Wv4VWtKk9EzTtJbPA2ozVbF3Tsm8ppL0imNQj
         IkcQ==
X-Forwarded-Encrypted: i=1; AL+hErHA+OZyLj0/HHqDQoKP63PaVrD3lUixIOMAoiFQgkeTc57eNDUt+W2xOslgKNdPrfVik6R3uD0O68g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+SeCwoPYeGDYn8xRnPeONHgHqxTFYBnW/Tg1ax17euOrVV5vDZ
	MTJQjWEzD75W8b0BZvQ3ybpLb5I+j+1MMeRto3TyKD1tu2wG7n0CEWeMgq1AS3yKJrRnmP2qlWG
	kdvs=
X-Gm-Gg: AYBFou2WisV4EV8aSc19WAw3NTH3iEXznulWlnGUj6s/Yow6rSdSX0QmnRrS+RC90bW
	ODD1ZmAvosixT30vpu7p0RwsXVCWuJgTYalpFkQSy57qBLcVrw4y84SW3hgpGFGwMu0tGEnu0AK
	wVVdX8bejYa9lk6P1TuyE9jhZdjrVbGDAIkAbTXbwvvFIAyiqv58OMkA6sMLQAwxd7vtnO41yqR
	rPToWIxJTJZPUQDoM49D1L9m7yAqzPXhNEaIBzgWwVCIpx8qbBY7cGvwJSJdbzhd7/Ce1r1QHee
	IEJh1ERNMY5viOTeLjvvEv1CPUd1WiKLgD7Z3HaIPzSsCfDMpELZaj45UiIrSNZM9jiaCfxfHVH
	flVPjZ6UhIsOdSuiYYRh5QermnlqM4l4gR1GXUTzMnRLKGdjAy7Yj772xXN3e5POgWa5l0s69b0
	0A5/7feR5KzCtE13X73W5muPW3QGXdexVvEu9zydo/AE1HM/jJhq8NVk9gyo9YSSqyXVj+pPwHo
	RgefGelvO+IIHwA/sC4tK6kAqCi9mm0Ho+ywTmcS0CExOSk3Hs9Wp9RrOIFNIehi5EgGiUAewns
	ChrBqSjDTi05vi1h8ehtjoDV95sD/h27KoXcDq1u94rT+TuEo71xgVpsMFaglWZRBGlBoVSGqs0
	IYaEeASPJCFvwaA==
X-Received: by 2002:a05:7300:fb8c:b0:376:a62b:ae09 with SMTP id 5a478bee46e88-3796676a1e8mr149029eec.16.1794511428235;
        Thu, 12 Nov 2026 11:23:48 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:5446:563c:ac92:43a8])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-3795591f4f8sm491585eec.13.2026.11.12.11.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 11:23:47 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Mark Brown <broonie@kernel.org>
Cc: Brian Norris <briannorris@chromium.org>,
	linux-pm@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [RESEND PATCH] spi: ti-qspi: Discard pm_runtime_put_autosuspend() return value
Date: Thu, 12 Nov 2026 11:23:34 -0800
Message-ID: <20261112112334.RESEND.1.Ia678a25bddd5942c7f3e11ff0eb807754d7e2aa2@changeid>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
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
This patch was originally sent as part of a larger series here:
https://lore.kernel.org/all/20261006161337.6.Ia678a25bddd5942c7f3e11ff0eb807754d7e2aa2@changeid/

I expect it should be merged by subsystem maintainers, and we can make
the return type change later.

 drivers/spi/spi-ti-qspi.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 091a8b8842f5..c21b8adbbfc6 100644
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
2.56.0.611.g1030f0b940-goog

