Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620204;
	b=y8/1f0IXwPS/3ySwKvXYjWKB0M7xlE7m96LvH22sablBRx7WPtp/M79Bpb3NXCU9s/e6
	 qeRwnl1x48flnxAX2icxdWYcnYpjSUnFRStsu5eOG4gQoxDzW9LoiDsrSsGSw8EY2sl3M
	 h53j0Qh8aAWE/Bm99uq928/myHcBcvTPpjrbJUznR91Df+MLMKZ5eg7keFaKnMayF5z05
	 gSk3/uK9Io6/Dsp7G9qeFkQddslRjLmNL0/IQUEaP0UTL78odGtC1u+LBNt+AmuWaEkoq
	 369VRmeCFH+bAk5hTJpRHOm5BwQufU5R57Ge/16Vs/4XsihW0IY5udxjctcmEOzJYxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620204;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=L3C9eeLer85Nd9nEHYWgLt1hiBYkBQpPpB78o7qufMk=;
	b=NbqH0w69OlYvsVGVI+gTLwePpkNdBbcgWkHvfSue/3bmDux5az1gK1OxHxbe9vJ0opZM
	 deM8n9w/6AluIVQi39cMMH7jsuhfjTGTIwUVlBy1iwM9G0aGUld5zaIk3ywBNZBuYocDo
	 xQjR0GxCs+0q6Y6YOzim2k4leH8e1C1B5rrSGLReCNdPG1hXtcL/Hij1HUNjtmhxX9Lss
	 CkpBgRX3p+Mhy4jYaQJ1GjbSRN7Hnsxh0N+p9P/Ti6FSoe7dbRrTCfT6GH2R2Bcxy2qgl
	 wo68rIebPBf1RviqaT6vuyX/4tDYNfV+aWrEmpyNZtftxRKbclN8BsDuRk3dMHYMtag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i1Z4js+6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B16B606A31E;
	Wed, 25 Nov 2026 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i1Z4js+6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A181F000D4;
	Wed, 25 Nov 2026 15:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795620203;
	bh=L3C9eeLer85Nd9nEHYWgLt1hiBYkBQpPpB78o7qufMk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=i1Z4js+6p8IaZI1ECnrcldkEwz4Cs1MI1G84hNvwn+a9uBwWmwF/n/CNJ+8IYwpXg
	 e60sfC7nHo0nJeC5siWJ51jRCPdctXXG+kmCgKkVoHrpowGNEaOVxaaks6GExDzqWA
	 o9LxrDKTYMIxCjjZdAcbAfDms6XJ+UdZX+e/3VL/sYtzw+Pg9Rknr9NZ9Ry+ulXEbI
	 G8ReTnTahWKOylFvT1Ix/SMPRz7M6LjnJGn/r0jkM/fNTQECHUnhdL2NPs72aBr+qV
	 36g9EobDZvjZdn8Cg5Ds47b6LAIhcNpYsUslYWhjEBi03vGlp4dFU0YTRTN5n/ocbA
	 DaybVUAjkXVeA==
From: Mark Brown <broonie@kernel.org>
To: Srikanth Boyapally <srikanth.boyapally@amd.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 michal.simek@amd.com, git@amd.com, 
 Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
In-Reply-To: <20261120-ospi_stig-v1-1-54f4d5f9f7b9@amd.com>
References: <20261120-ospi_stig-v1-1-54f4d5f9f7b9@amd.com>
Subject: Re: [PATCH] spi: cadence-quadspi: Bypass STIG for Versal and
 Versal Gen 2 OSPI data
Message-Id: <179554879342.947306.7979068047920510983.b4-ty@b4>
Date: Tue, 24 Nov 2026 19:33:13 +0000
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1162; i=broonie@kernel.org;
 h=from:subject:message-id; bh=SANk+j/6Nu2cjlqhijFVfcwE4gCH26A7WXTmeA6tao0=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLZ/mbM41qrfyPZ5t6nUkeW7hVMM3dJdVW/L/+TLrFzq
 ZXv/bxTHaUsDGJcDLJiiixxWdwv60ter+E7uLANZg4rE8gQBi5OAZgIUwYjwzORnsobQfwGLB1a
 j/a1JSxMP8fhoLHgw9Nosx3rMqdxmjIyzPI7n2/5ouvj5XrNO9O63i9+uZBhQ+xslfW+EktPfX2
 kyQYA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 20 Nov 2026 14:49:26 +0530, Srikanth Boyapally wrote:
> spi: cadence-quadspi: Bypass STIG for Versal and Versal Gen 2 OSPI data

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/1] spi: cadence-quadspi: Bypass STIG for Versal and Versal Gen 2 OSPI data
      https://git.kernel.org/broonie/spi/c/a2883431180c

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

