Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9687F3537C2
	for <linux-spi@vger.kernel.org>; Sat, 28 Mar 2026 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774714033; cv=none; b=oH2L4kUwrjeEFwViEJ8g6VXWq5+NIQZHrGu/kR0JLtGZDZBdvqgpdwZUcrkRetzXIGGKZnqy1m/Trfzs9y4hjk4pkshA9G0idN5Xo+kWiajPZlWDfrN9stweewdYBTTMDItLGZLfzn5Ndd7jJv0PKPiMJezCBV0QJ8uHv3lC59w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774714033; c=relaxed/simple;
	bh=Bp6FqcuqvbNaOb4ln+t0fQhjjxmyiJc3wIxmGVnK+W0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E0K5i1+L3ceK81EnQiBuBNFrrNSFsuRQojM2/c/qyhRBk84ZolszMtayp5FL5b821iny33G0U3eRwyvbmr0Q0xogIFEMC+DAb2DLoFUgPD+Zn/B6TcG/J6x/67RLH8Y7kHqu1ZrLNg87ThK7MOKqHqTU//XJyuQkgcheBLnDNvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q5xcfMki; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5xcfMki"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so2039246a91.0
        for <linux-spi@vger.kernel.org>; Sat, 28 Mar 2026 09:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774714030; x=1775318830; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mh8F9k4/dinkDW3+fSJ68XGmJrivibpzhc6HbsO47Hg=;
        b=q5xcfMkipi+Z6BDowH9RSnSjVshZZwVoDhEyIq3Unnt3MHKSwRfcz6LwOATEzW6Di+
         DxXoyLfLtlpxLqJqg3o1T+zywTcojnIAlugnCXdNHBZTR9u+gtzWEjGj2hfHuBeM8Hfm
         3AE7aoyl+kqYFvapeJZFF4PkY5ikSEay6DBSx+sJTYr0+bnBlM/L9bshjDQAzFuHEwM9
         RfzOJTB8FkaKdlcUeQWv0EF2GmBnq1gNeKrFuehRJrNFVaiUSTlOKMzCEB4QplYnUus1
         Nc151ttUdSW2ljTJ9HCPvMumqzw2UCAALr1/HV6bj1JLexy6vGvo13oirCChlNaLQlwD
         gqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774714030; x=1775318830;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mh8F9k4/dinkDW3+fSJ68XGmJrivibpzhc6HbsO47Hg=;
        b=RcpeA5LODhbQg07PSu9++YvaZ5Tc1cfq9+HBtLhROEukCjjSo91CstX3311WrNpImr
         Zz4r/5aJYVCWGwgfLzCxWMFlj2MyHqnKGooGNJq1TOjncF62SB4vhuBX+4uMT3BsR0so
         cHzJU8vQ1k03f5tKjbc4uJVV9At2ZI74x1dyyuX3Wx7pIUXZkRwDajviIbFIPRFC+/el
         zY+KFGq8YdhIYzMZmMWUS+K6pWFvHrpTXuYaois+xkpONlCG+++XdD6Ifj6ORgl1YV1l
         tJvwh+VO8xQ06nCxjLTrQJP5EY9R2K4syu40fj9UjZtpctf2zaZVsdkVNDwDf/TwcgPw
         n5FQ==
X-Gm-Message-State: AOJu0YzZdZZzzu1Po4EXr0bgUp5GxUW+OIdvgHavXwLKYuMIdLCtrCRN
	k0iV1PXPlWpak3JojBP4uPyEBYKT9rS00nygQiaX6lDxiGbe3XL0AdIK
X-Gm-Gg: ATEYQzzs+4z7qHEF/JZpL+7KpSP85ku8yTsxddiG5W9VT0VwHceEMry59EnLbRW9jzs
	iSWQYEDnL8n26o2jOoMOUwRf2ug5ELQKQYuXRJvYhFHgPWU9NolI9rqRW7DnvGmsFiYoMUDVDcS
	n7+cqTUF5SV2XsHb+FmKr2ALm4AWVbqPHQJzm54/42utr7nPQOkgQyBtrQsBGiMhjItB2PIfCBO
	XWrBJbJVtzGmGIT/82IvkPUPk+QjNLVUN/Mu4zwnpljn0xOWPDmXksFElu5PNFqNsgA/V1HFJPw
	eT13P9ckGNC0AlbsnNaYk2aitPYtW5LYZetlGKJCZyhirTuIy54CEvd8cYy9xiuTqItQKp9zFMO
	54V9urhvQTEbXrTAtOEmQBRkhd4stM3CzgH9vCtF3FpJ50Dsd0hivRYRyLsgvR5PcrmhpB7TVX/
	+DCxAglSi7P8TB9CtmTvZUgj0TkJ9jFEX0Vo1I
X-Received: by 2002:a17:90b:4b4c:b0:35b:e591:99d1 with SMTP id 98e67ed59e1d1-35c30115bf8mr5974559a91.29.1774714030368;
        Sat, 28 Mar 2026 09:07:10 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c2ec27da0sm1988140a91.8.2026.03.28.09.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 09:07:09 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Subject: [PATCH 0/2] spi: stm32-ospi: two fixes
Date: Sun, 29 Mar 2026 00:07:05 +0800
Message-Id: <20260329-stm32-ospi-v1-0-142122466412@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKn8x2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYyML3eKSXGMj3fzigkxdsxSj5EQDC2Pj1CQzJaCGgqLUtMwKsGHRsbW
 1AKuhUnpcAAAA
X-Change-ID: 20260328-stm32-ospi-6d2ca0833eb6
To: Mark Brown <broonie@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774714028; l=458;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=Bp6FqcuqvbNaOb4ln+t0fQhjjxmyiJc3wIxmGVnK+W0=;
 b=6Gs+lZTSrrDeaFeCljm1jglrdrUxEIJ+DaahhE1qGO2T/H/LZu0YUfCncOMvDLG4FCni1kwVH
 aHSXyDFyhHnD9e87xgGgrciIUZGsIMgG6dWSAeKw6Bxt4Dm5lQY06am
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
Felix Gu (2):
      spi: stm32-ospi: Fix reset control leak on probe error
      spi: stm32-ospi: Fix DMA channel leak on stm32_ospi_dma_setup() failure

 drivers/spi/spi-stm32-ospi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)
---
base-commit: 3b058d1aeeeff27a7289529c4944291613b364e9
change-id: 20260328-stm32-ospi-6d2ca0833eb6

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

