Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466210;
	b=NU1pmcNo/9NJz6g02EEFe7z83L2GEaaUFoIYogFpMnF33C0jMosqdT+eaV3hFdBtPQvU
	 0DHCCpRl546P9z3MDwheMU4H9bOfHv8xQLDtJ29P4cyHuLlP2xb1awLU1sTonvpSBvE4H
	 d2H80qrlCnaNMfAv6GgB7vCLqiiSzDsYVaCDh2mgK2di9RPJbOndV+uS3Gzcsgcvjvr7m
	 mZPdzzkr9AEpuxICDz/9us7RqPv62zutqDMp2xHNUn7/iJaGrl3luC3fiyh+9ZapJyGsV
	 EzGuyBPmPu2Jc2NDZo8LeIayzRrC67U+D9b2rb5W5qNut7AAbWKZzTYzU2UYscjEnGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466210;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fSSCkqvwTZj1huGL8Zl26siSAmzWWRmX0EP+FjZ9eu0=;
	b=gxeOHc5UCMN2NjuoIMxUAIeAaIPWFvm7G1uJG1/EFPei5nbdufaeWP5bNCHRGJOWxheD
	 ZjxbsmoUmFWdRMwRcmN/sZZVi5DGugRmEfkYxN25D4aGhGSZWN2OXwYr11vL1WerreWdF
	 yI9+9joGGJHvG4njStX0vbZD8ctc9F3niOqWEa7MOLedk96PhfX0yZdAGDXZzPwK/kUc3
	 edRsvETqp+Xy8vyGCmPrHDD/sA3n4OlukOLC5WgUn0d2Uw4wv85NahxPh11P1DVRSG8rs
	 x5xV+ANcnq5FPk0ODGNrle623wR5onuHeJpO9CfGTZnsJGtHlzT/UYSrk8xiJ/CXf3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hh2o3mX6;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B66C606A8B0
	for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 06:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B66C606A8B0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hh2o3mX6
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso8352350eec.0
        for <linux-spi@vger.kernel.org>; Wed, 11 Nov 2026 22:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466209; x=1795071009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fSSCkqvwTZj1huGL8Zl26siSAmzWWRmX0EP+FjZ9eu0=;
        b=Hh2o3mX6TwMjHtUDQjFKWWLY9ICG8OkBWi672/jXglxlWUU05O1/0gHpLXjBXZewdv
         AWSNmysG6Fa3+DAwAIRat8C4MYGAzHqrzgAGCrktfuO2ZoZaRrP97bGPgqXWsTkPxAwt
         zS9JbAuwskdP+RwY6qaQhXZBP60lWB0Ea3z+HPat35mrfiM1/T8A7wgjAakx+/Ux6s+T
         3RfFZeM3BhJHFCFhGNIKOOZ6ymglbgDOCgrqeKEob9AKKgchWcX+tCbQCZGAGMHVG3bn
         iC8UKZfAPE1zD4JdVV4sKcTbguTnRL/c7dg4eQgelrtbwdKmTkjdr7IoYF1vAZsXVSuj
         HPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466209; x=1795071009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fSSCkqvwTZj1huGL8Zl26siSAmzWWRmX0EP+FjZ9eu0=;
        b=rJHEzvgtBefp4+cvpxVCxf3PciXfviDxdjdRnRviilRyJJleD9YX7TPQN+C3PttvLf
         8aPy8nj2rGZG6Kf3dCEwYTk2B2N+cqh4VvTy/SWTBMT3BgkMfktsprD5+vy3mpW5ElFQ
         A/9ZvI3Ho7nUYI7jnUFk98o7dzQSexl9Lb6hkJBN6UMhUSZ/BY60I1F6K695BXCGfN+y
         wH6fWJHWcjSBSlfLlyFuMdHdJbKuSk+h2ww3xfq1BxELGq2ki1cqZ1aXO5n9I90ih6ZC
         CxO0fi4HkHy8XsX5tM66BV7yOsq656VuLmeMRtYqFNxBk5QoRv2GfZ4WoY3guxsViXIS
         IjyA==
X-Forwarded-Encrypted: i=1; AL+hErHb4kSDt7I89+bjFyXqOIl0PtPmKroCaA155TdavWclRy0tfOQ9FUulyrY/mAnosAYRxKASusyFx2s=@vger.kernel.org
X-Gm-Message-State: APuU4Z/RprPuy7HYWeNJW5Ismlrcc87DzvdmnKtujZQCiq55Yj6bUGzj
	tAr+/wDJylAfBKZi3MYehk91IOxptHO6J/c4l05LkVCWUnZ/qivX/8+a
X-Gm-Gg: AYBFou3f0+HRPV8DYKYJz0WiVDrLJi/x+NnqijN3HvdOEc1Su4EV+dw6lJQDRqdgXbF
	ThU9mocENG4LU7xZhV0HwNd3SH58/WWygy68QvZceirJpgwF4cC0pUA38jU3IEDOrmVbrELvPPf
	5brwqAgL85s3IUXu8YNjiah2gK2jWeSgEgKJVYoxzOj6PgSXgVWS8/o3L5wHyV7LzjD8V7GCON7
	0otiTwYXTbqAndvzu9hA9avcwY3+s2bBwXnQE7CGWQPuk3uJiF9zHQ9PK3M38nk/iunvGlFGOTJ
	QNvVcD05lDb4cov1OgS/rlTweYrIqbs4iAlascuJSzMtIxvNE4dqvRWJqjRG2l3eNcJ0ngpJF/q
	KhVH9Grc2C1Ivt0R180m4hDbhvCeBGACzSjgktAKunVtgZq9UJ3ROwSVGVRvfRVyBPDAUDW3jPS
	AhBS42RCq7NJ3PJcBy/W4fQqY6/G7x5bvv4+1XvqTrIg2gyEUoT07BTXo4U1Atu4WkBNQ/xkwzU
	sSsw/JyOTaChutd6Ehj1YIZ00FkUy4alt7G/xndw3vpPdAcdUjOjWM6tPjYRc9p7/oRT74a+gn7
	7US3t1CS9gSPteQ+Ykcd+gJoRSyownxLA/BJRSHd7vsEWMzzva7koZi3VdlTCQvGgHQW0sRLfd9
	Bb1JbRR4EmE/q8tYu
X-Received: by 2002:a05:7300:f54b:b0:36c:a42d:9bc9 with SMTP id 5a478bee46e88-37685c7a866mr4653158eec.25.1794466209304;
        Wed, 11 Nov 2026 22:50:09 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:182d:659:ffce:39a4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfadsm27190961eec.19.2026.11.11.22.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 22:50:08 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Kris Bahnsen <kris@embeddedTS.com>,
	Mark Featherston <mark@embeddedTS.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	linux-input@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] Input: ads7846 - remove unused code
Date: Wed, 11 Nov 2026 22:49:56 -0800
Message-ID: <20261112064957.1796975-5-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
In-Reply-To: <20261112064957.1796975-1-dmitry.torokhov@gmail.com>
References: <20261112064957.1796975-1-dmitry.torokhov@gmail.com>
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

Remove the pwrdown_cmd member from struct ads7846_packet, unused since
commit 6965eece2a89 ("Input: ads7846 - convert to one message").

Also remove the unused REF_OFF macro definition and drop the CS_CHANGE()
macro along with its sole call in ads7846_read12_ser(), since the
request structure is allocated with kzalloc_obj() and cs_change is
already zero.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/ads7846.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 6352117cd898..4a5a141bb4a6 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -84,8 +84,6 @@ struct ads7846_packet {
 	struct ads7846_buf *rx;
 	struct ads7846_buf *tx;
 
-	struct ads7846_buf pwrdown_cmd;
-
 	bool ignore;
 	u16 x, y, z1, z2;
 };
@@ -145,13 +143,6 @@ enum ads7846_filter {
 	ADS7846_FILTER_IGNORE,
 };
 
-/* leave chip selected when we're done, for quicker re-select? */
-#if	0
-#define	CS_CHANGE(xfer)	((xfer).cs_change = 1)
-#else
-#define	CS_CHANGE(xfer)	((xfer).cs_change = 0)
-#endif
-
 /*--------------------------------------------------------------------------*/
 
 /* The ADS7846 has touchscreen and other sensors.
@@ -195,7 +186,6 @@ enum ads7846_filter {
 	| ADS_12_BIT | ADS_SER)
 
 #define	REF_ON	(READ_12BIT_DFR(x, 1, 1))
-#define	REF_OFF	(READ_12BIT_DFR(y, 0, 0))
 
 /* Order commands in the most optimal way to reduce Vref switching and
  * settling time:
@@ -400,7 +390,6 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
 
 	req->xfer[7].rx_buf = &req->scratch;
 	req->xfer[7].len = 2;
-	CS_CHANGE(req->xfer[7]);
 	spi_message_add_tail(&req->xfer[7], &req->msg);
 
 	scoped_guard(mutex, &ts->lock) {
-- 
2.56.0.567.gdb80ae8cd5-goog

