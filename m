Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E913932F7
	for <linux-spi@vger.kernel.org>; Wed, 10 Jun 2026 11:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781092590; cv=none; b=mD8N+DSWGAvXFkrHxpMTQ+uo1q4AhFletsDaY6cva1gbtVeJgxCQoriQ2hAa28WgD+WmAGjtoACIg8aTm5WxKGK8Xm3LwIuyfoo7KZjUanRF81unKhz3w6T0bHlqx4V+xi5oBSB8632mtfmZ36Jmm6pfnb9O1hASAb+x+IKXnEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781092590; c=relaxed/simple;
	bh=gG6dCT2yvB6PDOpB4wiRPvLXceH1ipJgFyv4K18OGd4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kB7DJ3Z79F+2nHqEebbHtlRsx29aiGkR6JO8HMXcvHeT0JT3aOZHCfKNcurptdZk6lqI/TPLiHjyeLEOOwDI8fm2iFcO+Olylz7is11UDmzJDJ3f9LKwuDM3vRppB6hSnnrMrcsRUtlb/rcRQWETunKs4+rIhhkMDFc97uLGqsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=wX1SWP7P; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="wX1SWP7P"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c8589498839so2978063a12.2
        for <linux-spi@vger.kernel.org>; Wed, 10 Jun 2026 04:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1781092588; x=1781697388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qi4w7zRN4FtxkA4S46A60IGs8UNJ+c8S4k9RcdkfCmQ=;
        b=wX1SWP7PjEvmgSRXxp6OvcxPnt8ofeC+iq5RXr+78pzd3c/YAXJHpBr7Z4XHQcXKuA
         w4rDoNycb085xPW0Mn3naERQ0rDNf0Ua4gxFh69dH0jU06EO1/K77dwOsbOhFLNN0IRl
         tiAVJzHZ9Q0xW7T5vBsywjumJTN+2Tp2LlBZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781092588; x=1781697388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qi4w7zRN4FtxkA4S46A60IGs8UNJ+c8S4k9RcdkfCmQ=;
        b=EOAjJg4mu0/QkPiybEAEEsWlRdvDghKVHetZH5eEBqghsxUH9Ym31w+Xmyt52k95VE
         /rlqeXLGkDZb8Q4YEkZxyjUwZIdlV+cKO0EqIza7F/aRnOodA7Z7WQ8ABGjqTZvVi+8P
         G3Mehdl2UqnXiSc1JilWTkPUuPoaz64yVc295TbKFhmr5EIrz9GgDbotu/l1BzibDL5c
         iOqho5V7jG+a8qAHIfk2rbbnxC2wv7KqfGDHWJP7IsrdwJ4TGWKKBmyWsUM/AZg3rmR2
         JQd3/Y/JLyhCQjC447ErpLqoQLmUDYQvFHQfvbldGFoNpWRkEVGGDRlllZvZGHdMv7KM
         usSg==
X-Forwarded-Encrypted: i=1; AFNElJ8OrnbqCaTyeixEQhpsxkPBgRYO0zWdpqgljtXFP+r6jJHIB0pWc5Y/QC4i3supwEDR6zJJ7s+Y/Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxDoQe3N/L2TOg+PBpJS4bWEEbE9XqV1Rihf/8wxHm/vn7WJeJ
	jf8vuFf16YgIl00IV7iN7ujIdzc/8yI+J8pdzzj3OWjv0E8g1/tYBMxeleWnGWvPylw=
X-Gm-Gg: Acq92OGK3XsnVDOJdWe+2tcBUJ6X6Ro//hBupIHe3AWcVJNXEIsrpw+nOFKsUMz6m7J
	FOsxZJzq54ffHpLHSxVFc/w+BJv2kYPqZH4qRq8QMeKsjXf6jkrfTZ3ssltPKSB73pZtxeAKeZ/
	d3kiuFARLrsw/392Wda5R2H4LPWWzeQjZrsVS7af70PBV0m4u3YaQW10S7XQVt0ltfknCl9nnRW
	a+J+HkMRzGyQsDJctdeILrkUutDAA+j/7vesfaM2/mxCEx2bx4xDf8DTRLy29Ldn2H1bJy+1BDf
	9WIuPnKpe0DWIc36aRKIPza164+l08AdTUAP/BzcZ/X9jBQ8M0jNxclpzHCH0tzWPJIxRDCoQjG
	/oH7JtBfFOVg9EwmBu2pwiYPye98j0DxeKSkx02/tmRPLZmwK5uqYHevdeC7vvyYdHIIcWmt8gW
	OB2IwBc/mQjXxNOG7Bq3UsVEGzIPSgxQBv4bx954GtIi3Ecq99XX9qhd25vFHh5UD1u6M=
X-Received: by 2002:a05:6a20:c793:b0:3b3:2703:115 with SMTP id adf61e73a8af0-3b4ccd7f6femr29605015637.16.1781092588202;
        Wed, 10 Jun 2026 04:56:28 -0700 (PDT)
Received: from nunu.. (nunu.snu.ac.kr. [147.46.112.82])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04a0e9sm18300516a12.13.2026.06.10.04.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 04:56:27 -0700 (PDT)
From: Jaeyoung Chung <jjy600901@snu.ac.kr>
To: Mark Brown <broonie@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jaeyoung Chung <jjy600901@snu.ac.kr>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sangyun Kim <sangyun.kim@snu.ac.kr>,
	Kyungwook Boo <bookyungwook@gmail.com>
Subject: spi: uniphier: KASAN wild-memory-access in complete() on early IRQ
Date: Wed, 10 Jun 2026 20:56:21 +0900
Message-Id: <20260610115622.773149-1-jjy600901@snu.ac.kr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

uniphier_spi_probe() in drivers/spi/spi-uniphier.c registers the
interrupt handler uniphier_spi_handler() with devm_request_irq() before
it initializes priv->xfer_done with init_completion(). If an interrupt
arrives after devm_request_irq() and before init_completion(), the
handler calls complete() on an uninitialized completion, causing a
kernel panic.

The probe path, in uniphier_spi_probe():

    host = spi_alloc_host(&pdev->dev, sizeof(*priv)); /* priv kzalloc-zeroed */
    ...
    ret = devm_request_irq(&pdev->dev, irq, uniphier_spi_handler,
                           0, "uniphier-spi", priv);  /* register handler */
    ...
    init_completion(&priv->xfer_done);                /* initialize completion */

The interrupt handler uniphier_spi_handler() calls complete() on its
done path:

    done:
        complete(&priv->xfer_done);

If the device raises an interrupt before init_completion() runs,
complete() acquires the uninitialized wait.lock and walks the zeroed
task_list in swake_up_locked(). The zeroed task_list makes list_empty()
return false, so swake_up_locked() dereferences a NULL list entry,
triggering a KASAN wild-memory-access.

Suggested fix: move init_completion(&priv->xfer_done) above
devm_request_irq(), so the completion is valid before the handler can run.

Reported-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
Reported-by: Kyungwook Boo <bookyungwook@gmail.com>

Thanks,
Jaeyoung Chung
