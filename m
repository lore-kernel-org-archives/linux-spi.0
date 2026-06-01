Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D463D3D06;
	Tue,  2 Jun 2026 12:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780402067; cv=none; b=hp7Hpl51/ClbsRD8ga7KIvMNIi6SZgd8M+0vBQ+TJ33f6EHb2ZDgVOYqP/ef7iYG9qQUD/rwej+RUm/2dlIj2yfH3zYwkd/7yGFFciT2bDuBsrT9Z4HVeSizPwuLOX1NChwkHWnsVN82HgKBeTYUCOx1LOvsGS6Do9EUh9AdE+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780402067; c=relaxed/simple;
	bh=znm/xYFPPzIp+vZhak+uytiArf36c+YjCXqqixihkXo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TMlCPTuRtWQ1B8GQpcebCV8086N7ER7O66dp9MnziHnC8vAVxc+uTtdPj65ILPHUq0XY+AQe8DXbepwrFYycOvp7YCaHBEHh/uz6gEmbL/aBJaAaJXReLe3uEzzQABuXre9+uBcoNXs5x+xGP3F9KRG0LqYhgBMMfz6/lwcocQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQHx7N8j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQHx7N8j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8291F0089B;
	Tue,  2 Jun 2026 12:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780402065;
	bh=DHPDiqn8LSPaxr2rasAHtKAcGxdyURFmrBAgPFEOvQQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=DQHx7N8jb/ECUwPpqoMELX73Ct6BFdnEm2iZ/HisdYy0dUb2VbdGECWXi7MuCYy8x
	 vUoFowLeF1alpi7LhQ3LbqbSV2enwyrObEoXY1pe34tG6+KkaPpPaQ4+7dM7bGXKTq
	 KmWYO/vDy/KH5Tm9D1UOC90Vb5wn2u0vEk6Wzq2wMloEIEYP/5ZaBT9hj/iyXpr5M7
	 EAMldCkNejJo0C9A/c2hfTiw7bsSNhec3cT2/wL2Ltie9vzBHH31CrwLRmXNJMXObT
	 DPQIE2QPmTtWHSvxgjF0ibLyThRNp2tRkQr4nHG4JlLYUG6f9IG2qJNk2Do4xhQAw6
	 95/wtQr0EAszA==
From: Mark Brown <broonie@kernel.org>
To: Frank.Li@nxp.com, xiaoning.wang@nxp.com, 
 "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Carlos Song <carlos.song@nxp.com>
In-Reply-To: <20260525062357.3191349-1-carlos.song@oss.nxp.com>
References: <20260525062357.3191349-1-carlos.song@oss.nxp.com>
Subject: Re: [PATCH v3 0/2] spi: fsl-lpspi: fix DMA termination issues
Message-Id: <178032289378.44654.7682097134134835987.b4-ty@b4>
Date: Mon, 01 Jun 2026 15:08:13 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1568; i=broonie@kernel.org;
 h=from:subject:message-id; bh=znm/xYFPPzIp+vZhak+uytiArf36c+YjCXqqixihkXo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqHsePYfkXsOt+wvX7GJE3qdNFCCqZGMOQ1s3rN
 ijPAs7swa6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCah7HjwAKCRAk1otyXVSH
 0FqUB/4pBVNlL95oXPptIbbXIwmRvSSRqvvqXXk+SDlzSqhMker0XfkpQ5nY2aIbb2OMe2g06QJ
 tnNpkOYmdEFNV+ms4KXeI+QATv2qE3OBmkOzRv/fKdC9ShBRJgpp/Jx29IUK4K/pSlZBP1GYDfI
 lnJj99ARO8BGmimOYxgjMDRD1OHhgCjzYF+yJiR81ONLNCcUn1isp+MZxS7fs2hn6TuscudH3kW
 PkC2uPX/5+UjzsOMEK7lRKl8vljb4bfeOmqVWepcTU0SsXmq1gM3anY2KuTpCoHHLEncddTXDtf
 srSWInLSLrZJfJ8hDC2GRcYtASKb8du3BNNC4JqNjsE7lxsu
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 25 May 2026 14:23:55 +0800, Carlos Song (OSS) wrote:
> spi: fsl-lpspi: fix DMA termination issues
> 
> From: Carlos Song <carlos.song@nxp.com>
> 
> This series fixes two issues in the fsl-lpspi DMA transfer error paths.
> 
> Patch 1 replaces the deprecated dmaengine_terminate_all() with
> dmaengine_terminate_sync() across all error paths in
> fsl_lpspi_dma_transfer().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/2] spi: fsl-lpspi: replace dmaengine_terminate_all() with dmaengine_terminate_sync()
      https://git.kernel.org/broonie/spi/c/e703ce47691b
[2/2] spi: fsl-lpspi: terminate the RX channel on TX prepare failure path
      https://git.kernel.org/broonie/spi/c/01980b5da56e

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

