Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD39A4718F3
	for <linux-spi@vger.kernel.org>; Thu, 10 Sep 2026 21:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789076622; cv=pass; b=Z90d0aCb+V05Esx2wDtYiN2FS3h2HwUFVBUqpYfCenh22Nzou7H4Gz2SQLxudVRid80H8f87FtmOt/sJv0W3qgMRUdgVt/3Z/KaGjV3H5roUaDVhj+kqKYv3aXW9P3i78nL/GtM+HGFRvMnb2pMnlP3e+BOE50T444+rxr1Q6eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789076622; c=relaxed/simple;
	bh=K+M1hRC3J1lPZHVkwlbZglylwWv5qUa1oz6hH/E7ZNU=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=WnaQZ6GVz7Ga0zLHS8ynKc6gMISIISlUCxmDB4GKiNPXJSBV0ZPFKHUKko8C3igt2iTMPLOhW7vtnvF8Xs5WxZzMxgjD3xv/IS8MoTEwssoy7kXqcXit9WSVovoUGbrpNocWhtr9E8jZbAzgJJls+LiYPkjEpri27ZeYEGoTXSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=AK5sON+n; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="AK5sON+n"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d9520b9155so1772045ad.3
        for <linux-spi@vger.kernel.org>; Thu, 10 Sep 2026 14:43:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789076620; cv=none;
        d=google.com; s=arc-20260327;
        b=W3bU0MGugg3TDvDXEWLrSDGQLOQKsHLZmRoaP6UkAdbTvIc9EfRUTvR5rwvPzOy4fk
         dnSDkNKc2gDAC7P/16byQ9K3XEgCY1ri3WiDqcf/RVU3bdhUS8GOsF/yu9AvZUyiTSr9
         ez0FbgD54kd83HnLAgCQ0PmhFubV7XMuz9y+bUtMtZ70Zfq56kJwNnYBzJFwM3AilxOC
         lK2pB8MxA7PuWMeLUJcxmJRcEvouONjhjkXPoOQ5o+DCVQPVjj4gd5sCyiKoZl/iqexq
         SyR1s25Rq3cJ5S5k9hPPJQiJfRjnyatPcuiSK+Iu1gYg6ZfVjqvuys+KYEcxY8fftOZw
         kHJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=3ni5Or1iizW0Oi2Q/TkK3TNnNcK6Qg+mAIz5hPJ11Q8=;
        fh=VSQGERI0jjwNmQja2UIRbefdl76ZV47guo3lwS+Ymho=;
        b=NWASv1cmHyE9247Ub3oYEFbAKer1H7zcEE9o8xtKGrs2MiZVAAViBF0MMuUAR4Y2zP
         RhGp4d3Sw1+rjoA6rxG9CS7/10kxdP5ehQFhuk4Ua/M/mkvpraM8LYuNdDGHsuYqsZkG
         iahxE+0C/cpUmldk9EuMZcSq142dWJCI58WYADm6uKUWnBavvHF01eNFx7hq1j6ZKdp0
         pVQGX0CfUtDRscfdxOLO0J0f5Nq77OoJhCVL70F/+Nl5KepwIb7PTHkz6FVXZ+ABUpGw
         JjKx+sSJrnZKKcBP0DCUshKPPAuN16k8vlo/MaJ4vJEcqVTBizKTMWxOS39AywOai6zG
         071Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1789076620; x=1789681420; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3ni5Or1iizW0Oi2Q/TkK3TNnNcK6Qg+mAIz5hPJ11Q8=;
        b=AK5sON+njgSc5wcqjmSsmaUWKGg/uAstOFTNUh/RSnHI8SVH63uyIXRWrRrGBrl87s
         ffUFhRZ8adL1cnF+p0ATOtOnOwWqWpL+rR956sVEbt/ordhNpq+esL3vXGMqmqzbPyj1
         S/w2YCYrMIZha+AI5/XoSovJxfBmfI4Jsc2qQnv0CG0Rhj4aeDnVzasrGJa64tgW9Ge6
         lejmGiEtOu3e6eSDIBvXUoMbBUsO+npFNgPD2CzGRoWujy/vLygBq9pEseUl6ay7aUyt
         jzmuBlYPQbw/VuXiRXb1w47gDLVS17i2ALG12MkTCvTlaR9ZEtin6dQNyh+le0F+rX6j
         AtIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789076620; x=1789681420;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3ni5Or1iizW0Oi2Q/TkK3TNnNcK6Qg+mAIz5hPJ11Q8=;
        b=s5iq0ET79eoAbN0RIODydcwWDipwA59TWf+UXaLZlBQbVnIIeM1exxu7lf7PDbCpUK
         w4lBwY8fLCaLWRqMFUUZXuw7AWxKMiVJnhIofHg1jRrVufUkAxF/DjAxt/WyFXXixaqn
         7l/2UN/9cLAv1ZCzuTo6e6U77gFh5MU9k/Ae664rlWv4eTdeCJBXTKxCuYRmGHDYM+HI
         aU7toGAFz9W5f32MW/T2L2j7r1ELXgoTjnqb1KSBCtV1POSmSW+Lg4Vh6eZAyypbGiVW
         J/xCWcCpEfPZ9Qk2BG3Ogjen+HuTJrpoQluA1qlA60CbbsHVaZ/zvDxWahKufb2AR79H
         7ekw==
X-Forwarded-Encrypted: i=1; AKwUvBxYXZp/wXlBzbjB3UzR44oPEJhduoccaNhKw5LXgkBhjWAc070+ReMYOfuAjl85HUhsi5f7K/GwFmg=@vger.kernel.org
X-Gm-Message-State: AFuF++knsFo35e1X3ExAD5Qjxv+9Bumj2x13Ia+9qIt/eICZc++KswX/
	XsuZsfFurbzjRDGLx04l/AO7AnvFWvj2DcULVFRKCk4r7192CdJLvDVdwbUZmlOoDGBqAF/05cj
	Ogv5EKvqyCrC1Bj8PrSWE301OFWRSQjMrZ866nzg9
X-Gm-Gg: AYBFou0/ELrl63ZASHArBWqFKHCaHYAUKJB8a3rzeAqHrSfgLtuQrpyMrcMJkhhT/nS
	+FGl1RiNjPJWgFV8/AJe3NolNNBAgTIt8P5o1sCfnaWpMynHxEkPLypATWGk9thYKBKC9SV3AxT
	OHkUN8zgPzBnJFeTxd0EOYQqWFjzO9k7OYlH9Ll/SIUkOhT8EeBwvGT5ZDTP0AlQuns1N2i0D7Q
	plDt8yifvI/LioIJFkDJsp1Yp7L+tMM4dLVUNJqQ+tJMAldD7PVV1huv05JO/lS2e3k2omYImTq
	VTLYFvvq4B8L1xVf0ccYl3HdS8m0giuwxYSy+nEZMO1N9W655ULcplbL0PkDaOu4Hhm0vGvevzi
	KTsYnmkYFcdk/5YTZqEM2PG2fwYzmuBAbqdEFwl95Caw=
X-Received: by 2002:a17:903:4b4b:b0:2d0:cc92:f7ae with SMTP id
 d9443c01a7336-2dd2a1c425fmr23721295ad.3.1789076619207; Thu, 10 Sep 2026
 14:43:39 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 21:43:38 +0000
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 21:43:38 +0000
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Sep 2026 21:43:38 +0000
X-Gm-Features: AcwNN1W35qNEJEtjTaS5E6l35yvlHx_w4ZWX3F9ageKJTtnwfUEo-YSxtu_pIPk
Message-ID: <CA+0ovCivEREvoy=Z-D5TSddgTfFknhFrCBPON3a7QD2Kne=MTA@mail.gmail.com>
Subject: [PATCH] spi: dln2: validate chip select count reported by the device
To: Mark Brown <broonie@kernel.org>
Cc: falemi@asu.edu, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

dln2_spi_get_cs_num() stores the chip select count reported by the device
straight into host->num_chipselect, and dln2_spi_cs_enable_all() then
evaluates GENMASK(num_chipselect - 1, 0), whose shift exponent is out of
bounds whenever that count is zero or larger than BITS_PER_LONG. The
resulting mask is handed back to the device in a u8 field, so any count
outside 1..8 is invalid regardless. Reject such counts with -EPROTO in
dln2_spi_get_cs_num(), where the value is first read.

Closes: https://lore.kernel.org/all/CA+0ovCioY634b646jDcs2cFmg_1q2UMN4wuTQ1V26Gy+Dm_c+A@mail.gmail.com/
Signed-off-by: Farhad Alemi <farhad.alemi@berkeley.edu>
---
The device was emulated.

--- a/drivers/spi/spi-dln2.c
+++ b/drivers/spi/spi-dln2.c
@@ -71,6 +71,8 @@
 #define DLN2_SPI_GET_MAX_DELAY_BETWEEN_FRAMES	DLN2_SPI_CMD(0x4C)

 #define DLN2_SPI_MAX_XFER_SIZE			256
+/* The CS bitmask is carried in a u8 on the wire, so 8 lines is the ceiling. */
+#define DLN2_SPI_MAX_CS				8
 #define DLN2_SPI_BUF_SIZE			(DLN2_SPI_MAX_XFER_SIZE + 16)
 #define DLN2_SPI_ATTR_LEAVE_SS_LOW		BIT(0)
 #define DLN2_TRANSFERS_WAIT_COMPLETE		1
@@ -201,6 +203,8 @@ static int dln2_spi_get_cs_num(struct dln2_spi
*dln2, u16 *cs_num)
 		return -EPROTO;

 	*cs_num = le16_to_cpu(rx.cs_count);
+	if (*cs_num == 0 || *cs_num > DLN2_SPI_MAX_CS)
+		return -EPROTO;

 	dev_dbg(&dln2->pdev->dev, "cs_num = %d\n", *cs_num);
