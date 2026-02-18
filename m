Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DCF31770E;
	Wed, 18 Feb 2026 08:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771403109; cv=none; b=A6qoJh4gGXxIeMbjuLm1ftiR8EgXRjHt98yrbTlvFNlfHnWSIOFwN9cLW3CygK3U4pq5mPlTnjxB7krM9ANR6Z7dWhtUy4e+DRgz+8lj5GyKaDd0jwgiSS3/4HL38dYTWXjNd81+dtwr0ZD/qT+De6IkSPGFtKBjM+5oM4u6Z2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771403109; c=relaxed/simple;
	bh=Zhe+qNHKYPH+Gr0CR9DePhE8hbJt6VV3wrNMdRwyKac=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=kL8GQoe926n4deyKgrkpzr4WptbxZaEOzpl56rm3MGj0Fg4l8jar8lpHfguaehPWTAvLl2WO/OhfAKsAVzlOjXDOHR+Ov5IDZN7xuRQm20F2xW7/eP6FmWjyOMVfMHGgZJF00af3ks/JndcFaly+jg3Y1/oHF69ZI6PDo/4Iy2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=pN4JB9jI; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="pN4JB9jI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1771403097;
	bh=wojLPn+scY4sV5Bm8WYNYZSTF91xdc6yqbBc3RSidDw=;
	h=From:To:Cc:Subject:Date;
	b=pN4JB9jIJ/wOG736dH6xurRIvEcRn8I40fd5crgwdlpmYWixrOB2e0oQnnnZglwIq
	 kMe6oB5CFuox3DXvsxtp/DpP9m6O/VICZRXLaBFkbVFTV1m5RQ7JoUD3PPkux82gRO
	 BuQtNWYZZAta9uRFyP5URlAyaUSuEOpzhuJmqckw=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 54C0D0CC; Wed, 18 Feb 2026 16:21:12 +0800
X-QQ-mid: xmsmtpt1771402872txyuxy6r5
Message-ID: <tencent_E59C90CD95B9DE440871635139437A79410A@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5d9VMSzcCG3DFUY+rRvrmeExCzweAUWMTZ67Em4SQpqQR89MEXE
	 u5l3/BjJjgDcdydSdxrmD+8HQgB8pe0um97gfv/8w5xMtYHQZKEo3DdsLaJnkgFO+79DBnq45t+x
	 1MUDHbRIj43YjU/qBGCLMN6zRR2+1strKWoWhOCBNKa76S4O85l18ZA6J8/2zgzgBPLcH2T5QxDr
	 0m3zRJC2387HqKdp/SnBsxdvLsahSn/ZAnmPLPNMCp6f2CUk6zGVJKEd4mGw63cHJu6owIN0bJ1f
	 KZDdG6qKq5j4T3Bw3Gog1ltczpaTSWWpWtXoC0v0fTXFyLVFXJQP2gw28NgcIEQl2dmOOBrunRJU
	 rJ+u2s+F4hN0YZky9+6iM6+X0yQ9GnZvJ2rhJwsHYuOTrOgkWY/G4pnEAZlVZJm8vBjKP7c60Fzg
	 ixkIbCDk+GkmPmNE44kyjI3LV+p7+WfjdygPRXnxoicpVYNO+3/2xr5mC6w6emOU/TjZk1fgtmhO
	 SQDV60nVhF2OYxMxo3eMPjpdgjsLwLs9qsgazLYp3E80VZXmvSbJZtvicmlMyUihi7UKJS6eaVH9
	 QFBKCZhLbSLP61Z9uFKfkZUTk9zWcbDlFzUJ8JCulBL9qwZSleXgLx33ouiYMqFgp9CbpYr+yoNL
	 9kNCCxkF/rGNgN5B5No3LbbFn9K4KCVU5fZKYjJwJGAK0VaaCONO1qqT4BSmxXeUlI8H05mDvSWE
	 RQlB+3YzJ0/AENy+31H883h7gn+k6HkD+6+AM36h1aYfuV3k/Z1nZR1asws7RqSvsOowFGEk9CZ5
	 p5LhB5fauVkb6FSFPdh4QjYj/31XuxSQHjijbfJIim1V49EFgf1LHYKMe6LhoJ8A37+w0nHqQvb7
	 2007z9deehMOpp6yzosb34uWACdMGf6gWkbiuR2e9ydXfqaiFRsttr7PPIX2GCjQbQmvGgvyMme5
	 azjTDonAE66w8T+npn9ABetG2kg+NPftybC+Ig/5LwMH2Hoai5ItKGiB5XHmnqDWdI//kkmUMJOE
	 EDKdjWiaKwK7NhixFB/+YZ+9CV5snU8HPtPfYsWg==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: xiaopeitux@foxmail.com
To: cl634@andestech.com,
	broonie@kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] spi: atcspi200: validate data buswidth to fix FIELD_PREP build error
Date: Wed, 18 Feb 2026 16:21:10 +0800
X-OQ-MSGID: <eca47f984ab7bab56e31b3a3f852c9ca599c527e.1771402821.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pei Xiao <xiaopei01@kylinos.cn>

TRANS_DUAL_QUAD only two bit, limit to range 0~3.
which gcc complains about:
error: FIELD_PREP: value too large for the field
drivers/spi/spi-atcspi200.c:198:9: note: in expansion of macro
'TRANS_DUAL_QUAD'
tc |= TRANS_DUAL_QUAD(ffs(op->data.buswidth) - 1);

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202602140738.P7ZozxzI-lkp@intel.com/
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/spi/spi-atcspi200.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-atcspi200.c b/drivers/spi/spi-atcspi200.c
index 60a37ff5c6f5..87a2dedcee55 100644
--- a/drivers/spi/spi-atcspi200.c
+++ b/drivers/spi/spi-atcspi200.c
@@ -195,7 +195,10 @@ static void atcspi_set_trans_ctl(struct atcspi_dev *spi,
 	if (op->addr.buswidth > 1)
 		tc |= TRANS_ADDR_FMT;
 	if (op->data.nbytes) {
-		tc |= TRANS_DUAL_QUAD(ffs(op->data.buswidth) - 1);
+		unsigned int width_code = ffs(op->data.buswidth) - 1;
+		if(unlikely(width_code > 3))
+                        return;
+		tc |= TRANS_DUAL_QUAD(width_code);
 		if (op->data.dir == SPI_MEM_DATA_IN) {
 			if (op->dummy.nbytes)
 				tc |= TRANS_MODE_DMY_READ |
-- 
2.25.1

