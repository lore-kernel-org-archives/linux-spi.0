Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D2C1684BE;
	Tue, 24 Mar 2026 00:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774311132; cv=none; b=fgoInUHqKNniRKNkadQnlxiV6gvH6lhS8iAv1I5Se7cep9f0fgPvn/G8Hl0gkVihvi1STmE+1KKUTin/NjW5vKYW2nFoO8jUvUsgom+wKAtrebPT2hnD+B2yjRcB9Jc5JCZg8a0P1sFI4yrAKrhp8vjVH+idkviys4d9gF3/kVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774311132; c=relaxed/simple;
	bh=fzzp9pPjHZ01Zmq5YuvtiG1A0Qb9NxE45c4ILsVDQ30=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=F9jR4dNTfiVLJWPrQ3oLIXoKLkmzI9HqDKkrQSQytLp7OvXyfANu5h0B4tnebKiPX+ZM4VsPNP+dCLNCiLDKl8oCe7J1xvPc+6cFMYUM3jQtutEisZTrKKZQzFcazIsFh5svnRPnnadM+MqY5etnukfnBmBTaBo8vxuXgjGLuHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E65CzNXV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E65CzNXV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1A1C2BCB4;
	Tue, 24 Mar 2026 00:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774311131;
	bh=fzzp9pPjHZ01Zmq5YuvtiG1A0Qb9NxE45c4ILsVDQ30=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=E65CzNXV/qMDhWcN4jqRbdigwxjL3g2fhBelx1hWWeKMZF91i+rEfT2eNpqul7NR9
	 CObyfBE+A6jOV9GXHYNULjN0CBaKE5858/14r2Ptxv6q9YK1EdLE66yLXiR9Tj3wYL
	 BNJyvCADfWbEaKguQ9XOB7UMmyb1zIvWusOpFDgNk5G40G5gAp+3iewMAvrX0c0SWe
	 59/1Rg9OGcZODZWewYByBINONqbr76z2zULlrJs1baVUCfp/cKB0+zpOx3fuNXE1v+
	 s2VLYS/x1Z7QRi9Rdh0IRgl/HTWaV9VaRRhKiegoXrvnKJrN9kTODq3eP2bJkjLDUZ
	 yQE1u6I1aJkYw==
From: Mark Brown <broonie@kernel.org>
To: linusw@kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kexin Sun <kexinsun@smail.nju.edu.cn>
Cc: julia.lawall@inria.fr, xutong.ma@inria.fr, yunbolyu@smu.edu.sg, 
 ratnadiraw@smu.edu.sg
In-Reply-To: <20260321105940.8143-1-kexinsun@smail.nju.edu.cn>
References: <20260321105940.8143-1-kexinsun@smail.nju.edu.cn>
Subject: Re: [PATCH] spi: pl022: update outdated references to
 pump_transfers()
Message-Id: <177428946630.537498.3740041984153015633.b4-ty@b4>
Date: Mon, 23 Mar 2026 18:11:06 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-17187
X-Developer-Signature: v=1; a=openpgp-sha256; l=1127; i=broonie@kernel.org;
 h=from:subject:message-id; bh=fzzp9pPjHZ01Zmq5YuvtiG1A0Qb9NxE45c4ILsVDQ30=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpwdbYCrc+VxhI9fTAMG6rQaPJnTW2PjYTaKFN+
 iVWAHoyU86JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCacHW2AAKCRAk1otyXVSH
 0NSGB/9iw+bXso2wFRLcYwKkibQxiDoN5VD0moMK+Dr7D7txhXuCU+OsabTPdjgixBub/v/VaoF
 B1HZtl61Hbu+J7m85FUezDRTKKewmn6JYRX90UYNo/M9ehe8lPMOyVXaA7mnT2TKyI1nSh+Z+Wu
 XF820kSdziXGgAvfOjo7LPuMSBPTHTXyzO5fL96lCUUP1NHBTVa9sFSBO9nbPq+5O0pKRIIm0rf
 YFC8Tu0qL5LVAO+/D4sXuZCqEsG7qmEyVn7WJW1V7SfJNvSAZUs3/54QSTZ4YM5h1lKmgt6KBpn
 xwswgWlQnj0ZjkjbPQ2s78ZwhJGE5qNMREAllgYzqCDUqPzL
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sat, 21 Mar 2026 18:59:40 +0800, Kexin Sun wrote:
> spi: pl022: update outdated references to pump_transfers()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/1] spi: pl022: update outdated references to pump_transfers()
      https://git.kernel.org/broonie/spi/c/a37fb5166be9

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

