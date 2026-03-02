Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662111D5151
	for <linux-spi@vger.kernel.org>; Mon,  2 Mar 2026 22:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772490025; cv=none; b=cqWGtnMCm/R9trleSPuMFCGs1o5ddClyu8V2Sae/bjQmKeHs56+sF6/KLZeJ71IAW8Targ04ueFmmPK78ndyJ96noSoiom7rjMNyAKtKA+pFCwKEzJcOvzrjf7Oe/0rvnPw6U9E4IMYM9T7VEQ3GlbFR4fyquvG8FJYIHnfayUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772490025; c=relaxed/simple;
	bh=XIxfit6rbhonFvJPR6uOtO72ELL6XkclAFBu49S3xh0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VvimDUqqvrDjIdrP3nS3ybFPcqt2N8ElIur5zVWLxuG38GdBVjh0MRbNaARfipprumVZ3GwJXpgUxbkjs6LLCDyZIt1TMvwrswwZhU+mUjpihhLai8DdMkp3APhwaRC7eLaj2tvOvUKOmuF15WmUFSGihbfgVGYlsyWJlR9i2FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMKRMi+t; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMKRMi+t"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-38709888abeso14335391fa.1
        for <linux-spi@vger.kernel.org>; Mon, 02 Mar 2026 14:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772490022; x=1773094822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b1Ew/KZz3dD4ffWl1ZDrTnr+YNlh57E6b1K8QfwwXEI=;
        b=aMKRMi+tA12TcXGKzhVnhZUFodcfiC4dBAU0XeieaZ/o+/6IgUrHQUcUgKovAl7yv1
         4HRxaOFw4Q/2ZdDgTlNSo5WVJqWdPF66cyEoH9huxT09MKcxrXwKazozpt6YQ++kZACH
         vHhKIgl206O/f/dKTv7X8awBwjPi24YbJi1Q1LtDXgrtPOVWfcTURexWSBkUbA0cV0ML
         wRzHZ8rnlm7jUwaf1GrzqERkyeZC9i+el6pg/2NxxL/hGIaveeSd5Rpunc20cSROwg+A
         y5Hr5CJyMuyz7JCGCFwSBHClK+8zErnFxp+kZnjd4iwX57RA0fL216lDfarr5hCVEAUo
         gMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772490022; x=1773094822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1Ew/KZz3dD4ffWl1ZDrTnr+YNlh57E6b1K8QfwwXEI=;
        b=OS/nKbRtS2Y6hhmEn9mgb8T3Az6BmfmBHTXhCemrrZ+OMYe41lBCzuNcbnUE+Q+Fgz
         LhtCdl81iNDgfqjNX7rbZ9DJ/yv8WSfRxx4lE6j2O+ZYS+RHKGjHFRxnCVlnRR/Uly8g
         /t0RaYgDy24zScX1ExSnqIEsCj/SJ/EGVTAwcaUM8VqyETFciOLi/qlgDkanxqynqkSv
         p72JISBkVXMYLJy18RZB8rfKHQGYT6hvcKb+G97ICEb29tIE5+hoTZwXkJ6ncyK6SC6C
         EDS0WhGAY0IFzSsLjgggrEGLH8B5a0ECbliBrlayfpwdsKEZ1RwopvmP2Yv1E1NSedVg
         SAYA==
X-Forwarded-Encrypted: i=1; AJvYcCVCMVrKqqBoxCEQeTDUdsx+8UEw+0HqbkMkMUZFidmQVgQ2UvcfTDfI3zYuBmN0W1dg/ZBt4NLC9Og=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF1eNI13av36vQlkhAbNamGEyg5S4ZVk1mCnecrjam59GePAVP
	ANMk6WruHU8sVZVPs/dnRbCE1VX1Yy9DOmhgwfqFw8An4i5VBSHskZ7tDZOuAZnw
X-Gm-Gg: ATEYQzx1hbraxdBMOYVwD06XozyBRqRB7XEVBxlCHduaOCriVeFo+PVQoKKXbsZU7IH
	JuXo3LJpRZjtD1BAp6nnT0EGiKl3MjAhFxCim8aE2wVft8y8GI1aSgXt2ZY6Tqv1oMATrddEOfs
	oPhjABvSV4k6lNEu7JrxwGZJz+rRpr54cltrRCYoyZ5aRDtaOIiJlnFy2Cs6cXcG8Mh/ho5L433
	aV8SWLfTOV8JK/fKADLhHCrIYtTOKbl5Tg9YKN/NJBjpS8HtfocJTKoGVIjCbLDaXPQoHOPJitT
	uI8Td+6GjS0/TijdboIIt1DBcPV6lqLP3vl6IK8QWYivCHKe0fEPr/EfjyLaKT9RfwW3NPzrFyL
	Nt1lVIQj0n9PuQ7qdVOTYODmThcZyeWVOuIko4eQionFyWma6AD3PO8/2I57qu5vRqWGMxbikhd
	JdtAASxWkSYtoIxuh5gfjKWlr1WWWJOyshs6tr2V/fig==
X-Received: by 2002:a2e:80cf:0:b0:37b:aaf7:f022 with SMTP id 38308e7fff4ca-389ff3644bemr77407621fa.35.1772490022201;
        Mon, 02 Mar 2026 14:20:22 -0800 (PST)
Received: from vovchkir.localdomain ([95.161.223.42])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-5a12356ff20sm159739e87.78.2026.03.02.14.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 14:20:21 -0800 (PST)
From: Vladimir Yakovlev <vovchkir@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Vladimir Yakovlev <vovchkir@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] spi: spi-dw-dma: fix print error log when wait finish transaction
Date: Tue,  3 Mar 2026 01:20:16 +0300
Message-Id: <20260302222017.992228-1-vovchkir@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello!

This patch fixes a system crash if there is no current message
for a transaction.

Changes in v2:
- Sorry for the inattention. The variable in the dw_spi structure,
- which has the struct spi_controller type, was renamed from host to ctlr
- starting with version 6.19.

Thanks

Vladimir Yakovlev (1):
  spi: spi-dw-dma: fix print error log when wait finish transaction

 drivers/spi/spi-dw-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.34.1

