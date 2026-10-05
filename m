Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A5E3BBA0B;
	Tue,  6 Oct 2026 08:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791274434; cv=none; b=WNYhOvM7Q8zpbjJ9FWkrTgfn1vlvtGawJX0MKa2bHN79byKshnd4+7O5y8jLGEejilL+LxnyYqYozkY3txxIvvsfogIC11T3Xpj8+2Uj37uVvtvADUpfYcgkeWUAEKgTas+Aow15xfKoHtzccBaHA+yeJCcOCoZ8k2bF+xT3+4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791274434; c=relaxed/simple;
	bh=Q9vvcmVBRhpRz4C85yLdcNbZrICgW6aw5aF8WscT2f0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KF/wVYLLp+lO/lhxeAAq7zvA/Ao68IWgiXRoCR3e/0/RwA/Sdqvr1aGCYP6mU4OEiaF0lKoc8INF9NsNuGxMVwNBTtVG94yQhCwke7ikYBPe/+lneq/4yTm8sxDER762KOrs09RjJK3Yj1ab4aZ/M6OwAog3HL4Qy1jX+jncM2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZUV1UVM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZUV1UVM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716231F000FF;
	Tue,  6 Oct 2026 08:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791274426;
	bh=Q1T4SsA9cY1Wq3Hbv74FXfyPET5SOEe7zIh1TvR0e2E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=bZUV1UVMswQRIb7ckKMEglOX2Lfp3F0LP7orGSpFUe3+NUt8gZEkqXP9ESeeitW3k
	 SZLIlA5anCqpmcCWlUWTP4Hlfc0LS+hdrBBAMOKkG0758wG/8Yq2uEwTbeRc4vODWH
	 CxYyJ0V6tl+kO5eJJmTZf/J1vQJE6Z7xJMRQMJl+0GBmYxutqmH6yBWr8khQSfuXUb
	 wURhE7A6dvmCpc5lcXysrpXM+Xp6z9OXOAUt9gL+qTEcGx68nwpXmL1kSleVosH9wK
	 mwWAUoGSZZOWVtAp4EYk+7MzhNGIZGJgRo2jXN/Jp+Da2uvSjNSg8mOOacbw3NH+kH
	 oBpRP582VVrnw==
From: Mark Brown <broonie@kernel.org>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Radu Pirea <radu_nicolae.pirea@upb.ro>, 
 Ryan Wanner <ryan.wanner@microchip.com>, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank.Li@oss.nxp.com
Cc: vkoul@kernel.org, imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20261002192616.161440-1-Frank.Li@oss.nxp.com>
References: <20261002192616.161440-1-Frank.Li@oss.nxp.com>
Subject: Re: [PATCH 1/1] spi: use dmaengine_submit() instead of
 ->tx_submit()
Message-Id: <179120912507.150114.2210463827298762700.b4-ty@b4>
Date: Mon, 05 Oct 2026 16:05:25 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1126; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Q9vvcmVBRhpRz4C85yLdcNbZrICgW6aw5aF8WscT2f0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqxK2z4yfag+huYeSHQiiV2RWVwh9cfdo/5MeNE
 sKQW0snmweJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCasStswAKCRAk1otyXVSH
 0BXmB/9BzBhmi/lfw68HGvnsbRuqqfe/EtZ6MgdZ3G+uMmanQnuOStMW2NppVyb0y6B3026WRDj
 27T4owhfLSBjHLugF9LdQ13iP2EMWQx/1KLGA6p2pZtoTHkp0nNh3USTZf+ALMhHBl5whv4v2i7
 gRZD51qQ8q6I4ulLfKhykyWQqe3TEK/AVILdVz/OmsFdbHlGUldyysSSxCC9Mu9UWkh3WjdYA0Q
 yPUrLDkDTqACI7vslyhz/PCyL5CnsIu2At86RSgIl1My6ZFDZEnqYs4GnQHa01AWHhIJuH93col
 deBPBWcrSOTTfBrzt8Q1PpxChKDCVjVIcQyx96lkSbNdv+mU
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 02 Oct 2026 15:26:14 -0400, Frank.Li@oss.nxp.com wrote:
> spi: use dmaengine_submit() instead of ->tx_submit()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: use dmaengine_submit() instead of ->tx_submit()
      https://git.kernel.org/broonie/spi/c/ec79a280e8dd

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

