Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623386;
	b=VmH0hXHw6N9YFNDAnd8lLuXZbr5ZC662LmqTNjBig70C+9zinb3soSjSaW0EmHjN6cYB
	 Np9MgRe72S738vLlRO83f93uSiTybsaZ/bUV5da8A+7nBnw6U6ModohgidijmXPtkC8ai
	 f8VnHT+rW2anIPkYRG+UMy92LDUrkdkWEkHiDrQvgiychkg7unsIenGIftYDCWImd24D2
	 RF/vZ4+U1GhLAqbr07869n0jRm8+TazprSaLQDSacfZc3POb/a2HA6MfTdNBm40I1WkN/
	 gYzftGmJi1q8jYG4ev0JSf3KWpsTbH+uDyzSBigzTz0eGuBXXBLQxAJlAfHXlmanJsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623386;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=1Pv9Wz/6/Mqcf0Mxk5niBDMqlILELai2f37Zx79Mm6w=;
	b=oPNH0mv/36rJNrm9qVRYLYjuozsRaBJ16eJ71kaRvwnV3FGXnA+8vecB9UvqJs88efz3
	 gnobczyTqSwhv/OsayWR7ky/CGGM2ZipSsPn37A9YwuXEgLxJy/qZlX9Z/ydvCdoT0SD7
	 O/dfD9HFm2oajiBmSdcyLpXGzJ6aQKryTMewy4b3BK2KVrHg4MVweylS50BHAgQr+Ttj6
	 FNuBAwMM/9BwBi314xquH3yH9BwPkvNv8HEVCZqX7qP7bHsdS0zBNErE8fQnkz1Nd1vjk
	 KKz+jikE8JUPpflW6/d0yiL9pLiueBH7N0A4I0vDYsg9H3a0HPHfDyB/hHL0kk+muwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OW+ccwze;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF62D60A262B;
	Mon,  2 Nov 2026 12:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OW+ccwze
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2ABE1F00A17;
	Mon,  2 Nov 2026 12:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793623385;
	bh=1Pv9Wz/6/Mqcf0Mxk5niBDMqlILELai2f37Zx79Mm6w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=OW+ccwzeSyuRix3iC5gkENICZGxYQCm7Qlz0ui129oLUXxIz8ueY2jPo0VAuQu2/L
	 Jrs42XUc/S2uDmfqToXaZdIbLBiJBhhfU9ghvdTCWaYj9Fo/i5jbJebC96IK4m2esa
	 QF7vSrdvnbbZsOH26f3/FjhRYbHzVDj4eJK8Shmpr0mLP1rk6oDow+7yHg9chQi9Ab
	 a8J//eC3BkeFsHFTYzDQoGat6nsgsuPUkzzzktjtVC/G3ZccJzq+auoZnFK8H7QiZJ
	 I9Ny3Qu8poM/yTOXXkvH8Tcnv1EuxDywKQ4BLeHAv4MTR9zgVwN2ZgS69O7yPTDHNg
	 nU2GXAPYNP0gg==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id E02732310535;
	Mon, 02 Nov 2026 12:43:03 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Chunfa Zhang <zcf1810@163.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <179334613930.227576.16591083055909656623@163.com>
References: <179334613930.227576.16591083055909656623@163.com>
Subject: Re: [PATCH v2] spi: fix zero-length scatterlist entries for
 vmalloc buffers
Message-Id: <179357789840.1716893.13299052372879866631.b4-ty@b4>
Date: Mon, 02 Nov 2026 00:04:58 +0000
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
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1134; i=broonie@kernel.org;
 h=from:subject:message-id; bh=dL0BvO5bJG1Wo9YBWphrOVc/kNJ8BgiID1GqRGqgYBo=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJetIYz5O5Z3Zx+fW03f8Thoou8fUdKTYpi5Wu9lwYfW
 9j6qWdLRykLgxgXg6yYIktcFvfL+pLXa/gOLmyDmcPKBDaEi1MAJsKkxPC/NC/qBd9e2YPztXvf
 193Krf9juLggiF/Td61wyrvPeSlGjAxn7W+c/85U+TliPXNrTH+8zB7GhQqRP2Y9aQ9Rui42q4c
 NAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 30 Oct 2026 15:42:19 +0800, Chunfa Zhang wrote:
> spi: fix zero-length scatterlist entries for vmalloc buffers

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: fix zero-length scatterlist entries for vmalloc buffers
      https://git.kernel.org/broonie/spi/c/daa9bdb942a6

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

