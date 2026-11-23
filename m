Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795523326;
	b=RJHIkaygRnjACOHBLCDbci4mo6z4BGD8XeQ0IPR71ztcoTW68MW/ooobnX3T2y7suSYR
	 Fsyy7wIfXYxnNuKVZqriofjIUGMo3eXf3XUj7iDn73G6PHnpqxzrS82yKZMBMbqSFhWsR
	 GpGL3NJJyfanTMRAg54cMLUA9ry7iyi2TLGOh7h8cjP9tHcJfq3QdBWYoeXGDtUijxBnl
	 9Z80fclHGxBWSMKdSvdrwOzjtU5HXk3pudt5TOOa15uyoryAaFcfxzXKW4jSy/pGDNASo
	 HdzfUGiMP3r8scUIreMIGK4FJTz05p/1a3eIT2hup4flVtvfK9fAIwDF7ZjvkkFhCNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795523326;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=/myQxVwBGatEya0bvaatkH8WGVvA8hp8Uie/NDgTxTo=;
	b=3RZw51jS9MlyRIT0nrlxUfkjtq3VoeYecKxLoX7mHxB/bwWdJHnrJ64MJIMr7vT4Qxow
	 Do6KJTLWmbPsTp2QE/vfgveVa1hmR4m0Ewi/LFVGCQgIiG3At3IOOUUFwf0NVw+pn79lz
	 oNqeFhUc4yhM979xocwLc7eOSrmojC0lus9RwkWXjBW0x4MlL/qkvLeBAC7rOPiibnrGS
	 KyrylE85nJ3G3kggL1g2SoHpo1JTjCjiWBX8t+z+HlzIAUFknLp+HYOrUhDgUBiQTCDBJ
	 fdwmpIE0h2YOSVZfUQwWs9i1CZukmcztReyeh+atFAxGmKP9W1+FjZXI/AUOd2KMHww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FJI8Ez1c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A448606A336;
	Tue, 24 Nov 2026 12:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FJI8Ez1c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4331F0089E;
	Tue, 24 Nov 2026 12:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795523326;
	bh=/myQxVwBGatEya0bvaatkH8WGVvA8hp8Uie/NDgTxTo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=FJI8Ez1coksaOFZBl+Tt+V0lzPFKxNxU8ifqRlBElxuj0Rwx5vfAxqrVbhJzfhB9g
	 B4JC0/DyxVR02Lg3ZVnvEgM5PDeNUsLXLgUdefMEaCPzhEQ4158/nM6qdwS+PcpaXI
	 bjMMgg9YMr/Olw2MBHs3a/KrQXKscPuQqe5oP0oGnsFb9ZyAfrzgmZZZt4mE6LVuLL
	 zLI/nRffhxaDNnQRki3LRsTiwyuC3HbgPwjSnMNl9fM/kNmj/JuZ+cEZDlt0Z8+Dm0
	 y0wxJCrSQis2sgHBQAn2XFMuM/uLm1NPstJ82eJsOO830+F8eUCQUPhPrWftCP+T1Q
	 cmgq8FIMr/kdQ==
From: Mark Brown <broonie@kernel.org>
To: michal.simek@amd.com, ranjit.waghmode@xilinx.com, 
 Srikanth Boyapally <srikanth.boyapally@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-spi@vger.kernel.org, git@amd.com
In-Reply-To: <20261115-qspi_14_11-v1-0-23425ed177bf@amd.com>
References: <20261115-qspi_14_11-v1-0-23425ed177bf@amd.com>
Subject: Re: [PATCH 0/5] spi: spi-zynqmp-gqspi: Fix remove and IO-mode
 reads
Message-Id: <179546075004.25092.12167808449795395139.b4-ty@b4>
Date: Mon, 23 Nov 2026 19:05:50 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1880; i=broonie@kernel.org;
 h=from:subject:message-id; bh=3CsvrBpOzx0ATu/gP5GIgfz4fWC33UG1X5kPugufffQ=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJZm377VYpxr2FqSumznSm0gHFxaYdb7MZrZfcuHVC60
 WMRrHuwo5SFQYyLQVZMkSUui/tlfcnrNXwHF7bBzGFlAhnCwMUpABNh62BkuH1HfuWLSQaW63hX
 H/Nk13vBumPJ3uPbH5+bzftHroB70ylGhktTZjl8/vrfeqGjicC1hP4Ui07HL8bRK+9y+0wvdF+
 9mgUA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sun, 15 Nov 2026 22:26:39 +0530, Srikanth Boyapally wrote:
> spi: spi-zynqmp-gqspi: Fix remove and IO-mode reads
> 
> This series includes improvements to the ZynqMP GQSPI driver, covering
> unaligned RX buffer handling, controller shutdown during remove,
> interrupt and clock handling, and RX FIFO draining in IO mode.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/5] spi: spi-zynqmp-gqspi: Factor out zynqmp_qspi_disable_hw()
      https://git.kernel.org/broonie/spi/c/128166704b97
[2/5] spi: spi-zynqmp-gqspi: Mask the interrupt before gating clocks on remove
      https://git.kernel.org/broonie/spi/c/e822c0e154ac
[3/5] spi: spi-zynqmp-gqspi: Stop the controller fully on remove
      https://git.kernel.org/broonie/spi/c/1cd11b56fc3d
[4/5] spi: spi-zynqmp-gqspi: Drain RX FIFO on RXNEMPTY in IO mode
      https://git.kernel.org/broonie/spi/c/bfc9ad332132
[5/5] spi: spi-zynqmp-gqspi: Use IO mode if RX buffer is not cache-line aligned
      https://git.kernel.org/broonie/spi/c/07edbea685d7

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

