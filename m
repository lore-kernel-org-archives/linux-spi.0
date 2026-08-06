Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F150375F9E;
	Thu,  6 Aug 2026 04:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785990039; cv=none; b=oeL+jpBoTLMtsOyqKSOsDQlWmOIPl5NH7AVHLs2c6yudJdK+8vkTG7t74rhBCgxecIUWPRN+PPfb/pyyBtEJFJRxVX5VkHGicwoVelE6VAnqoxLe49Nqjw9h1mTELm2kcClno3tEZsJRv7Dw0PstEvef5ZbCyG1KDo/oFLiTZps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785990039; c=relaxed/simple;
	bh=eCgqqkfm0UeUdXoUV/DHe1r1g3ztPDdn3Z7TKQgojPE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=rNbibuSe9rfHG4Xq4hvXiZjW8gfW2Sluubc2459ckD4A5LZvaFOl9pYfHX9d6ykfnZHZAf1VwqPztePQK4dZcYGp1muAR+VaZ6fhxuEeWtdFY7nsaaW1QG0GCT3yucavG+5noDlA27A3IVi1SBW4AmRd4m3e5VRU3fk8JezROE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pWGjgZev; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pWGjgZev"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=eCgqqkfm0UeUdXoUV/DHe1r1g3ztPDdn3Z7TKQgojPE=; b=p
	WGjgZevefMOatvvj1wfLIK7MziKKkqDLNKICmCINgpq4VXIOETFgYaHsG3QFofGL
	Tzr6aC7Es+IYZ8U/LDrnJxOofWhPkII/Zv9HtXFAOYknOghkIcfxpNlHjVjzznAK
	zkOoX5IfN5UtloSJIaRbBeQonuDsJF13b+6ZfoilZk=
Received: from jiang_hh2019$163.com ( [180.168.188.67] ) by
 ajax-webmail-wmsvr-40-101 (Coremail) ; Thu, 6 Aug 2026 12:20:02 +0800 (CST)
Date: Thu, 6 Aug 2026 12:20:02 +0800 (CST)
From: =?GBK?B?va266rvUIA==?= <jiang_hh2019@163.com>
To: "Mark Brown" <broonie@kernel.org>
Cc: andy@kernel.org, andriy.shevchenko@linux.intel.com,
	fancer.lancer@gmail.com, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] spi: Add KUnit coverage for DMA mapping error paths
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <fbc72384-2f47-4577-859f-719d55a2a66a@sirena.org.uk>
References: <20260805151456.756579-1-jiang_hh2019@163.com>
 <20260805151456.756579-3-jiang_hh2019@163.com>
 <fbc72384-2f47-4577-859f-719d55a2a66a@sirena.org.uk>
X-NTES-SC: AL_Qu2TB/WSv0gr5CmfbOkdmU8age42XMSzuP4u2YJTc+oEmjzt9jogd117BH3b0u+eDx22rwS+bTte5dhUXpVDWSEHY/ZIxxYEvWIjEFdjSw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <51604e4f.383b.19fd54cb92c.Coremail.jiang_hh2019@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZSgvCgBn73dzC3Rq2L0sAA--.16309W
X-CM-SenderInfo: xmld0whbkkjiirz6il2tof0z/xtbC1BOW1mp0C3M5rgAA32
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

VGhhbmtzIGZvciB0aGUgcmV2aWV3LgoKSSdsbCBhZGRyZXNzIHRoZXNlIGNvbW1lbnRzIGluIHYy
IGFuZCByZXdvcmsgdGhlIHRlc3QgaW50ZWdyYXRpb24KYXMgc3VnZ2VzdGVkLgoKQXQgMjAyNi0w
OC0wNiAwNTo1Nzo0MSwgIk1hcmsgQnJvd24iIDxicm9vbmllQGtlcm5lbC5vcmc+IHdyb3RlOgo+
T24gV2VkLCBBdWcgMDUsIDIwMjYgYXQgMTE6MTQ6NTZQTSArMDgwMCwgSG9uZ2h1aSBKaWFuZyB3
cm90ZToKPj4gQWRkIEtVbml0IHRlc3RzIGZvciB0aGUgX19zcGlfbWFwX21zZygpIGVycm9yIHBh
dGhzLiAgVGhlIHRlc3RzIHZlcmlmeQo+PiB0aGF0IG1hcHBpbmdzIGNyZWF0ZWQgYmVmb3JlIGEg
bGF0ZXIgVFggb3IgUlggZmFpbHVyZSBhcmUgdW53b3VuZCwgdGhlaXIKPj4gZmxhZ3MgYXJlIGNs
ZWFyZWQsIGFuZCBjdXJfe3R4LHJ4fV9kbWFfZGV2IHBvaW50IHRvIHRoZSBkZXZpY2UgdXNlZCBm
b3IKPj4gdGhlIG1hcHBpbmcuCj4KPlRoZSB0ZXN0cyB0aGVtc2VsdmVzIGxvb2sgZ29vZCBidXQg
c29tZSBzdHlsZS9pbnRlZ3JhdGlvbiBzdHVmZjoKPgo+PiAtLS0gL2Rldi9udWxsCj4+ICsrKyBi
L2RyaXZlcnMvc3BpLy5rdW5pdGNvbmZpZwo+PiBAQCAtMCwwICsxLDQgQEAKPj4gK0NPTkZJR19L
VU5JVD15Cj4+ICtDT05GSUdfU1BJPXkKPj4gK0NPTkZJR19TUElfTUFTVEVSPXkKPj4gK0NPTkZJ
R19TUElfS1VOSVRfVEVTVD15Cj4KPlRoaXMgYWxzbyBuZWVkcyBlbmFibGluZyBpbiB0aGUgS1Vu
aXQgZGVmY29uZmlncyBpbgo+dG9vbHMvdGVzdGluZy9rdW5pdC9jb25maWdzLgo+Cj4+IGluZGV4
IDA1YTg1MjQ5NC4uNDJlMzM3YzU0IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3NwaS9zcGkuYwo+
PiArKysgYi9kcml2ZXJzL3NwaS9zcGkuYwo+PiBAQCAtNTE0NiwzICs1MTQ2LDcgQEAgc3RhdGlj
IGludCBfX2luaXQgc3BpX2luaXQodm9pZCkKPj4gICAqIGluY2x1ZGUgbmVlZGluZyB0byBoYXZl
IGJvYXJkaW5mbyBkYXRhIHN0cnVjdHVyZXMgYmUgbXVjaCBtb3JlIHB1YmxpYy4KPj4gICAqLwo+
PiAgcG9zdGNvcmVfaW5pdGNhbGwoc3BpX2luaXQpOwo+PiArCj4+ICsjaWZkZWYgQ09ORklHX1NQ
SV9LVU5JVF9URVNUCj4+ICsjaW5jbHVkZSAidGVzdHMvc3BpX2t1bml0LmMiCj4+ICsjZW5kaWYK
Pgo+SWYgdGhpcyBpcyBqdXN0IHNvIHdlIGNhbiBwZWVyIGludG8gdGhlIGludGVybmFscyBpdCdk
IGJlIGJldHRlciB0byBhZGQKPmEgbG9jYWwgaGVhZGVyIGZvciBpbnRlcm5hbHMgYW5kIGJ1aWxk
IGFzIGEgc2VwYXJhdGUgdHJhbnNsYXRpb24gdW5pdAo+bGlrZSBub3JtYWwgcmF0aGVyIHRoYW4g
ZG9pbmcgdGhpcyBzb3J0IG9mIGJvZGdlLgo+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS90
ZXN0cy9zcGlfa3VuaXQuYyBiL2RyaXZlcnMvc3BpL3Rlc3RzL3NwaV9rdW5pdC5jCj4KPkV2ZXJ5
d2hlcmUgZWxzZSB3ZSB1c2UgLSBhcyBhIHNlcGFyYXRvci4KPgo+PiArLy8gU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IEdQTC0yLjAKPj4gKy8qCj4+ICsgKiBLVW5pdCB0ZXN0cyBmb3IgdGhlIFNQ
SSBjb3JlIERNQSBtYXBwaW5nIGVycm9yIHBhdGhzLgo+PiArICoKPgo+UGxlYXNlIG1ha2UgdGhl
IGVudGlyZSBjb21tZW50IGEgQysrIG9uZSBzbyB0aGluZ3MgbG9vayBtb3JlIGludGVudGlvbmFs
Lgo+Cj4+ICsgKiBUaGUgaW52YXJpYW50IHVuZGVyIHRlc3Q6Cj4+ICsgKgo+PiArICogICBXaGVu
IF9fc3BpX21hcF9tc2coKSByZXR1cm5zIGFuIGVycm9yLCBubyB0cmFuc2ZlciBpbiB0aGUgbWVz
c2FnZSBtYXkKPj4gKyAqICAgc3RpbGwgY2xhaW0gYSBETUEgbWFwcGluZy4gIEFueSB0cmFuc2Zl
ciB0aGF0IHdhcyBtYXBwZWQgYmVmb3JlIHRoZQo+PiArICogICBmYWlsdXJlIG11c3QgaGF2ZSBh
biBlbXB0eSBTRyB0YWJsZSBhbmQgYSBjbGVhcmVkICpfc2dfbWFwcGVkIGZsYWcuCj4+ICsgKiAg
IGN0bHItPmN1cl97dHgscnh9X2RtYV9kZXYgbXVzdCBpZGVudGlmeSB0aGUgZGV2aWNlIHVzZWQg
Zm9yIHRoaXMgbWFwLAo+PiArICogICByYXRoZXIgdGhhbiBhIGRldmljZSByZXRhaW5lZCBmcm9t
IGFuIGVhcmxpZXIgbWVzc2FnZS4KPgo+VGhpcyBpcyBmb3Igb25lIHNwZWNpZmljIHRlc3QsIGVp
dGhlciB0aGlzIGZpbGUgc2hvdWxkIGhhdmUgYSB0ZXN0Cj5zcGVjaWZpYyBuYW1lIHdpdGggZXZl
cnl0aGluZyBlbHNlIG5hbWVzcGFjZWQgdG8gbWFrZSByb29tIGZvciBmdXJ0aGVyCj50ZXN0cyBv
ciBhbGwgdGhpcyBzaG91bGQgZ28gd2l0aCB0aGUgc3BlY2lmaWMgdGVzdC4gIFRoaXMgbG9va3Mg
bGlrZSBhCj5ETUEgc3Vic3VpdGUgc28gcG9zc2libHkgbmFtZWQgYWZ0ZXIgdGhhdD8gIFRoZSBz
YW1lIGFwcGxpZXMgdG8gaW50ZXJuYWwKPmlkZW50aWZpZXJzLgo=
