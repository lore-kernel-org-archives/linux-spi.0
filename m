Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD2B364EA6;
	Fri, 12 Jun 2026 22:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781302793; cv=none; b=jY6EqnWBJLxikppxLrRZxwkuuqOv8JlTyvBgYb4Yilas7cnaZmzcM4OyhD3gEJfLMw1wKXzxveVkjCusLVYpkoe4qqVptJN2W0vDt9cXJ7sYYJqDPFnX2kHFD+csN2EayfqiKFDB5YvB5Oxsv6DUOQ2IsHgStxbPanmsdGy57y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781302793; c=relaxed/simple;
	bh=hbcQgfswpsO7MJ3neckUney6fXqJJI4n9dU5XN8tYpc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VrAV5ZHaLBucA7anegY5cQ+ugNsFlEyxD/bIq42er/QNHgv8IYe2d+CQhPHcO/s4IkT1k/HzKEe6x0PvIb52PEkxtMJtDe3KMSXCE4F64XDJwdvINLuSY4SqoizXWHADt3m2RgM+/BtIWjh3RKtzjzeCNTVtEtLSZjHdPdi/qOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlaAroOE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlaAroOE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BC61F000E9;
	Fri, 12 Jun 2026 22:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781302791;
	bh=gkD3CJpMiSHgROWtgLpLIprl/RDDRZePzULWE+8wdIU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=HlaAroOEzr1SSHhJ1mod4u4gAutfC7Xy2klYR/61gjZUav0QmUq/s4GM51WLoPF8A
	 FY/8VX1ELVMwDlpwljtTF5CnAh1TW59MaWrjQLxwRsu5llykZwq9Pg48/OrfI/lC4Y
	 CccQzGFllNaYafo5F5amgIyPOXdU+Br13/XFvB3ugSODdEpsjKK/57GUQkGLjmpvCV
	 2+m8pXvWKaYCvrFfoKLUau4KSVth8mfpkm6CUkT1H+F2IgLPMce2f+PxHTD6bioMWo
	 tmg64uOm7xEaOddqhmQuQsdKSJvK3k0oQVANJmqDtdebWLyuTv0ZT8B296/ionvslH
	 09OklqwxEh82A==
From: Mark Brown <broonie@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Michael Walle <mwalle@kernel.org>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260612-perso-fix-no-cs-assertion-kdoc-v1-1-626b2d6d0d9b@bootlin.com>
References: <20260612-perso-fix-no-cs-assertion-kdoc-v1-1-626b2d6d0d9b@bootlin.com>
Subject: Re: [PATCH] spi: spi-mem: Fix spi_controller_mem_ops kdoc
Message-Id: <178126984320.48375.10483574436721947030.b4-ty@b4>
Date: Fri, 12 Jun 2026 14:10:43 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1105; i=broonie@kernel.org;
 h=from:subject:message-id; bh=hbcQgfswpsO7MJ3neckUney6fXqJJI4n9dU5XN8tYpc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqLIYEuphWMif6ZWCsHKdt7srypx6ss4w+o2mYi
 oWfqazY5N2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaiyGBAAKCRAk1otyXVSH
 0HbTB/oDUW0bWVatcyGwIGJ28eLmndFvVukncAiV3+1zpqDBQrbE04oK9rOs0/sj2CJZZ5DfQze
 ZcaTtHmxe8jgpj0bTaY7fM+7w/gvVJkgaRVlscusyD/TUrG1iLQSHJH/t1uomkDOMUGRTwSck5C
 04iOZrv/vzq5uz8fHZTm+TFDMDLuC+7rPB5En3r67AbHMs4pNRaYo7v+qedj9FEIe2DQhfOPf3C
 YElVSyhOHOn4vDkwxp3NrUI8wcrCpJaQyNVZ1a0HDKhm8i2KS0xzovI2ODwhg/BqbSCbig2OQ0B
 tmj6jtsb9ky7CLg4nDwFBxkgIjnRh2fjL6KnAyK12WmKR6RH
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 12 Jun 2026 10:58:07 +0200, Miquel Raynal wrote:
> spi: spi-mem: Fix spi_controller_mem_ops kdoc

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: spi-mem: Fix spi_controller_mem_ops kdoc
      https://git.kernel.org/broonie/spi/c/c0a5405ec38b

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

