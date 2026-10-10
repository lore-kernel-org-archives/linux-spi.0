Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC2035E55D
	for <linux-spi@vger.kernel.org>; Sat, 10 Oct 2026 08:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791621314; cv=none; b=GY30yhtNEO9/CGWU0TjCxbnK1O2SzeF5aAVv+NWTmYK0acLR3SDEdRxcsOmVaGLKJ6SuYNAfnrtuDZnNSZu6dTYAcKfcI8e9cmDMHXE/Vvc3Ty89hqmxlrMgJ5gqf9Jn8Lgl3mnCfeCnPTRKiToYpkGK3e14vfwICIRACPuIbT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791621314; c=relaxed/simple;
	bh=zGTXdvUka6VvGbNqzYW14vdn2gkfCFwLPvPt6mWK5Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mp+rX71IxXNgsXXHS8msU29rbe4o90VJ3yDS4yaXivURLzZZTunxYwDHz9c/88IMyXOxSsA+efVbr8NKME91C/QmL610BQhg6U5bkPaXuP+Dwpgmnv+cMtk53CPckZWMFEzfuhb6KMTB59CLThfUgeyRnt98E2+yaYnsWDgRCBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=aayushk.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=aayushk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-356b1e20700so765906eec.1
        for <linux-spi@vger.kernel.org>; Sat, 10 Oct 2026 01:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791621312; x=1792226112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n8x4yOZ8tD94FrPHmEsxfPkgylOx+K7J5FAPthoO4fQ=;
        b=xjwHjXDAdAtQVeSDbJAEq7owO76Ggy7RZGzpmHSUt/2b8QT0oFCT3WXkIM0LKbrYJB
         UZdYauBuPdAI+ViwYeZJYW3dBh4sToOFOUbYrn97NH4X95m7zgZXNiIEY7bOoAe60FpU
         +SOiC2I+XFbE0lWnS/3N9IQbnNn4ekbnLS1ovNTmQs2taKpPZejoU23Wowdtbky1joD8
         Cehhkgtkn2C1i7S6vxQOJqRoUaEuvSWe8V3+s4QiVdmtxIdtbcGoQCIb3pwyW7zBzQqh
         MSO0WW2GfZbkkehnFmciVB/F42KkLEdpkCq4kSkaZPR2QmNaW11A23enVw85nTX7SMyQ
         fdPg==
X-Forwarded-Encrypted: i=1; AKwUvBw3XRgpKCwRkTlbYTkWsgKs27ORknB/b8zdxY1I/ScCzvyMw9Z9s/zG2HwFCrTE1upJ+sSKUowocNI=@vger.kernel.org
X-Gm-Message-State: AFq9FYL1ztKB0iMwHR0Hd5q+ziVAYjEBHkUDPEJSM31c5hmUTvGiGeQz
	41Tq5H0uh7ssKLA+FJpxYXG/Pa17vB1GnhqkapmBcKx1sYYlw1p+iFUw
X-Gm-Gg: AYBFou2zDRE2+lxfJJe/a3ozyenhXHA0lTMWMX3vP68VD98BhgY/rd3LYkycZtxakZL
	SmHE48y50sVQzvhqXlWh44v7UWGHdsT3E3PoE/4ZWbGEirxSzcs2OTf2RzUCmxxbMGb0hOrt81j
	rWWsgXLs5c44Kb4upji8EC78PKahaqmgCvyoe3ZrdUdsANapR+LHBVhnzoV9oDtQSU8oOVnabsE
	xH4p9pSgN/yhrnzCKZbZiIYt59w+mQ8DI4Ig0K1Fi4kvEKEdELISxY/zaucnp3HV3LIsw1pcNt1
	eSM/xnDZU73aQJ+7yfF0d1GpWmjTeHe8IgHzydp1p+boMN7efhNEPOU7QXrIpZtGvjBkOACW9Pq
	jCZ4sWguV7SZqXjRsSn0M9KyIw8PkU/WUae870qh6RYnKCja6nxZP6N140toJMt26LkWUM32IjR
	83UTnnRG6mXyiUNrr2jFvzujFVb9F2WP3AZTGUB2JLJk/ToVpkj4m90yPxJFE=
X-Received: by 2002:a05:7300:c00c:10b0:34b:6f6c:2274 with SMTP id 5a478bee46e88-3536c4bde55mr7001287eec.5.1791621312296;
        Sat, 10 Oct 2026 01:35:12 -0700 (PDT)
Received: from linmach ([182.156.30.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c841579sm12689858eec.4.2026.10.10.01.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 01:35:11 -0700 (PDT)
From: Aayush Kumar <code@aayushk.dev>
To: Mark Brown <broonie@kernel.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aayush Kumar <aayushkmx@gmail.com>
Subject: [PATCH v2 0/3] spi: use kstrtoul() and snprintf()
Date: Sat, 10 Oct 2026 14:05:01 +0530
Message-ID: <20261010083504.26261-1-code@aayushk.dev>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aayush Kumar <aayushkmx@gmail.com>

Replace simple_strtoul() with kstrtoul() and sprintf() with snprintf()
in three SPI drivers.

Signed-off-by: Aayush Kumar <aayushkmx@gmail.com>
---
Changes in v2:
- Drop the two strcpy() -> strscpy() patches (David Laight).
---

Aayush Kumar (3):
  spi: tle62x0: Use kstrtoul() instead of simple_strtoul()
  spi: omap2-mcspi: Use snprintf() instead of sprintf()
  spi: s3c64xx: Use snprintf() instead of sprintf()

 drivers/spi/spi-omap2-mcspi.c | 6 ++++--
 drivers/spi/spi-s3c64xx.c     | 3 ++-
 drivers/spi/spi-tle62x0.c     | 6 +++---
 3 files changed, 9 insertions(+), 6 deletions(-)

-- 
2.56.0

