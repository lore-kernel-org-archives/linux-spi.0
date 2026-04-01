Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDF6126BF1;
	Thu,  2 Apr 2026 19:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775157343; cv=none; b=dfvax0fWjZIaEPBoS02/g7k2GSlhg3Ag075krOfw3RYqPmal5KHR6tLN5+P9keZDuVZ17R6IBMKnHFiHPJfFCL8sA11U5Eq9lGDzjR0qZIRojKtTKc73KxrtRABy0rbDSDbr8sbLpML+xiLuv1FRGiDmN1J+S0iKpDORPd4UHRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775157343; c=relaxed/simple;
	bh=fzgciCrUicPoa9fFefLmegoaUyBiXBq/mPR3AUh3rNk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uIXfyPplbxKyIuZC0r22kRbh55dmp2q62I4KnyGMNbjFb9OMxXUfTGirhJzOQqpBdtpoyt2bPPyc6xGblrm8d07m9jVCMJc8clpzXho7o7ByPGbzyV1h+k1x6mPFLxs75bOqFttaSlESKJQkDc5bFkwiGoRxDdnlqci5Nqqj5P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ul38paWe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ul38paWe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DD0C116C6;
	Thu,  2 Apr 2026 19:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775157343;
	bh=fzgciCrUicPoa9fFefLmegoaUyBiXBq/mPR3AUh3rNk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ul38paWePZ/gr7M5nZ/LS/EOwJIflCOTEvvjTMDkaijU9KxlaLz0dnZ5cdO8eYEVr
	 1TbXYPkpzdifdkY/knuqZwmfcxChk2X8BTZ7yVOah2NhX+miyShsGivhBWb7dfnD6Z
	 qjZhUZaQC3mreU3rnjhmqtqkn90n6EIkWRbY42WsCYi/7cGKDtA9uHZxITnFbxqO5S
	 QXQOIo0HTynXlmJLtFd0F3J5Eq4LoAjhipltHJ+FUldxTt5k2fP/dt0QWmD5q2dXHp
	 C5jDDxTBxxJ0kAZBGxODotUqpypIHcVVXjFti4G0pWDhGiiBhoBarAdMD4GJZj/7n2
	 581dHPe9X5Mjg==
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Johannes Thumshirn <jth@kernel.org>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260327104305.1309915-1-johan@kernel.org>
References: <20260327104305.1309915-1-johan@kernel.org>
Subject: Re: [PATCH 0/2] spi: ch341: fix memory leaks and use-after-free
Message-Id: <177506409199.145704.1077486691099862120.b4-ty@b4>
Date: Wed, 01 Apr 2026 18:21:31 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-efa4b
X-Developer-Signature: v=1; a=openpgp-sha256; l=1326; i=broonie@kernel.org;
 h=from:subject:message-id; bh=fzgciCrUicPoa9fFefLmegoaUyBiXBq/mPR3AUh3rNk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpzsBd3jDcUPXS02c3SUe093gSxHyYQDHytiPI/
 mfGUSehlGOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCac7AXQAKCRAk1otyXVSH
 0PNZB/0eIn+06JqUje2bQVJc+48gCCtL6trJ89moA60IMaLTkaUBuSN0qvVxh2NImnOgTuCwlrq
 jejPVJh7+EGrLgkjrtulTX9VKts3jKGiCTYp1qNJQRDjj7I/F4xdrDQpi9b85EwXBlqq3r89amp
 /LK4ooxhAQ+dmLdQtiaQMzAS971o9lChmjRJshs0pFY9F6eZ03uaWdiQaotc/pFBUiQlPHPk2y6
 475/MtCRpFsOkTd1/WxZynVsXDD51b8jb/mXGeD0yUoJ+h96ONFxhu3tC0UZZmltYvw4wPHDRyQ
 ctNK+x+Yn9EFGth2OYNat+xRT1umJh6YXhkRtGWuO7ku9fzn
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 27 Mar 2026 11:43:03 +0100, Johan Hovold wrote:
> spi: ch341: fix memory leaks and use-after-free
> 
> Fix probe error handling and devres lifetime to avoid memory leaks and
> use-after-free.
> 
> Johan
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/2] spi: ch341: fix memory leaks on probe failures
      https://git.kernel.org/broonie/spi/c/b99e3ddb91b4
[2/2] spi: ch341: fix devres lifetime
      https://git.kernel.org/broonie/spi/c/abe572f630bc

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

