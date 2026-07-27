Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA60B42CB18;
	Mon, 27 Jul 2026 22:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785192917; cv=none; b=Tz+6yZDCXjfC0+TWzyYEF7iLiLhFgwu82Q+0iTOlg9W54MAutIJbp9xtBq7aTrhZhOm8lVmwjAocZrcXYOS2qv5eB6skhzZYboZFQx9t8SIU3tnOKV9FY/P1963oHkwgAK+oINIDpyPdgz392fP5XcA5c3a5lYqFwdCv0xWia2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785192917; c=relaxed/simple;
	bh=o8bW1uDcIlMOOCb/v+JJiZOhoRwvyAnJQVVS5QFmtmE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=S8VIeczHW9T5d4G6R62Rpw43qNC1j14WAdK9deDMpmi53CcgLRdgoMz5dCSC0aQDcnvMfqtd49nQwo//4q9S8Dmo5N2RGpakdMpw2yce/tGC5WCcHgQHFPGqRLTKXGTPxa2bMqlKJIPwH84KX6KDuCuVKGCO+0AZKD5G7SUii7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAsAKU5l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAsAKU5l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E471F000E9;
	Mon, 27 Jul 2026 22:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785192916;
	bh=0852csyWDUpIynklJWjUCMN5ef3cTMCMg6/euO4X67k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=FAsAKU5l1kZ4U7gkmvi9ShkYyL11h+QYbZ4yMvgcMINz+NN+pORcURDDf2BGGOwdO
	 JPPNPoJ7cbEcPIA9JS28hEx5I9mUWQ34PO8e61HotqIgoXcDSvHUuON2wjEMxD62Hz
	 m69Y9arK7eBwN3hzw0SxRS3DIRhlKXOXtzwaspTATIUR881zOoj5tVGM0k/agh2N5a
	 BAskkct9VttR3dDgpBU90ba+3YGfKHmgVrLXYwfnlTOpRy3Pa7iaDf0W2F/g8J/aS/
	 czKtht0HfCBifqvlgE8GKyb8NlhfKMNPtbYNRMv0HxhdUoZw7oHaKJGLdZIYntJxGA
	 iC+OyZoxf9tUQ==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20260719010014.3163356-1-fanwu01@zju.edu.cn>
References: <20260719010014.3163356-1-fanwu01@zju.edu.cn>
Subject: Re: [PATCH] spi: oc-tiny: switch to managed controller allocation
Message-Id: <178517410595.50339.9207832521965682254.b4-ty@b4>
Date: Mon, 27 Jul 2026 18:41:45 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1114; i=broonie@kernel.org;
 h=from:subject:message-id; bh=o8bW1uDcIlMOOCb/v+JJiZOhoRwvyAnJQVVS5QFmtmE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqZ+HSgHqoGChyOY/hMB1nWjWMK7NrixoNHsxId
 +xYvYw9UfaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCamfh0gAKCRAk1otyXVSH
 0AqWB/9GZl07KvAaCJucSVO7CksL/4SKSjeMgL0iNf1luKE+/a1G3PP76afuU3jNpHYV8Stg48N
 7bmmT5XgV2me8Uvpp0OiWGI3Ode6EzOHm/hn9bDFAF8xquvup0lWS9Po7j89yRzN2S5hElXTp3w
 eU3VYKLfyviyQIWaLDejdUrFaVFrRSF01vEXlhgcr9ld45jLDXuGAvvEwOTrMoEaFWqUSAwCEWs
 0sgsXZRZO9CX1pChieyw2UxEUDCMrFQ1u5RSugsKLZArGqW6pTKtHc2TMnPCWblHYocSPiSy/SI
 KnVwJCc46b+8sP8363UXTwVR1wmPZcc2uRR/4iNQN+1CNS5M
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sun, 19 Jul 2026 01:00:13 +0000, Fan Wu wrote:
> spi: oc-tiny: switch to managed controller allocation

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/1] spi: oc-tiny: switch to managed controller allocation
      https://git.kernel.org/broonie/spi/c/d710f43ce309

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

