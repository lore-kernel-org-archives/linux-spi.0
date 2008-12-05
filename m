From: "Eric Miao" <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Fwd: [PATCH] spi: pxa2xx_spi introduces
	chipselect GPIO to simplify the common cases
Date: Fri, 5 Dec 2008 10:28:48 +0800
Message-ID: <f17812d70812041828x6ff01993tbaa2d664c24681e6@mail.gmail.com>
References: <f17812d70811242317u706ff2bdq4410fd331975c463@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_18256_13580615.1228444128986"
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <f17812d70811242317u706ff2bdq4410fd331975c463-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

------=_Part_18256_13580615.1228444128986
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

David,

I have to ping you again on this patch due to the coming merge window.


---------- Forwarded message ----------
From: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Tue, Nov 25, 2008 at 3:17 PM
Subject: [PATCH] spi: pxa2xx_spi introduces chipselect GPIO to
simplify the common cases
To: LAK <linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>


Most SPI peripherals use GPIOs as their chip selects, introduce .gpio_cs
for this.

Signed-off-by: Eric Miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
---

Now rebased and posted again.

 arch/arm/mach-pxa/include/mach/pxa2xx_spi.h |    1 +
 drivers/spi/pxa2xx_spi.c                    |   96 ++++++++++++++++++++++-----
 2 files changed, 79 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/pxa2xx_spi.h
b/arch/arm/mach-pxa/include/mach/pxa2xx_spi.h
index 2206cb6..b87cecd 100644
--- a/arch/arm/mach-pxa/include/mach/pxa2xx_spi.h
+++ b/arch/arm/mach-pxa/include/mach/pxa2xx_spi.h
@@ -38,6 +38,7 @@ struct pxa2xx_spi_chip {
       u8 dma_burst_size;
       u32 timeout;
       u8 enable_loopback;
+       int gpio_cs;
       void (*cs_control)(u32 command);
 };

diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
index cf12f2d..f3587b4 100644
--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -28,6 +28,7 @@
 #include <linux/workqueue.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
+#include <linux/gpio.h>

 #include <asm/io.h>
 #include <asm/irq.h>
@@ -168,6 +169,8 @@ struct chip_data {
       u8 enable_dma;
       u8 bits_per_word;
       u32 speed_hz;
+       int gpio_cs;
+       int gpio_cs_inverted;
       int (*write)(struct driver_data *drv_data);
       int (*read)(struct driver_data *drv_data);
       void (*cs_control)(u32 command);
@@ -175,6 +178,32 @@ struct chip_data {

 static void pump_messages(struct work_struct *work);

+static void cs_assert(struct driver_data *drv_data)
+{
+       struct chip_data *chip = drv_data->cur_chip;
+
+       if (chip->cs_control) {
+               chip->cs_control(PXA2XX_CS_ASSERT);
+               return;
+       }
+
+       if (gpio_is_valid(chip->gpio_cs))
+               gpio_set_value(chip->gpio_cs, chip->gpio_cs_inverted);
+}
+
+static void cs_deassert(struct driver_data *drv_data)
+{
+       struct chip_data *chip = drv_data->cur_chip;
+
+       if (chip->cs_control) {
+               chip->cs_control(PXA2XX_CS_ASSERT);
+               return;
+       }
+
+       if (gpio_is_valid(chip->gpio_cs))
+               gpio_set_value(chip->gpio_cs, !chip->gpio_cs_inverted);
+}
+
 static int flush(struct driver_data *drv_data)
 {
       unsigned long limit = loops_per_jiffy << 1;
@@ -191,10 +220,6 @@ static int flush(struct driver_data *drv_data)
       return limit;
 }

-static void null_cs_control(u32 command)
-{
-}
-
 static int null_writer(struct driver_data *drv_data)
 {
       void __iomem *reg = drv_data->ioaddr;
@@ -402,7 +427,6 @@ static void giveback(struct driver_data *drv_data)
       msg = drv_data->cur_msg;
       drv_data->cur_msg = NULL;
       drv_data->cur_transfer = NULL;
-       drv_data->cur_chip = NULL;
       queue_work(drv_data->workqueue, &drv_data->pump_messages);
       spin_unlock_irqrestore(&drv_data->lock, flags);

@@ -418,7 +442,7 @@ static void giveback(struct driver_data *drv_data)
        * a message with an error, or next message is for another chip
        */
       if (!last_transfer->cs_change)
-               drv_data->cs_control(PXA2XX_CS_DEASSERT);
+               cs_deassert(drv_data);
       else {
               struct spi_message *next_msg;

@@ -447,12 +471,14 @@ static void giveback(struct driver_data *drv_data)
               if (next_msg && next_msg->spi != msg->spi)
                       next_msg = NULL;
               if (!next_msg || msg->state == ERROR_STATE)
-                       drv_data->cs_control(PXA2XX_CS_DEASSERT);
+                       cs_deassert(drv_data);
       }

       msg->state = NULL;
       if (msg->complete)
               msg->complete(msg->context);
+
+       drv_data->cur_chip = NULL;
 }

 static int wait_ssp_rx_stall(void const __iomem *ioaddr)
@@ -889,7 +915,7 @@ static void pump_transfers(unsigned long data)

               /* Drop chip select only if cs_change is requested */
               if (previous->cs_change)
-                       drv_data->cs_control(PXA2XX_CS_DEASSERT);
+                       cs_deassert(drv_data);
       }

       /* Check for transfers that need multiple DMA segments */
@@ -924,7 +950,6 @@ static void pump_transfers(unsigned long data)
       }
       drv_data->n_bytes = chip->n_bytes;
       drv_data->dma_width = chip->dma_width;
-       drv_data->cs_control = chip->cs_control;
       drv_data->tx = (void *)transfer->tx_buf;
       drv_data->tx_end = drv_data->tx + transfer->len;
       drv_data->rx = transfer->rx_buf;
@@ -1086,11 +1111,7 @@ static void pump_transfers(unsigned long data)
                       write_SSTO(chip->timeout, reg);
       }

-       /* FIXME, need to handle cs polarity,
-        * this driver uses struct pxa2xx_spi_chip.cs_control to
-        * specify a CS handling function, and it ignores most
-        * struct spi_device.mode[s], including SPI_CS_HIGH */
-       drv_data->cs_control(PXA2XX_CS_ASSERT);
+       cs_assert(drv_data);

       /* after chip select, release the data by enabling service
        * requests and interrupts, without changing any mode bits */
@@ -1168,6 +1189,44 @@ static int transfer(struct spi_device *spi,
struct spi_message *msg)
 /* the spi->mode bits understood by this driver: */
 #define MODEBITS (SPI_CPOL | SPI_CPHA)

+static int setup_cs(struct spi_device *spi, struct chip_data *chip,
+                   struct pxa2xx_spi_chip *chip_info)
+{
+       int err = 0;
+
+       if (chip == NULL || chip_info == NULL)
+               return 0;
+
+       /* NOTE: setup() can be called multiple times, possibly with
+        * different chip_info, release previously requested GPIO
+        */
+       if (gpio_is_valid(chip->gpio_cs))
+               gpio_free(chip->gpio_cs);
+
+       /* If (*cs_control) is provided, ignore GPIO chip select */
+       if (chip_info->cs_control) {
+               chip->cs_control = chip_info->cs_control;
+               return 0;
+       }
+
+       if (gpio_is_valid(chip_info->gpio_cs)) {
+               err = gpio_request(chip_info->gpio_cs, "SPI_CS");
+               if (err) {
+                       dev_err(&spi->dev, "failed to request chip select "
+                                       "GPIO%d\n", chip_info->gpio_cs);
+                       return err;
+               }
+
+               chip->gpio_cs = chip_info->gpio_cs;
+               chip->gpio_cs_inverted = spi->mode & SPI_CS_HIGH;
+
+               err = gpio_direction_output(chip->gpio_cs,
+                                       !chip->gpio_cs_inverted);
+       }
+
+       return err;
+}
+
 static int setup(struct spi_device *spi)
 {
       struct pxa2xx_spi_chip *chip_info = NULL;
@@ -1213,7 +1272,7 @@ static int setup(struct spi_device *spi)
                       return -ENOMEM;
               }

-               chip->cs_control = null_cs_control;
+               chip->gpio_cs = -1;
               chip->enable_dma = 0;
               chip->timeout = TIMOUT_DFLT;
               chip->dma_burst_size = drv_data->master_info->enable_dma ?
@@ -1227,8 +1286,6 @@ static int setup(struct spi_device *spi)
       /* chip_info isn't always needed */
       chip->cr1 = 0;
       if (chip_info) {
-               if (chip_info->cs_control)
-                       chip->cs_control = chip_info->cs_control;
               if (chip_info->timeout)
                       chip->timeout = chip_info->timeout;
               if (chip_info->tx_threshold)
@@ -1310,13 +1367,16 @@ static int setup(struct spi_device *spi)

       spi_set_ctldata(spi, chip);

-       return 0;
+       return setup_cs(spi, chip, chip_info);
 }

 static void cleanup(struct spi_device *spi)
 {
       struct chip_data *chip = spi_get_ctldata(spi);

+       if (gpio_is_valid(chip->gpio_cs))
+               gpio_free(chip->gpio_cs);
+
       kfree(chip);
 }

--
1.6.0.2



-- 
Cheers
- eric

------=_Part_18256_13580615.1228444128986
Content-Type: text/x-diff;
	name=0001-spi-pxa2xx_spi-introduces-chipselect-GPIO-to-simpli.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_foc7w9zm0
Content-Disposition: attachment;
	filename=0001-spi-pxa2xx_spi-introduces-chipselect-GPIO-to-simpli.patch

RnJvbSAxNjVkZmE5YmZkYjljMTY3YmU1MjZkNTFiMmRmMmNmZWIxYTVhNTZhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFcmljIE1pYW8gPGVyaWMubWlhb0BtYXJ2ZWxsLmNvbT4KRGF0
ZTogVHVlLCAyNSBOb3YgMjAwOCAxNTowNjozNSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIHNwaTog
cHhhMnh4X3NwaSBpbnRyb2R1Y2VzIGNoaXBzZWxlY3QgR1BJTyB0byBzaW1wbGlmeSB0aGUgY29t
bW9uIGNhc2VzCgpNb3N0IFNQSSBwZXJpcGhlcmFscyB1c2UgR1BJT3MgYXMgdGhlaXIgY2hpcCBz
ZWxlY3RzLCBpbnRyb2R1Y2UgLmdwaW9fY3MKZm9yIHRoaXMuCgpTaWduZWQtb2ZmLWJ5OiBFcmlj
IE1pYW8gPGVyaWMubWlhb0BtYXJ2ZWxsLmNvbT4KLS0tCiBhcmNoL2FybS9tYWNoLXB4YS9pbmNs
dWRlL21hY2gvcHhhMnh4X3NwaS5oIHwgICAgMSArCiBkcml2ZXJzL3NwaS9weGEyeHhfc3BpLmMg
ICAgICAgICAgICAgICAgICAgIHwgICA5NiArKysrKysrKysrKysrKysrKysrKysrLS0tLS0KIDIg
ZmlsZXMgY2hhbmdlZCwgNzkgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvYXJjaC9hcm0vbWFjaC1weGEvaW5jbHVkZS9tYWNoL3B4YTJ4eF9zcGkuaCBiL2FyY2gv
YXJtL21hY2gtcHhhL2luY2x1ZGUvbWFjaC9weGEyeHhfc3BpLmgKaW5kZXggMjIwNmNiNi4uYjg3
Y2VjZCAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1weGEvaW5jbHVkZS9tYWNoL3B4YTJ4eF9z
cGkuaAorKysgYi9hcmNoL2FybS9tYWNoLXB4YS9pbmNsdWRlL21hY2gvcHhhMnh4X3NwaS5oCkBA
IC0zOCw2ICszOCw3IEBAIHN0cnVjdCBweGEyeHhfc3BpX2NoaXAgewogCXU4IGRtYV9idXJzdF9z
aXplOwogCXUzMiB0aW1lb3V0OwogCXU4IGVuYWJsZV9sb29wYmFjazsKKwlpbnQgZ3Bpb19jczsK
IAl2b2lkICgqY3NfY29udHJvbCkodTMyIGNvbW1hbmQpOwogfTsKIApkaWZmIC0tZ2l0IGEvZHJp
dmVycy9zcGkvcHhhMnh4X3NwaS5jIGIvZHJpdmVycy9zcGkvcHhhMnh4X3NwaS5jCmluZGV4IGNm
MTJmMmQuLmYzNTg3YjQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvc3BpL3B4YTJ4eF9zcGkuYworKysg
Yi9kcml2ZXJzL3NwaS9weGEyeHhfc3BpLmMKQEAgLTI4LDYgKzI4LDcgQEAKICNpbmNsdWRlIDxs
aW51eC93b3JrcXVldWUuaD4KICNpbmNsdWRlIDxsaW51eC9kZWxheS5oPgogI2luY2x1ZGUgPGxp
bnV4L2Nsay5oPgorI2luY2x1ZGUgPGxpbnV4L2dwaW8uaD4KIAogI2luY2x1ZGUgPGFzbS9pby5o
PgogI2luY2x1ZGUgPGFzbS9pcnEuaD4KQEAgLTE2OCw2ICsxNjksOCBAQCBzdHJ1Y3QgY2hpcF9k
YXRhIHsKIAl1OCBlbmFibGVfZG1hOwogCXU4IGJpdHNfcGVyX3dvcmQ7CiAJdTMyIHNwZWVkX2h6
OworCWludCBncGlvX2NzOworCWludCBncGlvX2NzX2ludmVydGVkOwogCWludCAoKndyaXRlKShz
dHJ1Y3QgZHJpdmVyX2RhdGEgKmRydl9kYXRhKTsKIAlpbnQgKCpyZWFkKShzdHJ1Y3QgZHJpdmVy
X2RhdGEgKmRydl9kYXRhKTsKIAl2b2lkICgqY3NfY29udHJvbCkodTMyIGNvbW1hbmQpOwpAQCAt
MTc1LDYgKzE3OCwzMiBAQCBzdHJ1Y3QgY2hpcF9kYXRhIHsKIAogc3RhdGljIHZvaWQgcHVtcF9t
ZXNzYWdlcyhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspOwogCitzdGF0aWMgdm9pZCBjc19hc3Nl
cnQoc3RydWN0IGRyaXZlcl9kYXRhICpkcnZfZGF0YSkKK3sKKwlzdHJ1Y3QgY2hpcF9kYXRhICpj
aGlwID0gZHJ2X2RhdGEtPmN1cl9jaGlwOworCisJaWYgKGNoaXAtPmNzX2NvbnRyb2wpIHsKKwkJ
Y2hpcC0+Y3NfY29udHJvbChQWEEyWFhfQ1NfQVNTRVJUKTsKKwkJcmV0dXJuOworCX0KKworCWlm
IChncGlvX2lzX3ZhbGlkKGNoaXAtPmdwaW9fY3MpKQorCQlncGlvX3NldF92YWx1ZShjaGlwLT5n
cGlvX2NzLCBjaGlwLT5ncGlvX2NzX2ludmVydGVkKTsKK30KKworc3RhdGljIHZvaWQgY3NfZGVh
c3NlcnQoc3RydWN0IGRyaXZlcl9kYXRhICpkcnZfZGF0YSkKK3sKKwlzdHJ1Y3QgY2hpcF9kYXRh
ICpjaGlwID0gZHJ2X2RhdGEtPmN1cl9jaGlwOworCisJaWYgKGNoaXAtPmNzX2NvbnRyb2wpIHsK
KwkJY2hpcC0+Y3NfY29udHJvbChQWEEyWFhfQ1NfQVNTRVJUKTsKKwkJcmV0dXJuOworCX0KKwor
CWlmIChncGlvX2lzX3ZhbGlkKGNoaXAtPmdwaW9fY3MpKQorCQlncGlvX3NldF92YWx1ZShjaGlw
LT5ncGlvX2NzLCAhY2hpcC0+Z3Bpb19jc19pbnZlcnRlZCk7Cit9CisKIHN0YXRpYyBpbnQgZmx1
c2goc3RydWN0IGRyaXZlcl9kYXRhICpkcnZfZGF0YSkKIHsKIAl1bnNpZ25lZCBsb25nIGxpbWl0
ID0gbG9vcHNfcGVyX2ppZmZ5IDw8IDE7CkBAIC0xOTEsMTAgKzIyMCw2IEBAIHN0YXRpYyBpbnQg
Zmx1c2goc3RydWN0IGRyaXZlcl9kYXRhICpkcnZfZGF0YSkKIAlyZXR1cm4gbGltaXQ7CiB9CiAK
LXN0YXRpYyB2b2lkIG51bGxfY3NfY29udHJvbCh1MzIgY29tbWFuZCkKLXsKLX0KLQogc3RhdGlj
IGludCBudWxsX3dyaXRlcihzdHJ1Y3QgZHJpdmVyX2RhdGEgKmRydl9kYXRhKQogewogCXZvaWQg
X19pb21lbSAqcmVnID0gZHJ2X2RhdGEtPmlvYWRkcjsKQEAgLTQwMiw3ICs0MjcsNiBAQCBzdGF0
aWMgdm9pZCBnaXZlYmFjayhzdHJ1Y3QgZHJpdmVyX2RhdGEgKmRydl9kYXRhKQogCW1zZyA9IGRy
dl9kYXRhLT5jdXJfbXNnOwogCWRydl9kYXRhLT5jdXJfbXNnID0gTlVMTDsKIAlkcnZfZGF0YS0+
Y3VyX3RyYW5zZmVyID0gTlVMTDsKLQlkcnZfZGF0YS0+Y3VyX2NoaXAgPSBOVUxMOwogCXF1ZXVl
X3dvcmsoZHJ2X2RhdGEtPndvcmtxdWV1ZSwgJmRydl9kYXRhLT5wdW1wX21lc3NhZ2VzKTsKIAlz
cGluX3VubG9ja19pcnFyZXN0b3JlKCZkcnZfZGF0YS0+bG9jaywgZmxhZ3MpOwogCkBAIC00MTgs
NyArNDQyLDcgQEAgc3RhdGljIHZvaWQgZ2l2ZWJhY2soc3RydWN0IGRyaXZlcl9kYXRhICpkcnZf
ZGF0YSkKIAkgKiBhIG1lc3NhZ2Ugd2l0aCBhbiBlcnJvciwgb3IgbmV4dCBtZXNzYWdlIGlzIGZv
ciBhbm90aGVyIGNoaXAKIAkgKi8KIAlpZiAoIWxhc3RfdHJhbnNmZXItPmNzX2NoYW5nZSkKLQkJ
ZHJ2X2RhdGEtPmNzX2NvbnRyb2woUFhBMlhYX0NTX0RFQVNTRVJUKTsKKwkJY3NfZGVhc3NlcnQo
ZHJ2X2RhdGEpOwogCWVsc2UgewogCQlzdHJ1Y3Qgc3BpX21lc3NhZ2UgKm5leHRfbXNnOwogCkBA
IC00NDcsMTIgKzQ3MSwxNCBAQCBzdGF0aWMgdm9pZCBnaXZlYmFjayhzdHJ1Y3QgZHJpdmVyX2Rh
dGEgKmRydl9kYXRhKQogCQlpZiAobmV4dF9tc2cgJiYgbmV4dF9tc2ctPnNwaSAhPSBtc2ctPnNw
aSkKIAkJCW5leHRfbXNnID0gTlVMTDsKIAkJaWYgKCFuZXh0X21zZyB8fCBtc2ctPnN0YXRlID09
IEVSUk9SX1NUQVRFKQotCQkJZHJ2X2RhdGEtPmNzX2NvbnRyb2woUFhBMlhYX0NTX0RFQVNTRVJU
KTsKKwkJCWNzX2RlYXNzZXJ0KGRydl9kYXRhKTsKIAl9CiAKIAltc2ctPnN0YXRlID0gTlVMTDsK
IAlpZiAobXNnLT5jb21wbGV0ZSkKIAkJbXNnLT5jb21wbGV0ZShtc2ctPmNvbnRleHQpOworCisJ
ZHJ2X2RhdGEtPmN1cl9jaGlwID0gTlVMTDsKIH0KIAogc3RhdGljIGludCB3YWl0X3NzcF9yeF9z
dGFsbCh2b2lkIGNvbnN0IF9faW9tZW0gKmlvYWRkcikKQEAgLTg4OSw3ICs5MTUsNyBAQCBzdGF0
aWMgdm9pZCBwdW1wX3RyYW5zZmVycyh1bnNpZ25lZCBsb25nIGRhdGEpCiAKIAkJLyogRHJvcCBj
aGlwIHNlbGVjdCBvbmx5IGlmIGNzX2NoYW5nZSBpcyByZXF1ZXN0ZWQgKi8KIAkJaWYgKHByZXZp
b3VzLT5jc19jaGFuZ2UpCi0JCQlkcnZfZGF0YS0+Y3NfY29udHJvbChQWEEyWFhfQ1NfREVBU1NF
UlQpOworCQkJY3NfZGVhc3NlcnQoZHJ2X2RhdGEpOwogCX0KIAogCS8qIENoZWNrIGZvciB0cmFu
c2ZlcnMgdGhhdCBuZWVkIG11bHRpcGxlIERNQSBzZWdtZW50cyAqLwpAQCAtOTI0LDcgKzk1MCw2
IEBAIHN0YXRpYyB2b2lkIHB1bXBfdHJhbnNmZXJzKHVuc2lnbmVkIGxvbmcgZGF0YSkKIAl9CiAJ
ZHJ2X2RhdGEtPm5fYnl0ZXMgPSBjaGlwLT5uX2J5dGVzOwogCWRydl9kYXRhLT5kbWFfd2lkdGgg
PSBjaGlwLT5kbWFfd2lkdGg7Ci0JZHJ2X2RhdGEtPmNzX2NvbnRyb2wgPSBjaGlwLT5jc19jb250
cm9sOwogCWRydl9kYXRhLT50eCA9ICh2b2lkICopdHJhbnNmZXItPnR4X2J1ZjsKIAlkcnZfZGF0
YS0+dHhfZW5kID0gZHJ2X2RhdGEtPnR4ICsgdHJhbnNmZXItPmxlbjsKIAlkcnZfZGF0YS0+cngg
PSB0cmFuc2Zlci0+cnhfYnVmOwpAQCAtMTA4NiwxMSArMTExMSw3IEBAIHN0YXRpYyB2b2lkIHB1
bXBfdHJhbnNmZXJzKHVuc2lnbmVkIGxvbmcgZGF0YSkKIAkJCXdyaXRlX1NTVE8oY2hpcC0+dGlt
ZW91dCwgcmVnKTsKIAl9CiAKLQkvKiBGSVhNRSwgbmVlZCB0byBoYW5kbGUgY3MgcG9sYXJpdHks
Ci0JICogdGhpcyBkcml2ZXIgdXNlcyBzdHJ1Y3QgcHhhMnh4X3NwaV9jaGlwLmNzX2NvbnRyb2wg
dG8KLQkgKiBzcGVjaWZ5IGEgQ1MgaGFuZGxpbmcgZnVuY3Rpb24sIGFuZCBpdCBpZ25vcmVzIG1v
c3QKLQkgKiBzdHJ1Y3Qgc3BpX2RldmljZS5tb2RlW3NdLCBpbmNsdWRpbmcgU1BJX0NTX0hJR0gg
Ki8KLQlkcnZfZGF0YS0+Y3NfY29udHJvbChQWEEyWFhfQ1NfQVNTRVJUKTsKKwljc19hc3NlcnQo
ZHJ2X2RhdGEpOwogCiAJLyogYWZ0ZXIgY2hpcCBzZWxlY3QsIHJlbGVhc2UgdGhlIGRhdGEgYnkg
ZW5hYmxpbmcgc2VydmljZQogCSAqIHJlcXVlc3RzIGFuZCBpbnRlcnJ1cHRzLCB3aXRob3V0IGNo
YW5naW5nIGFueSBtb2RlIGJpdHMgKi8KQEAgLTExNjgsNiArMTE4OSw0NCBAQCBzdGF0aWMgaW50
IHRyYW5zZmVyKHN0cnVjdCBzcGlfZGV2aWNlICpzcGksIHN0cnVjdCBzcGlfbWVzc2FnZSAqbXNn
KQogLyogdGhlIHNwaS0+bW9kZSBiaXRzIHVuZGVyc3Rvb2QgYnkgdGhpcyBkcml2ZXI6ICovCiAj
ZGVmaW5lIE1PREVCSVRTIChTUElfQ1BPTCB8IFNQSV9DUEhBKQogCitzdGF0aWMgaW50IHNldHVw
X2NzKHN0cnVjdCBzcGlfZGV2aWNlICpzcGksIHN0cnVjdCBjaGlwX2RhdGEgKmNoaXAsCisJCSAg
ICBzdHJ1Y3QgcHhhMnh4X3NwaV9jaGlwICpjaGlwX2luZm8pCit7CisJaW50IGVyciA9IDA7CisK
KwlpZiAoY2hpcCA9PSBOVUxMIHx8IGNoaXBfaW5mbyA9PSBOVUxMKQorCQlyZXR1cm4gMDsKKwor
CS8qIE5PVEU6IHNldHVwKCkgY2FuIGJlIGNhbGxlZCBtdWx0aXBsZSB0aW1lcywgcG9zc2libHkg
d2l0aAorCSAqIGRpZmZlcmVudCBjaGlwX2luZm8sIHJlbGVhc2UgcHJldmlvdXNseSByZXF1ZXN0
ZWQgR1BJTworCSAqLworCWlmIChncGlvX2lzX3ZhbGlkKGNoaXAtPmdwaW9fY3MpKQorCQlncGlv
X2ZyZWUoY2hpcC0+Z3Bpb19jcyk7CisKKwkvKiBJZiAoKmNzX2NvbnRyb2wpIGlzIHByb3ZpZGVk
LCBpZ25vcmUgR1BJTyBjaGlwIHNlbGVjdCAqLworCWlmIChjaGlwX2luZm8tPmNzX2NvbnRyb2wp
IHsKKwkJY2hpcC0+Y3NfY29udHJvbCA9IGNoaXBfaW5mby0+Y3NfY29udHJvbDsKKwkJcmV0dXJu
IDA7CisJfQorCisJaWYgKGdwaW9faXNfdmFsaWQoY2hpcF9pbmZvLT5ncGlvX2NzKSkgeworCQll
cnIgPSBncGlvX3JlcXVlc3QoY2hpcF9pbmZvLT5ncGlvX2NzLCAiU1BJX0NTIik7CisJCWlmIChl
cnIpIHsKKwkJCWRldl9lcnIoJnNwaS0+ZGV2LCAiZmFpbGVkIHRvIHJlcXVlc3QgY2hpcCBzZWxl
Y3QgIgorCQkJCQkiR1BJTyVkXG4iLCBjaGlwX2luZm8tPmdwaW9fY3MpOworCQkJcmV0dXJuIGVy
cjsKKwkJfQorCisJCWNoaXAtPmdwaW9fY3MgPSBjaGlwX2luZm8tPmdwaW9fY3M7CisJCWNoaXAt
PmdwaW9fY3NfaW52ZXJ0ZWQgPSBzcGktPm1vZGUgJiBTUElfQ1NfSElHSDsKKworCQllcnIgPSBn
cGlvX2RpcmVjdGlvbl9vdXRwdXQoY2hpcC0+Z3Bpb19jcywKKwkJCQkJIWNoaXAtPmdwaW9fY3Nf
aW52ZXJ0ZWQpOworCX0KKworCXJldHVybiBlcnI7Cit9CisKIHN0YXRpYyBpbnQgc2V0dXAoc3Ry
dWN0IHNwaV9kZXZpY2UgKnNwaSkKIHsKIAlzdHJ1Y3QgcHhhMnh4X3NwaV9jaGlwICpjaGlwX2lu
Zm8gPSBOVUxMOwpAQCAtMTIxMyw3ICsxMjcyLDcgQEAgc3RhdGljIGludCBzZXR1cChzdHJ1Y3Qg
c3BpX2RldmljZSAqc3BpKQogCQkJcmV0dXJuIC1FTk9NRU07CiAJCX0KIAotCQljaGlwLT5jc19j
b250cm9sID0gbnVsbF9jc19jb250cm9sOworCQljaGlwLT5ncGlvX2NzID0gLTE7CiAJCWNoaXAt
PmVuYWJsZV9kbWEgPSAwOwogCQljaGlwLT50aW1lb3V0ID0gVElNT1VUX0RGTFQ7CiAJCWNoaXAt
PmRtYV9idXJzdF9zaXplID0gZHJ2X2RhdGEtPm1hc3Rlcl9pbmZvLT5lbmFibGVfZG1hID8KQEAg
LTEyMjcsOCArMTI4Niw2IEBAIHN0YXRpYyBpbnQgc2V0dXAoc3RydWN0IHNwaV9kZXZpY2UgKnNw
aSkKIAkvKiBjaGlwX2luZm8gaXNuJ3QgYWx3YXlzIG5lZWRlZCAqLwogCWNoaXAtPmNyMSA9IDA7
CiAJaWYgKGNoaXBfaW5mbykgewotCQlpZiAoY2hpcF9pbmZvLT5jc19jb250cm9sKQotCQkJY2hp
cC0+Y3NfY29udHJvbCA9IGNoaXBfaW5mby0+Y3NfY29udHJvbDsKIAkJaWYgKGNoaXBfaW5mby0+
dGltZW91dCkKIAkJCWNoaXAtPnRpbWVvdXQgPSBjaGlwX2luZm8tPnRpbWVvdXQ7CiAJCWlmIChj
aGlwX2luZm8tPnR4X3RocmVzaG9sZCkKQEAgLTEzMTAsMTMgKzEzNjcsMTYgQEAgc3RhdGljIGlu
dCBzZXR1cChzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQogCiAJc3BpX3NldF9jdGxkYXRhKHNwaSwg
Y2hpcCk7CiAKLQlyZXR1cm4gMDsKKwlyZXR1cm4gc2V0dXBfY3Moc3BpLCBjaGlwLCBjaGlwX2lu
Zm8pOwogfQogCiBzdGF0aWMgdm9pZCBjbGVhbnVwKHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpCiB7
CiAJc3RydWN0IGNoaXBfZGF0YSAqY2hpcCA9IHNwaV9nZXRfY3RsZGF0YShzcGkpOwogCisJaWYg
KGdwaW9faXNfdmFsaWQoY2hpcC0+Z3Bpb19jcykpCisJCWdwaW9fZnJlZShjaGlwLT5ncGlvX2Nz
KTsKKwogCWtmcmVlKGNoaXApOwogfQogCi0tIAoxLjYuMC4yCgo=
------=_Part_18256_13580615.1228444128986
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
------=_Part_18256_13580615.1228444128986
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

------=_Part_18256_13580615.1228444128986--
