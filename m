Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C943E3D3D06;
	Tue,  2 Jun 2026 12:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780402071; cv=none; b=saORwpUq/oiE1WEOYaas54Mbd9Ip6Gr+EczL5givvjNH2L/gcC88//S+EVOoOfskGf4zUJvfIwuZh+KT/hZkrTap0mihF/08RufUmliMdIu6sLVmb3uS1G9bvGkFybOqjw5ILiR2/I/c67YdNhu7VCy9gXxw5oRKCX/cwJgJMd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780402071; c=relaxed/simple;
	bh=yxQQ9gaWWDoS8ysnsM1La01w5SvAJPAnAKtiYQjwhXA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ePkrxTOUJtkD4KZoZTyG9uyuf8nR0BUClWOsGBAT91MsTP9vUe60U8co8yYAvUlNg5V9RQgCu5JbkCaOqbZ1qkvj3vGGdjavshoI6/5ZayxLdG53uY4qyHRfIcn9VervpQYr+LWqpUJfXPo0buymm95+VnCCICZ4wrwxqChOnvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XU670/ye; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XU670/ye"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B8A1F00893;
	Tue,  2 Jun 2026 12:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780402070;
	bh=AjocX/StcatzA+7lRhbJocmTLZYm3zu6CJOUvlYp57c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=XU670/yewUMzeHj1IfYY/Nb6Ee1nuk67I6Kp6MR5lHyAxYXSqQCIZ9pkICxaVigzy
	 lAw/kwonX77zDqUXN1gcuILviEGr+9GLl7tpca035Gv+AbQbvpfq6/pCw+q0M9Fvx3
	 gpEnNdOEF1Boqht4U1mL6HcI0Jfbd+6y/j/4queDTCcbntmI4L3vGJbIk0iCC2cNla
	 KMUv1XUUCDaOTwUXxTuFV9c8R2j1WKE4+PyaWEyMgPBe9yYov6mvfyxybQWDU0+HDn
	 WZKMkon+sUWrgwDZJAlyaDGl+Efk63PYhm2H3pVk56YtCo3k6XLRu8E/O93VGswhPM
	 yakOYslCiUvNA==
From: Mark Brown <broonie@kernel.org>
To: Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de, 
 festevam@gmail.com, carlos.song@nxp.com, 
 "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260525062928.3191821-1-carlos.song@oss.nxp.com>
References: <20260525062928.3191821-1-carlos.song@oss.nxp.com>
Subject: Re: [PATCH v2] spi: imx: replace dmaengine_terminate_all() with
 dmaengine_terminate_sync()
Message-Id: <178032292667.44654.11142076412680419763.b4-ty@b4>
Date: Mon, 01 Jun 2026 15:08:46 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169; i=broonie@kernel.org;
 h=from:subject:message-id; bh=yxQQ9gaWWDoS8ysnsM1La01w5SvAJPAnAKtiYQjwhXA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqHseTLt8mhqABkDo/qpwSXNB94dDjhnTdFjVXA
 I214VRm64qJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCah7HkwAKCRAk1otyXVSH
 0JasB/kBexDdlFvqw5k+wXp4BPUn2L1tMWX+QCjBx+aHKPBWg1XEE1Hw9ZAjSBMc4BzwUknrzJi
 wJ27ApFrkntai7kX4DzB6PIWyUFmw0kSylVQakjz6g2a1SDCEePAbOxlD+K38SmJo8ptKj3CSAt
 v8QliTLMLCRrdTK/KHKQYOM3uOmqEeJMdx2Aj5+R7bt0SkOZ+D5a702nDQceQLHxkzTBwb4WbZf
 0/wlM2mHzTF1cfYQiWgjsfMRcTJEYbgNmxrddkaAHntu4C1I/hwD4s3SmJXjLY9XAKiU+mXHViM
 o6sa7dHNQOWQgEfpwANm39juHkpiklqyXOlshLwK8XqfWNRE
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 25 May 2026 14:29:28 +0800, Carlos Song (OSS) wrote:
> spi: imx: replace dmaengine_terminate_all() with dmaengine_terminate_sync()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: imx: replace dmaengine_terminate_all() with dmaengine_terminate_sync()
      https://git.kernel.org/broonie/spi/c/4503b2fe761c

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

