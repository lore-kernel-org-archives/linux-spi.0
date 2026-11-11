Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794389778;
	b=vTNyy4ujrT5u4lGJkqXVSg5VKB4yl3y8YS1ASSodANC4n2rIHAzd6jreY6c5pe4YkYNg
	 jKUhmWlVRmMm8/yBuoTd7gPLMqmRKEWghX4+NonWwSSY0DvLmossLg6i/2MA9/oQLzHe+
	 3ecGfTL0zrWgESfdJaq99w6XGOrp6StcKWlhcJ9ki2CSozpOdNgeSoqw9sh2lUAmIMKg6
	 FM3t0nMDnfDuwfyH+41Jj2fZ0Mh+psCQ+Lz8dS100M/Pv1cfZsCMRWTNr9doUqzxh+JCw
	 fUpwV8gV8C/pWGjZt0N5vfBKTpx2fu72j8HNdl41wsrvSC14R8uSoOPT9uMv5gU0UzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794389778;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=xYfhnM/B3nbEhSHaZbxy90wKrc0VRagGYhRr8V1JAok=;
	b=EMo35+ndXisW/7VIP5H8a7yr2PsqWMcKKhwlWmf8jzoVmlbgacF6ppfbsl8wprLBJJsp
	 oZaUU9s0KgJukSQ8Cu8uU2zWhA4x6/9nYI7Dt1+0rH6zs90MGo/ZyDt3GdJoyXpgyWwAd
	 WplPTgjjny60Adq1/iopI6t00dtYFpCI148/2cxZCOV51oRHjLaAqqEW1pQYT5mIwN5KS
	 LEvnTNDwp5KTD4r/4okSq3aRzgZZ7n8qero+z7IovTPaqUHPSuU9dQfPw53VFEJfLIv7o
	 l8a9xmaYYO8GJcVRXwAydSPK0XG6x4+jT2yQFOTJJr2gTmlEQU8jKooDK/E6XSiT81A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=nNZ5OnAH;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466BD606A31C;
	Wed, 11 Nov 2026 09:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 466BD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=nNZ5OnAH
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jPdgh3Bhbz8Xrrc;
	Wed, 11 Nov 2026 17:36:16 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794389776;
	bh=nISwyAkGwW+5KPZlR7klQihrMRsBcil/fLEMXbhFKD4=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=nNZ5OnAHag8nUux3OqaAPxF0FgodwUuM+fXu930K4eh65z/WUE57yeP1m/sPkaZI+
	 hphq+2+TWAyEnjdQlpV96pK2XZlRu6UO/aIJxlHHcPSuvJSg2xcC8NqFOTXDvI/bwp
	 wKck/wb6/7RQ7DWuiIHzFiGExKfkTwIs9UuLhHl3Emgpx8VwT26cMWHmg1IXAbATZ8
	 y2/8E2NNu7H9SJpzFQCoPWqN1LISATzo+UHKh/rBf5eSuXgYVGU089eGR86FzF3+mw
	 1nLyfdFAsSm29v5qCOE52czapW95/Psbeq3fOE8xVt+yO9ckpZZdIEKSPsaVNMoH7p
	 RetWLGHWc1yMg==
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 6AB9a7km008108;
	Wed, 11 Nov 2026 17:36:07 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 11 Nov 2026 17:36:10 +0800 (CST)
X-Zmail-TransId: 2afb6af4370a4f9-e655d
X-Mailer: Zmail v1.0
Message-ID: <20261111173610100jiAz_Z1qb0aBv45pMvy3c@zte.com.cn>
In-Reply-To: <b8b3dd8e-7d66-4d8f-87f8-c88148334ebf@sirena.org.uk>
References: 20261110233450305Smji446Uhvoxa7r8SHEgl@zte.com.cn,b8b3dd8e-7d66-4d8f-87f8-c88148334ebf@sirena.org.uk
Date: Wed, 11 Nov 2026 17:36:10 +0800 (CST)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <broonie@kernel.org>
Cc: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <pjw@kernel.org>,
        <samuel.holland@sifive.com>, <william.zhang@broadcom.com>,
        <kursad.oney@broadcom.com>, <jonas.gorski@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>, <anand.gore@broadcom.com>,
        <florian.fainelli@broadcom.com>, <rafal@milecki.pl>,
        <linux-arm-kernel@lists.infradead.org>, <sven@kernel.org>,
        <j@jannau.net>, <neal@gompa.dev>, <asahi@lists.linux.dev>,
        <ryan.wanner@microchip.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MiAwLzVdIHNwaTogZml4IGRpdmlzaW9uIGJ5IHplcm8gd2l0aCBhIHplcm8gdHJhbnNmZXIgc3BlZWQ=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6AB9a7km008108
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 11 Nov 2026 17:36:16 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF43710.000/4jPdgh3Bhbz8Xrrc

--------------------------------------------------------------------------------
On Tue, Nov 10, 2026 at 04:14:21PM +0000, Mark Brown wrote:
> Oh, I see you also sent those v2 patches as part of the series as
> normal.

Yes -- the two standalone mails from 22:57 were a mistake and are
superseded.  v2 only changes 1/5 (sifive) and 5/5 (atmel); 2/5–4/5 are
unchanged.  Waiting on your review.

Thanks,
Shao
--------------------------------------------------------------------------------
