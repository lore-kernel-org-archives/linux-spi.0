Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8815111AE;
	Tue, 29 Sep 2026 12:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790685430; cv=none; b=pQgOS3SZMpn4FfHx3jl1o0WhgT5ELJ2qtVgBqByJMJK+rrscJtqJu513JZlosz7MNZQuQIP7boU22S2IJT7aXuWBU34X8StGYgUhMx1eMeQB21utcMpdiAe215BQWWGF2X6xqki/d3o2pdGzcRo2Ub8Bs6+aIZ1bcyuKS6wzlWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790685430; c=relaxed/simple;
	bh=+r26wpA4P8dpYkJJg5U2bzHvUaibn2zioBBwg1ndoug=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iOUnxfTFrDs9hjCk+M9RGzx2uIcKPdzX2BQ5+lcf+PawdwR+G8Blner90O2UCnV5RwVHy+8g3lyKIxFaSJvrglNXDJuKISdzfKllSQooCvEAvxWxdtgN+uHbcvTpEPVFqEsChuQIjTO2OpiAmrqdyX1bBx0gPMdLHb7vYUBLwD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SI5hCyBx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SI5hCyBx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9760B1F000FF;
	Tue, 29 Sep 2026 12:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790685429;
	bh=0QGuLOj+qfCT9MeLPF6Bs9UcGV8S4px66Fx6N5h4OwU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=SI5hCyBxXD75oO5/nJotFR6aqc2H3Vld8OAQHT0WrxlaJEmRlBU7FLF3Afe9h03Sa
	 e7LmhI8soyJd/YETyJvMirpH0/Yv7NbVESVaciPWtiDIy8ZMBbK7wcnR0PP4y3ItEt
	 vCuZd8EQ/n72URmBMWbLz10KWiZCFr3K/1b+51VTkExkexnUhseDAFWWrLJHqqBO1L
	 fSomSTpvMqWwf4VaOgrzYj8gaplAQ8mDzE8wkK/oTggBCLh6+i2lqxSRxPXVuKCGxv
	 qHtR8H/pL6tRWXVPuwXG6BTgjbR7qdl3Ne56rFgHm5FeQ28Jf7J/mz/7elv08X/gM3
	 IjdpdGwksMgtg==
From: Mark Brown <broonie@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Md Sadre Alam <md.alam@oss.qualcomm.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 linux-spi@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260929-qpic-snand-drop-ecc_buf_cfg-v1-1-c9de93142815@gmail.com>
References: <20260929-qpic-snand-drop-ecc_buf_cfg-v1-1-c9de93142815@gmail.com>
Subject: Re: [PATCH] spi: spi-qpic-snand: remove 'ecc_buf_cfg' member of
 struct 'qpic_ecc'
Message-Id: <179068160040.115027.11339777816056138235.b4-ty@b4>
Date: Tue, 29 Sep 2026 12:33:20 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1151; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+r26wpA4P8dpYkJJg5U2bzHvUaibn2zioBBwg1ndoug=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqu7DxcVUd8Gt+fX+EAAKOxEC/rwVnAnwsjuCgo
 zGZyxycIZqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaruw8QAKCRAk1otyXVSH
 0KP7B/9UrVJTPvmWOsMdy6fn6IjljnT+NNlr6OUWX/Yvq4ewVOnfqOpbX9NbEXeDX1S5VthSd4v
 rv+Ay4/jObW03uaxR51RuRYhdDKAOnfw13eJhWTJp+cnQ6J8rsfueckkbQ0lpq92baq1eDezjRa
 m3uphKoAUyxzo3uGMZhVPZqwZgCZlWOeuF4C7WzUT6NBEbWhU8eKWikfdzvqmxOZ4vKcUAzGryg
 XsLFbeGer5z6C1Tebh6plCVqclagKI1F9kjZ3s1zEsZGjUL50qau7Hhy141oJMk/n00MTxC09c/
 nLarhD5SnbvsfdU3ya+CaD/pLEhQSEaW9a74Riyomwh2ju3Z
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 29 Sep 2026 13:04:00 +0200, Gabor Juhos wrote:
> spi: spi-qpic-snand: remove 'ecc_buf_cfg' member of struct 'qpic_ecc'

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: spi-qpic-snand: remove 'ecc_buf_cfg' member of struct 'qpic_ecc'
      https://git.kernel.org/broonie/spi/c/1f07c6fecb38

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

