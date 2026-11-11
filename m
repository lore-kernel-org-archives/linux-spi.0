Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794421443;
	b=a0CPoyVHur77rcoty/DDuxzx9xpLtUBSmRH5sVh6JGjgUYnOkdhyyUP7sHeEVhvaG1ES
	 VJ6Xkp58/Odl7YRu69zC11J7m+q7B/56o8I2UdoRsYn5LL/C8wstiorZk5CAuoPt6qrXA
	 huSpThzTFeFeQvDtkckWMV9q2T/OFXqSHxtxj4VyZMwmQQD1iSlDqaRA425YrMoMrezpR
	 1ULX9P5+GSHqNqyvBNPmUekRamgC8OtPQ8QRQP2irdikWbcLJm1ts/cvPr9uDYvbdqxbp
	 M9AZrgS8FBxaUgbDxY01JvGY7vcFRnzm9QApwwhJa8J6sMmjcuOIERXwAiE57nI2ehw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794421443;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=DqnDace4KJcCuvOqrBqkR9Xmsw4qa9ua7zCmO3by2dA=;
	b=U/gjiXqEdT+kgRN2A+j6kkqm58jCnTZAi7Ge5M5oxaDtg4oaXY8N5KC5/wvanl3wz5sP
	 +sAjmddePiXKjH1BiJQKbWdyjox8eHGSTLEUteQIJDRwKsqQnTnMn7YjcxQ2mFVk8dLcn
	 aRmsvq4UwDVjhyH8pXI1kqspzXANxSPfGm6WDFGFwZvaKdS7SsktfFkl4q2C1tLJE846W
	 EipgcNPID/luZOycvq2SAlPFp3ogwr0gLpTzog+f/MIq3sIPc8yCBUacuNVseGMVj/T+8
	 tvus6vSga9w44dNEXRJFaqbP7S7qmOfe+sLUz+5CdB84KmujtBnycdk+9e6b0HEJsvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aYYw+V5p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C19606A321;
	Wed, 11 Nov 2026 18:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aYYw+V5p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527D51F00A05;
	Wed, 11 Nov 2026 18:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794421443;
	bh=DqnDace4KJcCuvOqrBqkR9Xmsw4qa9ua7zCmO3by2dA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=aYYw+V5p6svw24nsCqDdq3ChCGYgqzxmHa3gemCLZe/0PyvqWP+PUFf935h4nFm1w
	 0kwbZlYcZd4kJUPtIkGBTzj0x2HCQQu/TJObOaaksPcv63wj8ap0l9RdNduoHM7N4v
	 ajum9uyW2hlke0vU1hht7G1qi1TIcUoVLtDqne0bJkns9mK7vyLWBXTrGWPVZvIUHt
	 66yJ14TucjfX92NU8O4XgEPblhgaUBGSxg8BehGt+x+Ct8zfRjT0Qv8faLDOykp8Zs
	 kgDOUjV+4tLquBP+Cf3TwZouWVulHloj0u5hkBBXQhw8mfzctUjmUslA6PScIqGfuj
	 pF3lc/32fmbPA==
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] spi: pic32-sqi: guard against empty BD list in
 pic32_sqi_one_message()
From: Mark Brown <broonie@kernel.org>
To: Li Ximo <lixicaicai@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Wang Haoran <haoranwangsec@gmail.com>
In-Reply-To: <20261103084707.1582675-1-lixicaicai@gmail.com>
References: <20261103084707.1582675-1-lixicaicai@gmail.com>
Date: Wed, 11 Nov 2026 18:23:59 +0000
Message-Id: <179442143994.484483.536971203389481819.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1392; i=broonie@kernel.org;
 h=from:subject:message-id; bh=pj5VJ1URBgauxKXGbwy/jkenlc5qzkwxuw3NPQVbu9k=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLK+bDowf0n7h1efT/NkeTqucNt3fJkOV3V/7ba6lJXz/
 9y84MaW1lHKwiDGxSArpsgSl8X9sr7k9Rq+gwvbYOawMoEMYeDiFICJiLgw/JU+OdFQM2nZ6mPv
 J80yv937eMXukzvUJwVu0mK99nYjU+Rmhv/l/Iw+Wa2eCo3X45ddUm5u6tzqa+dmFjCrzKDlot5
 XZQYA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> list_first_entry()/list_last_entry() do not return NULL on an empty
> list; they return the container_of() of the list head, i.e. a wild
> pointer.
> 
> The SPI core rejects a message with no transfers, but it accepts a
> transfer that has neither tx_buf nor rx_buf. For such transfers
> pic32_sqi_one_transfer() iterates an empty scatterlist, queues no
> buffer descriptor and still returns success, so a message made up only
> of buffer-less transfers leaves sqi->bd_list_used empty. The subsequent
> list_last_entry() then returns a wild pointer through which the driver
> sets BD_LAST/BD_CS_DEASSERT, and list_first_entry() returns another one
> whose bd_dma is programmed as the DMA base address, corrupting memory.
> 
> Bail out with -EINVAL when the BD list is empty, setting msg->status
> the same way the timeout path below does. The xfer_out cleanup path
> tolerates an empty list, and normal messages are unaffected.
> 
> This issue was found by static analysis.
> 
> Reported-by: Wang Haoran <haoranwangsec@gmail.com>
> Reported-by: Li Ximo <lixicaicai@gmail.com>
> Signed-off-by: Wang Haoran <haoranwangsec@gmail.com>
> ---

You've not provided a Signed-off-by for this so I can't do anything with
it, please see Documentation/process/submitting-patches.rst for details
on what this is and why it's important.

-- 
Mark Brown <broonie@kernel.org>
