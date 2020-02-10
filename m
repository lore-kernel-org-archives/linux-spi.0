From: "Behme Dirk (CM/ESO2)" <dirk.behme@de.bosch.com>
Subject: Re: [PATCH RFC 2/2] memory: add Renesas RPC-IF driver
Date: Mon, 10 Feb 2020 11:21:26 +0100
Message-ID: <5760bcdb-e44b-6f18-7262-9526684e5780@de.bosch.com>
References: <cb7022c9-0059-4eb2-7910-aab42124fa1c@cogentembedded.com>
 <4db876ed-1ccc-e3be-311d-30cd52f40259@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Yang <masonccyang@mxic.com.tw>,
        <linux-spi@vger.kernel.org>,
        Chris Brandt <chris.brandt@renesas.com>,
        <linux-renesas-soc@vger.kernel.org>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <4db876ed-1ccc-e3be-311d-30cd52f40259@cogentembedded.com>
Content-Language: en-US
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Sergei,

On 10.12.2019 20:39, Sergei Shtylyov wrote:
> Add the memory driver for Renesas RPC-IF which registers either SPI or
> HyperFLash device depending on the contents of the device tree subnode.
> It also provides the absract "back end" device APIs that can be used by
> the "front end" SPI/MTD drivers to talk to the real hardware.
> 
> Based on the original patch by Mason Yang <masonccyang@mxic.com.tw>.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>


FYI, please find below [1] the changes I did locally on this driver. It 
seems to read & write successfully on my custom M3 (R8A7796) device, now.

Best regards

Dirk

[1]

 From d72b805cc461ab1e9747c973e9be84e7abb8f828 Mon Sep 17 00:00:00 2001
From: Dirk Behme <dirk.behme@de.bosch.com>
Date: Tue, 4 Feb 2020 08:39:31 +0100
Subject: [PATCH] memory: renesas-rpc-if: Correct the STRTIM and some other
  clean up

This is required to make the driver work correctly in my M3 environment.

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
  drivers/memory/renesas-rpc-if.c | 42 ++++++++++++++++++++-------------
  1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c 
b/drivers/memory/renesas-rpc-if.c
index 04be92b64bfa..f4356b066384 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -129,10 +129,11 @@

  #define RPCIF_PHYCNT		0x007C	/* R/W */
  #define RPCIF_PHYCNT_CAL	BIT(31)
-#define RPCIF_PHYCNT_OCTA_AA	BIT(22)
-#define RPCIF_PHYCNT_OCTA_SA	BIT(23)
+#define RPCIF_PHYCNT_OCTA(v)	(((v) & 0x3) << 22)
  #define RPCIF_PHYCNT_EXDS	BIT(21)
  #define RPCIF_PHYCNT_OCT	BIT(20)
+#define RPCIF_PHYCNT_DDRCAL	BIT(19)
+#define RPCIF_PHYCNT_HS		BIT(18)
  #define RPCIF_PHYCNT_STRTIM(v)	(((v) & 0x7) << 15)
  #define RPCIF_PHYCNT_WBUF2	BIT(4)
  #define RPCIF_PHYCNT_WBUF	BIT(2)
@@ -219,6 +220,8 @@ EXPORT_SYMBOL(rpcif_disable_rpm);

  void rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
  {
+	u32 dummy;
+
  	pm_runtime_get_sync(rpc->dev);

  	/*
@@ -227,9 +230,9 @@ void rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
  	 *	 0x0 : the delay is biggest,
  	 *	 0x1 : the delay is 2nd biggest,
  	 *	 On H3 ES1.x, the value should be 0, while on others,
-	 *	 the value should be 6.
+	 *	 the value should be 7.
  	 */
-	regmap_write(rpc->regmap, RPCIF_PHYCNT, /* RPCIF_PHYCNT_STRTIM(6) | */
+	regmap_write(rpc->regmap, RPCIF_PHYCNT, RPCIF_PHYCNT_STRTIM(7) |
  		     RPCIF_PHYCNT_PHYMEM(hyperflash ? 3 : 0) | 0x260);

  	/*
@@ -250,6 +253,10 @@ void rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
  	regmap_write(rpc->regmap, RPCIF_CMNCR, RPCIF_CMNCR_SFDE |
  		     RPCIF_CMNCR_MOIIO_HIZ | RPCIF_CMNCR_IOFV_HIZ |
  		     RPCIF_CMNCR_BSZ(hyperflash ? 1 : 0));
+	/* Set RCF after BSZ update */
+	regmap_write(rpc->regmap, RPCIF_DRCR, RPCIF_DRCR_RCF);
+	/* Dummy read according to spec */
+	regmap_read(rpc->regmap, RPCIF_DRCR, &dummy);
  	regmap_write(rpc->regmap, RPCIF_SSLDR, RPCIF_SSLDR_SPNDL(7) |
  		     RPCIF_SSLDR_SLNDL(7) | RPCIF_SSLDR_SCKDL(7));

@@ -291,11 +298,11 @@ void rpcif_prepare(struct rpcif *rpc, const struct 
rpcif_op *op, u64 *offs,
  	rpc->xferlen = 0;

  	if (op->cmd.buswidth) {
-		rpc->enable  |= RPCIF_SMENR_CDE |
+		rpc->enable  = RPCIF_SMENR_CDE |
  			RPCIF_SMENR_CDB(rpcif_bit_size(op->cmd.buswidth));
-		rpc->command |= RPCIF_SMCMR_CMD(op->cmd.opcode);
+		rpc->command = RPCIF_SMCMR_CMD(op->cmd.opcode);
  		if (op->cmd.ddr)
-			rpc->ddr |= RPCIF_SMDRENR_HYPE(0x5);
+			rpc->ddr = RPCIF_SMDRENR_HYPE(0x5);
  	}
  	if (op->ocmd.buswidth) {
  		rpc->enable  |= RPCIF_SMENR_OCDE |
@@ -432,6 +439,8 @@ int rpcif_io_xfer(struct rpcif *rpc)
  		 * mode instead.
  		 */
  		if (!(smenr & RPCIF_SMENR_ADE(0xf)) && rpc->dirmap) {
+			u32 dummy;
+
  			regmap_update_bits(rpc->regmap, RPCIF_CMNCR,
  					   RPCIF_CMNCR_MD, 0);
  			regmap_write(rpc->regmap, RPCIF_DRCR,
@@ -446,6 +455,8 @@ int rpcif_io_xfer(struct rpcif *rpc)
  			regmap_write(rpc->regmap, RPCIF_DRDRENR, rpc->ddr);
  			memcpy_fromio(rpc->buffer, rpc->dirmap, rpc->xferlen);
  			regmap_write(rpc->regmap, RPCIF_DRCR, RPCIF_DRCR_RCF);
+			/* Dummy read according to spec */
+			regmap_read(rpc->regmap, RPCIF_DRCR, &dummy);
  			break;
  		}
  		while (pos < rpc->xferlen) {
@@ -506,6 +517,7 @@ ssize_t rpcif_dirmap_read(struct rpcif *rpc, u64 
offs, size_t len, void *buf)
  {
  	loff_t from = offs & (RPCIF_DIRMAP_SIZE - 1);
  	size_t size = RPCIF_DIRMAP_SIZE - from;
+	u32 ret;

  	if (len > size)
  		len = size;
@@ -513,19 +525,15 @@ ssize_t rpcif_dirmap_read(struct rpcif *rpc, u64 
offs, size_t len, void *buf)
  	pm_runtime_get_sync(rpc->dev);

  	regmap_update_bits(rpc->regmap, RPCIF_CMNCR, RPCIF_CMNCR_MD, 0);
-	regmap_write(rpc->regmap, RPCIF_DRCR,
-		     RPCIF_DRCR_RBURST(32) | RPCIF_DRCR_RBE);
-	regmap_write(rpc->regmap, RPCIF_DRCMR, rpc->command);
-	regmap_write(rpc->regmap, RPCIF_DREAR,
-		     RPCIF_DREAR_EAV(offs >> 25) | RPCIF_DREAR_EAC(1));
-	regmap_write(rpc->regmap, RPCIF_DROPR, rpc->option);
-	regmap_write(rpc->regmap, RPCIF_DRENR,
-		     rpc->enable & ~RPCIF_SMENR_SPIDE(0xF));
-	regmap_write(rpc->regmap, RPCIF_DRDMCR, rpc->dummy);
-	regmap_write(rpc->regmap, RPCIF_DRDRENR, rpc->ddr);
+	ret = wait_msg_xfer_end(rpc);
+	if (ret) {
+		len = 0;
+		goto err_out;
+	}

  	memcpy_fromio(buf, rpc->dirmap + from, len);

+err_out:
  	pm_runtime_put(rpc->dev);

  	return len;
-- 
2.20.0
