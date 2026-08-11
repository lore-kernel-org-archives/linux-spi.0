Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C28B418377
	for <linux-spi@vger.kernel.org>; Tue, 11 Aug 2026 08:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437624; cv=none; b=GzzSI2Nmj5/eXKk8313ROvk6xYR/pRe0SalGZZYRZ9QN4iGx8GA8IOFPYqpzJj4Exv48QOczQqn39dyE9WWkzu2Csjvn3STuQUfW6Oa+pYWv4cBRG8bQIgNZYNSUBnbIwgPjH9UNa9KobacEBPcKwIiGUCxCuIJb7LdYmqC7mGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437624; c=relaxed/simple;
	bh=0v+cbzWnRAjA6ojEnzjct5jVn+xaEqlkAJcHpwhAehU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cIkvBlpXKXuuAnvxDIhyUoGjAbDVT5hTb7Bql2/ySTZRyLBE4ZkilYqJnw74nqU4Uokcfjy0Z3S+JOCQ9PPSh+C/6z96Y2bbmQOAikqVRJQCT0xkobY5JLhwFSfvrbu9iJSpJSQjV1ZlD2yruc2fbhGMZjvdhrbTd4gz7s6wKOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrydZMMu; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrydZMMu"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-480001972b8so1110137f8f.2
        for <linux-spi@vger.kernel.org>; Tue, 11 Aug 2026 01:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786437621; x=1787042421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JQrvHx8cRmWpupSwg8UgPnESCrLlQxGAZWKrSs5aESA=;
        b=NrydZMMuUcq8SXYadr3Fo6AvZ3W5btAmD475fvywDWXWcVuFwXfNAYev5ayivV7gth
         lz2uGUJpTSJZvvj8n2KFSA19mBHdlFXbZh1PGFiWnFSbnB7P0xksYPzWsy1eU0ZbZ90u
         ROOnaZlmQ2LrGenwJ9dfUCnA1miOVR2Q4lbPxtUBsYzS4FzRvCBlczZnvau0TwMjnYgh
         Bpo9gjkdkXZYiIRCq8giJIpOk+XWEZ9LQtBnxf/UUPeLG/gEE6kbTxtoGM9jsvA6pear
         KPebkQAD76YdNt0jhXyPlmNokkFl+Mv7OCnJc/Q8SLyJywl9nf2M3HowMZCPLjzndWJE
         5YcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786437621; x=1787042421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JQrvHx8cRmWpupSwg8UgPnESCrLlQxGAZWKrSs5aESA=;
        b=FmNI507ZeDxvXfygs/Xkz19qEb39KCYyvbQn2UouWLtc469p6CwncRuVS3q+vDaWYq
         v4uFPAuLF1ZkPLu5FJ/K3T47zrk+/I7W4/nAWI4JlKGL0nTpmP6xTGbAtsoWvD0jyGdw
         6t/BcYYUkUb7n1g7EiDhwKGMZPRGUYeeCJZcwmudWmlIxlkeww13mlv/tMnh6r8usGXT
         +7A6L0TYl1oCZ6iZD8wYjEquZkTo8nUEjLxvbchaxd/c432sW3tWxmWQu7mx44cNydSw
         YBlCNOGCRYn4aMipw7HSBSydhDnzAIhEpEpbQ2W/zaHjNZJasxTVlAJJlcJ64UKTfonB
         y0tg==
X-Forwarded-Encrypted: i=1; AHgh+Rr8o5CrVGkh4Oozy8TmHf7VM7YoDt7pq0BDlBqCk60ZWtqOYeDsntAFShQwRWuzLYjDsIbqdE1VPYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDF9gV5mHs8plDWaFUubACDZuvC0ng6xH+d3OE/YKKCuRbl5tV
	7k2RU+nzBtpdGnk4O/lNqpEJt3TCvtS6zJzDlxpM+KUr6xid678cNTWA
X-Gm-Gg: AR+sD12PY/xFgDJ76by6vGKHu/5V7qpsxOCRj6i8jTj/QacNwtRZqoreUdMHANlLDnZ
	d5ZUfGOnfPChFjgkFPUwDCSUcFz+7vX19CzwNGidRaQAEkKtLw3r6FJd41DFycswCzuGLX56bu4
	t+aO3Yvc7Zg32ijllgakZGpsoplydbzjWgWnYer+YnjtG5oE9LYGednqY6S3EZqyrCNZcVLm/XY
	67YU5JIHtuhb0NEjdUTrqf4lUNjBNZlokdFrNUll8M1GALXb4uZLu+h1dNpaYeA777KbgGXFtlM
	6LdnRDa8p/eDH8h1t7xEEi23Oxe0jET2SmporGNIb2exeyW3UI5SvhTZ0cXqZ11W2UTxF0tF4U4
	XPsYtV3NLSrLB3y8V2ijTB8MZKpTczXyBHhvGeAs86t7b9vdfjjVieSwSAbAUdggtMJqp4cI58X
	RVl+6lDN8rGx6f1w1AkL3206D9ZyBUwYsxTXLISHDREZG8oxianQMQVnUHBL6xDrk23NPB
X-Received: by 2002:a05:6000:29cf:b0:47f:f908:ba7b with SMTP id ffacd0b85a97d-4814addb4b7mr1946548f8f.23.1786437620646;
        Tue, 11 Aug 2026 01:40:20 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4814a5ac70dsm3233679f8f.5.2026.08.11.01.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 01:40:19 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	James Clark <james.clark@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12.y] spi: spi-fsl-dspi: Avoid setup_accel logic for DMA transfers
Date: Tue, 11 Aug 2026 10:40:18 +0200
Message-ID: <20260811084018.3566861-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810141437.2805389-1-mehmet.fide@gmail.com>
References: <20260810141437.2805389-1-mehmet.fide@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some measurements on the hardware, in case they help decide this one.

I ran the transfers that fail on 6.12 against 6.18.44, which carries
cac7e5054115, on the same board (Colibri VF50, vf610, DSPI in DMA mode) with
MOSI and MISO shorted at the connector, using spidev_test:

  3, 5, 7, 9, 11 and 13 byte transfers: every byte comes back, in order.
  Even lengths and a single byte: fine as well.
  SPI_LSB_FIRST at 2, 3, 5, 8 and 13 bytes: bytes come back unchanged.

Without the commit, the same odd length transfers lose the tail of the buffer,
because the accel path packs into 16 bit frames and computes the word count as
len / 2, and SPI_LSB_FIRST comes back byte swapped, because the accel helpers
byte swap through cpu_to_be16() on top of the hardware LSBFE bit. That is what
we have been carrying a local equivalent for.

So the commit is what makes those transfers correct on this hardware, not just
a saving of pointless repacking.

Thanks,
Mehmet
