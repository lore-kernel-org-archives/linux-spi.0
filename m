Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5914386555
	for <linux-spi@vger.kernel.org>; Sat, 25 Apr 2026 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777109425; cv=none; b=kHMEX+csyUOzJDmd149QbRgHgElF5G8rI1wTUvVVqvcZqUNKZI8JSTVFvxlyCOisqABhcgtj/ics7yqqMVRhfwCeATzXG5CTBKDmgZ+Nthbljs/vnzl0LUEzk5pp1Bqiu4/uvVeGEmlJ2fcLrlnR4lwNOdyjfzqICmY3hmec8qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777109425; c=relaxed/simple;
	bh=4VgUYG7Uz2/2gI+vnjHYuv9c1/SdEnYIyQwhnA4uOSg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZpgGa0JcEYlbNQvfgOMZlT3df9frJJV1NcdCg7R54vRpHNpWoE/itCD78F42sMZbkJWg8ne7xVLJlMVCY8EB5s+cYlCeTp/OI2FPCiwWeDgyeUKupJ8IrFtsJrujvfd23B5A5TZQLL6OJM2cHTxU8+4LUZOkAyoj/TaIYaBRGS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtBBi/jz; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtBBi/jz"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso56290915e9.1
        for <linux-spi@vger.kernel.org>; Sat, 25 Apr 2026 02:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777109422; x=1777714222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EI1lP6Fl/fJugk9EU1kz7AMxap4YeYzlUoYzl4zXJxs=;
        b=gtBBi/jznVyRh4fQSjwMgObNeF1h+lE+DJBp6n92CeKZ9GUEhL0k3WkhK+ydcAVUH9
         i+V6AFKhrt4DFunsCd+kThhCrcJf4V6nPOFo6JbBfO4HZuYa7RrqH3753mQO/sS55OFm
         31y2WL+/Vt5n5zsQaU9f8GQZ9z3KJzyKYeA4m74V4Co9WRVHo38RMbICVm/5J1W0FJP4
         rgoMpnSfZjueMi4xPOIeczNC7dZjVgRWUn4becBlAN+FiUCQASnvk89GE6OxvOhJ7BCz
         NdivzU7MRBNv0DaMkzFZbEjv4T3JJ5LUJE/RNYFdxX+inOB5/9wQg+KdBXlGZ/HksJZd
         3sjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777109422; x=1777714222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EI1lP6Fl/fJugk9EU1kz7AMxap4YeYzlUoYzl4zXJxs=;
        b=U4xZG0qISLSJM0Prg8fcglYaNLblDhJcyrIz0opgem67ocaDguoriTacnIH2U5fway
         KD3DQoURwWJtqKPx3/jXQZqWl4UiHaUwmJi/uDBqp28j7e4Khp4gkPvhb58hZQcGCmox
         taesEB4z1UK9baifdn3O7y+SZAtUBdqrcLv5pzwaBfnmQGyJKbklbi6cKyEdGLUVdtDw
         jFOE4/Sgo7RzIMZd2RipD2F3Y4RpbS9Y+Lmu9ej25xl5ZiJQRwybVbcQ/6nA3CGP2BWH
         +xZlXqa10gy3L98+Dgh4z7RCq75cZ4BPsaBSrC2kCvzcXES7nIFavzt3xHy6eFTOQgGi
         GkAA==
X-Forwarded-Encrypted: i=1; AFNElJ/7+yPWh+BhHsLlrFhNFpkPg06KOmm6kndgxXxkqdLX5GIvVdL3pBOUGsgOxBJ8wi121rQ8IqL07FQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJdr9zvcIN/2IVMgZV5HNsl1OyG9Y5AfFiDSiGMwcBH54NMGE1
	s3dvtKMEcMGNk7RUS28W5FpHgijSQ8Oaa2hJjOs1ORd86I5Nusmj3hje
X-Gm-Gg: AeBDieuF6cV68dQwrnm7SqypooQGBl7gFUmfVMAlFzH8xrLqyAdJ1EAC52NtoXJpMlB
	et2RwS2v0we2fugkm/QEJ4aTehl0SmZ3dOGbvepFug3s14zA+8odIZKjrlZABur1H8AgVVBcn2x
	TMfae8KIeOVi1MGbK65rt7dYhvdaWTJMJ1FwHMqlTxgxQbcowNb7DJ6c3jZ8quWVpw9IbLEe+OF
	jmTSHVbj7D2dqCoo0sespwQRzIxeLQoocfTNfFdr7j50xIAqHqSg4088OxEOM2dTLGlbAGDO+OL
	NejhEsfbDSWrjeLbEVEQ/D69usejdS7ZqdIMB/6awx7HczYgkT+sMjKB7BQJLmVK9hTzhtYfE4u
	6WnwMiasK7zIm/xbhmygKdUVheR1ca8ZXMOuei5akSg5XTCw/abBCr8/FrTCBeV6LyB/wDu4VSf
	SAkcbGlhLNeUyoYuGMNEabEMkvYxXuc610WTJIX/TyJBp00duKm/wDm5ZOTLE+3Gt/Iv5l8USaT
	JkR4hfxJ9cg8OY=
X-Received: by 2002:a05:600c:8b8c:b0:489:1d74:56d with SMTP id 5b1f17b1804b1-4891d7406famr395829745e9.29.1777109422135;
        Sat, 25 Apr 2026 02:30:22 -0700 (PDT)
Received: from localhost.localdomain (ns31537009.ip-141-94-163.eu. [141.94.163.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7b2716sm204422615e9.30.2026.04.25.02.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 02:30:21 -0700 (PDT)
From: John Madieu <john.madieu@gmail.com>
To: broonie@kernel.org,
	heiko@sntech.de
Cc: jon.lin@rock-chips.com,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	John Madieu <john.madieu@gmail.com>
Subject: [PATCH 0/3] spi: rockchip: ISR fix and minor cleanups
Date: Sat, 25 Apr 2026 09:29:33 +0000
Message-Id: <20260425092936.2590132-1-john.madieu@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,
 
This series fixes one real bug in the Rockchip SPI driver and tidies up
two unrelated cosmetic issues spotted while looking at the same area.
The patches are independent and could be applied in any order; they are
ordered here by decreasing severity.

John Madieu (3):
  spi: rockchip: Read ISR, not IMR, to detect cs-inactive IRQ
  spi: rockchip: Drop unused and broken CR0 macros
  spi: rockchip: Drop dead zero-check on fifo_len

 drivers/spi/spi-rockchip.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

-- 
2.25.1

