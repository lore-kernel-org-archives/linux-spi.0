From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH V5 3/3] spi: spi-geni-qcom: Add SPI driver support for GENI based
 QUP
Date: Tue, 09 Oct 2018 12:45:35 -0700
Message-ID: <153911433511.119890.17831207059115471972@swboyd.mtv.corp.google.com>
References: <1538574265-30235-1-git-send-email-alokc@codeaurora.org>
 <1538574265-30235-4-git-send-email-alokc@codeaurora.org>
 <153904219713.119890.7463642233895152532@swboyd.mtv.corp.google.com>
 <CAD=FV=XnYucy4JmgATrB89RYHTbzRC_GaouaRjHAocD4-H0ncg@mail.gmail.com>
 <153910152600.119890.14820584405992384926@swboyd.mtv.corp.google.com>
 <CAD=FV=U-ZZQhFKR9kxYnw=F1j+dExrsgFvjabYJ8AVmBDM4eXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: alokc@codeaurora.org, Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>
To: Doug Anderson <dianders@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=U-ZZQhFKR9kxYnw=F1j+dExrsgFvjabYJ8AVmBDM4eXA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Quoting Doug Anderson (2018-10-09 10:48:55)
> =

> Ah, you're suggesting separating the platform_get_irq() and the
> request_irq() so that we call platform_get_irq() as the first thing in
> the function but don't do the request_irq() until later.  Yeah, that
> could be done and I guess if you feel strongly about it I wouldn't
> object to the change, but I don't feel it buys us a lot and I kind of
> like keeping the two next to each other.  Specifically why I don't
> think it buys us a lot:
> =

> 1. You still need the "dev_err" print, right?  platform_get_irq()
> doesn't automatically print errors for you I think.

I usually leave it out. Who cares? Maybe we should throw a dev_err()
into platform_get_irq() on failure so we can keep drivers cleaner and
reduce a bunch of "can't find my IRQ" messages throughout the kernel.

> =

> 2. You now need a local variable "irq".  By putting the
> platform_get_irq() before the memory allocation you now can't store it
> directly in mas->irq.  We could try using "ret" as a temporary
> variable but that seems worse in this case since it'd be a bit
> fragile.
> =

> 3. You don't get rid of any error labels / error handling so we don't
> really save any code
> =

> When I tried this my diffstat says 8 lines added and 7 removed, so a
> net increase in LOC FWIW.  I'm relying in gmail so my patch will be
> whitespace-damaged (sigh), but you can find a clean one at:
> =

> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/e0325d6=
18e209c22379e3a4269c14627b19243a8%5E%21/#F0
> =

> ...the basic idea is this though:
> =


Thanks! Here's an updated patch that I haven't compile tested in any way
that hoists up the IO mapping part too, which shows that the 'se' local
variable is almost entirely useless.

 drivers/spi/spi-geni-qcom.c | 49 ++++++++++++++++++++++-------------------=
----
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 6432ecc4e2ca..917707448578 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -538,11 +538,30 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 =

 static int spi_geni_probe(struct platform_device *pdev)
 {
-	int ret;
+	int ret, irq;
 	struct spi_master *spi;
 	struct spi_geni_master *mas;
 	struct resource *res;
-	struct geni_se *se;
+	void __iomem *base;
+	struct clk *clk;
+
+	irq =3D platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "Err getting IRQ %d\n", irq);
+		return irq;
+	}
+
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base =3D devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	clk =3D devm_clk_get(&pdev->dev, "se");
+	if (IS_ERR(clk)) {
+		ret =3D PTR_ERR(mas->se.clk);
+		dev_err(&pdev->dev, "Err getting SE Core clk %d\n", ret);
+		return ret;
+	}
 =

 	spi =3D spi_alloc_master(&pdev->dev, sizeof(*mas));
 	if (!spi)
@@ -550,27 +569,15 @@ static int spi_geni_probe(struct platform_device *pde=
v)
 =

 	platform_set_drvdata(pdev, spi);
 	mas =3D spi_master_get_devdata(spi);
+	mas->irq =3D irq;
 	mas->dev =3D &pdev->dev;
 	mas->se.dev =3D &pdev->dev;
 	mas->se.wrapper =3D dev_get_drvdata(pdev->dev.parent);
-	se =3D &mas->se;
+	mas->se.base =3D base;
+	mas->se.clk =3D clk;
 =

 	spi->bus_num =3D -1;
 	spi->dev.of_node =3D pdev->dev.of_node;
-	mas->se.clk =3D devm_clk_get(&pdev->dev, "se");
-	if (IS_ERR(mas->se.clk)) {
-		ret =3D PTR_ERR(mas->se.clk);
-		dev_err(&pdev->dev, "Err getting SE Core clk %d\n", ret);
-		goto spi_geni_probe_err;
-	}
-
-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	se->base =3D devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(se->base)) {
-		ret =3D PTR_ERR(se->base);
-		goto spi_geni_probe_err;
-	}
-
 	spi->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_LOOP | SPI_CS_HIGH;
 	spi->bits_per_word_mask =3D SPI_BPW_RANGE_MASK(4, 32);
 	spi->num_chipselect =3D 4;
@@ -589,13 +596,6 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (ret)
 		goto spi_geni_probe_runtime_disable;
 =

-	mas->irq =3D platform_get_irq(pdev, 0);
-	if (mas->irq < 0) {
-		ret =3D mas->irq;
-		dev_err(&pdev->dev, "Err getting IRQ %d\n", ret);
-		goto spi_geni_probe_runtime_disable;
-	}
-
 	ret =3D request_irq(mas->irq, geni_spi_isr,
 			IRQF_TRIGGER_HIGH, "spi_geni", spi);
 	if (ret)
@@ -610,7 +610,6 @@ static int spi_geni_probe(struct platform_device *pdev)
 	free_irq(mas->irq, spi);
 spi_geni_probe_runtime_disable:
 	pm_runtime_disable(&pdev->dev);
-spi_geni_probe_err:
 	spi_master_put(spi);
 	return ret;
 }
