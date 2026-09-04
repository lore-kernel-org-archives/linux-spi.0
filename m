Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBBE51FCA9;
	Fri,  4 Sep 2026 20:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788552771; cv=none; b=imYRajyCI92KvgiUQjBN/aHtMYu0AOk4NLpQb3FiXtVEkKrxH+1fABUWUD36lLruB+OgXAmwJvi8sZwiQtKvW2YYITBXtiGeXyu6Stz09aGHFqQvTzHE+xQHNwHifSo93cZr9R8kh0YeykOGS4gChpjSXk1bxp0BG4+aTmzh7Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788552771; c=relaxed/simple;
	bh=aVAUFyN2fcAsGtIsHiEfxnnWzQCBgyC816+4/EFFpWs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YItlbfmr8ZUNsz37ZOnIhdktn6zb7rWX0fUNnjPdUTEB1dhoYaTo9YaY6vj8eHqOlFBOo7rAF/R+YasUg+a5sJNt3p03739hJuPJuvPM/k9gxenpF6BO8BLF4ScDim7vr8Tye0YietGyopXxAiNeyxkd0fQ1dDgOfac/sz1mdKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVReHXE+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVReHXE+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7728F1F00A3F;
	Fri,  4 Sep 2026 20:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788552758;
	bh=EFflaqNvAutXjvz21YeG1GMFMdMMYJym8w2IUJTAZYs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=mVReHXE+4ckfWMOa1/mayCrlZMXjauiaU5J5/ntwCs23N9JBgcBcKvPi9EqZuOHoN
	 qjeMPvIlPw/xA5O3zRSIak5iLavPrOvW0F5yXvJD23ryxfTyOuOliMfI/lu9mDB9wK
	 BAGSVdZZZ4WLdnuie6SQB1RlBNP5gBiSNeEICs3OOKzm1UMRNZVZitXhggr+WgLMGe
	 GUkFMXLggEVLUDJCPkDrPAvhO4g/tyQWV0/fqjmjI6Oo5AWdJZwtRmYzai2aXPBxWD
	 rvXMfbI0MDyrqcdEGXsU63P8feCgC4+oKj9bNu+hhRNsXb8osyK2Aa1jFMRg/Vetze
	 bdy2e8Gn+j9ZA==
From: Mark Brown <broonie@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260904-ingenic-v1-1-06218181a4f8@gmail.com>
References: <20260904-ingenic-v1-1-06218181a4f8@gmail.com>
Subject: Re: [PATCH] spi: ingenic: release tx DMA channel when rx request
 fails
Message-Id: <178854187653.632048.17193090018816306723.b4-ty@b4>
Date: Fri, 04 Sep 2026 18:11:16 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1126; i=broonie@kernel.org;
 h=from:subject:message-id; bh=aVAUFyN2fcAsGtIsHiEfxnnWzQCBgyC816+4/EFFpWs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqmyYyeJuzFXal1mv6+R83G22jA5yS+aiBZfBpx
 U5m/2IQZCeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCapsmMgAKCRAk1otyXVSH
 0KQeB/0S9lbadUwvO7BrPLNVGNYhs4FmT5nJ+nJC9bdfF5waUKm0gD/oJ5sXWzB5FQ4o8WACSF/
 xn8olR8itOpfkceVNT9DfOl+ZgtMg68ToTZ/K3MZpWZ+9F8vMF5Yqs8XZB448EjnLs5vmTQfad6
 jReLmvIrQ6tKXrHhIb0q3Nijztl1dKUJBRznGZiIWukGfa9GbQIyQDDbOSqMRnnu47g+yJoau+x
 1mFa1N/hONW+GsJD8z4zpaVjxAy6Y/j4UafJ4HK2vgKmMnPQDkwCY4folHeayfDXK8Sw9YL6BPl
 WA2mzs75nbZCT2TLgurqEY5DUy10Zq9qnqa5UkwXlqF4yIc/
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 04 Sep 2026 01:17:33 +0800, Felix Gu wrote:
> spi: ingenic: release tx DMA channel when rx request fails

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: ingenic: release tx DMA channel when rx request fails
      https://git.kernel.org/broonie/spi/c/bb308b27016c

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

