Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1074570EE;
	Wed, 29 Jul 2026 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331953; cv=none; b=tPlajJyZSxCe/URdu3PFSQbhWbUtQGaDdKdpWlnNVaRM67jxrH+7T55UNp/AqRv7mkJoznlHpToI8rU1KZWbp5JVE0sLofUCFnk+rwj6abynEj8WZ4p3T+cKdEDat28DKnLvEq7XQc0jTm4kGxBW0ZZfeHwbaQyVYQEnFnoOaJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331953; c=relaxed/simple;
	bh=sYO3OQMt/+Stif8+cNPvSfMwor9ljLrebznuS3yEydo=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QQrKzVojWDwFgMplnS6+5oNEbIVCJdvqfjUzMCZIdV/nwD4G7Zf9m6X6r+vC8avKyUvc1OAS6EfSHEQOpluXjLtUIOHYRiYLbxVBvT2+EdsnKo7NC3pyhGzHcB+y8mUsNE7rp5eWCEsxOHiGo/hOj7/NGtslpLTVUqOX1lxYQ8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYqI90r3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYqI90r3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A271F00A3D;
	Wed, 29 Jul 2026 13:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785331943;
	bh=f3O03q8g4zY3UkiuqFzkFOLvkkuY7KoV7rgZS+bJHG0=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=hYqI90r3Pj4axo/IkXm4UdGkdF/0ickGExddREMrxm7OlQ+37epBduCM//XKLqwWk
	 EIPK43P7LivY4I/bXRO0rN28k+jxRNgAdOmIrcIK4JTzElC/EEPzfyZKmQQWAGH7Fl
	 TmS25fepzui0nEEM0zT+Ywl+/sqo+P+ZwKwhDDi8LfSF99ru4Z8SSMTKIrxD0ojrLg
	 9xyBFLDbvQr6qAUk457ci+3X+psX9yrD1kx+Mo2kWh1sLDo38Y6xy48kMPRUIIVVBD
	 EgLkxvTyPIwctOULLnLe8oVfPJ60OJuaOtjgM1Ws6WtOJHNQvk/lIeGmuUAiVuQzcn
	 Bn+OpOMOoZzgA==
From: Mark Brown <broonie@kernel.org>
To: dlan@kernel.org, elder@riscstar.com, guodong@riscstar.com, 
 linux-spi@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <cover.1784527556.git.xiaopei01@kylinos.cn>
References: <cover.1784527556.git.xiaopei01@kylinos.cn>
Subject: Re: [PATCH 0/2] fix and cleanup in spi-spacemit-k1
Message-Id: <178526212208.13644.13743864400074628954.b4-ty@b4>
Date: Tue, 28 Jul 2026 19:08:42 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1509; i=broonie@kernel.org;
 h=from:subject:message-id; bh=sYO3OQMt/+Stif8+cNPvSfMwor9ljLrebznuS3yEydo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqagDlvAGIROrYOOVdq9xw2Bu9XpOSqAvBUu3xE
 nSvFgs/iIuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCamoA5QAKCRAk1otyXVSH
 0JloB/9mrloYBsxFc3DmMt2jQDXe/kbgXHKA62LBppIHoKvnp5kQrALUQw4TJ38655Db3Jl0BPe
 aiGoPaCdkFaxpR4VzRDXPX44p1ujH7F+7ql+5tz+/KjFKO1bWH6xFn7UpouVDOFWRpKnah5hy8Z
 55PnHDs23MXAvG+OX453G3d4BnDwPftT4/TPoig7QJjPGSeunBRR8Q4qeYNsrgdopqDCGhR8DBD
 liUzmnCgdMz1MMHGzuu+nqZbrr4dQdHK0LJ99GdCGR04lQp0t6JMUbY7ioMvmheZ6QguefkeF3D
 xDgU8XA4lCw2TzFUcWEAMcR6LPQ63OFp0XQ6v1QxfdhCu59H
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 20 Jul 2026 14:08:42 +0800, Pei Xiao wrote:
> fix and cleanup in spi-spacemit-k1
> 
> 1.fix TX DMA descriptor on RX prep failure
> 2. drop redundant dev_err_probe() around irq
> 
> Pei Xiao (2):
>   spi: spacemit: fix dangling TX DMA descriptor on RX prep failure
>   spi: spacemit: drop redundant dev_err_probe() around irq helpers
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/2] spi: spacemit: fix dangling TX DMA descriptor on RX prep failure
      https://git.kernel.org/broonie/spi/c/8955fbad8aad
[2/2] spi: spacemit: drop redundant dev_err_probe() around irq helpers
      https://git.kernel.org/broonie/spi/c/79052a6a6f5b

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

