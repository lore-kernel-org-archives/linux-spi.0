Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE41490C0D;
	Fri, 14 Aug 2026 17:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786729147; cv=none; b=Y/WrG8e8DbLEh73nkQkqX0BU73e+PQuYmCuTz2od+8S1ySgdKc7WAz45uMzJ1To8npp1zVdbfbNHzOXiaFZu4NMpgshWpVQ1IWz4XpyRqEfur2qYpP3zkITyfCxD1VdYj6E/r/Przom5IFwiM5a89+VpootntHYMSMQZPqqBud4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786729147; c=relaxed/simple;
	bh=n7dKlPcRbePGYLfKVe62w9G5TU4eYuYfA54xqufalcI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=F5Tk65R0eadOWpKf6yuAIwGRWuHfJDtCLjVBPNPVGxVtJjxsoZVn6UulfpX+2DUWb+gQo8+KE202Kk5xNjEnr3SNUFmpgNuht4tOMwIV5o+bodrG+fLosKsAl/Ti+icHy4MBWBMjsEOIft/blJGfUrj00Pfp8IoQd+R9Dy8umOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cSbnbTTn; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cSbnbTTn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=n7dKlPcRbePGYLfKVe62w9G5TU4eYuYfA54xqufalcI=; b=c
	SbnbTTnsP2xgyz5v9WBleWZMwkPrvJnhBMOxDh8wlYRZ2CFyyW+Unc/gJaGXLlP8
	hZHQXSJy3vTU2dcbrtPhX3dX70wjRjani3HGaAidRuOTbrTKiQIWAbCFdojz52PC
	dR+PIN/us0C9t5a4B34xmqTTrkFAKV6woaywrJzMTM=
Received: from jiang_hh2019$163.com ( [180.168.188.67] ) by
 ajax-webmail-wmsvr-40-145 (Coremail) ; Sat, 15 Aug 2026 01:38:11 +0800
 (CST)
Date: Sat, 15 Aug 2026 01:38:11 +0800 (CST)
From: "Honghui  Jiang" <jiang_hh2019@163.com>
To: "Mark Brown" <broonie@kernel.org>
Cc: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
	"Andy Shevchenko" <andy@kernel.org>,
	"Serge Semin" <fancer.lancer@gmail.com>,
	"Brendan Higgins" <brendan.higgins@linux.dev>,
	"David Gow" <david@davidgow.net>, "Rae Moar" <raemoar63@gmail.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH v2 4/4] spi: Add KUnit coverage for DMA mapping error
 paths
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <93950eda-ee8e-4a28-8e3c-707d64c956fe@sirena.org.uk>
References: <20260814031419.43378-1-jiang_hh2019@163.com>
 <20260814031419.43378-5-jiang_hh2019@163.com>
 <an8JaNLIy4je-tiG@ashevche-desk.local>
 <93950eda-ee8e-4a28-8e3c-707d64c956fe@sirena.org.uk>
X-NTES-SC: AL_Qu2TBPuZtkgi5yieZekdmU8age42XMSzuP4u2YJTc+oGtQb1xiIDeHFhJ0nT+9KOOwygmzObcCp+7vhhT6J4ZdXpWznSrZNQGxBm9LBnqQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <53943105.8b50.1a0015a531c.Coremail.jiang_hh2019@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:kSgvCgD3X6aEUn9q11MyAA--.18W
X-CM-SenderInfo: xmld0whbkkjiirz6il2tof0z/xtbC0wQwcGp-UoS9ggAA3r
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

T24gRnJpLCBBdWcgMTQsIDIwMjYgYXQgMDE6NDk6NTBQTSArMDEwMCwgTWFyayBCcm93biB3cm90
ZToKPiBPbiBGcmksIEF1ZyAxNCwgMjAyNiBhdCAwMzoyNzoxM1BNICswMzAwLCBBbmR5IFNoZXZj
aGVua28gd3JvdGU6Cj4gPiBUaGlzIGlzIGEgc3RyYXkgY2hhbmdlLgo+Cj4gV2VsbCwgb25lIG9m
IHRoZSBjb25maWcgY2hhbmdlcyBpcy4gIENsZWFybHkgc3BpIGlzIGNyaXRpY2FsIGVub3VnaCB0
bwo+IGJlIHRlc3RlZCBieSBkZWZhdWx0ISAgOlAKCgpUaGFua3MsIGJvdGguIEknbGwgZHJvcCBD
T05GSUdfU1BJPXkgZnJvbSBkZWZhdWx0LmNvbmZpZyBpbiB2MyBhbmQga2VlcAppdCBpbiBhbGxf
dGVzdHMuY29uZmlnLg==
