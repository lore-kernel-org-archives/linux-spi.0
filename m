Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795458284;
	b=CwuD4hwXW8O8bo402AZN4ZEEwXQ9QHR3GDNCgKCU7xYlsGNfff27ZTm1kZd/FOXojbJr
	 V64N5S30btGPHxELXKpb0HTZhI/0zdKBUQYpMKLupYtVz/Eqgjkz6rzMQHHLTL0QGMK2E
	 0akTj+uinWdQGV5hRTyFsx/XUhic2wgNSazz5jlg+WkaNsBmuValMtIAWkTcznrgBAq8t
	 9DPvtYU3eSVlzHf6DRI6+nZfqYOxwUAL+tpxEMkkurW8Yl4Hf5HxLvf7LUrjXdTIb+2dk
	 lDc3idDkVaL6DNI/KCvirI4bHo5Xm2AuWsUJXWGdlIlExnZLRkVFPxHv1jec8/RJ/rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795458284;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=ilZYU0nJlOfbIZpA54O6Llww2cRpeFf60lBf1k1tKTo=;
	b=feoae1m2OjxVGFa85AhEQtqmISOrlALmG2yYfC1Q1nkCS9y0117Ac2Z8e6P4daalEnIm
	 sJVWbVr8KqiE2hrvUQmpXOLxm+LMmM8JTJEPRyq4/+tfLfoFSKTWV3v0pza58FeBf+eDI
	 Wnez1a8Pi1JAiIRTkzLRiAM8PzVqafCZsmeStPmoCcJQ91irGloBgocthh2HDCFBYATWF
	 Wos3iRiAgN2z2GEr7rs8RHXW3prLdk2pqY9s/Tx/0R6xQU51m/EB/jgx2arNUEH3QXQOz
	 O0WxfoOZAxwvDMs6BlOnwaYSsh923XdL+TY5j6fgxP2IyjV9Ta9j87PQYwM/QeB5VFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=p25iRIYb;
	arc=none smtp.remote-ip=212.227.15.3
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E13E606A332
	for <linux-spi@vger.kernel.org>; Mon, 23 Nov 2026 18:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E13E606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=p25iRIYb
DKIM2-Signature:  i=1; m=1; t=1795458281;
 mf=PE1hcmt1cy5FbGZyaW5nQHdlYi5kZT4=;
 rt=PGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc+;
 d=web.de;
 s=s29768273:rsa-sha256:kBYL9/1AWZs9jnrhbqMPSiTJa3NO
   u04gZ4PyAU5AaY53pYTGGrVbbFVLuh2imxgxTN4NEDIwu49Xhmmud8VJtskKH+BNOplKOgIgM3B
   r6K/1N4lmrs425hZhD/tpoDNZQf3Oqwsh5gAmkNUs9/oLuiv13g6utfMKFGOiLlsFip3d8/YWAC
   vZjGy5C3/MMNumHhlokJJO+b1qmiAgABjOMfTm/7Etc7cmR+RCDTbiyq/TW/a/szFVnRUdSSskX
   iLJA9ptnvYjUIs7Nf2DS87MKmn1+T2DUOcPs/n44S2VxEtxZ41USwb3rk8prbs56UtpHm3bi+bi
   xEKHapwNd/hkqg==;
Message-Instance:  m=1;
 h=sha256:
   lFU5GzAKl7OHOHFEhr3F8UWbmK7nMFoCDiEMXnGekGA=:
   WxpEIgDNviJYDpLvFLwQq3jSa3mMR3LZqMWRbgfvz7Q=,
  sha512:
   lHmbAdtCFkvTQfCaTxC6MPuf25UWUTbj8xPsMbuH4KN05lUy55I3uD3DDLvUMmBjV0MoV5UINFgSiTcjTSYeUA==:
   LtcOp/THSetMhJQu9FTgkRmDYsCUWeWVMi7Mb1f8Od/vNWLygPyNfQIRYfWgtphwSHkSObECctHCLAeNEdXzPQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1795458265; x=1796063065; i=markus.elfring@web.de;
	bh=ilZYU0nJlOfbIZpA54O6Llww2cRpeFf60lBf1k1tKTo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=p25iRIYbrc7mYByoWmfWtzvu4sAVhjGyrgBFwkgouJwRFhkKVrPNUcNm+izTSn5I
	 i6DZC7HQn7+VuBtf+8ebLbRNJ5va40VaD0DaXW5hg6E1Wo2WML9lvs4Ry8uJ0Tuvh
	 aFr7s6RrpUHlMkqg9ru8oXoda4XGp/LeFPlMut6tXKzc0u+2/zZ1e9nHg9v9vkWzV
	 aLgWc65QRrqciOa0y/Q9Y1Gv1FH4D/9d48ag+6KQfU+tY3WQbdrNaHR870wdzxZwv
	 QH+qiNnRdxIcZFlBPF0+bc75do61pohkVkwl7G0qUBV8nwOIXGT6zlTPQPNqVq+FV
	 DiZBCHpPpK+e1GxvGA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2ggd-1xXUWM00bP-002Uz7; Mon, 23
 Nov 2026 19:24:25 +0100
Message-ID: <797d8f02-2e16-4ca6-bfda-8b6e40742a84@web.de>
Date: Mon, 23 Nov 2026 19:24:21 +0100
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: spi: imx: Use devm_clk_get_enabled() calls in spi_imx_probe()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, imx@lists.linux.dev,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@pengutronix.de
Cc: Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 Johan Hovold <johan@kernel.org>, Mark Brown <broonie@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Florian Fainelli <f.fainelli@gmail.com>, Michal Simek <michal.simek@amd.com>
References: <895d50a6-3a42-44d2-8625-3b8cba8fbfff@web.de>
 <awR3jGcH97PrYNqc@ashevche-desk.local>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <awR3jGcH97PrYNqc@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9cHX4ybb0CLcDRh387G8BMTzRDTbVb+A+YtoGlQvKFjiBdy/D9z
 +J4QDEssM4T5CEKLj1xw2bpccGzFVh289WJ3MbAjyxQaPDJ3hlx5NI6ZrsgCUrkNzgrZRcc
 tqT6R24r/G3+875PL+KIUbI6OmRz98x3vwbimvB1Lqjxh5FWy5cZynEBpEb+gE5BTt6XSoQ
 HmZsangITgbWRUt6N0HQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AbgOBMH4gCA=;19ZxCPShFkYCIz7Vqm+XWTTyPn8
 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

>> * Reuse existing functionality from devm_clk_get_enabled() instead of
>>   keeping duplicate source code.
>>
>> * Delete clk_disable_unprepare() calls on error handling paths.
>>
>> * Omit the label =E2=80=9Cout_put_per=E2=80=9D.
>>
>> This issue was detected by using the Coccinelle software.
>=20
> This now messes up with the PM callbacks at remove stage.
> It's not trivial how to make it correct.
Is there a need to adjust and extend devres programming interfaces any mor=
e?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/driver-api/driver-model/devres.rst?h=3Dv7.4-rc4#n242

Regards,
Markus
