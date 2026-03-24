Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5EC3328F7;
	Wed, 25 Mar 2026 18:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774463482; cv=none; b=Q4K9USKRMnjl3Y7+pG4Axm+o9bXhv2OKNpH/WHaY7XdVx5OadjxvQIiJR5bSV0pifA3PIEodICdmH+gI5ajK3lLYLpNMBJhBfv9E2cmP/c48JwsKcsX1jTdC9LUK2/yn4S3MrxFtH9pTnDJvJYtRFMwZtCxnaQHkqtGi8wVi35Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774463482; c=relaxed/simple;
	bh=sAz0MAIKMLTbWGidLLMrJJWq6WztNTHg48T12Bx+yU4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uS9J0eZvbDf/7nfFu2LWgEIaj8BKnLkRxYMSbOvi0BihgVJ7gU3qqDvMEILn2LVWtG29OYAS2nPrVQ5S/tgVCwTKdH6c4Dd33axhw5hDLlHcN3fh5utANFXg7nY7NsGMvX5ayR63O5jWInCjYRqGy8d/7tfnnBkUKdwOsswqf8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1VdO3r5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1VdO3r5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836C3C4CEF7;
	Wed, 25 Mar 2026 18:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774463481;
	bh=sAz0MAIKMLTbWGidLLMrJJWq6WztNTHg48T12Bx+yU4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=P1VdO3r5Vs8SJukiho+q+GQ766Lv+ZygGmw45zOlDArmvLNQxPaIumlx9G9V+D9F7
	 aYAG+HKCk6ip8tb+b1t2yeenhb8jIA4LdXd0i6A4K7gEK9MyrcY0kqCUaZCpNHzJ5e
	 zLCKkegVqQmWQaOEkU9BnIqTvSNyRjg8vrilY1QJxXic3JbvPwb53OsxgX9+e5lZIe
	 KiN+3pOtercyEcJOMdi0hkVxLWOJvaW/iW7GYtYcBQgAV9db/RIstVoRKT21bFZ0x4
	 xN78q86g1oxo40stxwKAytjXcWrWZC2FHC6+S4mTMI+wPE3JkQey5t5K/uQvMDKZol
	 fZPtHKUEL1PYQ==
From: Mark Brown <broonie@kernel.org>
To: daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, 
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kexin Sun <kexinsun@smail.nju.edu.cn>
Cc: julia.lawall@inria.fr, xutong.ma@inria.fr, yunbolyu@smu.edu.sg, 
 ratnadiraw@smu.edu.sg
In-Reply-To: <20260321105945.8224-1-kexinsun@smail.nju.edu.cn>
References: <20260321105945.8224-1-kexinsun@smail.nju.edu.cn>
Subject: Re: [PATCH] spi: pxa2xx: update outdated reference to
 pump_transfers()
Message-Id: <177438213638.322033.8740503029303656760.b4-ty@b4>
Date: Tue, 24 Mar 2026 19:55:36 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-6cc06
X-Developer-Signature: v=1; a=openpgp-sha256; l=1127; i=broonie@kernel.org;
 h=from:subject:message-id; bh=sAz0MAIKMLTbWGidLLMrJJWq6WztNTHg48T12Bx+yU4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpxCn2gThbBxhfKPHDgYO9ryJAQqHKDEEWV9FXg
 RUUOkEPd36JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCacQp9gAKCRAk1otyXVSH
 0OYSB/4s/d+tKEk2AO815MKrfRV77dNl1UsT85r6iwVyDbRlUFST3AchwLhdEeyY5FZp/g2o6Do
 c8ktOLwWgP5hr0+6aWSfXdvyW6h4HTFotzaLj0uazrbpL8DpIR6cT4KIR2icF40Nkq8qhJdjyFE
 Zm3QStrQmL2MdfPqmVkApd/nepfCvj1IyYQsDRxXQZUQCedxK8RWbm/AL+Ajpsl1mdF9YaaOXLZ
 mI4vHBpgBgCVbvZvRfrATc50Q3jn7IKra6ECZY+5DF13OCrHo0Gkm0SFzL2kwry4XH8yZGOI0Bi
 4C9jmcDq4yGFJeU5fMtHDUkgR+iCr+8fgNMgyy/YLUnzqMeZ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sat, 21 Mar 2026 18:59:45 +0800, Kexin Sun wrote:
> spi: pxa2xx: update outdated reference to pump_transfers()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/1] spi: pxa2xx: update outdated reference to pump_transfers()
      https://git.kernel.org/broonie/spi/c/762a3847a05c

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

