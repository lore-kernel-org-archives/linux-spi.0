Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D22136728D;
	Tue, 11 Aug 2026 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786470915; cv=none; b=k/h8uCZk0Pmh6f4YriGrtBE9r+sXum2nMHCz0Xy3kqGJQYaFWnMY8R61I2Q0Pg2Tr26eKuKLcS1ymPv2mAPZM/MN0Pj73eFfA0FIYqR1Yb8NtcDnVi1BYIzcpvouhDTdI1BbJInI4BnA78C77a9P9il3if4xRl/2kNMXBaCA8DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786470915; c=relaxed/simple;
	bh=7HyzjH+CUTTGPErOFzf3nAnR0Xils4AtlIefRaBUdlw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=u/2VDhfoNV3arW3uor/Wo61YnG1DFP+ExFYntj6uRb1lAJYpc8GL/JZ3FfqNq84KUPxGkPvEbR46E1YA/kPn3mR4giyU9fYx6eKxQmjUJVHq3cDGtFSn6pGdnJR9mrDEzSFwy+8rnAcFBTh0d4Y770p649aJ+/tlqEQcI1TbNWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7VKC/AX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7VKC/AX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308781F000E9;
	Tue, 11 Aug 2026 17:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786470914;
	bh=sJCVcseMsGHH1jluMOLr3srtxo60ge4sSxKLDTGGAaQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=N7VKC/AXemGLtEVc8lwMTTSbz+x0ijEYHhlLPCgirySG+/Q34QryCeqGpSLljiPEQ
	 W0xuv4kN5+/L0KbHlh1ZA4V1n31C6tviYBeHfXB5RRWFIuVsXwJkv9JrQHqt59Mu33
	 jG9/ZTk79XOq1AHyHyufJWQyIoM2ngeVz8LLhXFZI1lA4Z1ILGyrfPYxuHjpH6kS5d
	 GP92siDAsWGK1YaReh0TujjbGhOn3UIQ9oUlW7OETprXcCf9ZrD/kmLKs53k2neIV5
	 ayuQwlHaAIsP2fyBevLpAyZJisyEeqSggBPNeIT2gvOQXiQqwiBfuhf35qFf3NCviE
	 3/bVMbtceyurg==
From: Mark Brown <broonie@kernel.org>
To: Yang Shen <shenyang39@huawei.com>, phucduc.bui@gmail.com
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260807103848.46315-1-phucduc.bui@gmail.com>
References: <20260807103848.46315-1-phucduc.bui@gmail.com>
Subject: Re: [PATCH] spi: hisi-sfc-v3xx: Propagate errors from optional IRQ
 lookup
Message-Id: <178646294663.119683.15361969604878272831.b4-ty@b4>
Date: Tue, 11 Aug 2026 16:42:26 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1145; i=broonie@kernel.org;
 h=from:subject:message-id; bh=7HyzjH+CUTTGPErOFzf3nAnR0Xils4AtlIefRaBUdlw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqe2IAkXY0A/yUlHde/csJUfqjL3noShko2M2zh
 XYJIJqNhH+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCantiAAAKCRAk1otyXVSH
 0LvCB/93noNaeN7a62nlP8dL5mJNVk/hAmzyjLoUTk10AVP58ccIC0UolTGoAC3sle21SycfLuq
 2mBCryG/Jm+q3hqpoMvtEr4kE2+R5qaCCNyZXzFgaxpidQfsLDzMfxdNN7RVfs/FOL5oFLg2WSY
 HcW8We68mIFARY7IxjD7siQJRNlCFYBx1CTOeqrm2YiNqP4SneVRgxAW3b+D4YvCxK/b3EaM9ki
 LmD+gHiQndHBBR+vkkP6V6nbsLzJRm5N1R21y1FH2H+WpKNN+iftgmpdc7wA0ZVP9U+pSFNTwap
 Y62Xu3JvaAxdVm/8xRu9lus7goqebw0ZpY4zBBJM3SX9h3wX
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 07 Aug 2026 17:38:47 +0700, phucduc.bui@gmail.com wrote:
> spi: hisi-sfc-v3xx: Propagate errors from optional IRQ lookup

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/1] spi: hisi-sfc-v3xx: Propagate errors from optional IRQ lookup
      https://git.kernel.org/broonie/spi/c/e4702b6ff30e

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

