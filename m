Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E4A466AF1;
	Thu, 13 Aug 2026 11:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786621587; cv=none; b=tUhpJYbTeHXQ7O0CIVwQVahNYGVZj1axEvyZvPqVsEilB/STY1RNVfE/ReNw2BMoAuT06ThkUnxqaIoTBrMct0N4K4jZGZzs+6g50lPsZhAs+Q6ejhsWqXxo2V5Dg7xvXQ6El0pu4mK1QYQK4y5a/RNef4o15jAnFPrungztw6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786621587; c=relaxed/simple;
	bh=cZsUhtZagyN8wmnsD1iN8+x5lKstL6WF48h3CJ0yx2Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fLBo6fHfto8wRz1+4P4sF9yI6iO1n/GpBUDznEqe6wp+ncsw4CW/Jh/55Xn/4KWyFkX1EyvfS33+h/ycdSSfWVGAlv2D3tGyUX+iOxlEVLxw0l0dymhuODzBTi+hyRuhK4C04zUYoy/+ZY+Q4mN+OPy7DV2339h+qrTeJ2AbX5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIUxrevK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIUxrevK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44061F000E9;
	Thu, 13 Aug 2026 11:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786621586;
	bh=dxPOTQvUQ8SdAxl9YphvziVdijzrPz5Nrkxzq7eIglY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=XIUxrevK5+YUAKnGiI2bntQ9i7PRnnu2/24q6smvputJncnkNeKByi6xP3x3U6DTH
	 Nm7TLwHVAPHX4G2Zb+YOc64G/UEzUkc/dfxueO5EQL1jicRhGN4atUlRZjEZsa0iCo
	 kdtX0SHTr+ubXizSVSViyczg49kRERm8M/KpwE7sgj5nGtqMx7hmmwsub226otwbB/
	 QJq2+G3LKujeBeeqUunXteM+X2vCRqLoLrCFgWbzpwAe72LEgX+bVsm4rSnp/ROvzV
	 FCf34bI8+psR6gVKGSBSVzjMusKvZk1496P6gK+ZgN14AsIKO31uFB7eVSICmKWsdq
	 Vjzg4a45eAn5A==
From: Mark Brown <broonie@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 phucduc.bui@gmail.com
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20260807102932.45785-1-phucduc.bui@gmail.com>
References: <20260807102932.45785-1-phucduc.bui@gmail.com>
Subject: Re: [PATCH 1/2] spi: mtk-nor: Propagate errors from optional IRQ
 lookup
Message-Id: <178656054325.521321.2150374013382515611.b4-ty@b4>
Date: Wed, 12 Aug 2026 19:49:03 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1245; i=broonie@kernel.org;
 h=from:subject:message-id; bh=cZsUhtZagyN8wmnsD1iN8+x5lKstL6WF48h3CJ0yx2Q=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqfa6OvG3YHg+Flp59A9DgdDoUWkT/Yjg7zVMcy
 RMJbTPj772JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCan2ujgAKCRAk1otyXVSH
 0HZRB/0aW3FnCVlhnC3itp1bbBtinarnEwqQqX6sm5Q/F/+uUT/IdcGbHe2k2B3d6LhHrOMq0+E
 JN5TJ0c8DPlBQp68BGgB6vACNnD9FszlcgOA0M9eOjmwLydtMcoHOuZFTkcDaZYRffqhdz5IFCq
 dBsylu+YkVI4k5K4vF+tYl+SXghZZtvt1qjaxBUUhJoMYjxHF0WqkRvrX7qH7MvHbXUdmxOSGFF
 8V9jSuV82QIzzTP2LFkfBpJqZGNiiuzOFGUM61lgmpMrlUtb/cqiUQWrGplNHiz2GMt+IElAPaR
 FKb1nJDiuv5Gh2ZS6nz5jEKzBdppugcV50N6o7PqWCvildAK
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 07 Aug 2026 17:29:30 +0700, phucduc.bui@gmail.com wrote:
> spi: mtk-nor: Propagate errors from optional IRQ lookup

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/2] spi: mtk-nor: Propagate errors from optional IRQ lookup
      https://git.kernel.org/broonie/spi/c/356d5869bc33
[2/2] spi: mtk-nor: Propagate errors from IRQ request
      https://git.kernel.org/broonie/spi/c/560fbcf4720b

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

