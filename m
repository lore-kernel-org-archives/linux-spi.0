Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0152FFDFC;
	Fri, 24 Jul 2026 00:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784854755; cv=none; b=lOFL3X5qzXIppHBAKJC1YarAOUy4OZRT+D8SVWs5evgLkOQHGSt7C2qN4iyTNB0rCG38bSAlal5tG0cGNmcnuN04F0OfqAzFaITP3c00KQuxukuTq7OdiJ/AfkLNnp3x0Ck78JS8ERD6QicnnVpsKjZ8Ukgs3W0LtldB62Ulj34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784854755; c=relaxed/simple;
	bh=RDjoztJQbU4GVnyRy3kaRitfm74jeRfqA+SnJn+SxY4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Wr6w8N7WhYJjLpOzHv3aOEFcGs2/XhhyEdaSug+N5ug/d7Y4sBQLBRJq6EAcTx65+DNXUEFCXTz+0mwUF20h6QP76FScI72UcvuguinL1NayUQe9+wOzxl8jdwlhOrEW6avTHEzoQbSpkWSq2FYRfQlLYT+vJILIjgUghJSFlz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAgI6yWl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAgI6yWl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D34A1F000E9;
	Fri, 24 Jul 2026 00:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784854753;
	bh=4IqQuzWa9zukp/8Xa7Vx1hseOADWYDWrtLWPKRKUA2E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=HAgI6yWl4lzJe7ze7y3KINpyTvDzSkThi3xs2Y400VTeWIiRfjZnKE7W+5gMSSXHr
	 eHfk4hzoVB9ciJIiT/SMOdmfatwrIZTNXK2tMo+Oioam+CU1SWGZWu0Log3M6HUGw7
	 Mz7U1hOT6Gto7LlCfUKS4sUsm+nK2v7Sn/YaasZJGYZ3lnMiE8b6ZN9qTJZcw1tPve
	 wOIWI25ZHmaCQCqjA6fPjNE904JIHAuuQBfo1XDTkja9D6e/JTojuIY+p1/w5JzP/E
	 qsEe7v+NzT8glP/uVRGFb1sd45JhCRsi4xLMWBebW1Gwx6qTkiJVFzSqgTPF/9/KwB
	 HB2skUgbZMfGQ==
From: Mark Brown <broonie@kernel.org>
To: dlan@kernel.org, kr494167@gmail.com
Cc: elder@riscstar.com, linux-spi@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260722162444.11415-1-kr494167@gmail.com>
References: <20260722162444.11415-1-kr494167@gmail.com>
Subject: Re: [PATCH v2] spi: spacemit: prepare both DMA descriptors before
 submitting
Message-Id: <178475444741.5645.6128130514340592590.b4-ty@b4>
Date: Wed, 22 Jul 2026 22:07:27 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1142; i=broonie@kernel.org;
 h=from:subject:message-id; bh=RDjoztJQbU4GVnyRy3kaRitfm74jeRfqA+SnJn+SxY4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqYrjfh7V8VBPJzP4T3BLa4gWuOESEqMO26JPTt
 Hkk7G4aCz2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCamK43wAKCRAk1otyXVSH
 0KXnB/998YytmnS/jo+Qbh1QYspKr/9sSePM4fYW6xAvLWvgWL+fzCqe/MdoqHaKZitrOnvVFnt
 ukjgiisqaP1omjiNBfXujwQ3sQ/DX880xX94XxECsMob5cYBWSgq6A+3QbtHKsb6IaoYPuB7cZr
 SwZCTu7rz2c9OA+jq64yjyLa70pHNrFg4jolwIeHRujWJJB9bYW7CoFzg96oRnWKVAiKw8jA8vx
 Vh33vGkioMsnxGTYjxcV78oTST/Gm00fikDPmg0f93CAWkscZECWbeswjN3CSIyd57Gcom68HeV
 hXDo50SjJfKoY1omkCuGI0J4r2v29QTxLMXR/BDwhVgpuZQr
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 22 Jul 2026 21:54:44 +0530, kr494167@gmail.com wrote:
> spi: spacemit: prepare both DMA descriptors before submitting

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: spacemit: prepare both DMA descriptors before submitting
      https://git.kernel.org/broonie/spi/c/d3c87e71539c

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

