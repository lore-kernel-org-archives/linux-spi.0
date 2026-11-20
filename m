Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795155566;
	b=3X4vGKHXg5aF2ddIvpK+iNti/5dXDNeA0nEQ0dAxTjecf4F7HJ5F3yv0pNmR/BCogdDI
	 BS8Qwhfzu/GjaikxTULrHDFcIk9x+7fynFArwox8xGoTprYfYLRvrfEuh6UYNffLTdvm4
	 HWcDKM8CMhIMmswUiBF5wl8IHhbDu76ck1sE0KhLcr8Y6QfvF2C/ZDGOTcTIrIYAhcGhg
	 Yo8afmS7YwNgecbaREXFgJzlSDWLCNbcwPFtMGQaLzpG80KAFEPaKV2Vy+MJ2QVtQdzjE
	 PwHzjmA0x3ICpBcGRczIjUyhNbkrq1vOfRvyla1sX2RdcPbMouRB6HlTNMZJYmagCLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795155566;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0X0j1XhUMhKaP6JBzwMgpn+h1SsD9ZtkqloVM9q2hQQ=;
	b=fMLY3dvcWR7gn4bn5KIB2pTmcNZCvqqqnC3Xrxneuhur/42PCPyi5ai4EOB3hpSpOfeY
	 8OErKtp/sEXgCOZYndr+YKVQwiN8kJ2SPqHGcsCfW7YVmzLoAWR7WQ0rUqP7ir/XQg3Qv
	 BKlriMY1LX9sdd6sAF9OTUxjzNkHcSfnBpK0DH76zRuJ692EUCoUgY67+nIz3nJ1yvz8D
	 RxOOUal8udGlHoc7+MDkHrwpiHnh0BwIxYAxNhT6EoaC0IgXG03A7qkxzW/LAsmXtYxEd
	 WYfj8K3IC8duJXISTmfK/09qrD9rjsgIjZP+PUGAnId03BTFNY4DwPpDfDszRp2+0Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=r6bvnac6;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D95F606A33E;
	Fri, 20 Nov 2026 06:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D95F606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=r6bvnac6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=r6bvnac601+oBsDwU3S7blZT9Nj9dS8W/7Q2XL2R4JsIOFRE0G5L0Yb29w5grhhagmSELqMcOS8KP
	 lPkQIuvaopCs4aRJxazVBXf5M6e0uZg3oquH4cdYexfEEe7dGzBI+vO8gOFnL8w2TYwp6ph+TR2uUb
	 vO6MY0CsUPEMci6Y=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16affe66804f-00c23;
	Fri, 20 Nov 2026 14:19:23 +0800 (CST)
X-RM-TRANSID:2ee16affe66804f-00c23
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66affe66a8b3-18766;
	Fri, 20 Nov 2026 14:19:23 +0800 (CST)
X-RM-TRANSID:2ee66affe66a8b3-18766
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: broonie@kernel.org
Cc: rdunlap@infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] tools/spi: Return failure from spidev_fdx on I/O errors
Date: Fri, 20 Nov 2026 14:19:22 +0800
Message-ID: <20261120061922.98182-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
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

spidev_fdx logs failed ioctls and failed or short reads, but always
exits successfully once the device opens. Return an error from the
helpers and translate it to a failing exit status after closing the
file descriptor.

Fixes: 31a16294261a ("documentation: move spidev_fdx example to its own source file")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/spi/spidev_fdx.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/tools/spi/spidev_fdx.c b/tools/spi/spidev_fdx.c
index bc9c4f6c3ba8..45f0fd2444dd 100644
--- a/tools/spi/spidev_fdx.c
+++ b/tools/spi/spidev_fdx.c
@@ -15,7 +15,7 @@
 
 static int verbose;
 
-static void do_read(int fd, int len)
+static int do_read(int fd, int len)
 {
 	unsigned char	buf[32], *bp;
 	int		status;
@@ -30,11 +30,11 @@ static void do_read(int fd, int len)
 	status = read(fd, buf, len);
 	if (status < 0) {
 		perror("read");
-		return;
+		return -1;
 	}
 	if (status != len) {
 		fprintf(stderr, "short read\n");
-		return;
+		return -1;
 	}
 
 	printf("read(%2d, %2d): %02x %02x,", len, status,
@@ -44,9 +44,10 @@ static void do_read(int fd, int len)
 	while (status-- > 0)
 		printf(" %02x", *bp++);
 	printf("\n");
+	return 0;
 }
 
-static void do_msg(int fd, int len)
+static int do_msg(int fd, int len)
 {
 	struct spi_ioc_transfer	xfer[2];
 	unsigned char		buf[32], *bp;
@@ -68,39 +69,41 @@ static void do_msg(int fd, int len)
 	status = ioctl(fd, SPI_IOC_MESSAGE(2), xfer);
 	if (status < 0) {
 		perror("SPI_IOC_MESSAGE");
-		return;
+		return -1;
 	}
 
 	printf("response(%2d, %2d): ", len, status);
 	for (bp = buf; len; len--)
 		printf(" %02x", *bp++);
 	printf("\n");
+	return 0;
 }
 
-static void dumpstat(const char *name, int fd)
+static int dumpstat(const char *name, int fd)
 {
 	__u8	lsb, bits;
 	__u32	mode, speed;
 
 	if (ioctl(fd, SPI_IOC_RD_MODE32, &mode) < 0) {
 		perror("SPI rd_mode");
-		return;
+		return -1;
 	}
 	if (ioctl(fd, SPI_IOC_RD_LSB_FIRST, &lsb) < 0) {
 		perror("SPI rd_lsb_fist");
-		return;
+		return -1;
 	}
 	if (ioctl(fd, SPI_IOC_RD_BITS_PER_WORD, &bits) < 0) {
 		perror("SPI bits_per_word");
-		return;
+		return -1;
 	}
 	if (ioctl(fd, SPI_IOC_RD_MAX_SPEED_HZ, &speed) < 0) {
 		perror("SPI max_speed_hz");
-		return;
+		return -1;
 	}
 
 	printf("%s: spi mode 0x%x, %d bits %sper word, %u Hz max\n",
 		name, mode, bits, lsb ? "(lsb first) " : "", speed);
+	return 0;
 }
 
 int main(int argc, char **argv)
@@ -108,7 +111,7 @@ int main(int argc, char **argv)
 	int		c;
 	int		readcount = 0;
 	int		msglen = 0;
-	int		fd;
+	int		fd, ret;
 	const char	*name;
 
 	while ((c = getopt(argc, argv, "hm:r:v")) != EOF) {
@@ -146,14 +149,12 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
-	dumpstat(name, fd);
-
-	if (msglen)
-		do_msg(fd, msglen);
-
-	if (readcount)
-		do_read(fd, readcount);
+	ret = dumpstat(name, fd);
+	if (!ret && msglen)
+		ret = do_msg(fd, msglen);
+	if (!ret && readcount)
+		ret = do_read(fd, readcount);
 
 	close(fd);
-	return 0;
+	return ret ? EXIT_FAILURE : EXIT_SUCCESS;
 }


