Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794281562;
	b=lXzyi+nHIG5H9esc2V8R5yXy6OeQehsgutnP1QF6n1YHbR08ZQv6Is4zIV4SFFx1rgAX
	 mBevlPrK8ZqLzBa0KWKvMFRfjrPOwBNrdu96Uab12x4uwfUzTFu69ot2scEPZTyGusUk+
	 eMAXKp96F9HakgHUrnvwNSD5oYHA9VsgAPXT8RD9IHNkgjj0w77kl+iNqiWE8btVK1PFZ
	 F34Rei/XRH7a43yUoDAcIZT1vxkqjcbuiGwAFSLh8lixI8XP0UP39GDZGR/UjvjBw/+XF
	 bQXYy7A7eNFwJRlplc/ASZ4NJkGphxLXTMSuWuYBs61OBHPNRcLCMqWT+9zSVNNJItA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794281562;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=E8TzJdnwMoUKQa3BZrpEeZ73Zmi4FS/NQeMtNUjMmsc=;
	b=Qv8coU8tbWIvohSZuhcRIyuZYkZvjNkgbF4FiN1wIc3gQHPqfXHLutLEM2wbKQ7QwBjP
	 78nz6DhHQIunoHNKzAgm8aSKO0oRsIKKjvJRulFJSpboNN0syayJ68C2fu0jS7zk6XuVk
	 EVYraX6WL9+w01H3VsM5MVDEp9caOhrTRgdPmXvgQL4wE1Tz7ahJsVhis9a9Iqti84r6d
	 sh2aF3n1m4xcdpwxDDZsv54d0cFLknROFcagZUC6EpDqVh1P2Uh1gkhMZTyUih5b41xnF
	 m8DbMFMsknIZhmPZdV3vvhPBE0pUcMH+h5OYr8bL90AhHVlBUmwX3BRG7h6atwMpjqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=PB2z9M43;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41D0606A31C;
	Tue, 10 Nov 2026 03:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F41D0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=PB2z9M43
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jNsfb25lkz5HKfr;
	Tue, 10 Nov 2026 11:32:39 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794281559;
	bh=tfgADndfGoUNK2Ro5HGDGrNmlb6U9tBz0qPeA6uhP0s=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=PB2z9M43gVirgpU42kVqKjEdL2C8uUXfYGr+bTJFRucc1mzJFnd7QkwrWo8UnEQkJ
	 JBaVxnweLDK1eVBetyN8mtK2cONtYwq+KCt7PC8lvbwB/9epCmms+7cOBx0mIrCAdK
	 eFWqVwvsXkzwW1FlS/7OhF+xi7m6QmdUwbiKQ38KOyToHpYWVWfXl/21u5n4jNKptg
	 4XPYfMXkSasnZa3Leq61YaiqQ+pbkNj8gjXSV/0vKRprRxoyGtMMdcB3RIJZsx89Hk
	 6tJyyAe4xGqd2c5NbO3aEd9QmRJRt7sZoXBm6eDwLy5jNcieucsFc7u8I2Eg1P2YCD
	 21ZjSOMO0Fkag==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 6AA3Waw1025458;
	Tue, 10 Nov 2026 11:32:36 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 10 Nov 2026 11:32:37 +0800 (CST)
X-Zmail-TransId: 2afb6af29055dbe-e081f
X-Mailer: Zmail v1.0
Message-ID: <20261110113237323lKLmgDYxxItDh5XxXWnRP@zte.com.cn>
In-Reply-To: <179425602306.3711751.12136281369535948110.b4-review@b4>
References: 20261106234751020Egf42VCVVlsSC_Msov4HO@zte.com.cn,20261106234756882V9wUQNCEZAYUGTAbexMSL@zte.com.cn,179425602306.3711751.12136281369535948110.b4-review@b4
Date: Tue, 10 Nov 2026 11:32:37 +0800 (CST)
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
        <samuel.holland@sifive.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzVdIHNwaTogc2lmaXZlOiBmaXggZGl2aXNpb24gYnkgemVybyBpbiBjbG9jayBkaXZpc29yIGNhbGN1bGF0aW9u?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6AA3Waw1025458
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Tue, 10 Nov 2026 11:32:39 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF29057.000/4jNsfb25lkz5HKfr

On Mon, Nov 09, 2026 at 08:27:03PM +0000, Mark Brown wrote:
> If we did genuinely end up with a speed of 1Hz this results in only
> dividing by 2, and we then truncate this to 12 bits to fit in the
> register which feels a bit risky.  We should probably handle the
> overflow if the result doesn't fit in the mask.

Agreed.  v2 drops the 1Hz substitution: when t->speed_hz is zero the
maximum SCKDIV value is programmed directly, and a valid speed whose
divider would exceed the mask is clamped to that same value instead of
masking a truncated result.  The normal path is unchanged.

Thanks,
Shao Mingyin
