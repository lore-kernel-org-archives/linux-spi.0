Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C929466B74;
	Tue, 30 Jun 2026 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834536; cv=none; b=loDnbbDD3Fu0Cw/GKO0ZlaxO3KMpBTZI4JZp10EkEvDFsebJWgBUYOtvurKC52VBrNTwALFdt0mXQHCDgPLUcDtVF/RNu0m4oYxMdthuiABjgwyLPKdK4DIXyd6/7aGT2Xax2vngsm5mz+yBYcPZO2DXb1If4QonOepf2gQoZIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834536; c=relaxed/simple;
	bh=hYQcgs08EJQmX1fD4fD6n4V65TZK5swqC/qt8S1ySl0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QUd9DCS8U1KVy1Mj5+vYwVdxoGdHued2pTqUAXSQgS301UZMchewxFAXvJIm2RVaOoCdCsH+bMrROlFPMN9DWu6597/2bPUsJWsSfu/qS5rEfZrwsgIbyXT+BoS5ib9/rR1ZcsufpKicsEDCj0tTQ402jIKeaVhuBDuzSBeMCiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g357mc5f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g357mc5f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D371F00A3A;
	Tue, 30 Jun 2026 15:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782834535;
	bh=NEYOhYv6ArVBt2stTjzgKo/ytuUeobwYcnoWRrKWKu0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=g357mc5fhDJtOff2Tj/nAPuPVh5I5dzU0L6cdKP1E3/ZzpqxiDDIb8n22f5VuXUeD
	 PdBCba/KLBomVTx4K43u0RPSOy/m6Udbhokq+qCfyB187iSyE/SH/mi7vaVgOw1mXi
	 h5P8feupqLtD8g/fj22PaOY3Gv8vSGVyZsO0wtrb8gBRoxH4/rYe77RJsMmMd5SN5q
	 16l2THIMvUOWDHUfTqcr0BM/pq0bGfNQn8bZyqCqQa6OUPbzzVjIK4AODZxMbN8wzf
	 Y06b0hpEH311ru+daFEpz4AgtNx0pmEyJO32IFgnxOBf0/I9zsGQ988xz+6i3l2eV9
	 PNYEURjuNLIFQ==
From: Mark Brown <broonie@kernel.org>
To: Jiawen Liu <1298662399@qq.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kamal.dasu@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
 jonas.gorski@gmail.com, kursad.oney@broadcom.com, 
 william.zhang@broadcom.com
In-Reply-To: <tencent_0BD7D4091B90EC17A8B2BA5EBA8803725905@qq.com>
References: <tencent_0BD7D4091B90EC17A8B2BA5EBA8803725905@qq.com>
Subject: Re: [PATCH 1/3] spi: bcm63xx: return error from failed controller
 suspend
Message-Id: <178281936779.79320.7982735612466422622.b4-ty@b4>
Date: Tue, 30 Jun 2026 12:36:07 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1377; i=broonie@kernel.org;
 h=from:subject:message-id; bh=hYQcgs08EJQmX1fD4fD6n4V65TZK5swqC/qt8S1ySl0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqQ+VkwIuU6RR9ilKhj5XzPF3wK256J0IF4TOk8
 mG9Y/G3DXaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCakPlZAAKCRAk1otyXVSH
 0AgbB/sGhijh2G3Br3fMabAn0x40QR9yqVhLlIyr6DdFFKm+cVpqCSeBcN2QBS0oUtOcw1eS8mO
 FCH2Tcx9HQA7A74FCusW50mxwQwQYcUx9QSI2q1xCgBO73nvylyolQ7EWVGJVH6yd0cl03xNpdp
 fn2KD7z7DewKC4lJyrQh+/xZZIiokk3nGMmmHmiesa06Ba+W0UkdsiYaudKUEJYA5+9JROXmhAq
 wrN29ggDxRmM3Pcvmv0kWxY4yCHdphRnttgaLr2U6bw+3IGGc42Nb6fg8b4snpE0sXjWHkGp9gq
 4kpKFKZ/v4jyWXhiTZE9TOTGh4Hn4YZcaRcV7Ac/WjPf4C33
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 18 Jun 2026 20:45:16 +0400, Jiawen Liu wrote:
> spi: bcm63xx: return error from failed controller suspend

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/3] spi: bcm63xx: return error from failed controller suspend
      https://git.kernel.org/broonie/spi/c/bbbc1ef5b353
[2/3] spi: bcm63xx-hsspi: return error from failed controller suspend
      https://git.kernel.org/broonie/spi/c/3b5414d76a03
[3/3] spi: bcm-qspi: return error from failed controller suspend
      https://git.kernel.org/broonie/spi/c/44d09ef0ba69

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

