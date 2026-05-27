Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2223BBA0F
	for <linux-spi@vger.kernel.org>; Wed, 27 May 2026 08:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779870091; cv=none; b=TUmVlqLShbsRZpGo7cdTRRhU8EHatXbqXlj4QjC+Hz1Eb56yDkQ3AqGCCuddWC5h5e4LUC7/z7ajXQr9As7Cqamo66Euj+cKf6fYV+fRqC4RjNifKTiHEeXYWzmD3RTdnJKYIgKZ2w9ajyUfqy2POzpeXzswJTyUd/onRcLWatY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779870091; c=relaxed/simple;
	bh=PaOu3f0GeNd5APagV5i8pt0bFx6B+Zy4I225B11I2Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=os5IU4amT5dB1kpkpW7Ma5pCIygnpIdMpJo/LyFEnlMhVd0MBbEaCiJy4wWlDmk+6qUKkFZoTyBxNWsKJuYcRaQJPVzWuIQjXA6InDCRU6X420iKjWgAq63OdS7X9TQdRC58XyqFIRzKT4AzaQTw8+EaPCACsCYCZo4a9oh9I6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p2ghZ7PW; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2ghZ7PW"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-3698e34a567so10644145a91.2
        for <linux-spi@vger.kernel.org>; Wed, 27 May 2026 01:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779870089; x=1780474889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lglXISlUl4HOF/2ivuZOi8fibva9uDU+M81E0DQb3Vo=;
        b=p2ghZ7PWb/Bt2TgvlodOy0NYVn+WdUu/a+W4Y7kCFxQZaWbj+rTxYuxpAs/REzw/tZ
         H8JZwfL3fJsIoQji3N+1GmVpFn9d2N8Xn4N7envywHmY/YFi8zg/jPOrgCO5h6jVstfa
         LQAIXQnosieM8I30XIlhXx1QWBdxAE3/INYsYT48zhkYnPy/j6XHvwk9fJ7Ttayg5Z+n
         rctBy9A8/JIyywvIwN58kNgJLVQh92TTiOwXOB6axbLiT2k84xX2G0z6i+rJQohgInvE
         KzFT+CwYgmxyYiMm3v7x6VbqjX8hHkHZj2O4wFqG++JwZ56DnqU+SWSWN85NeRjfSeQt
         OLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779870089; x=1780474889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lglXISlUl4HOF/2ivuZOi8fibva9uDU+M81E0DQb3Vo=;
        b=QMbH+k+MCy81sej5sYTLFxkI7iaCsR3eJcYAwYqHFrSZllt8cjP94dX0X3ZZJpa3ae
         E12fulbgQTQZ696NMLAXC3GOibuzamWuyH1PEqbuPriUWIswsvxPdoa/uMzbVluOctx7
         uk+SfZclpyGM1FB1lUbvkuPY7QKn1/jGphgk/hiPu4eZ7Cf2bng8IxHNu1vGjBa5BO4t
         8r+7rSUaMrzkFZq0TuW3JEW4xVb+EtqaP/0Vy45QAGOZH9wX75JA6TjVpOLn1U6YX/ED
         LrpQ5tX3oliYP39Lp8VVxy99XW09rTL9sJxBv4reLMF8Cirru1HKwswdv9vbSc3BI2hi
         AVag==
X-Forwarded-Encrypted: i=1; AFNElJ/L0KqtEdOY/HsyMm/yymtbnjEYpaJuvVE8LZvBVBUsX84CkbuqINVv3/gxgMCFPdkl+z5tcfvioCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrXZ3Bl/AY4EjwRRhbqx/NtQbaog/YgiXrSCvQVPxdT1eomwJ/
	7N8IGqOWEDNeDqL1C0TD7yeAHKIZwYmdJ61ppmgNmoCuy0xBvWf3OrZJ
X-Gm-Gg: Acq92OH66dUJIu/QSwJ+CgVd2vG8urhBnkOZSRPb/4+MFZgCHfwbT/qERAt9LNtBx38
	9RiI9MPKUdP68GlP8V0T36OKsBJs6BRJLNVnVj0MtrxLZ15/3A2tx0gOGLQMgh6G3iGqLiLZPf6
	qHdzo+DrO/bQvbNZcZOZbm47aKnpqoHbN3mhvcKb6ozkNgqXBQALbEmnfvbRETw85+EkC3Tukjp
	HJ/MLGkHu7Tu/ytU0m6GRztuIbkJCAGYjYBhZ4l6ff+XkkUr1n73Q09oz3XQYMh4jhN+kf/9Vu5
	z6TIuX/ec91Lq6L155+FcTiIpw92qsSXZehosRUYKX8kH/oLXCGudDZMqtYHsqICXEPYfVCSDqz
	IEtn8pMPQ8KIe+3psGCT2zb5GgrM2f60SiZNS2gM8vwHRWvqXpim78GooFwoqX2McKa1sEaa4SH
	c/38X9Q1IbM1IkN1NXoA==
X-Received: by 2002:a17:90b:3882:b0:366:132:fda7 with SMTP id 98e67ed59e1d1-36a6771a702mr22535678a91.10.1779870089446;
        Wed, 27 May 2026 01:21:29 -0700 (PDT)
Received: from Dell-5540.. ([2001:926:3:e0:b673:38ac:c711:a9f5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a7263179bsm14177558a91.1.2026.05.27.01.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 01:21:29 -0700 (PDT)
From: Peng Yang <pyangyyd@gmail.com>
X-Google-Original-From: Peng Yang <pyangyyd@amazon.com>
To: Mark Brown <broonie@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pyangyyd@gmail.com
Subject: Re: [PATCH] spi: dw: fix race between transfer IRQ handler and timeout handler
Date: Wed, 27 May 2026 16:20:42 +0800
Message-ID: <20260527082042.3746-1-pyangyyd@amazon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <d08e1763-1130-48ef-9804-22e708c6e8f2@sirena.org.uk>
References: <20260522095727.18307-1-pyangyyd@amazon.com> <d08e1763-1130-48ef-9804-22e708c6e8f2@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, May 26, 2026 at ..., Mark Brown wrote:
> Please don't top post, reply in line with needed context.

Apologies for the format, fixing it here.

> Please fix your mail client to word wrap within paragraphs at
> something substantially less than 80 columns.

Will do.

> That doesn't mean that's the only possible thing that could race.

I've traced through the code paths during my debug. The only
race path is in IRQ mode, where handle_err() calls
dw_spi_reset_chip() from the SPI core kthread while the IRQ
handler is still servicing FIFO interrupts on another CPU.

Poll mode returns 0 so the kthread never sleeps and
handle_err can't be reached concurrently.

DMA mode has its own transfer handler that doesn't access
the FIFO directly.

> What happens if between checking the interrupt status and
> handling the FIFOs we call dw_spi_handle_err()?  The next
> transfer could be started, updating the buffer pointers and
> lengths in dw_spi_transfer_one() but that doesn't exclude
> the interrupt handler.

Looking at spi_transfer_one_message(), handle_err() and the
next transfer_one() are called sequentially from the same
kthread:

  transfer_one() -> spi_transfer_wait() -> timeout ->
  handle_err() -> spi_finalize_current_message() ->
  next transfer_one()

A new transfer cannot start until handle_err() returns and
spi_finalize_current_message() completes, so buffer pointers
won't be updated concurrently.

If reset happens between checking irq_status and taking the
lock, dw_reader/dw_writer will see an empty FIFO (max=0)
and exit without accessing DR.

> That's also already an issue, but it's complicated by the
> thin locking windows.

I think this case is safe because the kthread serializes
handle_err and the next transfer_one sequentially, so the
buffer pointers can't be updated while the IRQ handler is
still running.

Please let me know if I'm missing something here.

Best Regards,
Peng Yang
