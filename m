Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30FF3F23A6;
	Wed, 10 Jun 2026 10:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781087015; cv=none; b=iDsrllMaI5MQgb8YzDxhUm+MoFEafMCpQTGpcqmV5M0KBcI/5G5DZ/AFHypZV9tRYbCJ8AA9fM3/ughPQhH2FywnnY0jDnKE55qZkw9HfR50ScXgBnS2ZsESMDI0gPg9ikBPJeJARlk/Ody27O4B9RHT+A5kNnHhcY6rdNeq/pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781087015; c=relaxed/simple;
	bh=C/czuiP9grpMZXO7aleQvnc9q8khXKOwwS2Z1kdf4dM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HYa6xfE1trwT+/lMrZLri2SfW8faumO2Npxn46w40xsc42QWXCOc58nSSjTuvZ3HOpCCMh7whl3eASDKb8cK5MeNeUMiLQJQpZYmlgacI8CF/sWHJ5RZ8ApYTR1e11MUvjFYixe+CFp4BMLUZBjWj95gHZRGQ5nktFpr1oZzh4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnqPRjW8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnqPRjW8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23CA21F00893;
	Wed, 10 Jun 2026 10:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781087014;
	bh=b952kGpEMvRiit9FTFHTz6P7HfXCrJpbJbKuJYF3T8s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=SnqPRjW8N2AK3UIZlbRblqGrklySyh7TGWdMw+XrdGXogaIqJdMEBovqwtnfVK6rc
	 xVlENf/nhxE7Z89+A0qBE8fkFV57IYZeRD9b44H3X66ILN5gAsHUK8pgWehRzrvNT5
	 UhrnGLW0pajIpTigHI78JrPFQQ9M8AphGXo85xAGY6+NiYldlq+VCezAME1lX5POOZ
	 nKHqU10FPtT9m4LQPphCANBYRFD1PlcLi1iHbqD0BqVgNiCl55ekmMj7nV/0qv+Jmf
	 29gjF/cHrDnSkeCGLPfECNzjzmn+06f0dTPN7D0rAXfNgAiBFBvg2DUOPJgRuBRVoA
	 5g1r6DB0U4RWw==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Beniamino Galvani <b.galvani@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260609052647.5-1-ruoyuw560@gmail.com>
References: <20260609052647.5-1-ruoyuw560@gmail.com>
Subject: Re: [PATCH] spi: meson-spifc: fix runtime PM leak on remove
Message-Id: <178104640986.212106.12502273738645325347.b4-ty@b4>
Date: Wed, 10 Jun 2026 00:06:49 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1106; i=broonie@kernel.org;
 h=from:subject:message-id; bh=C/czuiP9grpMZXO7aleQvnc9q8khXKOwwS2Z1kdf4dM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqKTsjUnvIDFUOx+gx/OS+/TdsHBQ/1dxwRtkt4
 eRn7TEiCPiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaik7IwAKCRAk1otyXVSH
 0A+iB/0WiyEFVlvDGYdaAGsoWZEnfDSyFifJuz2TPP9E6pBgh64emn3QWgwcBQPgGWvXqn0fbQ/
 v2oH4KY+wkat0DQTiFDDVC57bN+dder0Fo48vQKpkmloMIsUxEScrVtRQw6J9IHC8wygFeI5/+d
 zwaqmFNKIIPHLSe3BmtG8M0VCwvAgvSCqmEHFsVwjPLDEbTPMn9OX2JqPU3ivsW3Nwuat0lmK8V
 CF/GmHrxQnewc12i7OZAjq5Hhs156ip0RLXS7IFJC4QDn3c0/zLa7S+8nreSIm86Up3XXiUk6oP
 BAtOduaWpapGNvH3rEGh6scqCbX8O67Z6xYcIpJbt2pNLBCZ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 09 Jun 2026 13:26:47 +0800, Ruoyu Wang wrote:
> spi: meson-spifc: fix runtime PM leak on remove

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: meson-spifc: fix runtime PM leak on remove
      https://git.kernel.org/broonie/spi/c/606c0826bd90

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

