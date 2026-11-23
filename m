Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795451015;
	b=1+oceqghxWcH4nxJ+ecedBEx7GJxT9JIsqTR7AgcxdZYImQzc6sELLRMa3Y0Z1ayP8Av
	 KCQzMjBkPy95vmaKaskm1RBAKnxu6CXsGQk8U33CB84Vklp4vi+DuAF0NFbDbZAd6I+JG
	 Z3Fb2PR6YRvgBFRHjT0F/VYzWjHW1/oGNk8YpAPqtwlh0Pf6uXtMbEaQmOo5ilY975ATB
	 KL11dmHXtJfQTyfW204bRPmvcFNcXGBY7XbvVh1Cmz1r8l51hPjjMUzaYMTxSaesw1Ys0
	 fKg18vD/2+4KJe2tEDXWrRVOUmfFLNMoz3drDmZxycraM5kC34cYfMG0VJZt+qAwCxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795451015;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:To:
	 Content-Language:Cc:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=X3yr2M2g/qTvSv+jcYlpkHtUUF45VS+YXGmnSQ08rlc=;
	b=c6yHC9znI8lmKmwQy70Q1fR6ggCxhQRG0/rlzMZz+hQl6cavYupJpfjqual5M804fIDS
	 JBWuJXAGnNl9plTItFjHPfaB25nrw0v9zpBSImiqfZOJj77OqSFVkKmEqvXt8f8o2dhMl
	 dxiPSujiFt1eOpxNQnPBjJMjqMmJzEHX9gg0pfqY12zy1ENDXLag95ek95QuoSCvGTFdr
	 UPmu7hyDHZqcA5Ng+cDhTD/Rb863ge9YhVrt5oebLwWKnDyk/NQHRq3+2FMqbq/IoN9gM
	 DwKg4eabtBIRT9datHIJnNiHuxZVzVkl6MSiPYzYwyiq6Y1upnkGeyA4eNAb/mDIEog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=mnZIXW1A;
	arc=none smtp.remote-ip=212.227.15.4
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB71E606A321
	for <linux-spi@vger.kernel.org>; Mon, 23 Nov 2026 16:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB71E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=mnZIXW1A
DKIM2-Signature:  i=1; m=1; t=1795451012;
 mf=PE1hcmt1cy5FbGZyaW5nQHdlYi5kZT4=;
 rt=PGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc+;
 d=web.de;
 s=s29768273:rsa-sha256:sxbpZZGC/IdsYLMjgSz1wHMxR7Cm
   6Mvp/x7vtc43aRUL+iNCXIMbiicvr+OxFzraULGUU0leNtfPwXzTKejYrXr5NFmGQ+O8+nOoiMZ
   Hs+X0uvs8o0R05AMFFghICdC1dfPwaB0ktyzPlJziBKkL1zayXTZy5X25li77WOTJ4KjxrbtPuZ
   c1lwy1vQB2BLVsjTK/AipkJYJ/UcuZpJJOt9ukHtVL5EQohiUqNnI0WpKr0KsHdDI6JZbcGK5Dg
   EsaZAZxDMhDtlAphDNzhw+fzkuy7aw37BVml0B3yHQjxBHHkjyqflGwFtlV37x2RzNRjQ4soQs1
   CIX9xrx6GwTtAg==;
Message-Instance:  m=1;
 h=sha256:
   Hrdq8KIwcn/AdX6M7b5tP2DTPx7H/mxCGGwbl6NuK8o=:
   2PsbQVCwzemTr25ZHIDUT8zps6viXcOVve+219qWt2M=,
  sha512:
   LZP52UeQDBTA7A7SjLNbtCnMWVxfv4XZtgwyhjgmEq7m68vVy9V2tdg2hxJ5gX8CACG5GeeqYICVNqWX7nxuEg==:
   Xr4ZVZKa0tiDH6GxxdMDt/JHrwN5CWHatPmuaxAnUW3Z3sNTitKqziJZdBxXGx5QK6UKUmklQ+2eZJG+0rwqNg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1795450995; x=1796055795; i=markus.elfring@web.de;
	bh=X3yr2M2g/qTvSv+jcYlpkHtUUF45VS+YXGmnSQ08rlc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mnZIXW1AXe3APiehopt1hb6Solue76O1yN0RyiN+wudDkyRRiNSoF8Oxmm+oh0UE
	 wMP2IlkUNymDRfBM5mR63QkBgB5JeZPnasXsYFFh5libNGRHOtjWj7FCM3xSB2l4H
	 NG98ef+yRM6pDqKFHOC+a1oZtr5TqXYSzy6te7uqtNS/4+mCYV4JqSuTyEug5PaTM
	 2MPXZUIXmeCzdghp1+g1ndx7D4pSWY5Y+HgpdOmaru+yLU9chXZvRnDsK+04nimZR
	 PPmn4vOpeN9fDXo7Tm28TT7nAPUBY08a1TSrU7dMpwBNz5MnzVHVj+XEG2qL9Xq9V
	 w7PFsFVB/GfddS3ing==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MEUSE-1xlSBN1QBm-002Bsn; Mon, 23
 Nov 2026 17:23:15 +0100
Message-ID: <895d50a6-3a42-44d2-8625-3b8cba8fbfff@web.de>
Date: Mon, 23 Nov 2026 17:23:12 +0100
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
To: imx@lists.linux.dev, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 Johan Hovold <johan@kernel.org>, Mark Brown <broonie@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Florian Fainelli <f.fainelli@gmail.com>, Michal Simek <michal.simek@amd.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] spi: imx: Use devm_clk_get_enabled() calls in spi_imx_probe()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0+GByxQdUJwHdHxbxuioaRqzxaRNM7BhSR9Mzr+3Dt7wPWgUxSg
 eKp0BNEYapil+kruCa8k4T1tK+eM35mAg7Cz4W408+XbY5aRIAMY4LpbK4LXkfjxUxEnw4S
 4EcC3BPQEhf78C7vzmAMjIJwaToBFCE2hrheFNWrzcfpPRjwuLGXXVQewEI8AUd8KAgk1rg
 Y6DOSqkRIFguXryEbX9SQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Zrzli6ViF9Y=;tvYvmqSxnlsxF91toNuJ/eREf5B
 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
 C+ZdL24XDGN4/1Kt5PHw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 23 Nov 2026 17:07:22 +0100

* Reuse existing functionality from devm_clk_get_enabled() instead of
  keeping duplicate source code.

* Delete clk_disable_unprepare() calls on error handling paths.

* Omit the label =E2=80=9Cout_put_per=E2=80=9D.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/spi/spi-imx.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index cadf0b93f440..a99edfbf2d61 100644
=2D-- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -2319,22 +2319,14 @@ static int spi_imx_probe(struct platform_device *p=
dev)
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "can't get irq%d\n", irq);
=20
-	spi_imx->clk_ipg =3D devm_clk_get(&pdev->dev, "ipg");
+	spi_imx->clk_ipg =3D devm_clk_get_enabled(&pdev->dev, "ipg");
 	if (IS_ERR(spi_imx->clk_ipg))
 		return PTR_ERR(spi_imx->clk_ipg);
=20
-	spi_imx->clk_per =3D devm_clk_get(&pdev->dev, "per");
+	spi_imx->clk_per =3D devm_clk_get_enabled(&pdev->dev, "per");
 	if (IS_ERR(spi_imx->clk_per))
 		return PTR_ERR(spi_imx->clk_per);
=20
-	ret =3D clk_prepare_enable(spi_imx->clk_per);
-	if (ret)
-		return ret;
-
-	ret =3D clk_prepare_enable(spi_imx->clk_ipg);
-	if (ret)
-		goto out_put_per;
-
 	pm_runtime_set_autosuspend_delay(spi_imx->dev, MXC_RPM_TIMEOUT);
 	pm_runtime_use_autosuspend(spi_imx->dev);
 	pm_runtime_get_noresume(spi_imx->dev);
@@ -2378,11 +2370,6 @@ static int spi_imx_probe(struct platform_device *pd=
ev)
 	pm_runtime_disable(spi_imx->dev);
 	pm_runtime_put_noidle(spi_imx->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-
-	clk_disable_unprepare(spi_imx->clk_ipg);
-out_put_per:
-	clk_disable_unprepare(spi_imx->clk_per);
-
 	return ret;
 }
=20
=2D-=20
2.56.1

