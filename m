Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3488395DBB;
	Wed, 25 Feb 2026 19:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772046460; cv=none; b=TG+gOUTJUJUMHfCXDIQgY5R765HSAP4Jeowa5iGD1Z05WADNRmhFi8eaV8beLwTaCAI5sHLWGTAPcHyv+RaXM3cK8ooIvQ4d94+KUzL03liFIDLVaq1CJ/tk75/TrUPE46svlXt96vPZf8CTKwezGw/1bGrXOM/dDfujYG9dTJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772046460; c=relaxed/simple;
	bh=bI+Op+k/62if1XQZhqOZn4GmEtiaxB5GHYdEO5Xw5Q8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=l587yyf+HsiY31hoo5jau9sZ6guFISSmsoG+93fDdolK+itIM42me22a6eCbqJZc36RWsesWl6NH04t+YBCLBbbGDg+Rnn6YczzV1wsQJKkZtsuu3b0Y9t0cB9bCQCdIYDrSH+R3PVLGP8BxiY2ZmqR9nDg6/RwsERPO2J66xt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmxezAw+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmxezAw+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0529C19422;
	Wed, 25 Feb 2026 19:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772046460;
	bh=bI+Op+k/62if1XQZhqOZn4GmEtiaxB5GHYdEO5Xw5Q8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JmxezAw+Y/L9/rljxKrYvciHY3AqhSrQtv9hHB0ln7aW/hTCVMd7cZFV8w9VmYNHV
	 h7lJvNh0xg2bACYHHbI61Izugl93tIBJMT3QBccYl4FW2Nih862mTAOSUePVDowouH
	 +/E0JMvQsBj5OPZL2MCxub0R23DsEojy4MJzOGQln+QoM4weJ3jt/frieE4scr8PPr
	 Rz0XJrydCdS0Awyx2yScST0yee1HcjaC1h9zm4DaR5i1Jdye3B8S5mBGTP62UIMjGS
	 HsoEDzPVtnx6E7Jb3gUYAMJwxzWXYptVkV7Ej+H/Ir/mLq7/SgK2fQ+B2ttc/0ygMQ
	 wtP20oaAeUEtw==
From: Mark Brown <broonie@kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260213-upstream_ospi_remove_exec_op_debug_log-v1-1-164f17515fd0@foss.st.com>
References: <20260213-upstream_ospi_remove_exec_op_debug_log-v1-1-164f17515fd0@foss.st.com>
Subject: Re: [PATCH] spi: stm32-ospi: Remove exec_op() callback debug log
Message-Id: <177204645867.169139.10618667712861229552.b4-ty@kernel.org>
Date: Wed, 25 Feb 2026 19:07:38 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Fri, 13 Feb 2026 09:19:11 +0100, Patrice Chotard wrote:
> Since commit ad4488845193 ("spi: spi-mem: Introduce a default ->exec_op()
> debug log") a common debug log is available in spi-mem, so remove the one
> from spi-stm32-ospi driver.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32-ospi: Remove exec_op() callback debug log
      commit: 52531750d39b94803e089dda95e43925730c03bd

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

