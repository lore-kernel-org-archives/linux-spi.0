Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.191
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079806;
	b=NMxOUxSBUUDyqdKAI3/HcjqBzLRqgYk2JRuvZSIYEWHhfzhhWVnBay/m7pBxqMlsyb0U
	 QluLTePfmYG2su0gSdLawhoDhtaHgYwSBSKRVzI3MpTb4EulrT52u4O/r/HG8wrENYQJJ
	 G3SBNl4D1eQPBsXydeh0hWyhpuT1pYFrefn9gka0La7yFs/Op04/ampJ+KRphLdE2xIur
	 zZdbEVPQvPjIyVJXXvx+3Shnb55E4Cfn+J68ojAHF5krMAjU/DJjBKRk74H62L5cFcSTs
	 gjcOZs0Z1P6vRyPBhuqBXEMwHcztuE9cssXIfLAOHrJxHrChlNYcivpeXD+iocPfwIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079806;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 In-Reply-To:References;
	bh=r/HZhF4g+YhTB3MYztLZdTIyPzcd92ZFlOciidMdYlU=;
	b=y+MK1ypm9lJC+H6jTQ4wKUeauaHV3lV2m14YfATRauyEbEFo1m3tADdNUVLgixm8s1z/
	 UOtDDfSGyo4j/vZXdFVI34N51BdrC7n6ARRL8DOVWfG//Yu/ZQFA9Zc+NetdoYRae8tBj
	 bNPJig9McN9ua9uMqjT5X67wQLyYKjBwDEByDe+AkF2JyJTdRW28UzUCLydrMiYeezhXi
	 t6Q68BoMXisz+eGg0pCn/Wnq3rMeOUbktIJyLKwcwYn03gSC7NzqaOhkiOpspLTHCfWyI
	 m8i2kh1pa4rljPRx62wgZY8aJR4pPgdEw4oIvPO7c/bq75sP/uCCuPJx7OaMBWRefvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=GWbg95On;
	arc=none smtp.remote-ip=203.205.221.191
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B10606A31A;
	Tue, 27 Oct 2026 05:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28B10606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=GWbg95On
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793079797; bh=r/HZhF4g+YhTB3MYztLZdTIyPzcd92ZFlOciidMdYlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GWbg95OneLyZbmKylHULxEVSqIYXDlb9zLSHGj/QJ7IAYeF0HI3ViZONCiXC0szsb
	 QH4T80v6f9pa+lg59d9eli8UGMzTm6GtxKiBmujH7gykNYsaY8Ap6jKgzx3YgrzGs2
	 U/zByV/ybiaXXEilVKqaM7pvasDYAhX7d9W0QCRM=
Received: from [127.0.1.1] ([117.158.156.199])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id ACF878D2; Tue, 27 Oct 2026 13:43:15 +0800
X-QQ-mid: xmsmtpt1793079795tdqs5g9o8
Message-ID: <tencent_BE9EA6A9047748CC61C2D23D4B7A88655105@qq.com>
X-QQ-XMAILINFO: NW7HORcYNlTFt1uoMKOFT6zXT6IuEwiKIlR31mZ/7wb6aonbmHWK87lWD6ctvC
	 6Dhrl8nzGsQbRirZpwjU2x12yRQukNHk8nJLLRbsO+NlwJsW6gc7qA5Uziprb1PMXbM8Wxy0RqD0
	 IQkR3Pw6Q4ThPY8zAfGOXHRaEamsTUXqa/q13YuPiWNCK7q6Tefp+sKhmUD4vpOfd1mpI4iTltpe
	 H8U/BHOOTyeX2u3GgeDhQNTwvMjcAWLchlyPmPxFG92bxvT9CGNeHPgrAHeebUSCSTbJgw+KnsyQ
	 ALnakOC2poQVM90QqN39P45mRYR+ZBO7uW3LoB2Wd8QEi3j2kmtDSvjqlg/dl9YR0QRguvOmR5A5
	 NaxhmKG6gb+6g4FFAkZiNDZCe+1MSetDvPv1JRUbx5PVAaHvJ2YCBrTy13p0PSklH4ogWeZKI+O9
	 3Tc0xRdekncxYMU4/J56+4qp/AZT/rl+DswQWQhwInJglnFMTHvcGI71a6n9OaKDpy/5X95OaEoq
	 Ix9zo7BUrq3p+dzA4VkUjIDmHQ0KMjKDyy3Cu1XeOJB9y1Yn8s9qKz0rkJyA1zzcPq6tnTHxRj1X
	 A+w76P1STczNf8wo4dU4SyrErXBebpbjzH8qOC4ERNRnpCZyPDkRipOLxI8MA29EI2gCZgu2SvB4
	 tTSrvtmMZdsi5Spa/uKZ6CzOpziU0D94YFWgVtnp0Ek6soKcQdJHWW7vZ6saZTRpBmVYyfo9h+QB
	 k2cK6kjIL07GbolKjl9E5mCfn4s7Z4c8YLGCgovPVkDCZ356w/avtG654dV1pWULA73q/NTnoHN0
	 CLnXGUY3YG9bHVHtLxfGn8Ox2v7mJGTm+Ldqv/FoyNtgRVqsp0PI6lc45RjqJ67UC6GyPaR8+kFb
	 nUVY/KKpyZMDtdTKb3NnNbzWc21TN4Y/vF7n5ImiHCYJC8QArDSRgpdYqYiqwhHfWInMsZ2Rxoof
	 YWqFqPIYetqzYtTSGEOp2Lbdg3mXZbQf2cq/8zdM2qD0kbg78lLGlrZftfq7UnkxGSpyUoV/SQ4A
	 jxmlOmUeGyI2z9XrbKhF7xxv2ShtxnUgU6gfJA6QvxvY+tnPwnvVWb03kBawe8mPPXs8Uvn+yvvr
	 vMGDkd
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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
Date: Tue, 27 Oct 2026 13:43:15 +0800
X-OQ-MSGID: <20261027134315.12944-1-847807867@qq.com>
In-Reply-To: <20261027033632.77840-1-kmehltretter@gmail.com>
References: <20261027030352.615926-1-847807867@qq.com>
 <20261027033632.77840-1-kmehltretter@gmail.com>

T24gVHVlLCBPY3QgMjcsIDIwMjYgYXQgMDQ6MzY6MzJBTSArMDEwMCwgS2FybCBNZWhsdHJldHRl
ciB3cm90ZToKPiBDb3VsZCB3ZSBjaGVjayBuX3R4LmNoZWNrZWRfYWRkKG5fcngpIGhlcmU/IHNw
aV93cml0ZV90aGVuX3JlYWQoKSBhZGRzCj4gdGhlc2UgYXMgdW5zaWduZWQgaW50IHdoZW4gc2l6
aW5nIGl0cyBib3VuY2UgYnVmZmVyLiBUaGUgaW5kaXZpZHVhbAo+IGNvbnZlcnNpb25zIGRvbid0
IHByZXZlbnQgdGhlIHN1bSBmcm9tIHdyYXBwaW5nLgoKTmljZSBjYXRjaCwgdGhhbmsgeW91LgoK
SSBjYW4gY29uZmlybSB0aGUgYXJpdGhtZXRpYyBvbiB0aGUgQyBzaWRlOgoKCWlmICgobl90eCAr
IG5fcngpID4gU1BJX0JVRlNJWiB8fCAhbXV0ZXhfdHJ5bG9jaygmbG9jaykpIHsKCQlsb2NhbF9i
dWYgPSBrbWFsbG9jKG1heCgodW5zaWduZWQpU1BJX0JVRlNJWiwgbl90eCArIG5fcngpLAoJCQkJ
ICAgIEdGUF9LRVJORUwgfCBHRlBfRE1BKTsKCQkuLi4KCX0gZWxzZSB7CgkJbG9jYWxfYnVmID0g
YnVmOwkvKiBzdGF0aWMgU1BJX0JVRlNJWiBidWZmZXIgKi8KCX0KCldpdGggbl90eCBhbmQgbl9y
eCBlYWNoIH4yR2lCLCBgbl90eCArIG5fcnhgIHdyYXBzIHRvIHplcm8sIHNvIHRoZQpzdGF0aWMg
U1BJX0JVRlNJWiBidWZmZXIgaXMgc2VsZWN0ZWQgYW5kIHRoZSBjb3JlIHRoZW4gbWVtY3B5cyB0
aGUgZnVsbApsZW5ndGhzIGludG8gaXQuIFRoZSBpbmRpdmlkdWFsIHUzMjo6dHJ5X2Zyb20oKSBj
b252ZXJzaW9ucyBpbiB0aGUKd3JhcHBlciBpbmRlZWQgZG9uJ3QgcHJldmVudCB0aGlzLgoKRml4
ZWQgaW4gdjYgYnkgdmFsaWRhdGluZyB0aGUgc3VtIGJlZm9yZSB0aGUgY2FsbDoKCglsZXQgbl90
eCA9IHUzMjo6dHJ5X2Zyb20od3JpdGVfYnVmLmxlbigpKT87CglsZXQgbl9yeCA9IHUzMjo6dHJ5
X2Zyb20ocmVhZF9idWYubGVuKCkpPzsKCgkvLyBUaGUgQyBjb3JlIHN1bXMgdGhlIHR3byBsZW5n
dGhzIGFzIGB1bnNpZ25lZCBpbnRgIHdoZW4gc2VsZWN0aW5nIGFuZCBzaXppbmcgaXRzCgkvLyBi
b3VuY2UgYnVmZmVyLCBzbyBhIHN1bSB0aGF0IGRvZXNuJ3QgZml0IGluIGB1MzJgIHdvdWxkIHdy
YXAgYXJvdW5kIHRvIGEgc21hbGwKCS8vIHZhbHVlIGFuZCBzZWxlY3QgYSBidWZmZXIgdGhhdCBp
cyB0b28gc21hbGwgZm9yIHRoZSB0cmFuc2Zlci4KCW5fdHguY2hlY2tlZF9hZGQobl9yeCkub2tf
b3IoRUlOVkFMKT87CgphbmQgZG9jdW1lbnRlZCB0aGUgY29uc3RyYWludCBvbiB0aGUgbWV0aG9k
LiBUaGUgdjYgc2VyaWVzIGlzIGF0Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXNwaS8y
MDI2MTAyNzA0MTUyOS4xMjU5ODYyLTEtODQ3ODA3ODY3QHFxLmNvbS8KLS0gc29ycnksIHRoYXQg
bGluayBpcyBhIHBsYWNlaG9sZGVyIGZvciB0aGUgdGhyZWFkOyB0aGUgY292ZXIgbGV0dGVyCk1l
c3NhZ2UtSUQgaXMgaW4gdGhlIENjIG9mIHRoaXMgcmVwbHkgaWYgbG9yZSBoYXNuJ3QgcGlja2Vk
IGl0IHVwIHlldC4KClRoYW5rcywKU2h1YWkK

