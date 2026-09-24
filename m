Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438F43AD50F
	for <linux-spi@vger.kernel.org>; Thu, 24 Sep 2026 11:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790249020; cv=none; b=W5Njmzu46yRd1njKPa3UacyemcBHsAUWbSfRTDbuqnG9+s/DOL8wskG4xyzO/IRwh/42uM3glOIapqL5vXGl7d/Aj5xsPT49Vxfp8NvNCn91qv78cImTFBeMYeZhjyyd27noAkGE5TyGDXiyQqFVbQU0YaEZMDq31hqZlovjAL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790249020; c=relaxed/simple;
	bh=V0m//0BePu9K8bXVScZ93KCgFEBxnZwn/T+75hu0Jt0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ofZG9819IoDuKgJEjEkK+aN131ivAjcmLdlGWhTecoNiNELr0NiGh7NHguMBuQORARlQDRdIVNp+M88G3+3gyeyk6Qngc0pKdZkkgdGC7K3sDtZmEUwFJxvN/X0gVRvP0U2O4luBSanPMcfBI6H6hqIzkF3R7EGTxkX8A0+XnF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bysWuup5; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bysWuup5"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396cccbba91so989510a91.1
        for <linux-spi@vger.kernel.org>; Thu, 24 Sep 2026 04:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790249018; x=1790853818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dvO1Qkk2Cc/fKI8T9OqiFoCZ+Xfk2+7b9EWzAp6ijiU=;
        b=bysWuup50ZJGsRSsOEtn+MUSMQiVtyvrw3Z1vr7XttRdF4plkeH9jdbYT+joqxysb2
         dn0+7OrMORhjn+Qeu+3Cqcoby7Dv7qoBvTTcvpNlQbk701gEnfV8CpaG4S8Lm9jTTiqg
         dHS+WeTyGuMFGhwhZ7DHbgANcNCmT80+zcBZS/SwxOyXoR6e7jSTvSKUph7hj/UMBt58
         e0154RdmeFlsitEYsVVX6bRBbt6SdUWwZNtAQX+DNXhuqT1XGXGsdIym5DFcCh4SJYKq
         meffWabtUs6nIXbkPNtm8OLiIBU/W98CvUWprstW5/DxGZcwaLHkin6O5kIQPNOjd5lK
         a1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790249018; x=1790853818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dvO1Qkk2Cc/fKI8T9OqiFoCZ+Xfk2+7b9EWzAp6ijiU=;
        b=hkSUjlOrCcn/LbC6UDi971MACRUUrKpRqNhwqXGokXxNW7w3l9HtopEQSjC9IIXrAq
         XV+MfyLIP6QOrVkBKX1mdwliHRcNVLxynq4+G3BcKH1zWsRqiV2PyuYP8FdaK69Ql9li
         XPA+DnjSzStHBkeYwet/nf5p1eppptH/odpJlZLIWU/GPMgP5OUhffCNPWx5i92Giwmz
         bpgL1LvmWZ1DrBjms89cXbpJGhJz8R/8z2WoRFqHcME3xlJJxm0nGAJbu1bREGCxUJI7
         E98ocUB3alalpUbIxj+zcfEeka+OyA2uJOzZBD4ipLnPl9/AqI3x0XIB69AIDcM1t8Y0
         olgw==
X-Gm-Message-State: AFuF++mDm/OdGND11rfkm7Svhbsw3B2Qqd1UxKrvpxrTrBaXIjoxCuSw
	9A7J05qL3hxgQJMkvZzrqo6+p5i0LL6nsitrJkIzo1OYz1AbHtk9X7/3
X-Gm-Gg: AYBFou1C90nI3IQ1gtP8VSBpZvxlPQAFQWMGUQGkwkJrHexoHTN8T8aYv5rPJ3cVuiS
	i0QmX3ArrUvOgdMf/RlkcPOsFzYafobxCRSu7p/VgfjJ6ugL19qlmrO937snFW9djMu+GoOoUlh
	IJ0S4TbL3wyzT9Y02C9U6NIO+CLUjpIUK4+fXAKu+EDC6+yAI2JnJ8MQSUESAJYOYITpxMfClIS
	P7kDSA4VOx0alTjk+YLbIgHnFpV25B9wsQIv8j4lwrkkrRzZM8+JJbTWfg0G/hKdXpJIgUba7BX
	nawyMTrrDMQg7f5FiaI6dsxfJqZJSOsc2FOnVhj3AZdk30wq4w0VrNLbDFDh9GtyIjNkLMXe0hB
	K+ZZ5yKgnY88nvKxS5YN1rfS+DrUDSm69BcnOeDl0AJSh4kxC2oEKIbWBzPqOrBKSc05g1IhU1r
	FjeYcIh1tE5siUMvc0NX9sou+qRjmeIcx9OyEAjFtkiuektLVdrKgOwPpcFOZ2vIjZ
X-Received: by 2002:a17:90b:524c:b0:39e:1310:cb36 with SMTP id 98e67ed59e1d1-3a0985bce17mr1718584a91.20.1790249018445;
        Thu, 24 Sep 2026 04:23:38 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0813318c1sm3586800a91.4.2026.09.24.04.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 04:23:37 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: broonie@kernel.org,
	heiko@sntech.de,
	william.zhang@broadcom.com,
	kursad.oney@broadcom.com,
	jonas.gorski@gmail.com
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linusw@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	jon.lin@rock-chips.com,
	bcm-kernel-feedback-list@broadcom.com,
	noltari@gmail.com,
	lgs201920130244@gmail.com
Subject: [PATCH 0/3] spi: balance remove-path teardown in three drivers
Date: Thu, 24 Sep 2026 19:23:26 +0800
Message-ID: <20260924112329.1566051-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several SPI drivers establish resources or runtime-PM state during probe
but do not perform the matching teardown after successful removal.

Add the missing unmap or runtime-PM cleanup in each driver's remove path,
following the cleanup already used by its probe error paths.

Guangshuo Li (3):
  spi: fsl: unmap immr_spi_cs on remove
  spi: rockchip-sfc: Clean up runtime PM on remove
  spi: bcm63xx-hsspi: Disable runtime PM on remove

 drivers/spi/spi-bcm63xx-hsspi.c | 1 +
 drivers/spi/spi-fsl-spi.c       | 8 ++++++++
 drivers/spi/spi-rockchip-sfc.c  | 6 ++++++
 3 files changed, 15 insertions(+)


base-commit: f03c39de3a1307371a4032757cd1732e91087c7d
-- 
2.43.0

