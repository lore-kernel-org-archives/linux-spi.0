Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.191
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079901;
	b=hhCA1lW4FJyvPPdCqjfsOVGAvxMdQo8J4arbIxAGQuUPw4sbZI3ezhBrQCaBdwM8q2HP
	 TRj6K4i/0rJGeAJcFZbltMIJrRS1mTpaKsFRBZJu+6NqPRiYMmmI5PPNdFQtV9M70JN/b
	 w1Maco73mgwc/cY5CVmcJGyV+03fewgqhJCifWKqTj+xF2lsYpf0dk+WUjEYM4rENTHLm
	 Oa+PIF2lmp1pyQs35MGWptnI+Fr1LfXr8Bm5w4NJSArOLLc6abOTXkBfVIwLRDT8Nn++t
	 l0ufg+3DbNj5ME6SIvniUOM7tk15bKtSyQYWvL+qt+fEZ2IdInHVcXZQj98XkD5QsMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079901;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 In-Reply-To:References;
	bh=M1aefZXxY78CY64/52szIuqWGGDvJKe3WaQPueOl+LA=;
	b=UlGCU6/M58yt3UzZ01OLG84Tp0W+MIqwQmBUByuTitaiRnOurW7bZxOjIyNCE4mUzAAS
	 YYAZsjsWZrZJJbXfSNHgcqHjk2RzdSeL2iLIrezZkXEkKmZrpFAF1hXze6kvByl5duiev
	 PFOflYtgO5YSxrfKP600POvsQjlosJaheHCBnnNRI+c82jEVAVtWUhfDrtVB0csjxGcnN
	 nHS+krRcotFsbSnk+4vgKJJWXdNrAR0tuHagP5lZco5DR9VqQAWH9OQdxx4KIpfFmGi7f
	 cNpMnYta3SymOPBAE1Wc4hncefctGKGvPyt8bq/qoJFGRLuafpKCFd/aslwRKbPfzWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=IKydy2Dz;
	arc=none smtp.remote-ip=203.205.221.191
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031FC606A31A;
	Tue, 27 Oct 2026 05:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 031FC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=IKydy2Dz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793079897; bh=M1aefZXxY78CY64/52szIuqWGGDvJKe3WaQPueOl+LA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IKydy2DzM8lzlRTZlY1FIi/B5ozj37jB71agtkz/pRbIC5oT1Q9hqYiBO407BsmE0
	 1pTw/L/HQS/IgEvhTpS3dlRqH0jOe+QeA9aRVbPtWPaxXvQnFzezAzW4VdftyUur6x
	 Lczh9fSh7o5bHnRu6sS0hTIaVr9OifBxJF9SqqS8=
Received: from [127.0.1.1] ([117.158.156.199])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id B37956C2; Tue, 27 Oct 2026 13:44:55 +0800
X-QQ-mid: xmsmtpt1793079895tcu1w36s0
Message-ID: <tencent_DF9E26185C69318F892F773E69599639F907@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25GZ9pKWJlcABoZARrVCIwMkUFJVy5QOeuaPa8vKf5mC/cyI0+qjP
	 7MXnAMCKLRSMp/KH3tYTltSKv9o7kpbhmoF6im+FHNS3od7NOKKYFzZazbp81nUDUE6HEEyJgOX3
	 bzAsWkxh7mzEHa7AeZSY3XIKIWpwVux/Jilwh2d2NB6voGCM5VNWq2rEl4w3REvaac+P2ar55G0q
	 o2Q09CjmKAaSIPf3G7vLJ+JFOxtAmhU5zEuXZ+ow1plTyxZyS90HVoJN8tP/yvlivbp00pAgNb8v
	 aUNp5FI1enCZNgMkqH7seRnxFMr1qso9RzSTG4Av0svEA6sKTElJQOUjlHSk1AMoKe9NyJven0Ow
	 jGsDlScSm3Uyxrn1Fs07KS/np0Z+/1ZPGR7ID3IYgsVkc/MbtuadswKRZygevpGeM2VHcZ1VEhpU
	 yAM7ui/kIUjsFNh5uj8kGaaiyBrPtPTyAWXQ5ubMBe9sqj2XjsvqlEES99YYUMWHf2EmQ+z7TuM0
	 hN1dGoKfBPUebyQ3fI9S9iyno/mkDZdxR42PON2yd3UTFVKmfowhPDtMfKe1At2dqCFrQY3uR8lE
	 YcyOepUG7yrQZ8LQT13dyMfpqc7XyILSxCXqUz0wqJLz1cYdz7/9WFDNugG/Wb0CfxLmaViZ7Ife
	 DjXHwSH3GvBn5m1w8YNrSVNbj8FTJHUVPHRhTgoW7p52MWfLgW6dvL/MLFSmSnR/xpIu6kZgecZV
	 0yei/geUIRswh8bo5BYTHBQbI7oWE2aaK5n2BpdTXmGepIo0kq4w9ugHIw8ZMa9IMtn/saX4S1Fs
	 TDTOAZdS5/5dvt1BXrMRQ4NEXQuSHATwL3Omu14QYLEF9xwpl75nR8dXSz3a/fDx8fl2zFkF9wHK
	 CEWIHJkI6MEedkDjiV6BTFWsQgqkl42WxH7ZMg9PdHPcdyf8kcLQwyjw4mqLLeSALhBm6uLxX1Y8
	 G5rcXb/CUY/6J+38/uDzMfuWiJL8FgTFOwVqT5oXS882sfLU0QunFV5oHetKCNf/TS8K+rv5m80v
	 XYQVR1l0sYjaF3B1E07DOFn5al/nX8ZoSaIgPVrXW2Sz2e/TzJfWgJPukA7Nw=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Shuai Liu <847807867@qq.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: linux-spi@vger.kernel.org, rust-for-linux@vger.kernel.org,
 broonie@kernel.org
Subject: Re: [PATCH v5 2/3] rust: spi: add SPI driver abstractions
Date: Tue, 27 Oct 2026 13:44:55 +0800
X-OQ-MSGID: <20261027134455.correction-1-847807867@qq.com>
In-Reply-To: <20261027033632.77840-1-kmehltretter@gmail.com>
References: <20261027030352.615926-1-847807867@qq.com>
 <20261027033632.77840-1-kmehltretter@gmail.com>

Q29ycmVjdGlvbiB0byBteSBwcmV2aW91cyBtYWlsOiB0aGUgbG9yZSBsaW5rIEkgaW5jbHVkZWQg
d2FzIHdyb25nIC0tIEkKd3JvdGUgaXQgb3V0IGJlZm9yZSB0aGUgc2VyaWVzIGhhZCBiZWVuIHBp
Y2tlZCB1cCwgd2hpY2ggaXMgbm90IHNvbWV0aGluZwpJIHNob3VsZCBoYXZlIGRvbmUuCgpUaGUg
djYgc2VyaWVzIGlzICJbUEFUQ0ggdjYgMC8zXSBSdXN0IGFic3RyYWN0aW9ucyBmb3IgdGhlIFNQ
SSBkcml2ZXIKc3Vic3lzdGVtIiwgc2VudCB0b2RheSB0byBsaW51eC1zcGkgYW5kIHJ1c3QtZm9y
LWxpbnV4OyB0aGUKd3JpdGVfdGhlbl9yZWFkKCkgbGVuZ3RoIHZhbGlkYXRpb24gaXMgaW4gcGF0
Y2ggMi8zLiBPbmNlIGxvcmUgaGFzCmluZGV4ZWQgdGhlIHRocmVhZCBpdCBpcyByZWFjaGFibGUg
dW5kZXIgdGhhdCBzdWJqZWN0LCBhbmQgbXkgcmVwbHkgaXMKdGhyZWFkZWQgYmVsb3cgS2FybCdz
IHJlcG9ydC4KClNvcnJ5IGZvciB0aGUgbm9pc2UuCgpTaHVhaQo=

