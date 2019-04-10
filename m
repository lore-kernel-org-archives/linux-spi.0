From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v9 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
Date: Wed, 10 Apr 2019 22:47:39 +0300
Message-ID: <9cf8bd62-10d2-fb8d-a001-261cf9166c59@cogentembedded.com>
References: <1553847606-18122-1-git-send-email-masonccyang@mxic.com.tw>
 <1553847606-18122-3-git-send-email-masonccyang@mxic.com.tw>
 <231f7423-bf13-99f8-427b-530f5446348b@cogentembedded.com>
 <OF7F1B534F.B934A9FE-ON482583D0.001DC618-482583D0.001FE84B@mxic.com.tw>
 <6d60bbef-a8ef-849e-33f3-3db35cefc09f@cogentembedded.com>
 <OFAEA16021.C7F7B095-ON482583D1.0031A13D-482583D1.00335085@mxic.com.tw>
 <869a1c6d-cfa6-35e9-592b-4e0937530e31@cogentembedded.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------854A01743A26F124AB02C562"
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
In-Reply-To: <869a1c6d-cfa6-35e9-592b-4e0937530e31@cogentembedded.com>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This is a multi-part message in MIME format.
--------------854A01743A26F124AB02C562
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 04/09/2019 02:20 PM, Sergei Shtylyov wrote:

> [...]
>>>>>> +   ret = rpc_spi_set_freq(rpc, desc->mem->spi->max_speed_hz);
>>>>>> +   if (ret)
>>>>>> +      return ret;
>>>>>> +
>>>>>> +   rpc_spi_mem_set_prep_op_cfg(desc->mem->spi,
>>>>>> +                &desc->info.op_tmpl, &offs, &len);
>>>>>> +
>>>>>> +   regmap_update_bits(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD, 0);
>>>>>> +   regmap_write(rpc->regmap, RPC_DRCR, RPC_DRCR_RBURST(32) |
>>>>>> +           RPC_DRCR_RBE);
>>>>>> +
>>>>>> +   regmap_write(rpc->regmap, RPC_DRCMR, rpc->cmd);
>>>>>> +   regmap_write(rpc->regmap, RPC_DREAR, RPC_DREAR_EAC(1));
>>>>>
>>>>>    So you're not even trying to support flashes larger than the
>>> read dirmap?
>>>>> Now I don't think it's acceptable (and I have rewritten this code
>>> internally).
>>>>
>>>> what about the size comes form mtd->size ?
>>>
>>>    I'm not talking about size here; we should use the full address.
>>> I'm attaching
>>> my patch...
>>
>> okay,got it!
>> what about just
>> -      regmap_write(rpc->mfd->regmap, RPC_DREAR, RPC_DREAR_EAC(1));
>> +      regmap_write(rpc->mfd->regmap, RPC_DREAR,
>> +                   RPC_DREAR_EAV(offs >> 25) | RPC_DREAR_EAC(1));
>>
>> because only > 64MByte size make RPC_DREAR_EAV() work.
> 
>    Seems OK now, after Boris' reply.

   Well, actually not. The 'len' check in the beginning is oversimplified.
Attached is the patch fixing up the dirmap read path (and making it handle
flashes > 64 MiB as well)...

>> thanks & best regards,
>> Mason
> 
> [...]

MBR, Sergei

--------------854A01743A26F124AB02C562
Content-Type: text/x-patch;
 name="spi-renesas-rpc-fix-dirmap-read.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="spi-renesas-rpc-fix-dirmap-read.patch"

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: spi: renesas-rpc: fix dirmap read

allow reading from large flashes.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/spi/spi-renesas-rpc.c   |   11 +++++++----
 include/linux/mfd/renesas-rpc.h |    2 ++
 2 files changed, 9 insertions(+), 4 deletions(-)

Index: renesas/drivers/spi/spi-renesas-rpc.c
===================================================================
--- renesas.orig/drivers/spi/spi-renesas-rpc.c
+++ renesas/drivers/spi/spi-renesas-rpc.c
@@ -264,13 +264,15 @@ static ssize_t rpc_spi_mem_dirmap_read(s
 {
 	struct rpc_spi *rpc =
 			spi_controller_get_devdata(desc->mem->spi->controller);
+	loff_t from = offs & (RPC_DIRMAP_SIZE - 1);
+	size_t size = RPC_DIRMAP_SIZE - from;
 	int ret;
 
 	if (offs + desc->info.offset + len > U32_MAX)
 		return -EINVAL;
 
-	if (len > 0x4000000)
-		len = 0x4000000;
+	if (len > size)
+		len = size;
 
 	ret = rpc_spi_set_freq(rpc, desc->mem->spi->max_speed_hz);
 	if (ret)
@@ -284,13 +286,14 @@ static ssize_t rpc_spi_mem_dirmap_read(s
 		     RPC_DRCR_RBE);
 
 	regmap_write(rpc->regmap, RPC_DRCMR, rpc->cmd);
-	regmap_write(rpc->regmap, RPC_DREAR, RPC_DREAR_EAC(1));
+	regmap_write(rpc->regmap, RPC_DREAR,
+		     RPC_DREAR_EAV(offs >> 25) | RPC_DREAR_EAC(1));
 	regmap_write(rpc->regmap, RPC_DROPR, 0);
 	regmap_write(rpc->regmap, RPC_DRENR, rpc->smenr);
 	regmap_write(rpc->regmap, RPC_DRDMCR, rpc->dummy);
 	regmap_write(rpc->regmap, RPC_DRDRENR, 0);
 
-	memcpy_fromio(buf, rpc->dirmap + desc->info.offset + offs, len);
+	memcpy_fromio(buf, rpc->dirmap + desc->info.offset + from, len);
 
 	return len;
 }
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
 
 struct rpc {

--------------854A01743A26F124AB02C562--
