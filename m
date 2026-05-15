Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186403CEB8D;
	Fri, 15 May 2026 16:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863212; cv=none; b=D/YY2bOzNtaFHeWFIAn5IlIDKPLrR98MskL6TvYfj9Kjj9IrZiIaeP0T+4FxuYHaQyej0kJh9gwSrKIE1G5mGNgnnbMGr0G9zIO45Vwqgmr98tKlL9y9HmvMvqRt8lgPGy8m8igicKgzNhiWmcI/fSsHiwe1jaYaiD3qQDWi5sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863212; c=relaxed/simple;
	bh=3wyAIoGMLD/Y4d5+cvprmdAb0H1VSwEUvKUpPDKdQKg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iupzw2HO63zl0yesZqUZr0URMsmxKJeVFT4D6PTfDvSm8E3VlUo2GcRwqiSy4mHegVEvr2ES9mXhCSzHuUNmJCRxDfsSaPlSyfqbpq9wWmf0d8db9LNmx+x7w+GFdNAypuRGZBBUIySNKQtiebHpb1CD7k2iMXfUCH4bHSQXbjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrWheXcy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrWheXcy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF49C2BCB0;
	Fri, 15 May 2026 16:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778863211;
	bh=3wyAIoGMLD/Y4d5+cvprmdAb0H1VSwEUvKUpPDKdQKg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WrWheXcyUyvCSBMPrVoyYvCzttQOIS6X/gf9ZP9tCroSBbz5cRPABDG9z5obxriIm
	 0sVwK0GOb7RxYoLmZCDxESgXheOvPVmaYDmC9KmBg/LrxAli+05odpZtK3X6hbKnHQ
	 RYi/C9Tf4S4ZMyNBg5Zr5HHHl0Rqy8uO7cA6GZiUg9xzd1CLzcU4Fqn7WWQoPDVSHm
	 zi8EW9QBWVJzOffjYIjFwmYndtZ+FCR6d1N50HiDuC3abdsmr1VykvqF1fLXr6r9BC
	 tMY648lAnpgYKoRVOVReCE7A7k8CDAj/Y1Ua+uUQCr8Z7uIq4xoUUBbu7zW0RAMgTY
	 Uet9ffBD+eUdw==
From: Mark Brown <broonie@kernel.org>
To: shenyang39@huawei.com, Qiang Ma <maqianga@uniontech.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260515102620.1926930-1-maqianga@uniontech.com>
References: <20260515102620.1926930-1-maqianga@uniontech.com>
Subject: Re: [PATCH] spi: hisi-kunpeng: Use dev_err_probe() for host
 registration failure
Message-Id: <177885258562.1136679.11962791857499960517.b4-ty@b4>
Date: Fri, 15 May 2026 22:43:05 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146; i=broonie@kernel.org;
 h=from:subject:message-id; bh=3wyAIoGMLD/Y4d5+cvprmdAb0H1VSwEUvKUpPDKdQKg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqB0xpVUjP2Qb5gCiNPAvypBp5Mq77xXlB3xXWf
 bakZhOXbZOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCagdMaQAKCRAk1otyXVSH
 0OAxB/wIPFHNu1Z7L146UNTZ8rKDS8FZZdAd33nAW0tm3LEVZfyI8NtPcxEBAtyrN2f2Wnd0j+l
 JIgML4K0TAc/xFEJsqoXGJGIpl4ixhiOddoAjZDUjIx1350SdpGSzp+hSSNDmeDXRVTB/NHZlUh
 M8CyAVmheUXxKS5nwGeG+BeIihaPgEbbMy0FNEyURkJ/e8HUPP0iBBMXt96uz7/x+S/Y3kSBJwh
 g0kGLmlPVgF8TzPX3g9KdKzSdQeZ7oh+V+Yo87tpPsnZFMUpjikSymAvJKNlKi4c6b1y9TUfXTi
 NaxOPL69I/8DW3qgj/3iBKt5Kj+Ze6XTj7/6t35U96I8bP89
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 15 May 2026 18:26:20 +0800, Qiang Ma wrote:
> spi: hisi-kunpeng: Use dev_err_probe() for host registration failure

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: hisi-kunpeng: Use dev_err_probe() for host registration failure
      https://git.kernel.org/broonie/spi/c/59b991990a04

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

