From: Flavio Suligoi <f.suligoi@asem.it>
Subject: RE: [PATCH v2 1/1] spi: pxa2xx: add driver enabling message
Date: Wed, 10 Apr 2019 10:16:14 +0000
Message-ID: <29d4b981e6224ee89db90bf71bdbf7e1@asem.it>
References: <358f26bc47bd4aa289971f0a763b27cb@asem.it>
 <1554889624-25000-1-git-send-email-f.suligoi@asem.it>
 <ab279a3c-0870-8a9a-62d9-38b17670ed2f@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Daniel Mack
 <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, "Robert
 Jarzmik" <robert.jarzmik@free.fr>, Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <ab279a3c-0870-8a9a-62d9-38b17670ed2f@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

> On 4/10/19 12:47 PM, Flavio Suligoi wrote:
> > Add an info message for the PXA2xx device driver start-up,
> > with the indication of:
> >
> > - mode (slave device or master controller)
> > - transfer mode (DMA or GPIO)
> >
> > Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> > ---
> >
> > v1:	- first version
> > v2:	- remove warning message "no DMA channels available, using PIO"
> > 	- add "slave device"/"master controller" indication message
> >
> >   drivers/spi/spi-pxa2xx.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> > index f7068cc..b9e04e2 100644
> > --- a/drivers/spi/spi-pxa2xx.c
> > +++ b/drivers/spi/spi-pxa2xx.c
> > @@ -1696,7 +1696,6 @@ static int pxa2xx_spi_probe(struct platform_device
> *pdev)
> >   	if (platform_info->enable_dma) {
> >   		status = pxa2xx_spi_dma_setup(drv_data);
> >   		if (status) {
> > -			dev_warn(dev, "no DMA channels available, using PIO\n");
> >   			platform_info->enable_dma = false;
> >   		} else {
> >   			controller->can_dma = pxa2xx_spi_can_dma;
> > @@ -1818,6 +1817,10 @@ static int pxa2xx_spi_probe(struct
> platform_device *pdev)
> >   	pm_runtime_set_active(&pdev->dev);
> >   	pm_runtime_enable(&pdev->dev);
> >
> > +	dev_info(dev, "PXA2xx SPI %s (%s mode)\n",
> > +		platform_info->is_slave ? "slave device" : "master
> controller",
> > +		platform_info->enable_dma ? "DMA" : "PIO");
> > +
> 
> "slave device" is ambiguous. Please use "controller" with both, i.e.
> "PXA2xx SPI %s controller (%s mode)\n", ... ? "slave" : "master", ...
> 
> With that changed you may add:
> 
> Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Ok

Flavio
