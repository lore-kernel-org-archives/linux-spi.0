From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 14/14] drivers/spi/spi-s3c24xx.c: fix error return code
Date: Wed, 22 Aug 2012 13:42:47 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1208221342240.1991@hadrien>
References: <1345365870-29831-1-git-send-email-Julia.Lawall@lip6.fr> <1345365870-29831-15-git-send-email-Julia.Lawall@lip6.fr> <1b3201cd8049$e753f720$b5fbe560$%kim@samsung.com> <20120822114015.GI7995@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kukjin Kim <kgene.kim@samsung.com>,
	'Julia Lawall' <Julia.Lawall@lip6.fr>,
	'Ben Dooks' <ben-linux@fluff.org>,
	kernel-janitors@vger.kernel.org,
	'Grant Likely' <grant.likely@secretlab.ca>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120822114015.GI7995@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Initialize return variable before exiting on an error path.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
(
if@p1 (\(ret < 0\|ret != 0\))
 { ... return ret; }
|
ret@p1 = 0
)
... when != ret = e1
    when != &ret
*if(...)
{
  ... when != ret = e2
      when forall
 return ret;
}

// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
Perhaps -EINVAL is not the right value in this case.

 drivers/spi/spi-s3c24xx.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
index 8ee7d79..a2a080b 100644
--- a/drivers/spi/spi-s3c24xx.c
+++ b/drivers/spi/spi-s3c24xx.c
@@ -611,6 +611,7 @@ static int __devinit s3c24xx_spi_probe(struct platform_device *pdev)
 	if (!pdata->set_cs) {
 		if (pdata->pin_cs < 0) {
 			dev_err(&pdev->dev, "No chipselect pin\n");
+			err = -EINVAL;
 			goto err_register;
 		}
