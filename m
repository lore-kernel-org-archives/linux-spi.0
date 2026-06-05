Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153ED7404E
	for <linux-spi@vger.kernel.org>; Fri,  5 Jun 2026 04:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780634617; cv=pass; b=WdyDYyNF6XGnUTArdgTZEdgCrW+2L7a1hhU6/t5YrDvBOSLiJcrhmxaUgrAzBza/BOavljRcflhSIIeAL5Fc4PRqvY1UPk7hlezsN33M+uBxsobFj2RPpAAejPcOHAGOidU1Sx6p2vpyWU7hgZ/S9nYlRo18Ny2+yZnqUonBP/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780634617; c=relaxed/simple;
	bh=MITCSCbNsWNHD/j8VEN+t/03GrVhR7EFR2ySYOfPBOY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=EWQc/xggMSDLZ8wW7mPY+1dQ8ScM+5wDAA4mYoTlq429MzMoUEDyBEPGgmf8/rRsXtQB77k7ABVP56NRc/FFHA86ddw7eqgpd0o5rc3n3xNuNuWsa18U6OTTu2kO3UeG+TMeIjfefVZ0lvLUbbQM8Y1NVUvCnbcJvyOHHvdNiuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1NZXkkx; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1NZXkkx"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c8589498839so666816a12.2
        for <linux-spi@vger.kernel.org>; Thu, 04 Jun 2026 21:43:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780634615; cv=none;
        d=google.com; s=arc-20240605;
        b=daZkLy2MBLxwNe9qTzBl4ZtgXajPnKbSvpQ5bnE5Xs1FmF+5CK/GcXqPiArVeiKJpF
         I2kD05rgacKrBKzGRdzmEBwHlkpFO6W7RLdtwcSZfXgZrZLahyFCXIhfSOhRTM3XbLhH
         KAu0upgo9ElvxsL4XJHxpZwSI42w10Tn89p1/oe0RkUhbDFZBr++qJf3CJPuVE8M/lRN
         Z21wIb0As+xWnMGg9ROwdCoFLcTT9d+7ePF4UY8/5bqToR8DUm5rWrpClyxlgUgVnQNf
         dgVxfInSNvGU2GYS58+Y306P0l0MxrppxQG/4kA9c0UOmgQpyj5z3oIGGmmdAA98HMv5
         p/eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=MITCSCbNsWNHD/j8VEN+t/03GrVhR7EFR2ySYOfPBOY=;
        fh=gqYqcIZeMv1L6oGDQwf+VUft9WvSOfT9VpwEjYSaevI=;
        b=hJFOVTvnKaOQwAOxLZXL5LFQTARyekpXFF5V5V3oU5YSB4rgtHiPcH8FOV3/pHV40Z
         8wLn7LPn5T9xA/nzd+TG8U5IMHNbQm+W4gWsPu1tovpzT0YSQLfAjzwtYmAyovKmnbC4
         hCgSN5afkN6WZdsaRozKozfykFTf03eqPxKbQQUzXwStnsFxVhkTSFUcZY0LOzb2W5wa
         8r7FXl016WSNWBZTSFQeYScL05iCSB9naWD4R0ZiVM3Ouy1FFyy3lJLOFLmnEwG7czGW
         0h3wilcfW9vzVfsSeiH5I7s3FDaRUVhdimbjG72QsJ/KVDLdsUign9q7HT0qU4yV41Ta
         /pjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780634615; x=1781239415; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MITCSCbNsWNHD/j8VEN+t/03GrVhR7EFR2ySYOfPBOY=;
        b=e1NZXkkxgAaWludQGs72sl2xinLo3s8bCFUkVM4M9gc7RcpfVGGmuGXTKuK2IlDM9b
         KdebaT791Re51C69jfaJ+m6W7mJ2HI9kYUL2tsRCROoO69K9gk7Ss2/iV2SmveLIb9tR
         GpZs5dsxqSrtQN5YTUQP2K0YKQfHID0Se/nqcn9uvaYRQZcEbAlbkT27RXg3rcPZe0kf
         qJJrWjPTioccWCE7AJO1v6i66XZmNhqkqhLZJRHmbi1w/+Q4UHuV7WNucut1YQyOu8JT
         DzEtY6Pd5MkM3S8UU9bI4Aoz2yYNaXoK9lLcec/dPhuKE3VMJUd4geTbFv/cLq4ZPLrG
         GdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780634615; x=1781239415;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MITCSCbNsWNHD/j8VEN+t/03GrVhR7EFR2ySYOfPBOY=;
        b=EMImYTta7zaAovdJ1s9Qia5EEwAu6Tuj27v1aFM+OcSe2zCt8otMhrP8a0FU2gr1FJ
         33mHIvhV2rh0dZWTuLgWdEH2evnaxNHV3opeVQcDTvn6FaTHl8ELgdluguD8/6ejDeMw
         mw4WFYarxDVY1zs2WboI4V14oaHYGrm8MsRS3HqafdDXC+5gIk18mjhbIt7sLl7/bCzK
         U4Ua+DOLP2NUpZhsWyw5nsB/gOL6CWNZcd6Eeiz904X1BmGv41sJkJuhwBmUd140VyKs
         Bo1aXJQj4TTd7pO8qv7BpsdF5XmIZXoCuSHQailzyJFPzjxGhjD5DOcDE9008r0LAawE
         S2zw==
X-Gm-Message-State: AOJu0YzfokPR35pxCEDgMA4ZliT+OeRdEFAdtwdkEEiX+IH4IiQ2BSKf
	nA3ggowm7w8gcRtb/BFUiEl16me09u8vBvKksOxzZFS8A1g8x1lqyN2ZiylINGIJq10EPZ+O3s4
	XGn2sjiqRSoub71Mip3s2VI8wtIbqLyVfg3s5q0U=
X-Gm-Gg: Acq92OH6/F7oOJPHCazSlmEMQop0R0qaKqBBNYtdi5xqCdnqa/S4Iti+jpZr0aEqFlg
	he4AwdtUKRAYylmq3bnE+BYxG1ocyrWijkfY4Zj075JGsnUJwhkj1yXFv0ChiVqOXsnGAOOsbfs
	42htUym22veO3+KCa9QNoUORFfpU0nqZh6jUI0uu2rvnVnfYWQgxb12+KYQex+nbI7+Jv976hPN
	Vsr1p6CDmqCtn6Xe/DLHajiHDIA2L9F3ak1ULHqwqQOcU3miNWvTyDFoNZttOWmzTg4jV7Emct9
	BxDukzaM97p1AEEh6ADqlBK9ljJceQWjC0Ad+XGl85IdTbqfHI6yAY4fo+Hl
X-Received: by 2002:a05:6a00:4098:b0:842:40f8:74d0 with SMTP id
 d2e1a72fcca58-842b0e2f5fcmr1823544b3a.6.1780634615345; Thu, 04 Jun 2026
 21:43:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Carter <carterd1016@gmail.com>
Date: Thu, 4 Jun 2026 23:43:24 -0500
X-Gm-Features: AVVi8CffcPSo8s9DT1ALeQJnF5y-62_ThH-wSB_n45JpRFZeqsCGrn9YkwXtWXE
Message-ID: <CAJ+nLsRXTc=3LagGVdNiAPttL38tPVub_UOKuqJq91J9U0M+9w@mail.gmail.com>
Subject: spi: geni-qcom: any planned QSPI support?
To: praveen.talari@oss.qualcomm.com, broonie@kernel.org, andi.shyti@kernel.org
Cc: linux-spi@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I hope I've found myself in the correct location; I haven't ever
officially participated in kernel shenanigans. I've been working on
enabling the trackpad on a Surface Laptop 7 (x1e80100, "romulus"). The
touchpad is an HID-over-SPI device (with a driver patched from
https://lore.kernel.org/all/20260402-send-upstream-v3-0-6091c458d357@chromium.org/)
hanging off a GENI QUP serial engine (spi19 / qup2_se3), but it
requires QSPI transfers - the SE reports protocol 9 which is unknown
to the mainline spi-geni-qcom driver.

I did find a patch for this driver online out of the linux-surface
community which may have even gotten it from another source. The patch
seems to work, however it is very low quality and I suspect it may
have been vibe-coded. I wanted to ask: is there any active or planned
work to add a QSPI mode to qcom,geni-spi controllers? I was unable to
personally find any related patches or conversations on lore, but I
may not have been searching in the right places.

If nothing exists, I'm happy to make an attempt myself. I worry about
getting in the way of more important matters as this would be my first
time submitting any patch work and I am bound to make mistakes, but I
will attempt it where that is welcome.

Thanks for any guidance,
Carter Davis
