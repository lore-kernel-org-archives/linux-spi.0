Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623390;
	b=gv1Gonhhtj1VgHDc6L1IAfehw0ulGWNQUPDbCPAUzCs+ASwxcAa22u9Bn0RZEUvD6ijx
	 aOFl1niaN/8d2hZfap8GwKECjB/BRQikt9yMSqnQT8CeLozMzAXNc4J/8E1Xt0oIgNoQN
	 bIdRTbVcL/Ei1uEJ2wo7M2ipWiH2kbnWSqjYQqvBbBwfr+mVNfkhCr2S2Hx8N/z38OkAt
	 6hvMi/hqXrOwCKVrgZDJFXJeLaHo16Qh5MnDycNFCgxZShUpmhopVq40wc2mzqinOfa0D
	 jQXO1FYky+MtZzJGF0Xzjoi+x3ouahKfarTIvLfMXkEPZz/TkD+ZlxAmGrD9duWS9yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623390;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=nmPyHrdHeNFlQD4qR4KsRRkb7hhXkl15EJwk4XfzXxA=;
	b=5fNugcOYMHdhN+nc+M1nnl9GDHogppDI1RVtIuI6TC1o6HZ3X8lRXKg9kwDk9h2irQVb
	 gzyO8BI+lWFbSZXvydama3PEeOhc7/P3cZbNo/9Q7WQLIYWiL8BTWT3SxYtL32xAtsPPz
	 W2/wQIo/JWlmBXYC8yMOGpcqQqvmmeWJY+uXD7ZekdoZAbcyfLhrruAJzMfpOBa+L5vQc
	 4CBePoG8/21J6wD4pqLzNx8s0slrSkQuRgQSq1y0/Biq1rHJhKQxGIzuNprMQqtuIbxce
	 K3zv6r/5fy76/Vnw4vduhHAVswFfxWWHRcAw8Kn0Gufetzh4xLq7vOOWgbIdo7MEvvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KaDPSKWx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481A260A3811;
	Mon,  2 Nov 2026 12:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KaDPSKWx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD131F00A16;
	Mon,  2 Nov 2026 12:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793623390;
	bh=nmPyHrdHeNFlQD4qR4KsRRkb7hhXkl15EJwk4XfzXxA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=KaDPSKWx7h51Kmy2dMBx3z3T3/lMb/p0jV7jc1wieQ54CNL3oFU64E9xCR1SmfoNf
	 xpx6MX259PwI3VamZ9XbE07aH0CteLmkJOreehCry8BXNHgh21xhNfuSH0W1orrjtJ
	 OC1iTc/ZFTOFXo7yn85r3XuVN0wkRp02sccWzVRow8TocdcROyd2sdE0NQ1cyacF+p
	 5PNbRjUWaiZ7egdJiyAvJ/D9iXQziWY2EJUauG9iq7ji/aLGgzgqjgaEqW3+0RnPR3
	 3lqo9LShb5xNGBN2nRfC3t6CZb6fj8xE6YCJhZ4S2NQrJESayDVx6Ew7nyNfcOC+9A
	 A2L72Q19lURdA==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 53E02231054D;
	Mon, 02 Nov 2026 12:43:08 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Raju.Rangoju@amd.com, krishnamoorthi.m@amd.com, 
 linux-spi@vger.kernel.org, Weibin Liu <liuwb@xiaopeng.com>
Cc: linux-kernel@vger.kernel.org, zhugl3@xiaopeng.com
In-Reply-To: <20261027021340.914399-1-liuwb@xiaopeng.com>
References: <20261027021340.914399-1-liuwb@xiaopeng.com>
Subject: Re: [PATCH] spi: amd: validate FIFO usage before executing message
Message-Id: <179357647437.1716893.1993598078742812854.b4-ty@b4>
Date: Sun, 01 Nov 2026 23:41:14 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1120; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Ldxr/tnh85SVJt4VHczBhqP5ie+DAa8XHF0Eclzicv8=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJetMZsyZ3OnNQifzv5pWXZ1lZBjyPpxqLboy67KpVIG
 Qao7DbrKGVhEONikBVTZInL4n5ZX/J6Dd/BhW0wc1iZQIYwcHEKwERCHzP8jzk35UL353Nxi/1i
 pQqDM/w3n9+pJ9PdwXY6+qmSf91UP4b//j91rG9FL+b18zipVvjp4lbflpBm72yRSJ6/52K3C0Y
 zAAA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 27 Oct 2026 10:13:40 +0800, Weibin Liu wrote:
> spi: amd: validate FIFO usage before executing message

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: amd: validate FIFO usage before executing message
      https://git.kernel.org/broonie/spi/c/aed0c7475d6a

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

