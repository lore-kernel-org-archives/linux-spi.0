Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253276;
	b=PPl9+CqBU6FrISpxbBUI7yF/1FHxuUfr7svP2ld3UOJcV0QMochKhonI/hk0Il4yfGcR
	 V2orJevtVzVKCaui8qFXJdS9st/wXYfJZIkGA9k/bLl13b2kLz0iCDrOGkdbllBUjFlZi
	 03qQ+107lK/r5PnpF69VY/ZWZHsapnEJxgYVwLh//2xoXxmwvdO4WqLO1tAgSr1a/baCj
	 Vwj/XD5vY7MdatSEsa45G4rsmVHnlzUmbxdCiA774otJn+RTTM6MiIBYUwcJe6nNPa1Kx
	 YLV8dmtJDK1BlEBGLY0D13rnUKQE8ubi1mPuzyqeFq3TIBlKIMioMTRoKM/QZdWdHbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=yQjiec7Yk01SvEkjgAhJ90ZgzbE++iwGitcjYLcR7rI=;
	b=TVKdwtpgcRwPSnBIrZ196BwYzb0+hVG0W0sHRalVfjKGfz7OIdNIcXNjailSKD1wYTo8
	 U6S5G1Di8q7Ib5CSUYxiHQo3uaFBhnOvXrfqT8RMoWxuCfW+f2nEnNm30RgN+uFYsKW0W
	 KZ2BRWDc0KFOKZ9wdVy1vc6SZBjWjK5gfMl77oZm0iEVX399Yg57wpZDkaxxipDMxrPgy
	 be7Ec5abX4UFAd4NTAiOdr+vns8XeJhxXz1iWi2C66fmlUMiNlNdSnsJqFoLOj4WFXkns
	 1pX7udchZ0AA6/CReGAMFadcgDfZFkl4s9TxJZdhsEAD1pqjklYTxhzSQI3rmm51fRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CHx9cHMo;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79537606A334
	for <linux-spi@vger.kernel.org>; Mon,  9 Nov 2026 19:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79537606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CHx9cHMo
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-492f563d1c6so479172f8f.3
        for <linux-spi@vger.kernel.org>; Mon, 09 Nov 2026 11:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794253275; x=1794858075; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yQjiec7Yk01SvEkjgAhJ90ZgzbE++iwGitcjYLcR7rI=;
        b=CHx9cHMomXbnCsSj+UiJItapWX9vFnpCT1p0VMVK/bL5PS5GdudbBpqgkUKbhsareI
         xHwFmjvmsbybfdHgC0kfR4/aHdnaQjQraU4c2tYmw16cpgHP7ClBCvK4Bir1d4wlx1d9
         ewrb/Psj2DyOaQPWCTN47ZoAEClJzvOpfEAAH1vV+BlA/Ww20f9nFUiyzGREjd7lDCTw
         10DlTEMQT/SLqPaLCqgemQmhzsiXeMjaXQwo6r53KTVfDq3gFtUT76OEaWAJ2rSbK5yd
         OUyaaEW5TVkUuE3BC+lroKggd9h9e6+b4GXhcTbnJyBUd09CXNlu2E2AYA2Rv6sQQY75
         IHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253275; x=1794858075;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yQjiec7Yk01SvEkjgAhJ90ZgzbE++iwGitcjYLcR7rI=;
        b=CyJ/dkHytpoq+4/h+wN/NI7hdBhR4iwRnBkY49YXuaI3elNdOiDWdhss+Ywlt4eByE
         h4egkrztiejeI4Ft9AcuAxvAYXKYkE5EMEeR0Cjnv/k49BjelTQVFkcqQwGYwLrRzhQl
         tDDDBak/Vw9gAUwGVkKdq3U+r+X7LiNuVkmhERBwgSuuQNZ4Hybng93bP2M+H1Fz2mVI
         xHkPoZ/C3hRS2I4bYQRRQOGZkMhLy2+lXc3SuflgYOkvRYdi3W+tpX1vJT1OOpIpYw5p
         5sEpVraeEz4ehslOMshTFudUXnGwEM4jtJNjORM6ihbd8sL3Lh5LzaaOOJgyBA8WxKot
         kVkg==
X-Forwarded-Encrypted: i=1; AL+hErHSBZRvN7T+dKtk9PCzPEuCRTKH1cYSkRVJSRLQfsFYi6X4MfoODW0JT+SBhtDjVZw5Oe2h/Q6KwmQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9k1xOtQdNeY/Nur+d5TtTRa4R13psxzlRspmRyZXZypBwWdNb6
	zRjWk7qq9dYmHhdD8LMgQizraMp0G7fIbUo4C5uey7Avc5cVe4hTwTFj
X-Gm-Gg: AYBFou1Jp4c5eg/Z4+f8rv/5bnpsQYE+wdX4HLDlJ7Vv9Q8EpB9Rze+ZwzPNncgN6l4
	UTL/axV4jZr12GjmoxomJZRGG9wKx1LUSrbi0ceeOFhKDY3IpO8BK0+fb1+Y1xZIgFm0KmfuoOX
	AxcvRR4Jydosht4I7hSMTpYJZFGW85CvK8jko8KYJAs88sambaBXOkg+w62Sj7IUHPIjvg8OCyK
	nqyEj94+DFBTa+ta2je7Tap5lgtprPl4EbsnXSYLX1z41qdHPPFs9lgdkD2HxMMYOeia3qTOgzj
	1oqJyjksw9/KVI8Ql88t0NP7rYqtxV8ddwj7xSha2ekLnxRobbp/EBlPWwMJ7meMTSg1szQMlWx
	jYLrn/FvUlWTqce1n+IaXvXk3toVAN7EvEkFrqBSLYcn3qNVgeRGflzn6rZBC6G9kXfFseVnari
	grXrOb4tdviP+R4+qoc6bd5YujgsO9/2FaWSVE4nsBQ+BQ/x0ky9LqVJloHRm16AqBEHPlW9Ctw
	1qmNf5+Ns7AR0XpurqR+oC+PoJW9uG+0KLcU4QWBcBo+HMeQvjfOYatU+kotI7oBOKad/Kim4Ud
	Pozkdqecoy0oFrECDx4JUOY78pNn2CGOyr1jJRM7xvxYefrjkU+RnOchvsQBK/Ok8m96+7pTIQl
	m3MU=
X-Received: by 2002:a5d:588a:0:b0:48c:4442:54e with SMTP id ffacd0b85a97d-4982f87455dmr967797f8f.30.1794253274651;
        Mon, 09 Nov 2026 11:41:14 -0800 (PST)
Received: from [192.168.0.253] (5403F394.catv.pool.telekom.hu. [84.3.243.148])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49836b8eb11sm714822f8f.57.2026.11.09.11.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 11:41:14 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Subject: [PATCH 0/7] spi: spi-qpic-snand: use generic code from the
 'qpic_common' module
Date: Mon, 09 Nov 2026 20:41:01 +0100
Message-Id: <20261109-qpic-snand-use-common-functions-v1-0-1e8601e2db84@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/03O0WrDMAwF0F8Jfp7Ach03ya+UPsiK3Blap7GTd
 lDy73PWwfZ4BfcevVSRHKWooXmpLI9Y4pRqwI9G8Seli0Aca1ZGG4fadDDfI0NJlEZYiwBPt9u
 UIKyJl1otgMZjF/hIKK2qK/csIX79CKfzO2eZ1wot7+OfMzS7ontj/iu1DSWmy1X4CVlovE4Mb
 LnrvT24PrTDw+yQp9934jI0lrpAJNQfWy/YsncH56xjPVp2ISAbRO2J1HnbvgFuQHtHBAEAAA=
 =
X-Change-ID: 20261028-qpic-snand-use-common-functions-12b18fc7a1e5
To: Mark Brown <broonie@kernel.org>
Cc: Md Sadre Alam <md.alam@oss.qualcomm.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.3

Since commit cfae2182fa7b ("mtd: rawnand: qcom: move common code to the
'qpic_common' module"), the 'qpic_common' module provides several generic
functions which can be utilized from the 'spi-qpic-snand' driver instead
of the locally implemented code.

This series converts the driver to use the common code to reduce code
duplication.

In order to make review easier, there are separate patches for each
functions and another one for reusing the 'qcom_nandc_read_stats'
structure.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Gabor Juhos (7):
      spi: spi-qpic-snand: use the common qcom_nandc_check_flash_errors() function
      spi: spi-qpic-snand: use the common qcom_nandc_config_page_read() function
      spi: spi-qpic-snand: use the common qcom_nandc_config_page_write() function
      spi: spi-qpic-snand: use the common qcom_nandc_config_cw_write() function
      spi: spi-qpic-snand: use the common qcom_nandc_set_read_loc_first() function
      spi: spi-qpic-snand: use the common qcom_nandc_set_read_loc_last() function
      spi: spi-qpic-snand: use the common 'qcom_nandc_read_stats' structure

 drivers/spi/spi-qpic-snand.c | 137 ++++++++-----------------------------------
 1 file changed, 24 insertions(+), 113 deletions(-)
---
base-commit: 4a8faaea975be15cb636646c0d4c6ff1c2110baa
change-id: 20261028-qpic-snand-use-common-functions-12b18fc7a1e5
prerequisite-change-id: 20260922-qpic-snand-fix-singlecw-readloc-c4c89b4369f5:v2
prerequisite-patch-id: 7f8a48bccb2e3c8de950bbddacfefe052cea50b8

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>

