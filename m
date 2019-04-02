From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v9 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
Date: Tue, 2 Apr 2019 23:10:24 +0300
Message-ID: <6d60bbef-a8ef-849e-33f3-3db35cefc09f@cogentembedded.com>
References: <1553847606-18122-1-git-send-email-masonccyang@mxic.com.tw>
 <1553847606-18122-3-git-send-email-masonccyang@mxic.com.tw>
 <231f7423-bf13-99f8-427b-530f5446348b@cogentembedded.com>
 <OF7F1B534F.B934A9FE-ON482583D0.001DC618-482583D0.001FE84B@mxic.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------4FF6AD4F5AF53631C1A98666"
Cc: bbrezillon@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        marek.vasut@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org,
        zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OF7F1B534F.B934A9FE-ON482583D0.001DC618-482583D0.001FE84B@mxic.com.tw>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This is a multi-part message in MIME format.
--------------4FF6AD4F5AF53631C1A98666
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hello!

On 04/02/2019 08:48 AM, masonccyang@mxic.com.tw wrote:

>> > +static void rpc_spi_mem_set_prep_op_cfg(struct spi_device *spi,
>> > +               const struct spi_mem_op *op,
>> > +               u64 *offs, size_t *len)
>> > +{
>> > +   struct rpc_spi *rpc = spi_controller_get_devdata(spi->controller);
>> > +
>> > +   rpc->cmd = RPC_SMCMR_CMD(op->cmd.opcode);
>> > +   rpc->smenr = RPC_SMENR_CDE |
>> > +           RPC_SMENR_CDB(ilog2(op->cmd.buswidth));
>> > +   rpc->totalxferlen = 1;
>> > +   rpc->xfer_dir = SPI_MEM_NO_DATA;
>> > +   rpc->xferlen = 0;
>> > +   rpc->addr = 0;
>> > +
>> > +   if (op->addr.nbytes) {
>> > +      rpc->smenr |= RPC_SMENR_ADB(ilog2(op->addr.buswidth));
>> > +      if (op->addr.nbytes == 4)
>> > +         rpc->smenr |= RPC_SMENR_ADE(0xf);
>> > +      else
>> > +         rpc->smenr |= RPC_SMENR_ADE(0x7);
>> > +
>> > +      if (offs && len)
>> > +         rpc->addr = *offs;
>> > +      else
>> > +         rpc->addr = op->addr.val;
>> > +      rpc->totalxferlen += op->addr.nbytes;
>> > +   }
>> > +
>> > +   if (op->dummy.nbytes) {
>> > +      rpc->smenr |= RPC_SMENR_DME;
>> > +      rpc->dummy = RPC_SMDMCR_DMCYC(op->dummy.nbytes);
>>
>>    So you haven't fixed this bug? I repeat, the driver doesn't work right
>> w/o this fixed!
> 
> Do you mean
> 
> rpc->dummy = RPC_SMDMCR_DMCYC(op->dummy.nbytes) * 8;   ?

   Yes. Or some other code that amounts to it.

> What is your flash part number?

   Spansion/Cypress S25FS512S. The datasheet says there must be 8 dummy cycles
for the RSFDP command...

> The problem you found is in 1 bit or 4 bits width ?

   1-bit, I think.

>>
>> [...]
>> > +static ssize_t rpc_spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
>> > +                   u64 offs, size_t len, void *buf)
>> > +{
>> > +   struct rpc_spi *rpc =
>> > +         spi_controller_get_devdata(desc->mem->spi->controller);
>> > +   int ret;
>> > +
>> > +   if (offs + desc->info.offset + len > U32_MAX)
>> > +      return -EINVAL;
>> > +
>> > +   if (len > 0x4000000)
>> > +      len = 0x4000000;
>>
>>    Ugh...
> 
> by mtd->size ?

  That'd be better, yes.

>> > +
>> > +   ret = rpc_spi_set_freq(rpc, desc->mem->spi->max_speed_hz);
>> > +   if (ret)
>> > +      return ret;
>> > +
>> > +   rpc_spi_mem_set_prep_op_cfg(desc->mem->spi,
>> > +                &desc->info.op_tmpl, &offs, &len);
>> > +
>> > +   regmap_update_bits(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD, 0);
>> > +   regmap_write(rpc->regmap, RPC_DRCR, RPC_DRCR_RBURST(32) |
>> > +           RPC_DRCR_RBE);
>> > +
>> > +   regmap_write(rpc->regmap, RPC_DRCMR, rpc->cmd);
>> > +   regmap_write(rpc->regmap, RPC_DREAR, RPC_DREAR_EAC(1));
>>
>>    So you're not even trying to support flashes larger than the read dirmap?
>> Now I don't think it's acceptable (and I have rewritten this code internally).
> 
> what about the size comes form mtd->size ?

   I'm not talking about size here; we should use the full address. I'm attaching
my patch...

>> [...]
>> > +static ssize_t rpc_spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
>> > +               u64 offs, size_t len, const void *buf)
>> > +{
>> > +   struct rpc_spi *rpc =
>> > +         spi_controller_get_devdata(desc->mem->spi->controller);
>> > +   int ret;
>> > +
>> > +   if (offs + desc->info.offset + len > U32_MAX)
>> > +      return -EINVAL;
>> > +
>> > +   if (len > RPC_WBUF_SIZE)
>> > +      len = RPC_WBUF_SIZE;
>>
>>    Ugh! Again, I no longer think this is acceptable... Maybe we just need
>> to drop the support of the write buffer...
>>
> 
> why ?
> Using write buffer got the much better write performance.

   OK, let's keep it then.

[...]

MBR, Sergei

--------------4FF6AD4F5AF53631C1A98666
Content-Type: text/x-patch;
 name="spi-renesas-rpc-allow-reading-from-large-flashes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="spi-renesas-rpc-allow-reading-from-large-flashes.patch"

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: spi: renesas-rpc: allow reading from large flashes

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/spi/spi-renesas-rpc.c   |   26 ++++++++++++++++++++------
 include/linux/mfd/renesas-rpc.h |    2 ++
 2 files changed, 22 insertions(+), 6 deletions(-)

Index: renesas/drivers/spi/spi-renesas-rpc.c
===================================================================
--- renesas.orig/drivers/spi/spi-renesas-rpc.c
+++ renesas/drivers/spi/spi-renesas-rpc.c
@@ -264,14 +264,12 @@ static ssize_t rpc_spi_mem_dirmap_read(s
 {
 	struct rpc_spi *rpc =
 			spi_controller_get_devdata(desc->mem->spi->controller);
+	size_t _len = len;
 	int ret;
 
 	if (offs + desc->info.offset + len > U32_MAX)
 		return -EINVAL;
 
-	if (len > 0x4000000)
-		len = 0x4000000;
-
 	ret = rpc_spi_set_freq(rpc, desc->mem->spi->max_speed_hz);
 	if (ret)
 		return ret;
@@ -284,15 +282,31 @@ static ssize_t rpc_spi_mem_dirmap_read(s
 		     RPC_DRCR_RBE);
 
 	regmap_write(rpc->regmap, RPC_DRCMR, rpc->cmd);
-	regmap_write(rpc->regmap, RPC_DREAR, RPC_DREAR_EAC(1));
 	regmap_write(rpc->regmap, RPC_DROPR, 0);
 	regmap_write(rpc->regmap, RPC_DRENR, rpc->smenr);
 	regmap_write(rpc->regmap, RPC_DRDMCR, rpc->dummy);
 	regmap_write(rpc->regmap, RPC_DRDRENR, 0);
 
-	memcpy_fromio(buf, rpc->dirmap + desc->info.offset + offs, len);
+	while (len) {
+		loff_t from = offs & (RPC_DIRMAP_SIZE - 1);
+		size_t size = RPC_DIRMAP_SIZE - from;
+		u32 val = RPC_DREAR_EAC(1);
+
+		if (rpc->smenr & RPC_DRENR_ADE(8))
+			val |= RPC_DREAR_EAV(offs >> 25);
+		regmap_write(rpc->regmap, RPC_DREAR, val);
+
+		if (size > len)
+			size = len;
+
+		memcpy_fromio(buf, rpc->dirmap + desc->info.offset + from,
+			      size);
+		buf  += size;
+		offs += size;
+		len  -= size;
+	}
 
-	return len;
+	return _len;
 }
 
 static ssize_t rpc_spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
Index: renesas/include/linux/mfd/renesas-rpc.h
===================================================================
--- renesas.orig/include/linux/mfd/renesas-rpc.h
+++ renesas/include/linux/mfd/renesas-rpc.h
@@ -57,6 +57,7 @@
 #define RPC_DRCMR_OCMD(c)	(((c) & 0xFF) << 0)
 
 #define RPC_DREAR		0x0014	// R/W
+#define RPC_DREAR_EAV(v)	(((v) & 0xff) << 16)
 #define RPC_DREAR_EAC(c)	(((c) & 0x7) << 0)
 
 #define RPC_DROPR		0x0018	// R/W
@@ -140,6 +141,7 @@
 #define RPC_PHYOFFSET2		0x0084	// R/W
 #define RPC_PHYOFFSET2_OCTTMG(v) (((v) & 0x7) << 8)
 
+#define RPC_DIRMAP_SIZE		0x4000000
 #define RPC_WBUF_SIZE		256	// Write Buffer size
 
 struct rpc_mfd {

--------------4FF6AD4F5AF53631C1A98666--
