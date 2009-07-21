From: Mike Rapoport <mike.rapoport-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] [ARM] pxa27x-spi: switch to dev_pm_ops
Date: Tue, 21 Jul 2009 17:55:40 +0300
Message-ID: <f870da180907210755o134bf9c3je0b80944abf99036@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636765b86b521b8046f38728d
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel <linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
To: eric miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

--001636765b86b521b8046f38728d
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Signed-off-by: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
---
 drivers/spi/pxa2xx_spi.c |   28 +++++++++++++---------------
 1 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
index d949dbf..a40ada3 100644
--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -1667,11 +1667,9 @@ static void pxa2xx_spi_shutdown(struct
platform_device *pdev)
 		dev_err(&pdev->dev, "shutdown failed with %d\n", status);
 }

-#ifdef CONFIG_PM
-
-static int pxa2xx_spi_suspend(struct platform_device *pdev, pm_message_t state)
+static int pxa2xx_spi_suspend(struct device *dev)
 {
-	struct driver_data *drv_data = platform_get_drvdata(pdev);
+	struct driver_data *drv_data = dev_get_drvdata(dev);
 	struct ssp_device *ssp = drv_data->ssp;
 	int status = 0;

@@ -1684,9 +1682,9 @@ static int pxa2xx_spi_suspend(struct
platform_device *pdev, pm_message_t state)
 	return 0;
 }

-static int pxa2xx_spi_resume(struct platform_device *pdev)
+static int pxa2xx_spi_resume(struct device *dev)
 {
-	struct driver_data *drv_data = platform_get_drvdata(pdev);
+	struct driver_data *drv_data = dev_get_drvdata(dev);
 	struct ssp_device *ssp = drv_data->ssp;
 	int status = 0;

@@ -1703,26 +1701,26 @@ static int pxa2xx_spi_resume(struct
platform_device *pdev)
 	/* Start the queue running */
 	status = start_queue(drv_data);
 	if (status != 0) {
-		dev_err(&pdev->dev, "problem starting queue (%d)\n", status);
+		dev_err(dev, "problem starting queue (%d)\n", status);
 		return status;
 	}

 	return 0;
 }
-#else
-#define pxa2xx_spi_suspend NULL
-#define pxa2xx_spi_resume NULL
-#endif /* CONFIG_PM */
+
+static struct dev_pm_ops pxa2xx_spi_pm_ops = {
+	.suspend	= pxa2xx_spi_suspend,
+	.resume		= pxa2xx_spi_resume,
+};

 static struct platform_driver driver = {
 	.driver = {
-		.name = "pxa2xx-spi",
-		.owner = THIS_MODULE,
+		.name	= "pxa2xx-spi",
+		.owner	= THIS_MODULE,
+		.pm	= &pxa2xx_spi_pm_ops,
 	},
 	.remove = pxa2xx_spi_remove,
 	.shutdown = pxa2xx_spi_shutdown,
-	.suspend = pxa2xx_spi_suspend,
-	.resume = pxa2xx_spi_resume,
 };

 static int __init pxa2xx_spi_init(void)
-- 
1.6.0.6



-- 
	Sincerely Yours,
		Mike.

--001636765b86b521b8046f38728d
Content-Type: application/octet-stream;
	name="0003--ARM-pxa27x-spi-switch-to-dev_pm_ops.patch"
Content-Disposition: attachment;
	filename="0003--ARM-pxa27x-spi-switch-to-dev_pm_ops.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fxeqyimo0

RnJvbSAxMThmNWY2ZTM3MGYyOTQ2NjFmZWNmZDM2NGJmY2RhN2Y2MWMzOWRlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNaWtlIFJhcG9wb3J0IDxtaWtlQGNvbXB1bGFiLmNvLmlsPgpE
YXRlOiBUdWUsIDIxIEp1bCAyMDA5IDE3OjUwOjE2ICswMzAwClN1YmplY3Q6IFtQQVRDSF0gW0FS
TV0gcHhhMjd4LXNwaTogc3dpdGNoIHRvIGRldl9wbV9vcHMKClNpZ25lZC1vZmYtYnk6IE1pa2Ug
UmFwb3BvcnQgPG1pa2VAY29tcHVsYWIuY28uaWw+Ci0tLQogZHJpdmVycy9zcGkvcHhhMnh4X3Nw
aS5jIHwgICAyOCArKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGVzIGNoYW5nZWQs
IDEzIGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
c3BpL3B4YTJ4eF9zcGkuYyBiL2RyaXZlcnMvc3BpL3B4YTJ4eF9zcGkuYwppbmRleCBkOTQ5ZGJm
Li5hNDBhZGEzIDEwMDY0NAotLS0gYS9kcml2ZXJzL3NwaS9weGEyeHhfc3BpLmMKKysrIGIvZHJp
dmVycy9zcGkvcHhhMnh4X3NwaS5jCkBAIC0xNjY3LDExICsxNjY3LDkgQEAgc3RhdGljIHZvaWQg
cHhhMnh4X3NwaV9zaHV0ZG93bihzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCQlkZXZf
ZXJyKCZwZGV2LT5kZXYsICJzaHV0ZG93biBmYWlsZWQgd2l0aCAlZFxuIiwgc3RhdHVzKTsKIH0K
IAotI2lmZGVmIENPTkZJR19QTQotCi1zdGF0aWMgaW50IHB4YTJ4eF9zcGlfc3VzcGVuZChzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LCBwbV9tZXNzYWdlX3Qgc3RhdGUpCitzdGF0aWMgaW50
IHB4YTJ4eF9zcGlfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpCiB7Ci0Jc3RydWN0IGRyaXZl
cl9kYXRhICpkcnZfZGF0YSA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOworCXN0cnVjdCBk
cml2ZXJfZGF0YSAqZHJ2X2RhdGEgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsKIAlzdHJ1Y3Qgc3Nw
X2RldmljZSAqc3NwID0gZHJ2X2RhdGEtPnNzcDsKIAlpbnQgc3RhdHVzID0gMDsKIApAQCAtMTY4
NCw5ICsxNjgyLDkgQEAgc3RhdGljIGludCBweGEyeHhfc3BpX3N1c3BlbmQoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldiwgcG1fbWVzc2FnZV90IHN0YXRlKQogCXJldHVybiAwOwogfQogCi1z
dGF0aWMgaW50IHB4YTJ4eF9zcGlfcmVzdW1lKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
CitzdGF0aWMgaW50IHB4YTJ4eF9zcGlfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikKIHsKLQlz
dHJ1Y3QgZHJpdmVyX2RhdGEgKmRydl9kYXRhID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7
CisJc3RydWN0IGRyaXZlcl9kYXRhICpkcnZfZGF0YSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOwog
CXN0cnVjdCBzc3BfZGV2aWNlICpzc3AgPSBkcnZfZGF0YS0+c3NwOwogCWludCBzdGF0dXMgPSAw
OwogCkBAIC0xNzAzLDI2ICsxNzAxLDI2IEBAIHN0YXRpYyBpbnQgcHhhMnh4X3NwaV9yZXN1bWUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAkvKiBTdGFydCB0aGUgcXVldWUgcnVubmlu
ZyAqLwogCXN0YXR1cyA9IHN0YXJ0X3F1ZXVlKGRydl9kYXRhKTsKIAlpZiAoc3RhdHVzICE9IDAp
IHsKLQkJZGV2X2VycigmcGRldi0+ZGV2LCAicHJvYmxlbSBzdGFydGluZyBxdWV1ZSAoJWQpXG4i
LCBzdGF0dXMpOworCQlkZXZfZXJyKGRldiwgInByb2JsZW0gc3RhcnRpbmcgcXVldWUgKCVkKVxu
Iiwgc3RhdHVzKTsKIAkJcmV0dXJuIHN0YXR1czsKIAl9CiAKIAlyZXR1cm4gMDsKIH0KLSNlbHNl
Ci0jZGVmaW5lIHB4YTJ4eF9zcGlfc3VzcGVuZCBOVUxMCi0jZGVmaW5lIHB4YTJ4eF9zcGlfcmVz
dW1lIE5VTEwKLSNlbmRpZiAvKiBDT05GSUdfUE0gKi8KKworc3RhdGljIHN0cnVjdCBkZXZfcG1f
b3BzIHB4YTJ4eF9zcGlfcG1fb3BzID0geworCS5zdXNwZW5kCT0gcHhhMnh4X3NwaV9zdXNwZW5k
LAorCS5yZXN1bWUJCT0gcHhhMnh4X3NwaV9yZXN1bWUsCit9OwogCiBzdGF0aWMgc3RydWN0IHBs
YXRmb3JtX2RyaXZlciBkcml2ZXIgPSB7CiAJLmRyaXZlciA9IHsKLQkJLm5hbWUgPSAicHhhMnh4
LXNwaSIsCi0JCS5vd25lciA9IFRISVNfTU9EVUxFLAorCQkubmFtZQk9ICJweGEyeHgtc3BpIiwK
KwkJLm93bmVyCT0gVEhJU19NT0RVTEUsCisJCS5wbQk9ICZweGEyeHhfc3BpX3BtX29wcywKIAl9
LAogCS5yZW1vdmUgPSBweGEyeHhfc3BpX3JlbW92ZSwKIAkuc2h1dGRvd24gPSBweGEyeHhfc3Bp
X3NodXRkb3duLAotCS5zdXNwZW5kID0gcHhhMnh4X3NwaV9zdXNwZW5kLAotCS5yZXN1bWUgPSBw
eGEyeHhfc3BpX3Jlc3VtZSwKIH07CiAKIHN0YXRpYyBpbnQgX19pbml0IHB4YTJ4eF9zcGlfaW5p
dCh2b2lkKQotLSAKMS42LjAuNgoK
--001636765b86b521b8046f38728d
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
--001636765b86b521b8046f38728d
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--001636765b86b521b8046f38728d--
