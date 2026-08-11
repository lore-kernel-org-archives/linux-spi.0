Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5843939DA;
	Tue, 11 Aug 2026 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786463094; cv=none; b=VcpGJnLCfC/swFusd5769avFNEh4LF92DGjHAyIdqgA1pW4dXoX6VE757H5AYayOHSN1wJa4F2owY2+WOedXoGHe5PlfxYVy5r36WI1VWwliSNWLUHGuklOZ4yoQMK5r4bhpWVNlvqUrRsLmr6QbLlrAN4xL3fgIsXHW2IspGVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786463094; c=relaxed/simple;
	bh=6t7TzoJqEu+NqqxKtXbkm0nM+DuCxxl4iL3QgbLdgDs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=N4kaWmSA7uPLkTr3cc+AAfeEHDUx5fn4L/NG5nelwTt5HFjXtNM8kLYHrej6nit/2asqBsmc5X8A8iHUzpOeyZHBildCh+KDsBPw45IVK75ndIDUy9cblLrTt8iMMo3rvX48IpAmQ3K4M9Y73eUzILfxN2UByE6EB3PD6LWjCNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwwoRSmx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwwoRSmx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A601F000E9;
	Tue, 11 Aug 2026 15:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786463093;
	bh=kgcjOarG+cnfeX5F3TF1+fIqnseyLLcBUybNBeUunvY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=bwwoRSmxy6y77A3rY9zImd7NYS09qB15zEYmQSbnHG3m4jScmfaTN9IPyMNPohZ76
	 fbRYVZRIe/QBk5EpeULNn567bzW5y0lnyDQE5UkyenBqOfkb88VjsmLZJpxNun7u0c
	 3iBhTQwP2NZiVEh1jdtzXmWUunTfbh1zrCcDqER+fCSL8v6h9hf7vkQNrARCnhAtj3
	 gq0HdpNQO9tIQEnXW1JEn3/h8VRwcSXYM3QKMpiwK0L66Y8iQX9ySFRUkhcYLqZVGX
	 KHPxddmaBbNgGkP3KcFOekhzt/bwh2KqHQlQpXcZK8hFeJYdfQiyiJmq/BhY54+sDY
	 K2eT7sXFj9r5Q==
From: Mark Brown <broonie@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260803135925.12622-1-jszhang@kernel.org>
References: <20260803135925.12622-1-jszhang@kernel.org>
Subject: Re: [PATCH] spi: dw: fix wrong RX_SAMPLE_DLY setting after resume
Message-Id: <178645843854.119683.11425726822354930402.b4-ty@b4>
Date: Tue, 11 Aug 2026 15:27:18 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121; i=broonie@kernel.org;
 h=from:subject:message-id; bh=6t7TzoJqEu+NqqxKtXbkm0nM+DuCxxl4iL3QgbLdgDs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqe0NzgK0rgonzHA0z5wrbMNQpOuYY+yHFQZiSl
 MpV5S8zT92JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCantDcwAKCRAk1otyXVSH
 0EX6B/9iSVN4J4glgRQLcRukFLiZYbpf9L7Zi1NPdQNz/ys42mrEY0eX1givcymiTmQCIVfoHEw
 MRxe0CSAzhuWa79/PzHsI1wO7Gi3UJPAM4MS0z5QZpcHv89pNMILkxImEFT8egRwgksUwoBMCMe
 PJZTpQp84Upgi9tlPrc2xGzXhdTPRZlIdgwgEpXnFvKHDkuZXCoNheOTd/7dzAsEVPq8CpSe72g
 ydy9R72dcqpWUyQd4nUPQGEh3E5S569X2tdMSxkI1VxuNpMOnEisvuFZCpHGB7lo1Ui2MoZ3tvq
 e/7dsBey1rLs5Hb5n1XTuyPdkq7il0JBbSDhzxdjsYneNA9/
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 03 Aug 2026 21:59:25 +0800, Jisheng Zhang wrote:
> spi: dw: fix wrong RX_SAMPLE_DLY setting after resume

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: dw: fix wrong RX_SAMPLE_DLY setting after resume
      https://git.kernel.org/broonie/spi/c/133c71b2c0bc

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

