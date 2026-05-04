Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39D9282F13;
	Tue,  5 May 2026 01:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777943371; cv=none; b=iD3+RPCJLz3fYjDj9l+XQuZtbycAdpXxD8xUwflUiFB/zM5H37LeM2yECCNsFrLt5EL1WJurJ2GPnnnIhriri4RlMF0tAZkwQ/N4XDNh5La9fQ6SPVjMH4PSaRxbJpe6Qm2so2zqmEWedHbEeKI5BhMvzgp8k8UvgbCmMnrpcOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777943371; c=relaxed/simple;
	bh=gaHaFPgjaQMZ2v4EBeDH08VzS430+afxCYqRBY/ZgVk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lSeU9102GRVM8qeIull45QTuw8vFBjV2DwCzZhLrsoQ03O0aVZq++bStcFR7V4Z/O6s8RNqLb4Mw3oTYYwMAYiHaOWUYbWpfS/VDtXbRpbVaIg7+5YZzdOgCyDTTm7sma0QB8RQywZ+h52sjMlXBjjLhONcGxemx01lcc1eKXic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kj3+EQL1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kj3+EQL1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055A1C2BCB9;
	Tue,  5 May 2026 01:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777943371;
	bh=gaHaFPgjaQMZ2v4EBeDH08VzS430+afxCYqRBY/ZgVk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kj3+EQL1APZh8h1QwD0jm6is71JTY7frK+IvQjE9W9y24/Jy9sHPki8zHWg3wLCyp
	 xDVzAhBJzTQ99seNuMTq9g1pU2S+iUee8m1L0jezkRocH5/jsoGz2YBTcEejt2HwbH
	 aBr8U3x1PlbKl9fi3hFeQmBgryIXqaqLUHT66V00j7U/CbYJ8Amxgg29gcBjT4qYAP
	 WQ5lubdx8DE7skzi7OlQMNKWqb+rbIyjh8zrHpIlsQYXujCCSfl7EBeK7G+EMwGH1F
	 ithJcU6pdJiirAGsYwSK+D91ZdQV77i7ybOBayp1RQ+xZS4ts9kbTln3pGfTjaepVF
	 Hnz5Y74tH21Pw==
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Radu Pirea <radu_nicolae.pirea@upb.ro>, 
 Ryan Wanner <ryan.wanner@microchip.com>, 
 William Zhang <william.zhang@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>, 
 Jonas Gorski <jonas.gorski@gmail.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260429091333.165363-1-johan@kernel.org>
References: <20260429091333.165363-1-johan@kernel.org>
Subject: Re: (subset) [PATCH 00/19] spi: switch to managed controller
 allocation (part 1/3)
Message-Id: <177790019991.458539.13091377646661237343.b4-ty@b4>
Date: Mon, 04 May 2026 22:09:59 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3477; i=broonie@kernel.org;
 h=from:subject:message-id; bh=gaHaFPgjaQMZ2v4EBeDH08VzS430+afxCYqRBY/ZgVk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp+UNJ6BLP3nZ4xS5nwdunQfptPq4qUxTKzDWay
 6g2LVnvmVaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaflDSQAKCRAk1otyXVSH
 0IZuB/9brFwhbgZXTuRKJZNWTxBcEmB+0FygbYnjMh+WBdGgyJYxQbGZ9r1VxV0Ym/eWpk4I1YW
 Npx1eZ3E6tLZQU8WjzpT5aZq0l5+knHeeL5PgnXfqROkzIDHHusLDWLNkdNtoW7QVZ69yK6kb3c
 GP05A9gd+Kg8CUneWWR8hE5/mBLr1+uTLvowNHOhiQMvZ2Fr03ek661MrIVNlLB1Kyx1Ms56qUa
 IcjkVzgo8UmLbZBqSVSzJP+8W5jkztv2SOdCjs9mSm80My25LxMwscSLOsItRyYKDcILqXGfYm/
 9pyZNzHMamgvBVshpbDF6JLQvOU+m3+eDercVejmhtjEqHZ+
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 29 Apr 2026 11:13:14 +0200, Johan Hovold wrote:
> spi: switch to managed controller allocation (part 1/3)
> 
> In preparation for fixing the SPI controller API so that it no longer
> drops a reference when deregistering (non-managed) controllers (cf.
> [1]), this series converts drivers using non-managed registration to use
> managed allocation.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[01/19] spi: at91-usart: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/5113e2307710
[02/19] spi: atmel: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/ebf99aebc458
[03/19] spi: bcm63xx: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/414c359e7295
[04/19] spi: bcm63xx-hsspi: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/fe010594a857
[05/19] spi: cadence: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/83c4ded3917d
[06/19] spi: octeon: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/eab6ce941217
[07/19] spi: cavium-thunderx: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/fcca78c08638
[08/19] spi: coldfire-qspi: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/079c7a626c7d
[09/19] spi: dln2: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/6bd505e710aa
[10/19] spi: ep93xx: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/01500b2cb05a
[11/19] spi: fsl: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/6afe041c2ce9
[12/19] spi: fsl-espi: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/9979501afa4a
[13/19] spi: img-spfi: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/8015cac85a69
[14/19] spi: lantiq-ssc: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/8cecd707d535
[15/19] spi: meson-spicc: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/69fb8784c81e
[16/19] spi: mxs: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/f7c857559eb2
[17/19] spi: npcm-pspi: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/c0c6875f0b7d
[19/19] spi: orion: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/bdab3707ddfd

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

