Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6712E06D2;
	Tue,  5 May 2026 01:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777943394; cv=none; b=SWcixEwBAyPKejwJ3tik7GhROS+j7g49DVQP2js1fPB5gQRUmlpo1XgvTGeKY2WfvHk8k2gf+z7Gkhjeg/o07zMvoqQF2ZO4HUT7yqT8Eqq5iW61HAaXqwNCr2Kea6i05TAt/F/9MAeUVjH71N73cqRtq80bfK94cM1foPhITgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777943394; c=relaxed/simple;
	bh=o1uZzOmL1JlTx3tGHoLEO392d4UUpL2cSV7rd5nLdrw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qJu/Kb7jhGCMowLVnWWom8AblSdKpVqLm7dmTwoz97iQHWCWNbFtEbklhE6N1vzTuI+WB3B1CNQ41ES8LqwFDYniaYTTzgPYmmWpDzXcyqzkyzSrTdk1FaGZ/H4nzoFjLr1XVdxXXOKY4EibtJ5BWMZ0KSDLeoTdJx4rMaF0Oq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbWe4Yv8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbWe4Yv8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F14FC2BCB8;
	Tue,  5 May 2026 01:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777943393;
	bh=o1uZzOmL1JlTx3tGHoLEO392d4UUpL2cSV7rd5nLdrw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VbWe4Yv8ifSHSfQvl0zfUrcq35Bc0GGgkdeXZIqFs3sa0DdozqKwrtjgvwooy/BrO
	 Lzc0R3Lhrz8yht1kScRP8PZsH6ufQabwG234K9tw5NLdgG4Ws93ftyqaA3BAfGpa5Q
	 ZDTXaZsoZiat6jCcHjBPkM7m2xoS61Wc9SAR6o4P7lYVAWyk0X6GygSjXIu2cvhSQh
	 MoaM0GulKfTg2YeUU8GhK/x7b3loRd1OMGQF0h3Cg2/uSkVLSeyDBM+6DC/BwThoBX
	 tBum5E78YNxRYFq//xcZaQSK5hyDoMTBlNnCzub3RfP0kv0cBI0fQhmWqKtj37BAEd
	 /V6fm+LE6LYUg==
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260430120200.249323-1-johan@kernel.org>
References: <20260430120200.249323-1-johan@kernel.org>
Subject: Re: [PATCH v2 0/3] spi: omap2-mcspi: switch to managed controller
 allocation
Message-Id: <177790032810.458539.8852080278876891194.b4-ty@b4>
Date: Mon, 04 May 2026 22:12:08 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1506; i=broonie@kernel.org;
 h=from:subject:message-id; bh=o1uZzOmL1JlTx3tGHoLEO392d4UUpL2cSV7rd5nLdrw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp+UNfv1sIUe3SUmOyZgxWn3tBwHSAqm2b0SCMj
 dxVXlHRuN6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaflDXwAKCRAk1otyXVSH
 0I8WCACCdPs5lCfECuS57r2GyL+FHczmBb7feMCzLY4+IjBzQSP4eqWL8m4B0XojVd8/adxGDJV
 5TIBUPE5As+UhiS+Lesh/qVh+wNraTe2Erk1YVEnvHfmBH8WluZJUB+0OZ2x/DAHKUpYVS3xIXL
 Oh8nKvEr6u/dTaivZZc5BBJseTODLIfvdv73eOT2MOjUnhnA78HWbbJw4mcnObn/nmyUsJtJgHd
 737ZCfS3pbBMxtwIi+tKv+0C64gj+UwfI5+PmB8q8P/k33d/RbLNi6q4//ixaR1Qk8LW77uh8MV
 R11guNlj/n5Ixvbbj/ugGi94rLRlH5z13dc8CWDqziolONjb
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 30 Apr 2026 14:01:57 +0200, Johan Hovold wrote:
> spi: omap2-mcspi: switch to managed controller allocation
> 
> This series supersedes the omap2-mcspi patch in the managed controller
> allocation series. [1]
> 
> Included are also two related cleanups.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/3] spi: omap2-mcspi: switch to managed controller allocation
      https://git.kernel.org/broonie/spi/c/caf2fd997bf3
[2/3] spi: omap2-mcspi: clean up error labels
      https://git.kernel.org/broonie/spi/c/186fda6ee1ac
[3/3] spi: omap2-mcspi: clean up probe return value
      https://git.kernel.org/broonie/spi/c/46bd1fafc494

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

