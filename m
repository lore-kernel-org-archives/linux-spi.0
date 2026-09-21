Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9E6494800;
	Mon, 21 Sep 2026 12:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789993121; cv=none; b=MFillLfBgswwnmDxdpv0YQDHmBdWynN1psB/dPuiGsZMvgT2UokDTu3n/9EzH0eHy41fVpLoXmoNrec1luAXwKh8R1faI9dKn/MaTHBKoP1YuQmmLTIJCoonlxmhtXqzG4Hpo/6ggo03fbW4v93viLEoEEmZcnDEBPEODgR6EPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789993121; c=relaxed/simple;
	bh=40d7/dkUIhDBbtJ14kZtM63YUxHuyDtkM3vZBppXzcw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bnuQc8h8+C53e6r9CueNSDQbQHrzqyl+Funp9pqCAxuaCRm1XNqBWHOGrcumWqw0IYyzDl+LxEdioai5odw1TubVmOynkEIuWW2LZe/YQn+lhwnYrBmaKENpTPPbx+6emJ4i3+LfBZ4X8cAMZJ3+iQrggbzNFiijiqhqqK5U7MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXuAJd8K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXuAJd8K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9327F1F000FF;
	Mon, 21 Sep 2026 12:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789993119;
	bh=KIZFnC8ruZVGF/QUyuF9da87PmsPWq++1WWUAIdlU0I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=JXuAJd8K62lzbKcd2oxFIwbCCUwVj+kqBBJtJpMo2kF4qkvwFbZGfNOlRYFjdEQLA
	 9icMaw9yAvGF/9kdmW4VmmJdm8b5cykRHKXJLAOfLbhKERprAn3Bl3CDGxJ8SByf5z
	 3DCzqqUqUgNeMV+3z1jSIN+/nlbDOZh8Z0gIl9TlT2mYUSkXHvaAQoVfsH4gdI//6r
	 BcMN7XsNBDjOpS8jsFXKwazNg2le9lflmijoLnPX7rw/e+oL5/6SoiQCuMpvkMJJC1
	 iQhATX0/+fsdGx1q5jTDLxgm6r5tcrcTELMajXaBDiVR6NkayhYV72CECsQmUd46iJ
	 dGMQvF3ZXp4Bg==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Vishwaroop A <va@nvidia.com>, linux-spi@vger.kernel.org, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 linux-doc@vger.kernel.org
In-Reply-To: <20260921044713.93122-1-rdunlap@infradead.org>
References: <20260921044713.93122-1-rdunlap@infradead.org>
Subject: Re: [PATCH] docs: spi: spi-master: use literal blocks for commands
Message-Id: <178998119672.153388.4193614944500459208.b4-ty@b4>
Date: Mon, 21 Sep 2026 10:59:56 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1122; i=broonie@kernel.org;
 h=from:subject:message-id; bh=40d7/dkUIhDBbtJ14kZtM63YUxHuyDtkM3vZBppXzcw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqsSCa1ecs/IJ71O884NjoIS81PSL14Ohg1gjQZ
 Q0RkqiTFpiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCarEgmgAKCRAk1otyXVSH
 0JVaB/0XhWmDiPsCTLerxqQVLZOYi4xpThDzDPltuz+EkfpyjQzVV+HUOQ3dhqSiBItOk4i7fub
 eXdgQKQ6EponHLnpNU58zusogzPh+u166xVogNr7EyGGu0q9APfOcRLUXdrFy5tYAm0cCLlzevb
 o5BFv+V1uT2OoASSueDAi1EukodXfu8ix6s0z5bbZXDVcbZq36NL30w2ADqhE9ngY7eqUG2JYxX
 HppG6dtSySk0o/ngddOY26t6i98qF1V5xAd1YSwHnSucNtYyz9G2px+4ETR3c03FZjo6EXWFGQh
 deMcb+0Xtcf9JGp6oHhnNkPONY39aGbnousONSvBtxl0XiPz
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sun, 20 Sep 2026 21:47:13 -0700, Randy Dunlap wrote:
> docs: spi: spi-master: use literal blocks for commands

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] docs: spi: spi-master: use literal blocks for commands
      https://git.kernel.org/broonie/spi/c/3c82e199d411

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

