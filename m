Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794056165;
	b=aSnvV+PBHRL43QQCyQzd+rU0jBAmGtO6rDs1MiM7vmCA6ESDGKDits3vI3M5B7sbcDcP
	 53VyHJjZyqwJvBsAbpksXEFzvhlF7KgSZujSzjMJv2LBYUjyNaybQCIcBvW+SzTYQvnRa
	 jefBjLfNuchomOGy/QI7lfQ5ZL9BaC3Naq0gtU11Od5j7BzKdVlv40uTrp7KQEGmeHJmf
	 ZLAVJgbqNl6pZL15BY7geNZvFmEDHBDX0WgNaUinTae2C9PAxauW066/QmvKPqX80QNxH
	 EVKGIgC7IDzcCss7Z6sOEwrvlmoaBRe6XpRmb2Hzi04dF8MzRTc02nUFjFm0kTKM8sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794056165;
	h=Received:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=UCE3NbaID3E5C798LUsUaYaoCronIRnRlzf++jSypMo=;
	b=nX0lbimlxzZXTOkBqHPb49jtwJpJ1oq5/ccqusVQlm/SgYFsEWK/gmRzzwWkHPbm/1YH
	 HPVXqrGGC0rMxOcNhFFeIPkeSD+LzDUXwDVvcOTmUv/SP/FvCUYRoG9uVVr0spbOf0C83
	 qjBJt3JbLFn5rxeHHzp2Ec1NISJErsZ7X+Py71GrUl2FDCyhK3Jw+aqAbbii4dNFrUGtz
	 oCvVadXtq2j01bSxzRlv+qkqch3Qt9cDHSDoQ4m1eZV2NEqW/gksqAvQLeCRsTbZioHND
	 viRD4Mns0WaFzjyO7ryFQZLkhhVxZbibGVkYrbq2KsFXDWJi8gK206EREbmt1DZnBzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NC+OQUPE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9238F606A326;
	Sat,  7 Nov 2026 12:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NC+OQUPE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32021F0089F;
	Sat,  7 Nov 2026 12:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794056165;
	bh=UCE3NbaID3E5C798LUsUaYaoCronIRnRlzf++jSypMo=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=NC+OQUPEUbDREDxaVQgMtnSYRSxbMOCOUEHTxIwXwojL+K4F60FAIKzlEfw9J0Vgp
	 QK875kemnk6CgPCoIKmYK1sF/Ll1zZtVLNFSt3kc4TFfP5mtLlZw++mFqo8rIA1Qyg
	 rMoVxGzhzs9ytKPPwhwmuKZAQkwOm3tQQodHRL8kbXIDcNXYt3VAMd3XRIBEzEKMhd
	 MjyBl5fcwPWwRZVK/30kkOZjLN02DBuYkv70WdrZuJHi18WmbOQluBLdM0/DZ+4iM/
	 /keY7LNOyJ48oCeROKbCe+QGo0AcblAtHQEQ21+VvpBaBzp3RpJT8clqKtDZGpFW2M
	 Id1Ey2L/1zbfg==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 70619299A85C;
	Sat, 07 Nov 2026 12:56:02 +0000 (GMT)
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
Date: Sat, 07 Nov 2026 12:56:01 +0000
Message-Id: <179405616110.3424803.15364430590351990795.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1394; i=broonie@kernel.org;
 h=from:subject:message-id; bh=v+xm3DXBEMWN0zz8hpvA0YXrjsZ9eSJnSciEEYdjm5Y=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLeyz+SfND9uDt9p9+Kztg5R5sfGR7JkzsqbV7mwOqvs
 eeJr/7BjlIWBjEuBlkxRZa4LO6X9SWv1/AdXNgGM4eVCWQIAxenAEwk5ijDH66lM7L0VLK43LWS
 ar6tkHCbHGdx4shf1eWGZad/mkq9ymP4zXbS//5rP69cj3fV9j7el6SEC498jf+3aJLNFeXyF/V
 XWAA=
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
