Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED41455D895;
	Wed, 14 Oct 2026 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791995836; cv=none; b=Wa7uIeYwILiZxj/1AQKH9vuTZaM/0hjFJ0WC1/h+ys+HlklFstTK+Mza+NWb7zoRetKGVbsdnHbO5yq6Hfb/snarTCc+hsMXEyLmvZmg6AFwJHyHIe749wl040ihpfbD2Ao8XNCquk6ilfoWecj1J5i1rRrCzOX4qxlq4JgkOGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791995836; c=relaxed/simple;
	bh=uurGcHzdzFzhWnJLh1CqNlIoZwhFSdzzQPlGA6vu2xM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Hr7rHFyw+Psyjdi6cEvaMlwkhQBc34Py1+L9fwpQhg0Ry7IFfHyQXFq7FkNPwsQ3pmfY5tq/vKSFSpVmz3D/ls1Ks5a+zl3q52DFy8c0rbyd3djb7K5aPI3gGenOWoVEL9qCXeoCiidjcHt/5if7jBjmEDdHRdpBYKy6fCxDfDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbN9/1KK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbN9/1KK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E481F000C4;
	Wed, 14 Oct 2026 16:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791995834;
	bh=Qh7JBX0K+5twpqHU/cJbIIn5dL7/JpLSLNjwQd3bh1Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=WbN9/1KKPr8lj0U8y8GSfR67QR4mOCh6kPH1aOBIjXrPGrIjDdNnrpy1taH3d4+qQ
	 dcHckBQUIq+Th7NbPty3IP7G+EjVzoxxH3f77nb0WzCpdAQ1zejr2FEpS2TPNQEYYZ
	 L2hRTarWowYbaC+gCOeYvSnaLW8yphBRsmbOwDbAmrVzWjSVKxukTEqFNLPuizeQDB
	 ZL+Yz6MDiOmRqWe43NpHZAe8n+uG2ZKtOTBTQsN2vJ+v7+6c6/cEaiNPvtiErwvRdm
	 JN8eXhYYXld0WN3hisnOySchSIKg2N8lM8LV4Q8LkpctAEivFe3FCwLNeljIQdUbvl
	 mc2jV1sjBtzDQ==
From: Mark Brown <broonie@kernel.org>
To: Joseph Steel <recv.jo@gmail.com>, Jisheng Zhang <jszhang@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261005151739.25233-1-jszhang@kernel.org>
References: <20261005151739.25233-1-jszhang@kernel.org>
Subject: Re: [PATCH v5 0/4] spi: dw: use threaded interrupt
Message-Id: <179191308596.42298.5738197342460103107.b4-ty@b4>
Date: Tue, 13 Oct 2026 18:38:05 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1824; i=broonie@kernel.org;
 h=from:subject:message-id; bh=uurGcHzdzFzhWnJLh1CqNlIoZwhFSdzzQPlGA6vu2xM=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLOr9++5WhBUO2KN2k2tl4ztr+feYpR8K4n47Z1vxO1v
 12Wmi32vKOUhUGMi0FWTJElLov7ZX3J6zV8Bxe2wcxhZQIZwsDFKQAT+X6KkWGu2OXzYd99Xf9z
 fjzj5rLFVbxtUfOxbxuZ9bom8ZfbblnCyLD+s9DdCgE/Vw7xd5npV1+ZJpmyr+S0ucv3LNx+xu5
 3iYwA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 05 Oct 2026 23:17:35 +0800, Jisheng Zhang wrote:
> spi: dw: use threaded interrupt
> 
> To avoid blocking for an excessive amount of time, eventually impacting
> on system responsiveness, hard interrupt handlers should finish
> executing in as little time as possible.
> 
> Use threaded interrupt and move the SPI transfer handling to an
> interrupt thread when non-native CS and host only.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/4] spi: dw: remove useless dws->transfer_handler check
      https://git.kernel.org/broonie/misc/c/3e3d3f96213d
[2/4] spi: dw: remove duplicated "!rx_len && !tx_len" handling from dw_spi_irq
      https://git.kernel.org/broonie/misc/c/ab30c5cdf457
[3/4] spi: dw: restore previous irq handling behavior when !ctlr->cur_msg
      https://git.kernel.org/broonie/misc/c/62d2ce4ee2f2
[4/4] spi: dw: use threaded interrupt and optimize the threaded ISR
      https://git.kernel.org/broonie/misc/c/d9d0f5b84cc3

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

