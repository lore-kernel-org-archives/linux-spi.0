Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.242
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794158651;
	b=pqulIznkDdciDUj2LhJ3GmgDdlAX/jdfLxkgwhlwvywA/OSUG+AUA+VuPKD6+F+FboXo
	 iwq8BmMkXCsn+paGXQ9h2sEwtfyXG1LRpO8tGak73k3a0aMUAQ1eSxg7ylQKzcOHAtk9H
	 d8SvgFjka3bqvmmBPq1clENT9SPTlwOkCbyk8ESy8IbUtLRGTLaAb4utlb6gjNzzfv93H
	 tjY8ElUJdlSeE2EbVQYpDLmjkrrhH2Q1aF+NcccGaPqS/ES6erd4ohyVL5BpOVx4G88/G
	 Lnh/h95/r55GIXn0yxYetPSosjHxMO+axyoqF86QOQ16/hqptVKKrPjkT2tSWaZ0U1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794158651;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:In-Reply-To:References:
	 Date:X-OQ-MSGID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=yMXVt6q0yHMEQDmEW1Jo477hKUYUiAhwQxAj6RUn8ic=;
	b=toESSO73LUxo2uYBR1VvX7bcfjaE7I1sy+aPZR5OyaNzjD96mxH43vBWlfc0PlSVfNdP
	 mCvS2UalgdU+Hgkbd1tt16VugTxAkYmsNA2ykQarwE4ZL0pGzKp5DuSrjkp6KIrMTNcnv
	 FhGmJHOkaHFY78zmF9l6otI0To3bcAmj4bZ4d95ZrNXnA24O1bIQaQQvL9XF2fGdRjQHs
	 NMvco2NqFslyowAR0CdaYFefRdp+1HiQJNy+y7Is1NZFrrK4eddjpElmMeaLdM2X34aHi
	 2efe6Dtc0voJ2OZVcFgxqmPLz3MBIFuq+g77Fdu9YTMfVeryCfuyVX1xdVBEpyvYJ3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=rIPrjtkA;
	arc=none smtp.remote-ip=203.205.221.242
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA51B606A31C;
	Sun,  8 Nov 2026 17:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA51B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=rIPrjtkA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794158640; bh=yMXVt6q0yHMEQDmEW1Jo477hKUYUiAhwQxAj6RUn8ic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=rIPrjtkAF5dBDgSerUec+SqX6uuP/VPrzOi87PfcNfbe9UII1SfamGk/q0qu9aq5v
	 //nCHtDYg0OGMtJy8DgZFNKzMXbKJjlMs8rGjgjUckX1wxDz5W4cieEYWzh9nGgOuX
	 LoyHr+eJhtigsD4xckGbCaeyeuBtYeK82oTxrLIY=
Received: from [127.0.1.1] ([5.195.0.150])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 5F906C5D; Mon, 09 Nov 2026 01:23:57 +0800
X-QQ-mid: xmsmtpt1794158637tldxyld69
Message-ID: <tencent_2D9D38017F7FA92A25EAE78A562059747B09@qq.com>
X-QQ-XMAILINFO: NR2AmdDOCZJojQEiQurhnA2kAecAlc3NX7v9foT1F+whufHY4QoCxmv2e02cZ1
	 DV/wUKKLlsR+kYsKhhc26E4h563iyob6nix3lyDvIRKU0vfZrW0ayNNNKNw9IS7pEzqwgSwfgrup
	 0zrSV1iIMYVHCCTkjVeA6ol7REdEa3dHyZ2o2BAbPtSCP4Xsqm5C1Bi/bxhZDsxN6kzuioMALt52
	 zQFhNKvUFkOg8Mp5UO2pJR0fbz4QOSX0p0riOSiqqABAJ20qRvNxFlvmoonDMqdRkJf1VGgQfsvI
	 daMiU+kbzup7N0Z0I+npp00oAz3JQFVXdI+nnWWRJdY7MN1cZgC8LMhE34OJB7XE8WXrYA5FffKU
	 HhfahTx2Fhvf0IMpRXRL6kGxcw3E6T82rksv2y2Pxzc4SnhiwsuWvTUae/uv/s/+MZjgXg+Ag2CK
	 iQSsLqm56GHlYslflEwJh5qWLm/EssrCApWfn+WNUj2a0IMeAK89QkcuCMNnS72pVfdmnPc3SMEd
	 3tj2kVqSwXwFSCs7DQQi51dRAbNDkbs7dXrD/NavR3YZzvDF+9OxYq/Q5P1FXQE25TvYD/ICoK4E
	 qA+wpBxychcUKcZ5qGH3TdGd4t1lMVrtcmO6bFTZDzuL3GZq2QQUcGPDUuT1YykZhZZZ/K/i3yCY
	 T1Whd3LFWO+oqTVlLkwHleqhACUzXcLL5pHuqiV0bImyerEjgMJYiJ3tXVIjiNL3ilq9kb2QqPJ7
	 FDWY4vYqa4kjAJdPYCU3KPdJmOZByytfLg902fdBLxepBdvrsrdqEzXEEiIOaYEvLR1ptsXRs0rP
	 oD3CT0IEb5R+4WjaASgyGH4DWQ7Q8fMGybeJlI1PNo1IMCQH428n8IwzeSmutVRdrcvVr+WY7hn6
	 0PpXCrjg12QGtvdh66v8A0cRsUG9Jm7GtWDNlqJg3y55FgpE/gzKX6Nfno7UTIcyxhkJnst2Meza
	 bmXbo9Hc53hlgW0a8nVrnWbKweQmtfy6zeIJHP8p1cAcv4VA/vN6OulNRh/kKo4BqWtjwBgsPgRf
	 /NGCDOu7isZiUsXiVNCwa3LojivebHWiQEfaFJGlrU117zPLT7
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Jiawen Liu <1298662399@qq.com>
To: Bough Chen <haibo.chen@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] spi: nxp-fspi: check runtime PM get in cleanup
In-Reply-To: <DU2PR04MB8677C380950F84DE7EA6DC4290CA2@DU2PR04MB8677.eurprd04.prod.outlook.com>
References: <tencent_B3AF7EA2C812124397C0691BD0F0B7B87205@qq.com> <tencent_9A37C7A91DB0EF57A552A99EAC881CD24605@qq.com> <DU2PR04MB8677C380950F84DE7EA6DC4290CA2@DU2PR04MB8677.eurprd04.prod.outlook.com>
Date: Sun, 08 Nov 2026 21:22:12 +0400
X-OQ-MSGID: <179415853266.5.9011991732901964059@qq.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Haibo, Mark,

Thanks for the review, and sorry for the late follow-up. I also saw that
the v2 series did not apply.

The probe-failure runtime PM issue addressed by 1/3 is already covered by
commit 5d14285d60ba. I'll assess the remaining setup and cleanup changes
against the current tree separately.

For cleanup, I agree that the implicit asynchronous put from
PM_RUNTIME_ACQUIRE() is unsuitable for the ordering described by Haibo.
I'll check the failed-resume path and keep explicit control of the runtime
PM disable and put_noidle ordering in any revised fix.

Thanks,
Jiawen

