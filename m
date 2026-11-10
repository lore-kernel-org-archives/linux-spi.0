Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794281574;
	b=0vmtV8RA2Q5hP+coL88Rg5nbQO2Ynx0CW311XlCnowkBSqHp/naaOtrjD0rdGLQs2WY8
	 atdj09B31r60jpeIZeSbdhhw5h02Q4SVKW9VVG+ogwIRil1OYwJuZTzndWG3ZXAhYExpa
	 IesVcUZkY83k68i1Opjxc19zgjb4I2/GPTFnreRNgd1ULg+RbAQGmFVHjFTiYV1Bx3EWf
	 wM7OAJsBigY+Tc1Jfte0c8wxE7mcIlAOCCRLYy+9FmLsNVyvE9nFPowo+qV0t4blvytDZ
	 WIsDsr76IIfiFMxTBw2GoEh0Xk/z96FkYWKDEW5nREeZuMk29IQPENMlR43BKVusxIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794281574;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=sep7K3aXXez8bxhneDHoZw5qLLf18VUUjjOMqsGu9tM=;
	b=fomC2MM4HvjIkB/aXJ3uSZ5uIDxVCv1eG/xtDGOeZLmnC0RAzoaoasW4CEzIjCEisrfm
	 9/nsvTfF4I4Fhj25HiByUJ1EXF6XCPOZuvpYgKlsTkhxWh1/aZFWxmzqWyxMSKzP03xWI
	 1h3NxwS75YvcJx9fx9PlO+SdEnoaTa1xc0VSgmJKSNgqWZfK6Z0s9wb6I14/8bpX7AGpF
	 8VP3NYSHWeBhC+LVHbMYhz7b4V8TcpgZESZJHwRLpdSpML/yUSeTW7upwZZvcplXZk4nl
	 XjjWOWIH1fSBWpO98Tshg7Mn+7RKExNnK83K4mrtNrNxbb6fIjVw9EK1VsXNUvLygdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b="Hp/wvEki";
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A51D606A31C;
	Tue, 10 Nov 2026 03:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A51D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=Hp/wvEki
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jNsfl0Rtyz55y2K;
	Tue, 10 Nov 2026 11:32:47 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794281567;
	bh=2vj9GwjHs7sqtmZt+JapmtLfkjKvzkVSeeB9yRpOl3g=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=Hp/wvEkiR/4opWco5pEbozf/3dY4oCbGc7n5746X6FzKnhmndzkhpaRO78MGGBmfJ
	 C40E3jKidxPYKQPyrkXNkVsEeleWi+PfzbJaxeB/rnx1SYKmFe+6F6q9T+Xk8Hky95
	 OTriok3z7XPaowkrp0YpWwx07DfqNDSUM2mSPArbgcoqiRBOTr+hqmEKJXsKEii2YO
	 He7E50B9HnzF4hhTRZFWQZQ0RNX5cayJgbDrksBypuXfbLWZUs4zMA76pTZ1HaVDYz
	 tr1dLdJ8I1+DMsLSEwhrlXRqujVwy9jtHySqqo0MCFDpJZ2K3hlWJOtEgbuHxZblpX
	 cB9hRXFVMDuMQ==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6AA3Wd2q063186;
	Tue, 10 Nov 2026 11:32:39 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 10 Nov 2026 11:32:40 +0800 (CST)
X-Zmail-TransId: 2afa6af29058372-f4dbe
X-Mailer: Zmail v1.0
Message-ID: <202611101132406724LbMYy9osCSBiAGR97vNv@zte.com.cn>
In-Reply-To: <179425602307.3711751.7845465463671042950.b4-review@b4>
References: 20261106234751020Egf42VCVVlsSC_Msov4HO@zte.com.cn,20261106234803459Z94udUX-Ai29-OfBFRND6@zte.com.cn,179425602307.3711751.7845465463671042950.b4-review@b4
Date: Tue, 10 Nov 2026 11:32:40 +0800 (CST)
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
        <linux-arm-kernel@lists.infradead.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCA1LzVdIHNwaTogYXRtZWw6IGZpeCBkaXZpc2lvbiBieSB6ZXJvIHdoZW4gdHJhbnNmZXIgc3BlZWQgaXMgemVybw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6AA3Wd2q063186
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Tue, 10 Nov 2026 11:32:47 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF2905F.000/4jNsfl0Rtyz55y2K

On Mon, Nov 09, 2026 at 08:27:03PM +0000, Mark Brown wrote:
> This has a similar issue with limiting, in this case even worse as we
> generate an invalid SCBR value and then validate it later in the
> function.  We should just set the maximum instead of bothering with the
> division if we're subsituting a default here.

Agreed.  v2 sets SCBR to 255 (the slowest clock) directly when
xfer->speed_hz is zero, instead of dividing and then failing the limit
check.  The check itself stays for real speeds.

Thanks,
Shao Mingyin
