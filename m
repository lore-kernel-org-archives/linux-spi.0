Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623385;
	b=M0pio+fwadsGmtaZVmY2bXvc5VDZEOLQGEn9JM3955nokR+buayjhSDI8lwYFqlBcXj/
	 pFkiR6dXjcapT8LwAjqpiUNmnbvLQNxxlC8YG5IrSG2vdG9cVgcvlcsaCsZIlG6KdPiVi
	 gQhmMLlscJB7a4scdXld6ZoDZaCK9zN0pcG+Xu8+jtjcLX5onRXrQr/oRFEUPFrkH8Jnn
	 H1nAX2v+Q2ru7dKTRXsTjO+39lADuL0r2f+nCMfomAO8UMbmvrlft/8MpvHNOe0X02SUw
	 3HyrJQRFkceZBOWoZR6Q1XhtZi82jcZ99ItwZBkozalaycdseem0z3we1vcDENWtqCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623385;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=SkXyzh8uT2n1jzJIe19qHbcn5tH31EHYHMtwETTViV8=;
	b=LoT3uLtpaCA+h07VNbFbl3jeNgItM6doJiyWIWJbanOpQK32RHc6PaTh3sdWUcMGu7LE
	 PIKaqJ7e6Go77V9qJ7lzJuhkUMT2xyYsOAyzTFsAAa8fCNvLPxp4VX+oQ/6CdbdAi0Yp7
	 Nnvc4BrMQTSOQKNazXvzjUJmcK6zTtQsforjYQUKOgJJu6Fp2ef117zYtpeRoqpxplIt5
	 60/w9DnC5aeG7t5Awevl2/DRi8n+JKUeJtpSdd0+WuRxcca03z9eyeEk84SV+/d9RrvZ4
	 zy2OlwFAUqI7pg/LSOpMrWTIBCr9Qrm6PXpHojeM/CAKTwFjongkd/BvaAbKPjHsu6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dygrx1KQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8618C60A2628;
	Mon,  2 Nov 2026 12:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dygrx1KQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10ABA1F00A16;
	Mon,  2 Nov 2026 12:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793623385;
	bh=SkXyzh8uT2n1jzJIe19qHbcn5tH31EHYHMtwETTViV8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Dygrx1KQGHKITDdGJ6ho8goP6He7C298oqfMEJDT2hEHEdUoAMLdwtE0MJRUDRkrl
	 oCIVEG+HH0iRMoNxe4KGYLjV6eWbNLYDPYjCQICYYwUmAeSJYVA2BBbNlyFQMh9uUc
	 l98sE02TyvhejTuAkj5QCu251DsoDls4ZCkE+qx7ERrqTweQsl+diyMvTZxCXYbE3Z
	 ikSKNqo9tCui5MzndA8MWQ9N2sBxMrWfbkcWIcl82HwRkvi+GQNEUSloc6PjgyJlFc
	 /verUi14EBJppjTd0paUJKMuVtMlS/6Q30o0FpwZPz7+085AYAbj/djQd0XzetDVnt
	 Ku/POgBGGRLqQ==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 5C3722310529;
	Mon, 02 Nov 2026 12:43:03 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Hongjian Dai <daihongjian@kylinsec.com.cn>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 purna.mandal@microchip.com
In-Reply-To: <F5276982A630220B+20261017075545.95854-1-daihongjian@kylinsec.com.cn>
References: <F5276982A630220B+20261017075545.95854-1-daihongjian@kylinsec.com.cn>
Subject: Re: [PATCH] spi: pic32-sqi: fail transfer when the BD ring is
 exhausted
Message-Id: <179357807106.1716893.15775820389064671168.b4-ty@b4>
Date: Mon, 02 Nov 2026 00:07:51 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1132; i=broonie@kernel.org;
 h=from:subject:message-id; bh=8D+Gi3HVmMsBqdAbOX6/jRrCsq3dejvg01M4u2eXuOE=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJetIbPakl1mM/yzf9e0JsZ1yv6Nh3v6D3nEa6nuLa0R
 PPBinl3OkpZGMS4GGTFFFnisrhf1pe8XsN3cGEbzBxWJpAhDFycAjCRl3MZGda3COlZPNnCtiHj
 62R2PxM/y6enJh7PEf05YftBtiWWBycz/M+qOdj28/Kss/edPn/p++yYfjko0Ciua+OcJiftp9o
 S3bwA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sat, 17 Oct 2026 15:55:45 +0800, Hongjian Dai wrote:
> spi: pic32-sqi: fail transfer when the BD ring is exhausted

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: pic32-sqi: fail transfer when the BD ring is exhausted
      https://git.kernel.org/broonie/spi/c/2066970324a1

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

