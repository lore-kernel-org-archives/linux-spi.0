Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D8B38E8D8
	for <linux-spi@vger.kernel.org>; Sat, 15 Aug 2026 21:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786830607; cv=none; b=G4AR+2LknOXnxTWcD7WruKmVGBDWTSEqAp374zarDi0NoFawTN2/2ELWV7Vyj8joEHSf6CBBUBxHNbjzJoB0SQi/05wbwg+1cNs6EQCklFCkJWDhvHfEo1wFnL8kweBuf0GoAGDZIztwUOAHe/wG4Yf1RB7QWg/myI0sTCdHplY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786830607; c=relaxed/simple;
	bh=4VCb5hbd5FtPxnayyr+BaRBuN+DJl3M/be9Ng6hw8io=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kNUoif+46ZfBE4J4RsPfBpHok6xJxrnrIKpfLNWcMYiWyfe0XbvUD78pykfJgGeZeXYXhq2E0uFzFQ6XBpHNMI19TPYYY+ixKMEL2c297k9aWkQcMkU0PmmOIhaowd4K0y48kj34INqXwefM9S6DooFqUPF/zTJZX5JN2mRqllU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8UibSWX; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8UibSWX"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-381f03d7be0so348003a91.1
        for <linux-spi@vger.kernel.org>; Sat, 15 Aug 2026 14:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786830604; x=1787435404; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=flOU+GsPnkJk4hfwQBm4GqfM22X6Dcnmn1YJIc77Kh8=;
        b=j8UibSWXI9rl74spp4oJ6JLvNzfoOoC+VP7EFlN3H7PyDA7n3ndGaf88VVMuGnH2kV
         Y3tNS9EsxFYnlWafr+b5EEfKJE6srQu5FLDpfUpi/0pkVmpbwt/ecNKEV+HoCD3aQwcZ
         s/wnWkggbS8Vjiaq7WwG0kcVe3pdc85aGsJivDQ4ojugCRLI35J+LQnjjEDnau5bvPNT
         ZVuPC7qLrWsTsf/FSW2LPr1SE1fWs8yDqRY5YyTmqI0WXZ5PAiGtXZj5FxZXzujSK87i
         QGozrcZbm2EnPsMjCeGolRGpwWpl+ECJVSeRed+v3kXtOr/sLw4aHMIGacZvRmRUhZp5
         cYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786830604; x=1787435404;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=flOU+GsPnkJk4hfwQBm4GqfM22X6Dcnmn1YJIc77Kh8=;
        b=FPW8ezANqIe8dlq+4NLqIvzZfBRxYsIbLKrsUm8jr2UEz0drpg48KUUawYscytDEe7
         wdzqy8Ers3crJw/zfI0ExyauZnYau0liheW4f53VdXXIWsVJyczwWWAKWOBtagAWWqYK
         Q3a78t1YtzeTblv4KEraiTXChpocOU1f30GvENiaCWhs5G8NBVfFUernTvFhGb+m6X/b
         4xA/lbrAZB5Qt6OHN9atGeVm27EzMWDcBOpwl3fKUeZgg5GHAuc81n06i4FoFvvZ/oIF
         YRhVVCSGTXGVHT0P2Sp2BEPsn/afVt2PyOEuHHFKLk9j9mWDSHxjJO5jn/m1Xl3MkG0+
         SJEg==
X-Gm-Message-State: AOJu0YyhEF2mTSuV+8zAYWXay8jLaWclSsw5jFdURPKv+PubCml/6SHZ
	gY0aD65YDIh70xq6TMfRpTLHHfrKSqMrYZWI7I6MJdPl26h1LpYZh1Jo
X-Gm-Gg: AR+sD13DteBY1bTPef7v74RmdGx9eu0aYaUWEk0okHBhNw8RwlUMXVDrEmGHIdrJWQe
	sZpR/fo2KkW3rejuy0Xf3qGspfeHTwLiZigmRwvtzW3XXli3cghAvGeLFNx3tsbDYfwndvP56+3
	zTOuFgDZoehOeA2Ut4ABXdv9w5amdxG93tfvD32ADGuh1np4MwlCNd61AUewbkmf0RRRJ+LJAPv
	S6KyHeUuLy4oU8GZns4Mk+ByKb5qRas8or9W/Ud2DcKy85dOojRaR1sGc3nw53xtQypTnD1DLx+
	b1ek3fotaBAFdJ+hADdkIzktyZ66csVtfZXqssjO0njBbGLFFebeyrVce3LIlwHTt7wJQR+JHzS
	j2drPORkrtqAgxQpMcKVhSrn8+DaxaaEwCkrX+dxvQVa0u9UP1RJBNBnCYCIlc5GAplZmT97dIO
	6q1zMpk7zEHsamHMIwVoJ32E6JiO02oQm5FEhKRvsc/l5t1iYblf3RinhQxSQBMkCzF+y0OZZdZ
	yQd97ocITAdkrZd
X-Received: by 2002:a17:90b:2e4f:b0:38e:ab3f:2c99 with SMTP id 98e67ed59e1d1-3933b871cecmr11796551a91.2.1786830604335;
        Sat, 15 Aug 2026 14:50:04 -0700 (PDT)
Received: from [10.112.173.252] ([2409:40c2:505d:7e1:7f19:edf4:38f3:dccf])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141388b2554sm33541829c88.14.2026.08.15.14.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 14:50:03 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Subject: [PATCH 0/2] spi: davinci: Convert bindings to dt-schema and clean
 up DTS
Date: Sun, 16 Aug 2026 03:19:30 +0530
Message-Id: <20260816-ti-davinci-spi-v1-0-a7f57dfd5262@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MwQqAIBAFfyX23IJJLNKvRIfMrd7FQiMC6d+Tm
 NMcZgplTdBMQ1Mo6Y2MI1bp2oaWfY6bMkJ1ssaKcZ3wBQ7zjbiA8wlW6bXivHihGp1JVzz/cJz
 e9wOTgHJiYAAAAA==
X-Change-ID: 20260816-ti-davinci-spi-e64e4e48b6b6
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com, 
 simona.toaca@nxp.com, j.bhargav.u@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786830590; l=1098;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=4VCb5hbd5FtPxnayyr+BaRBuN+DJl3M/be9Ng6hw8io=;
 b=L5/ERK4hd8yvnG2dq35TqIPDWaNtOiDPSanlrZvZNIE1G6J7s74R8qtuhTEQORm+zHOyL+lpA
 IdfmRSWsfg1BzuE0e8IZSLENqEcuIzeUUlI2+Gz8efUOUOgvZJUYOXk
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

This series converts the TI DaVinci/Keystone SPI controller device tree
bindings from the legacy text format to DT schema. 

- Patch 1 removes the obsolete property `ti,davinci-spi-num-cs` from
  keystone-k2l.dtsi, as the driver uses the standard `num-cs` property.
- Patch 2 Converts ti,davinci-spi from text to DT schema.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
Bhargav Joshi (2):
      ARM: dts: ti: keystone-k2l: Remove obsolete ti,davinci-spi-num-cs property
      dt-bindings: spi: ti,davinci-spi: convert to DT schema

 .../devicetree/bindings/spi/spi-davinci.txt        | 100 -----------------
 .../bindings/spi/spi-peripheral-props.yaml         |   1 +
 .../spi/ti,davinci-spi-peripheral-props.yaml       |  25 +++++
 .../devicetree/bindings/spi/ti,davinci-spi.yaml    | 118 +++++++++++++++++++++
 arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi    |   9 --
 5 files changed, 144 insertions(+), 109 deletions(-)
---
base-commit: 3eb40771c00a8488fa6ed2cc1fe203477908bf38
change-id: 20260816-ti-davinci-spi-e64e4e48b6b6

Best regards,
-- 
Bhargav

