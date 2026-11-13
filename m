Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.240
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794535481;
	b=eUgmBBLwCR4LRAbiBOTbBWjwr6Mc70S5SKuG8LI6ZGGwATWl4lcS0MPM54QHi3gXhwkW
	 Eqq78O9Zg591EkgLpIdsGUOmI4mRuTHL2LFv1wD5oEMWFdni+ogRen6iiBx4IdR3q2xfl
	 w5e98V12l8jsCHOmQ/9pKa0iFuLSNoPd6m6qiBNSny+pY6ExIISjFVfFdd0x7MyTSySPG
	 vaTk2q2px8tA+u9OOznkT8asPe5tEWzhueGeNNDAq9goB3VYjoYDUh6viygkiBb/BhSM/
	 vDvZICYD7QqSuu+Sia93Mn2bJEx9gmnyOUbrW3om4DQiUQNlp1cQHCr78hIpb6jbbUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794535481;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AceqxThdekS4gnc9iIZOmTnn6HYCKyFrUKiFIIjfT3g=;
	b=uNKdYeICYqn0BC1LJfJ8BLq1LPqE+RPY0vV55NkgpQUVEJnJFyyNiTasNkdghJgCMv+W
	 ylbEwiHk+D12QIKHqAaRQLcBb1yl9e000nw1lh2RkIE2tsm58x28MGDNLG2SUmJLqlIL8
	 Jfgm6MYuC2S4q/j5x/Xlo6JZZa0mPrFYvktX5JMSTEIQSwDfuJwi8YrFzAeyHWCmxJnH0
	 oer71YPZv37K/zGcA2loNeGCzROEQztrg63wHl2jMZAe0TN2wF/OG+97Lj4vt+00674DT
	 kfKmnKfDZstlEqYiDfTrtbFr782EtwhJVJleNzDo8kxDFp3uQ1mYEpqafqrNaaFga3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=OEuWhh4q;
	arc=none smtp.remote-ip=203.205.221.240
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECC2606A31C;
	Fri, 13 Nov 2026 02:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0ECC2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=OEuWhh4q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794535476; bh=AceqxThdekS4gnc9iIZOmTnn6HYCKyFrUKiFIIjfT3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OEuWhh4q6XLLI5ayYgLkKy1i7qBC4udfZsRDugKnhmfgdrq9GrVCayyz/vFOsvrj+
	 6vy/QPvdC5WJ+q1LdXgTBfwSxg/Qo+ByeF8xSNXdU+r5iCkH2IG6e/DDgQ+h8p3xdI
	 vLlT/4pHgMmF0p7v4Of8RNK6WuQJiaF3g+U42o2I=
Received: from shuai-VMware-Virtual-Platform.. ([117.158.156.199])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 122134D7; Fri, 13 Nov 2026 10:04:34 +0800
X-QQ-mid: xmsmtpt1794535474tun2viu67
Message-ID: <tencent_12375A4C6A22DC3D4C5A9EC5491EB5690605@qq.com>
X-QQ-XMAILINFO: Ms5xyImz3IR/4EJrlIONb9aJO8inobFSvBKcsEUDFODLkUPJ9jHSC1j+R2AnKM
	 7JNXhazDYdEaHvMZATyO8cg4lSORLAA78ZFctlIBXkNaAXl1trkq+BJ2aCfnXXNHzSDtIFaysEJO
	 gnOZF2PseXi1YbxhrNykHDWo9Wf/X8LpsZcKWyUe+iqQjZHNfjIbkqVwOErMZbj2BAbaqpRKlb7m
	 dhCoJTTaYt1LCn2HlM8/lKyvffVtrHrIDMxcQQCwax+ltx+Uc2xJawr++o+LKfM6lzvNV77x/Xmp
	 ayJtq6IaNgwevbDWhK0Ud7YpZiUGoyvCXQL5cIF8E3Tbby4KpLLzcE7bK4nI+9lXBUnSE+EkAi7Z
	 VrgjDoPo4+rR0WdSWtE3Z2/IcrvqhoSLk1OKQZWz1VgJnjff1e6bPLvTYpgH0t0bHMvclEQBMx/S
	 3XyQBsfSrSMjZdhQ/4uXKF/6+CJDT0mvA0dgxBIKqf2agIhuhQk9x1M/LTK3vD8yosri+bQMrxlp
	 y6r4ela56uMXTnsd7cJmSRK+CeKSzpyVzoeHeWtMAy3v8sWbCvqhpL4WhYyKhh2BIdeOfamnBVOZ
	 dxhm2jpAlrGR43z0HqI9Audy7SHNfM2Qit67xRqTZqQSkRqnocyixHFfvlNk5Z+DVrwFE6xuGb9N
	 h7Gef9yNSSmNnPMcuMkmgE/WiVK39teppziU7xdWwZ/UcqGPDGjeZ3VjeTz6HzBDYrtcVNViyM5e
	 TsQu0TLpeAfroX0bIEJnaLnVqEEJ29UyjeUp5BUnVIoBHk/Hg999nCmvRHPxUjHnEf8SD832W/2Y
	 9qpRVTdq9MfLQZSHmljFY6oa0dz8hh6ADfvAUaN6tBhHtK8LR7ugVZ9PC+EERfvdRoGdA3u85wix
	 PD4O+CACcykqxwUsaUfbTg0ofrZiqoPph+A5SlrMA2xMlZSoWqniu6EEDOIu05xJZhCvcVf6AC+K
	 EvFJE0dyVczMbuWjqCQk1+EYne7gcPqiErUSD/BWbb7HNlcaJ31YKtM5XwlstaG44YZuhRtkPNSs
	 0WtTo+ZNVVIlvDvlmTVFIJlr3v/5h1iEwF3Lt1mMwD5pk0cb0Ax/rEaw8RUgmMThE3ddRTVdUszT
	 hVDO0crV9VTt9SF82b5b0+yBPfvg==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Shuai Liu <847807867@qq.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	ojeda@kernel.org,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	847807867@qq.com
Subject: Re: [PATCH v6 2/3] rust: spi: add SPI driver abstractions
Date: Fri, 13 Nov 2026 10:04:33 +0800
X-OQ-MSGID: <20261113021000.1000-2-847807867@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179451185979.339049.12323339081307899766.b4-review@b4>
References: <tencent_C5AC68A2C63D42DA8E8547FEA38904F74D05@qq.com> <179451185979.339049.12323339081307899766.b4-review@b4>
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Mark,

Thanks for the review.

Agreed -- mapping onto the lower-level APIs is the better design for the
Rust layer, so v7 (coming shortly) reworks the device I/O around a single
`SpiDevice::transfer()` primitive that maps onto spi_sync(): a sequence of
`Transfer`s (write, read, or full duplex) is submitted as one spi_message,
executed in order with the chip select asserted for the whole message.

Since spi_sync() requires DMA-safe transfer buffers and Rust slices may be
located anywhere (e.g. on the stack), the Rust layer owns the
bounce-buffering: every transfer buffer is copied into a kmalloc'd buffer
before submission, and received data is copied back afterwards. This
removes the dependency on the C convenience wrappers (and their helpers)
entirely, and adds full-duplex support, which the wrappers do not offer.

`write()`, `read()` and `write_then_read()` remain as thin convenience
methods built on top of `transfer()`: register-style access is what most
SPI drivers need, and keeping the familiar names makes porting C drivers
straightforward.

Best regards,
Shuai Liu

