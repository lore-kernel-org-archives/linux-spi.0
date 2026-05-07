Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1496E3F166D;
	Thu,  7 May 2026 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164956; cv=none; b=Uw5oshF9zYnRgAqiVryX7H9vvcIN438SVnOTiFsPzcyd91Lz2uvLSMoV9Tb6r0/rlcmW6joMQ4/ffIfd00Pb0GXFCeX8372ro9I6PQ0a4X1FIQ9WwBL+DGu02u2yGyFdiLnqiCzSDv7DnxS/Xd3OT0l76FVPcz1soZpZKbmavoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164956; c=relaxed/simple;
	bh=KCX3N2x1ol+I49/DTQ1+oZRTrXDmnXU69S4wRqEshBY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TSVCDijlZqouwffKGtVbc126aFWET4NM1yRGYDGYrCSSQSz5LhX/ADYcKutgqExb7dQX9WXbx1ljjCAk+1F+UAmnoU2QIwU7+qaX8yhBrYsPXAKBR8k3anzdS4zJOvk8Z0s2AJsbvNW72NwgKWwPdd9I/EbYzCSst5sb7hPeSC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lgex9zLP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lgex9zLP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9B7C2BCB2;
	Thu,  7 May 2026 14:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778164955;
	bh=KCX3N2x1ol+I49/DTQ1+oZRTrXDmnXU69S4wRqEshBY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Lgex9zLPFUXvGoh3Fd8qSnVoRYLjxpJmChkOW8Do9qhjrmdqCsIUSq7uFM6E/K0bF
	 UO1kyz/4EJS/Gar4wnYK5y0czE3T/hP1bj0zqIzLWYzKQ/ZNBkYme7ySdcXeYkOgu+
	 SrAskf1jAZ9vhNW4X7WdNoR9oHaTq74RJDw2jsyWhk6KVC4+flC+ZhOdSrCC98M7Em
	 6Nicsp7Z+mNM8cPig7puQptrJtSK4WoW6tmDCHvV9GylGCCj6DefWDDMwLHmMgGW6J
	 wijoKbSFe1X1FJenol0a1VnVx2ZNbE+JfpIs6DHaPnwfVNqmEEqeZZhjltlFqPVRLY
	 q7Crk+K48S8NA==
From: Mark Brown <broonie@kernel.org>
To: sunny.luo@amlogic.com, Stepan Ionichev <sozdayvek@gmail.com>
Cc: xianwei.zhao@amlogic.com, linux-amlogic@lists.infradead.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260506183513.482-1-sozdayvek@gmail.com>
References: <20260506183513.482-1-sozdayvek@gmail.com>
Subject: Re: [PATCH] spi: amlogic-spisg: drop misleading NULL check on
 exdesc
Message-Id: <177814235817.749715.9876596107513114221.b4-ty@b4>
Date: Thu, 07 May 2026 17:25:58 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1129; i=broonie@kernel.org;
 h=from:subject:message-id; bh=KCX3N2x1ol+I49/DTQ1+oZRTrXDmnXU69S4wRqEshBY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp/KTZvdxWwUlXuiOEDiIKk8B9yMKA4zhQvM3ak
 W4npfMS+oSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCafyk2QAKCRAk1otyXVSH
 0FVfB/40AuY8Cg0XYUtbrUCfRo3oYFbHVIA6foa6QyeMJEKVRDSHgUOKBYHTjYvl0H5kzvLHqgJ
 AC3TVs7hQ0zTWSo3jOd0iLeGd2izDXyc7GgSUsZOb3G2m69YECBK5QIVPo7cgMmj9peq9cQR8nT
 psRPH/A1PH8oFIrf0+6eluvqIOKxQBWUwYGlbJMQVwmOUdka0OGKwpEveGwlOdobVS3G7SgIane
 wtqwQCmJdGySNpkxtNDFiaIKlhzWOWrMfGAXCgHn5s3TTf2lu3b4cD1DM4MMToskfOB5iCEAqdF
 lGN5KRuQ74qduuUbnjZn6Q5p8r3JPdHsKTq+QV0tMN9y2V/M
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 06 May 2026 23:35:12 +0500, Stepan Ionichev wrote:
> spi: amlogic-spisg: drop misleading NULL check on exdesc

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: amlogic-spisg: drop misleading NULL check on exdesc
      https://git.kernel.org/broonie/spi/c/54725e3049e1

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

