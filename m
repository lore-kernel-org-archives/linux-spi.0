Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F1142A781
	for <linux-spi@vger.kernel.org>; Tue, 11 Aug 2026 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786439607; cv=none; b=FZqNFzLfb1dieUGfXhYb6p3FDeLOBgCCOG5P7gm2KYMnDI2X0hIckEet6ZAEyR7Lt6BuOp7bg0ZWvwL508qWkiotQh7vQOvoHTjIzITMqLo3rYLib//RdO0KTttGQgk88St61T06Z1dwoDbKkRGeRgedIIu6RKnKW1PJ4HkjmSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786439607; c=relaxed/simple;
	bh=eXTEDFxSkgdYFKaZ+v9LnbZewalK3Gedj5d7pJyL5F8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5g5ULbC9S0VzA6GJV7WXVPcvDwWMO7hSy/87LQWd4H+6MQvOkNunei7B4NNTFc+OerlZfUZcQH9DLPpF+NJeCk9LsV+U9/2bPtwzRTpJZp5m2ECBevo4N/lJlETgC1gmRGuaIQa2xA+j6QeXlCJxvoanXtEGSKN3O0sGIcda1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Al85h61b; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Al85h61b"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4956242332dso27464995e9.2
        for <linux-spi@vger.kernel.org>; Tue, 11 Aug 2026 02:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786439604; x=1787044404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eXTEDFxSkgdYFKaZ+v9LnbZewalK3Gedj5d7pJyL5F8=;
        b=Al85h61bREn4kxCaJ0kDVEytK9rE/+udegJqwFEs26j2iNHJcKVgY3gweliz6lSIlL
         gZKM4Ktuy8tP5DBBGJkUEjMLAVGauz69jVyLzMVLnWSxyXwUunvq/9qU9rDMpb2S8UOY
         MLlST2odWibL3tI88DsoK39kFM+K16egmO452n8qcEWOPdAekJxlNmFlwqTBjNEqm/36
         7crs9GBQCKfsPrLDXkqNhF9zzrfDufDpesw3gUvTq5jgm4b8P0gaaOsVvBZgCvDyXzXb
         h2dyZgEl4KWvlhooSd9a4m1beEoFx1uMuRW9qUvM1Fb96F1YFK1X/uP1GNJ74BY28iNT
         xkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786439604; x=1787044404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eXTEDFxSkgdYFKaZ+v9LnbZewalK3Gedj5d7pJyL5F8=;
        b=SSO1Ynx+n0yA8IhW1INOMszGTKE6qMhpZpOo8TXNw6PeJaxqdMC5u6SYentXg/vh7D
         wQa/EgukbRrylq6rUszaNCsUquM40ohv7i3o8ZqTpapNgOpg44zE72lNR0DYXkGge1gV
         bpN9QP0eZuy2fLJno7hgoMPRP3zIuVCM4E/ZvgXHM39Ehjsy4c6GoJwRzV6CsRU9ubdu
         8H26N6lUysF+b10h8DAhZXfSFBpAYPqla5hmIsBljM7vY3Rqn5bqFqvIOBSol5bxN2Vm
         pBahrBmfFM5Ga1dsYaTlkRaE4j0HERBH8gYPUtbyO/IPJuGYKXmoXqDma/7UfHyRfCqF
         cixQ==
X-Forwarded-Encrypted: i=1; AHgh+RqDNIbhHFxpN77cYE1RpBnNjDc+WXoGatbUotvrtLyP1Sz0Xk+ofCBhC8FAtt+8ocsEoW1Zz5h0veA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwttxdWRS4guVuuT5LIlwia20O6sr4ki79Zr6GOPgbjvVmZvnes
	3Dv4ooZ4fenMcTjrr9jDxV9MQ4g6E2dUeOwfAIlTWx2ZMaPFS3JOcwUu
X-Gm-Gg: AR+sD12CQSyk3fcqu/FPiZ0GZeoJzgeivxcNGXh8YDIxlZAgHChlXtnCoVBhOHNQFdy
	yRHYWJxHxnvQJ6HrxV/u9TAafcD0YlyY7bTyEIDaqgpJ30/z4NahBgKjCJCw/jjN4FKTxR1AiaQ
	3KYxDnTP6s57kVK5i34ZURoN4Hwpq2CbPagvLPKxGHujpk3MHPlsTaH6k/zMbHwIdQN9+30AnL1
	xOL8P9YKeMg3s8EjW1WmmQruUXIu5OQqe6QJHWQ8YGi0Z3vD1OFDlFu3VJ7SUzbFthQnMo0WOje
	y7r5m0qTFkuFz/K+5qWk65Q6Kboo6zm0foMkCpGIiVSgIQP2ajm/z1ZuWd0E3/+OstHKtUZjuj5
	4gL5EaPwOPAEQDaD70vwQ49+wl3B76TazqF8Opti5EP4IAGveEU74Zp4TsiGNqkaQ1hoz6pLqhZ
	N/AJD6Z+vKVlFBv7APsr2a4c8fIql6ludBLKeHznQYX8WaeKfzl3T2UzmPr0hv+RkW1Ifv0yegU
	LarpA==
X-Received: by 2002:a05:600c:3104:b0:493:f0f5:f2d7 with SMTP id 5b1f17b1804b1-4997842f614mr27031495e9.7.1786439603740;
        Tue, 11 Aug 2026 02:13:23 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4814a5be1b7sm2787760f8f.14.2026.08.11.02.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 02:13:22 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: James Clark <james.clark@linaro.org>
Cc: stable@vger.kernel.org,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12.y] spi: spi-fsl-dspi: Avoid setup_accel logic for DMA transfers
Date: Tue, 11 Aug 2026 11:13:21 +0200
Message-ID: <20260811091322.3592403-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811084018.3566861-1-mehmet.fide@gmail.com>
References: <20260811084018.3566861-1-mehmet.fide@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks, that fits what we see. Larisa is on cc, so she may remember whether it
started as a fix in the NXP branch.

Either way the behaviour is the same. On vf610 in DMA mode the accel path drops
the tail of odd length transfers and byte swaps under SPI_LSB_FIRST, and this
commit removes both. That is what makes it worth having in 6.12.y, whatever the
original intent was.

Thanks,
Mehmet
