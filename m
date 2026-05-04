Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AD1317143;
	Tue,  5 May 2026 01:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777943322; cv=none; b=JjXaaiJKV06wugqBYTsmvXaxIhgrQrosLWcjCZmBf4PEsb6IlxEpKJWH0N46sTMKOJ9LUMhDLIDPrwA0VQRXFFVYSAFhcI8XXYzTIPxDqJmN79DX6EN50qa5e7qzan/Aqmw4RJyv2LeEVETqhEbIk1e/en+c3eKuiRSqiqtXj+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777943322; c=relaxed/simple;
	bh=S4D4xiXgQHI7j63fa70zQ8ojrWnq9v7eBETq1Yu8RsY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FCIDP/b1lsg1nH3D3mIciSE4gwY2T/BfzMRUeMBtmHTPKzZP8Rg/W8HkkWwTf4iZVW9PmPbDefrOHQpSZr2bfD3Sbq+Nh45V/q50fmSV33FfTdLdv2ENzlfxP44WI6FR7VHfZIFdIDk5d8dF/w163joKb2HbLoH/n+Po0Oct4IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDY++W8m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDY++W8m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2633AC2BCB8;
	Tue,  5 May 2026 01:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777943321;
	bh=S4D4xiXgQHI7j63fa70zQ8ojrWnq9v7eBETq1Yu8RsY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WDY++W8mVC9vDzjSia9MPrZ8yRH2MksICNrMhfUN5ZUjEftDW7lMoIqwFHxH9V+2m
	 9kIwycayyLY6BwPv98+Dc6Dz3tllH09GWeXt1QnFgkUUJiFbghR5T6goVbLqEMz17+
	 sj7yeDkkyIJR1Eftp+ke4Z+ZgJp6uphTxJ/hGNDLbKRTOgYpiInfU7x9OdeqmGaLwR
	 3ZGHGSfupAXPSApHkn3KADgjjkpHNO5YvzCmVdldacPRA4vPaA84N/A3AWnbqU4CYu
	 kqD4z6cOYsNyBdzOSLmWzPfxsw2V6JTlNH2MhoHfEBzSnmRt8UMfR7GoPV/cyV0LVM
	 nHudAlBVmq7Ng==
From: Mark Brown <broonie@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 Cyril Jean <cyril.jean@microchip.com>, 
 Valentina.FernandezAlanis@microchip.com, linux-riscv@lists.infradead.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260430-levers-defiling-00406e391c5a@spud>
References: <20260430-levers-defiling-00406e391c5a@spud>
Subject: Re: [PATCH v3 0/3] microchip core-qspi gpio-cs fixes + cleanup
Message-Id: <177790098872.458539.9606470232934881996.b4-ty@b4>
Date: Mon, 04 May 2026 22:23:08 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1722; i=broonie@kernel.org;
 h=from:subject:message-id; bh=S4D4xiXgQHI7j63fa70zQ8ojrWnq9v7eBETq1Yu8RsY=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhsyfzuLXf17Vz1pgfFPfZ+GmkGLb9FRWWUWZ5ynzNIODI
 pg3S2l1MhqzMDByMciKKbKsfZaxKj1cYuv8R/NfwQxiZQKZwsDFKQAT0TjK/k/r9VtzVWcft6cb
 w67n57O17eE8Hiov7rS4LXO2xs26O8bGoo/W5Tfxrc6WabuoVemR9T13xzMnszkdr6InqnFFrHP
 T09+X08kfP/XbY3H96321Yjl1HP9meSnF32ivl7HhDAj1fpJqHS7n6vmJae+s/+UHHolNPMnmFl
 Mc2tguuG3ejK6XfQsff3r9WGKngP5Hz2cWgT67LohrSpte1GTgCgl9XFXb9OMJW+hstdIlSt+a/
 dpYzLdz3f9dJFzGeH/mea+vBnsarZeJlkvmT3vEMb2HvbpwUoTbom9llsrTfKeqyeeEvp9j6/7R
 8P9D/rt2F1Y1tdtPqd7A0h/FIN1812vZlGbR1BKD7f8A
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 30 Apr 2026 11:10:17 +0100, Conor Dooley wrote:
> microchip core-qspi gpio-cs fixes + cleanup
> 
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Hey Mark,
> 
> v3 with the review comment about the core handing CS_HIGH dealt with.
> I noticed that in the same function there was a "raw" BIT(1), which I
> replaced with a macro that the patch was already adding for use in the
> setup function...
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/3] spi: microchip-core-qspi: control built-in cs manually
      https://git.kernel.org/broonie/spi/c/7672749e1496
[2/3] spi: microchip-core-qspi: don't attempt to transmit during emulated read-only dual/quad operations
      https://git.kernel.org/broonie/spi/c/eb56deaabf12
[3/3] spi: microchip-core-qspi: remove some inline markings
      https://git.kernel.org/broonie/spi/c/0b2eb1f8473e

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

