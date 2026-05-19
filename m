Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C043BCD00
	for <linux-spi@vger.kernel.org>; Tue, 19 May 2026 10:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186364; cv=none; b=dEKfbKNX3hnR/r/1p2vNCaBDVODHopLjkksVyYd6LzC2EP3rMKJjwKdYApMiduWratn5g9i372fRrxZuYWHhJlSI9HABl6cJTDG73G4PjlRs0HD3vKNU0oXDf13XHFCLm/MYCd3cJ9I1DGnfivPue1e3Fpxl7qjX4dOi1xUEafg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186364; c=relaxed/simple;
	bh=0iubgivcayq+lyY69Sg+JRyvXsx29eB74VGe++/UMCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q2N+kR3cyIDQyDLmJSA3sdj8ebQCcwmphK/DcMpaE+KZeaQxdI+ZTnrc6jWJNFvM8kgSAs2tFyTtpKNjF8rbKwywxnFn1AnkiDQ9/4En0B3Sxs8Yt+1H6yIWDtdScKw+Fv8JC2O7DBa3AhbI3vSa0tkC0jn0Pcr4m8NbEH97Djk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pcc.me.uk; spf=pass smtp.mailfrom=pcc.me.uk; dkim=pass (2048-bit key) header.d=pcc-me-uk.20251104.gappssmtp.com header.i=@pcc-me-uk.20251104.gappssmtp.com header.b=ianILBu0; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pcc.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pcc.me.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pcc-me-uk.20251104.gappssmtp.com header.i=@pcc-me-uk.20251104.gappssmtp.com header.b="ianILBu0"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1329fc4bf77so9348705c88.1
        for <linux-spi@vger.kernel.org>; Tue, 19 May 2026 03:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pcc-me-uk.20251104.gappssmtp.com; s=20251104; t=1779186362; x=1779791162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zi8nkxTzh0Eo1ehnp7/9INpraaPZX523L/CWo/OlHz4=;
        b=ianILBu0MR6ck3JNfky/2eXt7oHM07/J2j3y3FGvhLEdYuKyvfR97in8sa7in8fHG/
         ENTQfJZ7+XYHRaWVcGn93TkyOWa6kGMrg8vvZdbhwDjAee83pY2UY8aaN6BjlKOlEsnL
         x6j0PcvVWRf0ZLLwFPT3Q3ZFozTv+e16iSb128wfWeA8JHWVRTfMj5F+vLJywJk8GsIn
         ewnzSmANHtCKg2CZaNf6k9EInrFmAsIo17zGVGrK6dk18U0Z22kx4tTMugpYo39Hh2+k
         qRBEBR31MzJI0jp8Z9wtRl0pn1BLqTE7SnODpaAot9cMIKEa2to4QmsExNTgJfJjIl91
         FT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779186362; x=1779791162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zi8nkxTzh0Eo1ehnp7/9INpraaPZX523L/CWo/OlHz4=;
        b=DUdWKvRYtpZZa6u4e8DGihn14IYQ1KsULBX6oAgKrxBxslZmRl5/YgVxemF0SA4dy/
         bW3NbJ2prS45LuhcnORGgJ+R3NgOSesTXNLP36nL47x04KgBLczzOgSl2o23TJGdcByy
         2SjpmuqmXUqEJiW+IiOIQSBvrKqgXVvVj9+wOH6yLJpO/mWn+GgbL08Af2yZ41876eR0
         YxDn8cQG/YIt7Enae9oIMDhhtFL0rHeQ4XEz0v8OLO4vfyM930wuaz2yaVg+5lyS4uAB
         LYTPgQm3zgfoXUwwZhfu8TWdXBOqlED6ZDLPDGyZ6Alw0T/T+t1z1IHFvr0tA68Fgvrt
         duZw==
X-Forwarded-Encrypted: i=1; AFNElJ9Fa9W67ofo//IJblsKhQEru4ojh5uTxEVt9LhBeK59hzVffUaZyFCABt33naxqzzl7fMcYaejhgpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Ujyb7Or8i55wnGcmUj6Q71fsgJ1e6grw08Z3kQXDHRvz6mFi
	zmQxEE/A3slHh3fN8IUyVLvHoGht1Xr1hbq/FurDYWt/6lXN1mfuSTBEGwIl1IT7uE8=
X-Gm-Gg: Acq92OFOe1sKzLXVK4LCLnXMd9HFvAAhARNahLq8WBHvtBRpf1Bzwb7f8DiQxG9u3YB
	TdGzfx3nrN2IctmCvkfJJjp/o9NGQV8ypGmP3lma+TDvcC8/58nSsF77/MJUt4A0zULgBYRjJLS
	H8Am3K1d3a9VucZLBV9YZlAhDXCcHumcU458oiWjmvryVuemec1mFQaY8AbeJa8JkRAsiW6V8cp
	Hr9oD9QtL+x5MbJaLvHQAGP4wbSX8giBO8QFtZAsKeA4iqZ0YCUM9o6RunWsLKfgsqUBCO2CCL1
	slBydVW/KV6Nb4923u300KUXS1r84RjY6CeD7mgQIoOIRD+vPROQWK+XxIgOeRLjfPzd7h8Gw58
	cxZ1pNK/utBnBuaM4o452eGnUf+bE2VInHxP1LA9x8BRM7BVgl22jj/bUgKZZQbOF6IcBSGUQH5
	RP0znM3HwdD4iv2CZT/NJzZarlSiRRz+mRCBvvY293eU2g4KcO5PcDOBo=
X-Received: by 2002:a05:7022:6890:b0:12d:de3e:cc01 with SMTP id a92af1059eb24-13504a4e7c1mr9034464c88.40.1779186362132;
        Tue, 19 May 2026 03:26:02 -0700 (PDT)
Received: from localhost (c-67-180-161-137.hsd1.ca.comcast.net. [67.180.161.137])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-134cc3490bcsm19415549c88.15.2026.05.19.03.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 03:26:01 -0700 (PDT)
From: Peter Collingbourne <peter@pcc.me.uk>
To: Mark Brown <broonie@kernel.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	Christophe Kerello <christophe.kerello@foss.st.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jani Nikula <jani.nikula@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Peter Collingbourne <peter@pcc.me.uk>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] iopoll: use udelay() for initial polling
Date: Tue, 19 May 2026 03:24:46 -0700
Message-ID: <20260519102446.209723-1-peter@pcc.me.uk>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A short polling delay, such as the delay of 5us
(SPINAND_READ_POLL_DELAY_US) provided by the SPI NAND driver,
can become a 1/HZ (order of ms) delay caused by the usleep_range()
call in read_poll_timeout(), significantly reducing SPI NAND access
performance. Fix it by adjusting the read_poll_timeout() macro to use
udelay() to delay until 1/10 of a timer tick after it is called, and
only then sleep.

Fixes: c955a0cc8a28 ("spi: spi-mem: add automatic poll status functions")
Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
---
 include/linux/iopoll.h | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

v2:
* Fix it in read_poll_timeout() instead

diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
index 53edd69acb9b..2ee89b76f072 100644
--- a/include/linux/iopoll.h
+++ b/include/linux/iopoll.h
@@ -19,9 +19,11 @@
  *
  * @op: Operation
  * @cond: Break condition
- * @sleep_us: Maximum time to sleep between operations in us (0 tight-loops).
- *            Please read usleep_range() function description for details and
- *            limitations.
+ * @sleep_us: Maximum time to sleep or delay between operations in us
+ *            (0 tight-loops). Please read usleep_range() and udelay()
+ *            function descriptions for details and limitations.
+ *            This macro will delay until 1/10 of a timer tick after
+ *            it is called, and will then start sleeping.
  * @timeout_us: Timeout in us, 0 means never timeout
  * @sleep_before_op: if it is true, sleep @sleep_us before operation.
  *
@@ -35,11 +37,18 @@
 ({ \
 	u64 __timeout_us = (timeout_us); \
 	unsigned long __sleep_us = (sleep_us); \
-	ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
+	ktime_t __start_time = ktime_get(); \
+	u64 __delay_timeout_us = 100000/HZ; \
+	ktime_t __delay_timeout = ktime_add_us(__start_time, __delay_timeout_us); \
+	ktime_t __timeout = ktime_add_us(__start_time, __timeout_us); \
 	int ___ret; \
 	might_sleep_if((__sleep_us) != 0); \
-	if ((sleep_before_op) && __sleep_us) \
-		usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
+	if ((sleep_before_op) && __sleep_us) { \
+		if (__sleep_us <= __delay_timeout_us) \
+			udelay(__sleep_us); \
+		else \
+			usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
+	} \
 	for (;;) { \
 		bool __expired = __timeout_us && \
 			ktime_compare(ktime_get(), __timeout) > 0; \
@@ -54,8 +63,13 @@
 			___ret = -ETIMEDOUT; \
 			break; \
 		} \
-		if (__sleep_us) \
-			usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
+		if (__sleep_us) { \
+			if (__sleep_us <= __delay_timeout_us && \
+			    ktime_compare(ktime_get(), __delay_timeout) < 0) \
+				udelay(__sleep_us); \
+			else \
+				usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
+		} \
 		cpu_relax(); \
 	} \
 	___ret; \
-- 
2.54.0

