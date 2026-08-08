Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53A833B6F1;
	Sat,  8 Aug 2026 17:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786211712; cv=none; b=WDV6tSldeP5RDwzpBcgqps3vni4WZvkm5E6yuFoM6ogpfyIXtmv0nLLVbO+BUx8iOD+rduO7U7Eivw8Il4YV1xNJPHM1J6m8jE70rfUX5srPLH3VqvXItsNG2JDRVPtaD/EFou/DRb/PvLRpxXw0vZsoKsen+gb50QS+dCppYDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786211712; c=relaxed/simple;
	bh=qk5kYmCwJcjseGWjfQKpkQgEEHKNob7Ggq2aX1uaMY0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=poEUCEI+1BOMGmJv8TkUbw31VTgjOoRHYG1HiWUu54JC6SUMCjp9x2GQFHh5gy1BaMqXMCDNe+k8xW9qd0m9x7QYET8O9nS4erkdudUBv/SW/5uZ3wHa/JBx49o9rY7ayle0gdOvhva7UBiCCwJvDF9jG1gIzmxefXp7hksMkGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=F4Gxp1gv; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="F4Gxp1gv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=qk5kYmCwJcjseGWjfQKpkQgEEHKNob7Ggq2aX1uaMY0=; b=F
	4Gxp1gvujsVc2iDp7+PnJF0aEsoDgBiXZus1MbQ3s+Xtl83/KZ7ob0i4nClCLNF3
	XNMI90epCKQqOqFXqaGodcKG8UP1hRfOg7jjmIME2O0TnkBy3VzsAMGOyfiI6UxT
	WabXKoMW2x+ztBNoc9U366xWeLGyRuFRHSWPkdoilg=
Received: from jiang_hh2019$163.com ( [180.168.188.67] ) by
 ajax-webmail-wmsvr-40-132 (Coremail) ; Sun, 9 Aug 2026 01:54:28 +0800 (CST)
Date: Sun, 9 Aug 2026 01:54:28 +0800 (CST)
From: "Honghui  Jiang" <jiang_hh2019@163.com>
To: "Andy Shevchenko" <andy.shevchenko@gmail.com>
Cc: broonie@kernel.org, andy@kernel.org, andriy.shevchenko@linux.intel.com,
	fancer.lancer@gmail.com, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: Fix DMA mapping ownership on partial map
 failure
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <CAHp75Vf=riT4uCVrF+bHuAB-xCLV8wRZrn0WVVRsfxN_-0WAPg@mail.gmail.com>
References: <20260805151456.756579-1-jiang_hh2019@163.com>
 <20260805151456.756579-2-jiang_hh2019@163.com>
 <CAHp75Vf=riT4uCVrF+bHuAB-xCLV8wRZrn0WVVRsfxN_-0WAPg@mail.gmail.com>
X-NTES-SC: AL_Qu2TBP6avk4t7iebYukdmU8age42XMSzuP4u2YJTc8IFgQXB3DklWFh+M0Lk8caKLAevjCCUdjRi1vljWbZdAAQSTSPgl9AZn7mj1ECMrw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4adeeeb4.2dec.19fe283130a.Coremail.jiang_hh2019@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:hCgvCgCnT6pVbXdqFhcuAA--.23W
X-CM-SenderInfo: xmld0whbkkjiirz6il2tof0z/xtbC0xXoKWp3bVWSVgAA3m
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

VGhhbmtzIGZvciB0aGUgcmV2aWV3LgoKT24gVGh1LCBBdWcgMDYsIDIwMjYgYXQgMTA6MzQ6MTZQ
TSArMDMwMCwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOgo+IFRoZSBGaXhlcyB0YWcgcmVmZXJzIHRv
IHRoZSBjb21taXQgdGhhdCBtb3ZlZCBmcm9tIHBlciBtZXNzYWdlIHRvIHBlcgo+IHRyYW5zZmVy
IG1hcHBpbmcgZmxhZ3MuIENhbiB5b3UgZWxhYm9yYXRlIHdoeSBpdCB3YXMgbm8gcHJvYmxlbQo+
IGJlZm9yZT8gKE5vdCBzdXJlIGlmIHdlIG5lZWQgdGhlIGFuc3dlciB0byBiZSBpbmNsdWRlZCBp
biB0aGUgY29tbWl0Cj4gbWVzc2FnZSwgcHJvYmFibHkgdGhlIGNvdmVyIGxldHRlciBpcyB0aGUg
YmVzdCBjaG9pY2UgZm9yIHRoaXMgaW5mby4pCgpUaGUgcGFydGlhbC1mYWlsdXJlIGhhbmRsaW5n
IHdhcyBhbHJlYWR5IGluY29tcGxldGUgYmVmb3JlIHRoYXQgY29tbWl0LApidXQgdGhlIGZhaWx1
cmUgbW9kZSB3YXMgZGlmZmVyZW50LiBfX3NwaV91bm1hcF9tc2coKSB3YXMgZ2F0ZWQgYnkKY3Rs
ci0+Y3VyX21zZ19tYXBwZWQsIHdoaWNoIHdhcyBzZXQgb25seSBhZnRlciB0aGUgd2hvbGUgbWVz
c2FnZSBoYWQKYmVlbiBtYXBwZWQgc3VjY2Vzc2Z1bGx5LiBBIHBhcnRpYWwgZmFpbHVyZSB0aGVy
ZWZvcmUgc2tpcHBlZCB0aGUKbm9ybWFsIHVubWFwIHBhdGg6IGl0IGNvdWxkIGxlYWsgbWFwcGlu
Z3MgbWFkZSBmb3IgZWFybGllciB0cmFuc2ZlcnMsCmJ1dCBpdCBjb3VsZCBub3QgdW5tYXAgdGhl
bSBhZ2FpbiB1c2luZyBhbiB1bnB1Ymxpc2hlZCBETUEgZGV2aWNlLgoKVGhlIHBlci10cmFuc2Zl
ciBjb252ZXJzaW9uIHJlbW92ZWQgdGhhdCBtZXNzYWdlLXdpZGUgZ2F0ZS4gVGhlCnBlci10cmFu
c2ZlciBmbGFncyBjYW4gbm93IHJlbWFpbiBzZXQgYWZ0ZXIgYSBwYXJ0aWFsIGZhaWx1cmUsIHdo
aWxlCmN1cl97dHgscnh9X2RtYV9kZXYgYXJlIHN0aWxsIHB1Ymxpc2hlZCBvbmx5IGFmdGVyIHRo
ZSB3aG9sZSBtYXBwaW5nCmxvb3Agc3VjY2VlZHMuIFRoZSBzdWJzZXF1ZW50IGNsZWFudXAgY2Fu
IHRoZXJlZm9yZSB1bm1hcCB0aG9zZQp0cmFuc2ZlcnMgdXNpbmcgYSBOVUxMIG9yIHN0YWxlIGRl
dmljZS4gVGhhdCBpcyB0aGUgcmVncmVzc2lvbiByZWZlcnJlZAp0byBieSB0aGUgRml4ZXMgdGFn
LgoKQWdyZWVkLiBJJ2xsIGFkZCB0aGlzIGV4cGxhbmF0aW9uIHRvIHRoZSB2MiBjb3ZlciBsZXR0
ZXIuCgo+IEZvciBhIGZpeCB0aGlzIGlzIHByb2JhYmx5IG9rYXkgdG8gaW50cm9kdWNlLCBidXQg
Y2FuIHdlIGdldCByaWQgb2YKPiBmb3J3YXJkIGRlY2xhcmF0aW9uIGJ5IG1vdmluZyB0aGUgdW5t
YXBwaW5nIHJvdXRpbmUgYWJvdmU/IElmIHNvLCBjYW4KPiB5b3UgYWxzbyBhZGQgYW5vdGhlciBw
YXRjaCBmb3IgdGhhdD8KClllcy4gSSdsbCBrZWVwIHRoZSBmb3J3YXJkIGRlY2xhcmF0aW9uIGlu
IHRoZSBmaXggc28gdGhhdCBpdCByZW1haW5zCmluZGVwZW5kZW50bHkgYnVpbGRhYmxlIGFuZCBi
YWNrcG9ydGFibGUuIEknbGwgdGhlbiBhZGQgYSBmb2xsb3ctdXAKY2xlYW51cCBwYXRjaCBtb3Zp
bmcgX19zcGlfdW5tYXBfbXNnKCkgYWJvdmUgX19zcGlfbWFwX21zZygpIGFuZApyZW1vdmluZyB0
aGUgZGVjbGFyYXRpb24uCgo+IERvZXMgdW53aW5kIHJvdXRpbmUgbnVsbGlmeSB0aGVtPyBJZiBu
b3QsIHRoZXJlIGlzIGEgY2hhbmNlIHRoYXQgc29tZQo+IGNvZGUgKG1heWJlIGluIHRoZSBmdXR1
cmUpIG1pZ2h0IHVzZSBzdGFsZSBwb2ludGVycy4KCkl0IGN1cnJlbnRseSBkb2VzIG5vdC4KCkkg
Y2hlY2tlZCB0aGUgY3VycmVudCB1c2Vycy4gVGhlIHRocmVlIHVzZXJzIGluIHRoZSBTUEkgY29y
ZSBvbmx5IHVzZSBhCmRldmljZSB3aGVuIHRoZSBjb3JyZXNwb25kaW5nICpfc2dfbWFwcGVkIGZs
YWcgaXMgc2V0LiBUaGUgYWNjZXNzZXMgaW4Kc3BpLWFtbG9naWMtc3Bpc2cgYWxzbyBvY2N1ciBi
ZWZvcmUgc3BpX2ZpbmFsaXplX2N1cnJlbnRfbWVzc2FnZSgpIG9uCmV2ZXJ5IHBhdGggd2hpY2gg
cmVhY2hlcyB0aGVtLgoKTmV2ZXJ0aGVsZXNzLCBJIGFncmVlIHRoYXQgdGhlIHBvaW50ZXJzIHNo
b3VsZCBub3Qgc3Vydml2ZSB0aGUgbWVzc2FnZS4KSSdsbCBjbGVhciB0aGVtIGluIGEgc2VwYXJh
dGUgZm9sbG93LXVwIGNsZWFudXAgcGF0Y2gsIGluCnNwaV91bm1hcF9tc2coKSBhZnRlciBfX3Nw
aV91bm1hcF9tc2coKSByZXR1cm5zLCByYXRoZXIgdGhhbiBpbnNpZGUKX19zcGlfdW5tYXBfbXNn
KCkgaXRzZWxmLiBUaGUgbGF0dGVyIGlzIGFsc28gdXNlZCBmb3IgdGhlIGluLW1lc3NhZ2UKRE1B
LXRvLVBJTyBmYWxsYmFjayBhbmQgdGhlcmVmb3JlIGRvZXMgbm90IG1hcmsgdGhlIGVuZCBvZiB0
aGUgbWVzc2FnZQpsaWZldGltZS4KCj4gU2luY2UgeW91IHRvdWNoZWQgdGhlc2UgbGluZXMsIHBl
cmhhcHMgaXQgbWFrZXMgc2Vuc2UgdG8gZHJvcCAnICE9IDAnCj4gcGFydHMgdG8gbWFrZSBpdCBm
b2xsb3cgdGhlIHJlZ3VsYXIgcGF0dGVybi4KCldpbGwgZG8uIEJvdGggY2hlY2tzIHdpbGwgdXNl
IHBsYWluIGlmIChyZXQpIGluIHYyLgoKVGhhbmtzLApIb25naHVp
