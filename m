Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794636486;
	b=xHCveYYcjVZbBS88tQZlBPzAANKoRSxXXFhRbkYIYQAWrfsj9n9AAI4XENi3hR99uXtm
	 O13HQPTZ/3Ar6K6qKHXpb03AvMlP65oCmHgaLY78pswrHA+AxaPwT9eBi+7zeH1oVRVr0
	 s5tZMgTqMK3cGHJD1D5rmBL0F5GtQYOEzAKzFtszu1vsLwFr0aoKOm5RBxC5mRghMm6Kc
	 Ks3Kn9vxD5iO1W2CmEkw/IAhUG6v7GpYA35kyUMR+MGSLeFrHObLqyafdV4sQJYTbcbYP
	 GSaKRw7KyMVDiTDaVngEttCChAUmN1DBikosezaDXlqMhlK0b+IW0ZPgJ/QJ9n9IDZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794636486;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=TV7/rNuPIcAPimQoiERTrRHJ9hzdQoce/kobpTJs1XU=;
	b=rzgJGb9rItK+/QOZTqnQkF6x+0aWhUX6a4JcP8hbgvuvj3PtH4qUlg+qy1feEzkTWKmr
	 Fvui1HiDa6T9TKVxwOrKDMP3E2MDLJFybnfufWFgnBlEH8GtXlNydei5xtsaEYiIYbM8L
	 6JuxgJYo1KmLkmUYDZpRRrM/+5y81BE18b8UVMi0B1NwfiQxxfqNXpJnEh0FjuMy0ONq9
	 L5B7zgVgWhsiZcsGZM4+aKQSC4MT2bALnZrX1885Fd8iECx64qx3WgxcLjSaON64rT5hV
	 w/ydzLnIfExi9BNfBGpYvfdEdQLMDPaDI57MP7/Zjh7SJ5a56jzF0zb+wvdKfmCUGQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=eHJLNOWZ;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E22A606A327;
	Sat, 14 Nov 2026 06:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E22A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=eHJLNOWZ
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jRNw1329yz5B13X;
	Sat, 14 Nov 2026 14:08:01 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794636481;
	bh=5lzsOGRbljK3UBGsxRWnpa6SowpbvPCeY1W5tc58u7M=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=eHJLNOWZSaYUZo7rxalDo358pfeRaghstONJbcKc8oKd9rFsOGWCdd8uNhLZdpwSi
	 iy3n+D0o7Oq3PDOAhqtc9T9xgYkKcamZYFAXT37IoW1isB9qW2Ab0+LDAb+ntAuJQP
	 aennq31FDHtuaoWxD1zUp+eB2VF69uEJVqBM8DoLsOJrgz+2xBSN3ptGdGqESHsBH6
	 GCbUqKkiAsbEdSvgMs7UWxVgNULg3vAuNLsILJAwWFiLyhbHafx/xPv1BjW2AREWLg
	 IIK1tJzm3lDkJM+Y7lCa+H9RStE6NUYoUMMkieBlBnD5agjfQrgOV62aorJjvQe1AG
	 OF+qCKJ5ZEHgg==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 6AE67ttf060421;
	Sat, 14 Nov 2026 14:07:55 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 14 Nov 2026 14:07:57 +0800 (CST)
X-Zmail-TransId: 2afc6af7fabd8be-0c510
X-Mailer: Zmail v1.0
Message-ID: <20261114140757347tqYOa2IkTGVulSwLrw2Mf@zte.com.cn>
In-Reply-To: <CAHi4H7FCOxcXnYkNfXNa_iO9KFZRSC96urJthPkgoem7C52ppg@mail.gmail.com>
References: CAHi4H7GHGO27Q=O8Upfds8jk-ujSHU5h91hCZw6qjftNX7a2Ng@mail.gmail.com,20261111173637687ugnRPRBKJkF0zihl662i2@zte.com.cn,1d8b7784-f217-45ef-8f09-658044e441ea@sirena.org.uk,CAHi4H7FCOxcXnYkNfXNa_iO9KFZRSC96urJthPkgoem7C52ppg@mail.gmail.com
Date: Sat, 14 Nov 2026 14:07:57 +0800 (CST)
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
Cc: <broonie@kernel.org>, <shao.mingyin@zte.com.cn>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <pjw@kernel.org>,
        <samuel.holland@sifive.com>, <kursad.oney@broadcom.com>,
        <jonas.gorski@gmail.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <anand.gore@broadcom.com>, <florian.fainelli@broadcom.com>,
        <rafal@milecki.pl>, <linux-arm-kernel@lists.infradead.org>,
        <sven@kernel.org>, <j@jannau.net>, <neal@gompa.dev>,
        <asahi@lists.linux.dev>, <ryan.wanner@microchip.com>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@tuxon.dev>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MiAzLzVdIHNwaTogYmNtYmNhLWhzc3BpOiBmaXggZGl2aXNpb24gYnkgemVybyBmb3IgZGV2aWNlcyB3aXRob3V0IGEgbWF4IHNwZWVk?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6AE67ttf060421
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sat, 14 Nov 2026 14:08:01 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF7FAC1.000/4jRNw1329yz5B13X

On Sat, Nov 14, 2026 at 09:13:59AM +0800, William Zhang wrote:
> In that case,   Mingyin, please update the patch to ensure FCW >=1

I need to correct my previous reply: I incorrectly agreed that the clamp
gives FCW = 0 with a 200 MHz base clock.  Sorry for the confusion.

The applied code in both drivers is

	hz = max_t(int, hz, 1);

	reg = DIV_ROUND_UP(2048, DIV_ROUND_UP(bs->speed_hz, hz));

For a zero-speed request, the clamp sets hz to 1.  With the 200 MHz base
clock, the calculation is

	DIV_ROUND_UP(200000000, 1) = 200000000
	FCW = DIV_ROUND_UP(2048, 200000000) = 1

The outer division rounds up, which I missed in my previous reply.
The same calculation gives FCW = 1 for 24 MHz and 400 MHz base clocks.

With the 200 MHz base, FCW = 1 corresponds to about 97.7 kHz
(base / 2048), the minimum rate.  The 1 Hz value is an input to the
divider calculation; it does not mean the SPI bus runs at 1 Hz.
For this case, the applied code already selects the minimum FCW.

Mark, understood about the difficulty of handling zero speeds in the
core.  For the 200 MHz case above, the applied driver code already
selects the minimum FCW; any further adjustment would be incremental.

If you would still like an explicit FCW lower bound in both drivers,
I can prepare an incremental patch on top of the applied commits.

Thanks,
Shao
