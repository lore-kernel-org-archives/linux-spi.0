Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794389807;
	b=lJuLH/JsNM3NwGUUzmNWTaEsY3Hwzr0ecteuEFU3UWCL/uxvhq/IKzeUZwlCMw36aLS/
	 VUBt/F3lNfYQwR2TK1Cuxk6WJRWqH8EnaNLuHx/zw5eRELcKjEp/kIb5iFbiqtFbeZkwG
	 CjIYVf9LRlMQL1j4JpS92neVp06sQxWt5RY0/2IL9InClJy4UJmQdB/sIBEwMBt7TCfct
	 3I3GDXfD/YhfB9zV92ol4xNey9FgWLhyqbd2sHehoPt2CwrpiNWcx+UJ2qg1EvITpWVSe
	 tsn8xAxbgB9LHh63kKs72Ehf8Rt90s4bEoWtEM+TI2jk71CatnzX7vW6BN4YDLg+8eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794389807;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=egSqt+pQ6gz6nq0lUaXUWrPZgrt8DPk5rzDYl32E4KI=;
	b=lIVu6raOg2Tqom7ut4ybC1mxBQ2Q9ljyPc6Z5KdfDUua2drmQbxWOjOoRIk2BJtdlT5X
	 SEO2aeJy8bXg/MMlz3E+2VIZyXCrVRA43sPqJHXuejoJiRjV0K/arCKJAGthBZQJVNIbm
	 aMMKmUftE2FTLSf3y5XhPUqlQIU7576gfVr8ddOnuFNOn1R96ZBRurwq/TArBQ/97WLU7
	 5DsTRxznp8I5BLAS2BeUd+/AtTmL7AoM7PXsR5qz3BKc488hKPpVMorWubi37C29n955g
	 mVhGEphjv0Ue1lmqHRpRGwVvzuLHWtXMlOBOBkYHcPacNjMN2Eq148BTGno/9/w4bzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=vTqNIyb8;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE919606A31C;
	Wed, 11 Nov 2026 09:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE919606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=vTqNIyb8
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jPdhF490Rz8XrrZ;
	Wed, 11 Nov 2026 17:36:45 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794389805;
	bh=OWQQz0Or3HEOmZllORXZ/evEFZ/NmfH5mW+Je0IlXnc=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=vTqNIyb8X8VOGgx/bgNK/ZyLw5ErsV0kjfTnrhqx+OoAZzsRmetcUREIQkeY5lqTt
	 QBGKUTtFrD6Pe+eLKew9VciIlBsrBwi3xGBVwucMz1+Fmi9Xyq/eUvsCvtBnNO8Q7G
	 aqZbctRTpGUMbAdCV+c5FhKztJqLoyodMcROkZ7qcsfiSGUJ8M03vichtVw/t4BS/y
	 f1zX8OHKEhJB+BXE/mszizZT52CEhMF1lVVDQrS8gZsGuS+7KUem8VKZhHFmrMdJc2
	 HwXUkSigxMMyn73Kwg33Ius/1fMxFqno23NRvh51XNYtgJv5KUaFxHshjNRDQ/bptN
	 ybb8L1rHQUusg==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 6AB9aZ4Q009552;
	Wed, 11 Nov 2026 17:36:35 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 11 Nov 2026 17:36:37 +0800 (CST)
X-Zmail-TransId: 2afb6af4372505d-e70c0
X-Mailer: Zmail v1.0
Message-ID: <20261111173637687ugnRPRBKJkF0zihl662i2@zte.com.cn>
In-Reply-To: <CAHi4H7GHGO27Q=O8Upfds8jk-ujSHU5h91hCZw6qjftNX7a2Ng@mail.gmail.com>
References: 20261110233450305Smji446Uhvoxa7r8SHEgl@zte.com.cn,20261110233459277eFsXn1VXUPZl1EA9CCa5Q@zte.com.cn,CAHi4H7GHGO27Q=O8Upfds8jk-ujSHU5h91hCZw6qjftNX7a2Ng@mail.gmail.com
Date: Wed, 11 Nov 2026 17:36:37 +0800 (CST)
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
To: <william.zhang@broadcom.com>
Cc: <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <pjw@kernel.org>, <samuel.holland@sifive.com>,
        <kursad.oney@broadcom.com>, <jonas.gorski@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>, <anand.gore@broadcom.com>,
        <florian.fainelli@broadcom.com>, <rafal@milecki.pl>,
        <linux-arm-kernel@lists.infradead.org>, <sven@kernel.org>,
        <j@jannau.net>, <neal@gompa.dev>, <asahi@lists.linux.dev>,
        <ryan.wanner@microchip.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MiAzLzVdIHNwaTogYmNtYmNhLWhzc3BpOiBmaXggZGl2aXNpb24gYnkgemVybyBmb3IgZGV2aWNlcyB3aXRob3V0IGEgbWF4IHNwZWVk?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6AB9aZ4Q009552
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 11 Nov 2026 17:36:45 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF4372D.000/4jPdhF490Rz8XrrZ

--------------------------------------------------------------------------------
On Tue, Nov 10, 2026 at 12:30:05PM -0800, William Zhang wrote:
> The bs->speed_hz is typcially 200MHz, reg(Frequency Control Word)
> will be zero when hz clamp to 1.  It is not a valid reg setting.  FCW
> must be 1 or larger.
> The same applies to bcm63xx-hsspi driver.

You're right -- with speed_hz ~200 MHz the clamp yields FCW = 0, and
2/5 (bcm63xx) has the same expression.

> IMHO the upper layer should fail ... rather than having the controller
> driver to override with a risky 1Hz clock.

Agreed; the fix belongs upstream of the driver, not in ->set_clk().
Mark, which do you prefer: reject max_speed_hz == 0 in spi core, or
have these two drivers clamp FCW >= 1?  I'll wait for your call and
won't spin a v3 meanwhile.

Thanks,
Shao
--------------------------------------------------------------------------------
