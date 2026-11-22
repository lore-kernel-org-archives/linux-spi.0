Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795369491;
	b=RRxC7jZIvDRT/395ARQcT9HzYknEvQxUf3gYJjBvILTopWdHoxK/33dI7UvU4nB5lBUK
	 afxFwOYt0e08Z0/3rx8y8EC29Nfru4LZxD38vkMxKaWFtFOUEq7G5/cTynIVaBkDtLiRf
	 ZMjvROGE/hmSSA811SdO2YOuyVOiPl1xW7Plynso6z6f2LRnVtYmdFyIbTT1a+sVN4NUo
	 4Et1Ew3OHNXEN99uOMpF8vVjooeUCtZayfp4Ssal2IS9Nr9ZM1bRuiMw8Rxv7zIvWGcpU
	 LaDMKOSI4n/fUrsvN0KP9MV8v4Tr2GCBPN95PX9CjLKNWrkfvbRHni+XnjPv1K7gRZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795369491;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:CFBL-Feedback-ID:
	 CFBL-Address:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=YC+Ogj9wmHA/Qf6zYsQ4fT2IqAwJLhOnqw7/ALnfGek=;
	b=x/Fv4cnlKFbWeYT3sG6cVBo33HJoYn8waMi2y+DOE8MDYQq2XvZFCp8JLC3rDTSuQNWz
	 5oKlfDOu/5jOa22huud+3QvzoC0y7eidjPhYh7YRTZ1S5hLdV80t1eYv40Z84FGqB031T
	 qj/iGjFCQYPNqviuMpzy/rxax/YMIQNnUnNWpBdyDHf5fAPafcN4banhoqsa2QEtdMgmI
	 YvdgY/xzsieVcEZ1eEz+KBUf3rwhFvdXw7ZV4YbllayXsVlMwi7PYTb2e2bHnLhfCbOI2
	 W2pQ8HwqdK51HoCKXB6UG/VIA5Ig/PMR/ieYFiNXoZDHp2LAXgQ/yuhjZhcMUok95kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kwiboo.se;
	spf=pass smtp.mailfrom=fe-bounces.kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=eQSO7jbW;
	dkim=pass header.d=forwardemail.net header.i=@forwardemail.net header.a=rsa-sha256 header.s=default header.b=NrQvOlmR;
	arc=none smtp.remote-ip=149.28.215.223
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB444606A682
	for <linux-spi@vger.kernel.org>; Sun, 22 Nov 2026 17:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB444606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=eQSO7jbW;
	dkim=pass (1024-bit key, unprotected) header.d=forwardemail.net header.i=@forwardemail.net header.a=rsa-sha256 header.s=default header.b=NrQvOlmR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From: CFBL-Address: CFBL-Feedback-ID; q=dns/txt; s=fe-e1b5cab7be;
 t=1795369489; bh=YC+Ogj9wmHA/Qf6zYsQ4fT2IqAwJLhOnqw7/ALnfGek=;
 b=eQSO7jbWwdzVmf48iiCsdCn2MIUs08sRiqBjROm719HHzGwCWm2NFQkBQfr/Gp1JKY5dDLX0h
 HIST4Z7ee9P1NMgoUGGOH15SZ4DkogMyHQqWjIkVsrZrlJ/5Lp5bQM6AZf6CDAta06iUkGgQhQ3
 Kl60xWiiyOxsIlIXp0V9URbLiU5skogjUM7qOP8MX0SIxfiPsCM/IxivUThVevGzwnbgI5a0cpm
 9HwU0kqXWlMgzna7rzHZP3ob76tFvzVMbrv6y+7cFtP54W7aXzSkXEitusDfLAZ5+OsZg2iK9dq
 6zpqF5Y4KQ+rIvmfdqbmpz/JGxPVM+fWG+74jOLsA1Jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=forwardemail.net;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From: CFBL-Address: CFBL-Feedback-ID; q=dns/txt; s=default;
 t=1795369489; bh=YC+Ogj9wmHA/Qf6zYsQ4fT2IqAwJLhOnqw7/ALnfGek=;
 b=NrQvOlmRKhhYGs6uxbympWPpIFWPDp+W2j9E2qYvBDDfOl2ZexQ9XaSSvK77w7JQSnnJlKrxd
 leYSQi1kJpb7ty/i+Hkuqnae4X7mColyiqQhdXlvGniZps7kWUp2AMt8nHYb/lguH24JHKDIvYl
 n2ftpMPmDjEFHghkD/CLsjI=
CFBL-Feedback-ID: 6b0329e237459da6a917fd20:615e4b675148a362b7f544948ebb1200
CFBL-Address: abuse@forwardemail.net; report=arf
X-Forward-Email-ID: 6b0329e237459da6a917fd20
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.19.37
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Mark Brown <broonie@kernel.org>,
	Jon Lin <jon.lin@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH] spi: rockchip-sfc: Only use x2 clock rate on version 10 and later
Date: Sun, 22 Nov 2026 17:43:57 +0000
Message-ID: <20261122174357.1295391-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The detected NAND ID is read back incorrectly on RK3506 using SCLK_FSPI
rate above ~50 MHz.

  spi-nand spi0.0: unknown raw ID f7d511000000
  spi-nand spi0.0: probe with driver spi-nand failed with error -95

The FSPI_VER value, clock names and vendor kernel sclk-x2-bypass
handling seem to indicate that x2 clock rate should only be used on
FSPI version 10 and later, not 8 and later.

Summary of FSPI_VER reg, clock names and vendor kernel workarounds:

   SoC       Reg address       Value
  rk3568  FSPI_VER  fe30002c: 00000005
  rk3588  FSPI_VER  fe2b002c: 00000005
  rv1106  FSPI_VER  ffac002c: 00000006
  rk3528  FSPI_VER  ffc0002c: 00000008 (vendor sclk-x2-bypass)
  rk3562  FSPI_VER  ff86002c: 00000008 (vendor sclk-x2-bypass)
  rk3506  FSPI_VER  ff48802c: 00000009 (sfc->version set to 6)
  rk3576  FSPI0_VER 2a34002c: 00070010 (SCLK_FSPI_X2)
  rk3576  FSPI1_VER 2a30002c: 00070010 (SCLK_FSPI1_X2)
  rv1103b FSPI0_VER 20d4002c: 00070011 (SCLK_SFC_2X, sclk-x2-bypass)
  rv1103b FSPI1_VER 205c002c: 00070011 (SCLK_SFC_2X_PMU1, sclk-x2-bypass)
  rv1126b FSPI0_VER 2146002c: 00070011 (SCLK_2X_FSPI0)
  rv1126b FSPI1_VER 208c002c: 00170011 (SCLK_1X_FSPI1, sclk-x2-bypass)
  rk3538  FSPI_VER  fde2002c: 00670013 (SCLK_2X_FSPI)
  rk3572  FSPI0_VER 2a02002c: 00470013 (SCLK_FSPI0_X2)
  rk3572  FSPI1_VER 2a08002c: 00470013 (SCLK_FSPI1_X2)

Vendor kernel use x1 clock rates for RK3528, RK3562 and RK3506 thanks to
use of vendor sclk-x2-bypass prop or version downgrade, effectively only
use x2 clock rates on version 10 and later.

FSPI1 on RV1126B should likely also use x1 clock rates, and DDR_UNSPPT
(bit 20) of FSPI_VER being set could possible be used as a runtime
indicator.

Runtime testing also seem to indicate that SCLK_X2_BYPASS (bit 24) of
FSPI_EXT_CTRL only stays set after being written on RV1103B, not on any
other version 8 and later controllers.

Change to only use double clock rate for version 10 and later to fix
use of SPI NAND on RK3506.

  spi-nand spi0.0: Winbond SPI NAND was found.
  spi-nand spi0.0: 256 MiB, block size: 128 KiB, page size: 2048, OOB size: 128

Fixes: af103eb7d7d8 ("spi: rockchip-sfc: Support sclk_x2 version")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/spi/spi-rockchip-sfc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
index a85a260ba95f..8cc300d533e4 100644
--- a/drivers/spi/spi-rockchip-sfc.c
+++ b/drivers/spi/spi-rockchip-sfc.c
@@ -113,6 +113,7 @@
 #define  SFC_VER_4			0x4
 #define  SFC_VER_5			0x5
 #define  SFC_VER_8			0x8
+#define  SFC_VER_10			0x10
 
 /* Delay line controller register */
 #define SFC_DLL_CTRL0			0x3C
@@ -220,7 +221,7 @@ static u32 rockchip_sfc_get_max_iosize(struct rockchip_sfc *sfc)
 
 static int rockchip_sfc_clk_set_rate(struct rockchip_sfc *sfc, unsigned long  speed)
 {
-	if (sfc->version >= SFC_VER_8)
+	if (sfc->version >= SFC_VER_10)
 		return clk_set_rate(sfc->clk, speed * 2);
 	else
 		return clk_set_rate(sfc->clk, speed);
@@ -228,7 +229,7 @@ static int rockchip_sfc_clk_set_rate(struct rockchip_sfc *sfc, unsigned long  sp
 
 static unsigned long rockchip_sfc_clk_get_rate(struct rockchip_sfc *sfc)
 {
-	if (sfc->version >= SFC_VER_8)
+	if (sfc->version >= SFC_VER_10)
 		return clk_get_rate(sfc->clk) / 2;
 	else
 		return clk_get_rate(sfc->clk);
-- 
2.56.1

