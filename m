Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A7D576EB8
	for <linux-spi@vger.kernel.org>; Wed,  9 Sep 2026 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969228; cv=none; b=WNYrUAJgaHhIF64r23PtBftAoGCtcvHujh15aHxXqW55dXw5HZhXGxuQjvHxwQisKJfMM7M3421LZkbMxA+/RFflfFiFMqod/pfTthrwq3khlmVbTBMhp/i7WkTIbcJ3VFxKaqNGeDNrwovySmZhqOoKKsmHbLwmRTo88Rrc1NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969228; c=relaxed/simple;
	bh=0ks4/8O+dv2VXA7aK1fFkmIoucROu9n6J7HpMlSjmNk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V8TtmQbvmgqhsxCmF7ZlhL6IXS4sN/aR0BBGtozHaZ5u/z8PIzgT+PwVtAyI9cgr8zlogWfvjytH8ZnDNTnC99upfOGjCzb8qu+uDUMjbCUfOLxuklycfSIwdm3uXM2nAXd43PvhXByFF6ZFfHmeKhT3gMcT79UAsvMkwfp+cnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0kExflE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0kExflE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8956C1F00A3A;
	Wed,  9 Sep 2026 15:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788969226;
	bh=5kdBOTMmU5DfSYZP8j6aAUyrVhoCyluz+UsdILKsiG8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=g0kExflE4cDskFAtzSYSAvtEjc57MjJRrxghfBADwQOYEJxtnpJXXsjSSqqlUymzS
	 Glr0THm5T/LQuQvVkPx06QIaXpjZTmkay8Vtji414m6gOzakDovuLk5gmsQO7MjhZw
	 H020EgY95cOqY9AO3S4s3UiBuZ3fJPEMWnUrXGS0dJZdmB18nVIZG+Gq5UtwJclLNr
	 k2BSyiDolCBlFtZuqwoXXfuVgbtQXVku6hByFOEOsat3CMbOUncQ9xKfCIBPdtYoIV
	 CpUp1Od67jVtQ3Co8yMPApplmy+Jc1wwp5zSE9vWOXkoD/j643JY6Hfm7hYyx38ao1
	 3voh7CrazPc/Q==
From: Mark Brown <broonie@kernel.org>
To: sunny.luo@amlogic.com, xianwei.zhao@amlogic.com, 
 Li Youhong <dayou5941@163.com>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 Li Youhong <liyouhong@kylinos.cn>
In-Reply-To: <20260831094553.2247003-1-dayou5941@163.com>
References: <20260831094553.2247003-1-dayou5941@163.com>
Subject: Re: [PATCH] spi: amlogic-spisg: check clk_prepare_enable() return
 value
Message-Id: <178896045987.87467.11120635075116589342.b4-ty@b4>
Date: Wed, 09 Sep 2026 14:27:39 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1130; i=broonie@kernel.org;
 h=from:subject:message-id; bh=0ks4/8O+dv2VXA7aK1fFkmIoucROu9n6J7HpMlSjmNk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqoYEHZkIrejUJDn83W7ET5BGkOofXAWW+Qgs+P
 w6vcX3bDxiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaqGBBwAKCRAk1otyXVSH
 0Dx5B/9MNcQRfLJJ2QgfCdNMg2rd6KPW/lyBGzSsQ/KaIVcyhNWEz2RiXCzEOBFA/phpHdEekeD
 VkJTFdh9Ry6RJgMTlViRSOTBKV2SvgqJCJvA0lYI63h7Tl0tSTV5cpnv8nABa2wfIODWCT3kM7r
 v1bgzRgXGgnNLbCZGmmiswV7k13OhpQLWo3A9F3hYPOdqLQJQhiVfHFZx7/PAVmKdg6yncYFSIe
 v2B1hSL1mjRbd7t6P8JTxPhdxJRx09R8lNo2xCN0jzMITqqfc4J4FI6QmpFImy/X2TMJUETll/X
 7KopJb7bQcBR0MwAAhAI4/XV5Lk1RphDRrSAyyhUwCluYPLq
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 31 Aug 2026 17:45:53 +0800, Li Youhong wrote:
> spi: amlogic-spisg: check clk_prepare_enable() return value

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: amlogic-spisg: check clk_prepare_enable() return value
      https://git.kernel.org/broonie/spi/c/c595dcbce20f

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

