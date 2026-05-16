Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DAF23C4FA;
	Sat, 16 May 2026 04:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778904732; cv=none; b=anh8/yithP1UVz81efUSK3WoEcibdJzEX0BGHg2YxiJqwKBTF5RGtJxMXI+kM3tdIhfLgOziY6hnHsY4ICMT9RY6oa7/HvSMFLCtzWfw/5jqSp1K4aCQDmiN0643gitXD4XekWknIhzwHwi21j3yiCiRYQxCGaGlAFWmHN0W8oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778904732; c=relaxed/simple;
	bh=pVhh1+loyr9iK3yA1i9SkEZhpEbFJzBj5uryiWLg0Ls=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iye7SYISza4fm7iCynqLlHhwVtssVqsWDE/n9pgrG9mTvVY6Ki1I/OpYjh5pVK4U6ZgmxKOfsD63ngfDEAjBk6u1ypp67uazywEScF388GTmyATseC/QZAOqS1W7xRy/Hzi9ItE6gSM3D/qbq7Ko/kptma5YZ9XQJNbUoX1YqOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eloqvfx5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eloqvfx5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A674C19425;
	Sat, 16 May 2026 04:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778904731;
	bh=pVhh1+loyr9iK3yA1i9SkEZhpEbFJzBj5uryiWLg0Ls=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Eloqvfx5NsGl+M8dN9fqen7YOZiDRFUDZ71L2M+kaTsXD/aZRHDMX2GntqkHQ44xN
	 T2VXvmwtYyqcjM9xIkxWK6GF3y6VZ18IBvwN4m8ZRSDiX/3GDR+t/sbXiYc+qXi3zZ
	 ppWtM7EbSq2i6Sj5dsmQJi3Zj+YLuQErUsUT9xFKuyaRMRvyZ71ePI+VCoNaU5E/K8
	 EyJ4Vt2T4oKJuvqOaQO/LgAEPOUWfRrnH7tyRmF5NPJFFqGxm4y7HDGVpzfZVPEI7+
	 /4CBqMmMlsv9cr3ubknN+y/m9TFnm8YJ4qewn9N3XuQGdEHg2n1uiQ3rrYv36+/ivC
	 nW9qCRv76W5kw==
From: Mark Brown <broonie@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>, Felix Gu <ustc.gu@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260507-rspi-v1-1-8cfa47cd56aa@gmail.com>
References: <20260507-rspi-v1-1-8cfa47cd56aa@gmail.com>
Subject: Re: [PATCH] spi: rspi: Simplify reset control handling
Message-Id: <177889811103.1174745.13169258472508897331.b4-ty@b4>
Date: Sat, 16 May 2026 11:21:51 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1096; i=broonie@kernel.org;
 h=from:subject:message-id; bh=pVhh1+loyr9iK3yA1i9SkEZhpEbFJzBj5uryiWLg0Ls=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqB+6YbFNtjgulyv0bUaBIt+91JMTY+imSGx3Fu
 oLhEjAgxouJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCagfumAAKCRAk1otyXVSH
 0F59B/9Ye1UTbkKgj0Di7GKvWMcYEAUJv8LHIY45smNghuim64nGJPC9074VH6YwRuqFG28wdqR
 8GFcPEWFMzQOtwjSsb1e3F6sAQcMjvW3fkHzvIqv95KvsFmxlUXJH8jRq6US2O0W8DNcZqR4MIi
 32qgQPCt5G2o+7WfacAssIQwgEkI6NDtZwlDRDxhjN6CXPi1gZkAcQJ7zvFmyHiIPyLYix7s7MJ
 LALk9OkA2XNkN8+PFC9DuRrhrKJxZB1+ChzxmPR8gIaIwcWU8mcaPM/itb/qUN1PIaVb9zlaQoW
 YX+R3YAAuX/S8uSB6k2cgwhOXaVZYDiCktTgJGy19xG6Fgd2
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 07 May 2026 22:06:36 +0800, Felix Gu wrote:
> spi: rspi: Simplify reset control handling

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: rspi: Simplify reset control handling
      https://git.kernel.org/broonie/sound/c/d3873c5f4d6e

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

