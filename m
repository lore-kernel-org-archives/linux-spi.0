Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D938288C2D;
	Sat, 16 May 2026 04:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778904744; cv=none; b=MUIaoVMUgakPr7/Mj8I1aO19jgyNxIQpcPAzl/t0VBpevGVxTE4MbxX5h2iK57/wq1wZInVmDeTu6ndINzD5V3V5x/jZ3lk4IjEK9EH2Q54PXF3tTNSXou4PqyMZ6V1qu7c4nQQHYuVmxXZSk8f4Ra2UcM3NqAJN5TywXcBr8rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778904744; c=relaxed/simple;
	bh=krf0ubK+QUrCPT2ffiJuNibxSiI0Pko+MJw8mKNdMBQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZZwUIXufEqyGGZ3l5UB0BtJGvc8V9A4l6kQevPfzUHzCAmF3908AbVmcY6+5aEbcZtqz7QiQENaxFRwFu2jMsvvcmj09W3bqD/A46hzmSlFD5hoh2dGrxqGtE1CqPOFUa9AJ9bGxpSqXHmP5aQNwDvxOtr0c5wKrAQKGJwIWQUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2tsNmk3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2tsNmk3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45DFC19425;
	Sat, 16 May 2026 04:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778904743;
	bh=krf0ubK+QUrCPT2ffiJuNibxSiI0Pko+MJw8mKNdMBQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=d2tsNmk39s1aRPHSiwXRBqiFxuEGDGikEhdXdKyL4zrBZc1py301r0yuBplr5hhKg
	 LEp70q6JTbjY8p5MOU0uflB28uFF5X26MBBV2h/O8Iho/Rykc4KF5da3GEeg8Pdero
	 r7+PpVf49HMkxVAFS1Vhs/5h0CkQXXgAnVtTMOMUN/NP4RxlwnAbkNOvVfHnVulfDp
	 HVBEnV6lb7YpV8W3YmLGcAgkhxR9oypedHTI4cMnuxyDQDWBy8Zw4nxyVgWVg8PrfQ
	 DCzcjpQijQPoS8GXfKN5eC1a3m0LWwoYFbVeOMFLqQzV95xaBlN4bO2nYDVN+qt0FL
	 5+x2GO5qX1Afg==
From: Mark Brown <broonie@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chuanhong Guo <gch981213@gmail.com>, Felix Gu <ustc.gu@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20260510-snfi-v1-1-bc375cf1af8e@gmail.com>
References: <20260510-snfi-v1-1-bc375cf1af8e@gmail.com>
Subject: Re: [PATCH] spi: mtk-snfi: Fix resource leak in
 mtk_snand_read_page_cache()
Message-Id: <177889843639.1174745.10626893124577105758.b4-ty@b4>
Date: Sat, 16 May 2026 11:27:16 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1136; i=broonie@kernel.org;
 h=from:subject:message-id; bh=krf0ubK+QUrCPT2ffiJuNibxSiI0Pko+MJw8mKNdMBQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqB+6jkGgY6lC5Y3cioDC9PO/YNhcVL3kitOby7
 8sbDMrSfoWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCagfuowAKCRAk1otyXVSH
 0AqcB/9LxFQxqX5rI8MM8g1PfrQ6uNT+8BO5i3yzllNC1xNiDphsdnLelOTWr3xJgnbexD834o5
 brl9ZyYapn4f653+NXmxoUcALdD19dp3KHozqg4WPZThQZy9+WBIHTxCiX8kZ+/K5fyG5vl5jrC
 mmzpp8Gag8rG/q5iHtWnM15rYoT8v6PBDT+VPor77B0v39uv26wDkjb0axE4q0A0bBokmV1IdRj
 inuNDQJRlgX5vwUqfImj697GF4e5HepC4C906FXvuKwzpCgZHZgbGhWZriu4wvkxbkcWe6SIvVl
 V6KGE4KQ/61eDnSd15lbOzDwWkWuhQVVsIcCuL/1Ac9DrjNU
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sun, 10 May 2026 01:55:37 +0800, Felix Gu wrote:
> spi: mtk-snfi: Fix resource leak in mtk_snand_read_page_cache()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/1] spi: mtk-snfi: Fix resource leak in mtk_snand_read_page_cache()
      https://git.kernel.org/broonie/spi/c/496ba79b9496

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

