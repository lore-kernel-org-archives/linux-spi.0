Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F543C8C55;
	Fri, 31 Jul 2026 23:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785540024; cv=none; b=cscDyO6BhrL1JnnSJYHkWkogY7ZU0UjnnWCX9gWIVk/lN9hy3ZYCjkxpd1lDqDvh79A2jkhaa191NfOnMU8gPLvMyrOkU7c6B7cFX3FAQkGlpNtjKHLG3Ogl/SsA6HyBCYWw5sjrNqrRPfX5+X3fOosuSTM1CZvHy0M0IBQoHF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785540024; c=relaxed/simple;
	bh=b1jbsBN8PVKIk1W1VVQJ7Hb77/au6VADIXZdL/L1c3o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j9vTe9eAF0XgJ20CE1I5fI/vgxrpo2BNHKs1ISGkbTfFIFm0qbY7QE3zULalr9wGEvINSKzoKiIVEhG472aeQ+WktAnqJGwKXRGAxtCrlysiftIA3ygwIyPqkIZ7lUI+lG+WmmbotAMSbiXZSnEQgzBN523E2+QZHjxkWTK8Y+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHgVz/ti; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHgVz/ti"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29721F00AC4;
	Fri, 31 Jul 2026 23:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785540022;
	bh=8mkw2ozZY1Mo7jsuI6tkydXSVhLTGH/6y9oFCam1vp8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=DHgVz/tiNc6xVf5ezGNzvzmeT+JpI7/q4uW8guJR2XDc7BSs3BtWb7liSZxMFca9b
	 wWUfKP0nMTXvV1KofHwNnG13K5hTuImnRJKl51J3hQU//ZAyMqfV9IRdLcqIAuM12b
	 1FYwUgT1lGhZPgvAZJmRMg+zNNhf3Xi9zzdu6CeBtLdbtIL7TrD7zVznoQpoFewnG4
	 aK5Fv4YBNYSDdrQRXuYF9Cw/ozgjg5gwJg0zCNMiTU+OcUgHh/JToMhpauEBZaodlQ
	 go4OYqzjKNnzQR9C1ir6yZLqOqKIuqiztiyEnGz6Bd0tHuCGC+qjfkmrLSRA9NZe93
	 J/3ijLG5qI9hw==
From: Mark Brown <broonie@kernel.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 cwweng@nuvoton.com
In-Reply-To: <20260731023818.1626075-1-cwweng.linux@gmail.com>
References: <20260731023818.1626075-1-cwweng.linux@gmail.com>
Subject: Re: [PATCH v5 0/2] spi: ma35d1-qspi: Add Nuvoton MA35D1 QSPI
 controller
Message-Id: <178552979126.353541.328189267219361170.b4-ty@b4>
Date: Fri, 31 Jul 2026 21:29:51 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1438; i=broonie@kernel.org;
 h=from:subject:message-id; bh=b1jbsBN8PVKIk1W1VVQJ7Hb77/au6VADIXZdL/L1c3o=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqbS2zeX6rISPNvKpyKp8c1RxviMtHppXNrokSt
 /Lu6u2F/TKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCam0tswAKCRAk1otyXVSH
 0P3DB/4ksrqYeNau7j6Rik9hG10h9oSsTDlcGayjNIyj4T0B8peFSt6R3SPT+xPDawU29cJghuQ
 JEBbrI4r9t/UUJ0Hx55xY2RWhal9yqvg/+fZfWn2ZVKmalVrsZTJ4bU2G/VrOZmuUsef7NGBIWQ
 Waqnwvbb0FtBUegUh8+os1CO0/N+m9VsAAZCZf66WBbLjaR6LxuspN4vgHJOAiPC0j+BZo7vSGj
 MJI/9oQs+m7Atu8eeESvA9F6oj3sNJ38BDOnSr7/7KZtwNvYZCi1YlJiMbeaMI32T40PPNwrpvm
 p1W/tywBqEwINGe075qcmt14qMlDydHLpTxMCTG7Qwp9DqZ7
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 31 Jul 2026 10:38:16 +0800, Chi-Wen Weng wrote:
> spi: ma35d1-qspi: Add Nuvoton MA35D1 QSPI controller
> 
> From: Chi-Wen Weng <cwweng@nuvoton.com>
> 
> Add devicetree binding and SPI controller driver support for the Quad SPI
> controller found in Nuvoton MA35D1 SoCs.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/2] dt-bindings: spi: nuvoton,ma35d1-qspi: Add Nuvoton MA35D1 QSPI
      https://git.kernel.org/broonie/spi/c/d458c752cf6c
[2/2] spi: ma35d1-qspi: Add Nuvoton MA35D1 QSPI controller support
      https://git.kernel.org/broonie/spi/c/78b16af159ae

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

