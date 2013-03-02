From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH V3] spi: tegra114: add spi driver
Date: Sat, 02 Mar 2013 23:09:06 +0000
Message-ID: <20130302230906.141BE3E336A@localhost>
References: <1361536659-23225-1-git-send-email-ldewangan@nvidia.com>
	<CAKDJKT5yngpZQC-ZvHSaKeBVHW97wo4QwLSXQ4KsVWCs5J1YKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
	linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Manish Badarkhe <badarkhe.manish-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CAKDJKT5yngpZQC-ZvHSaKeBVHW97wo4QwLSXQ4KsVWCs5J1YKg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, 22 Feb 2013 19:59:11 +0530, Manish Badarkhe <badarkhe.manish-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Fri, Feb 22, 2013 at 6:07 PM, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> > Add SPI driver for NVIDIA's Tegra114 SPI controller. This controller
> > is different than the older SoCs SPI controller in internal design as
> > well as register interface.
> >
> > This driver supports the:
> > - non DMA based transfer for smaller transfer i.e. less than FIFO depth.
> > - APB DMA based transfer for lager transfer i.e. more than FIFO depth.
> 
> s/lager/larger

Applied, thanks. And I fixed up the typo when I did.

> > +       spi_irq = platform_get_irq(pdev, 0);
> > +       tspi->irq = spi_irq;
> > +       ret = request_threaded_irq(tspi->irq, tegra_spi_isr,
> > +                       tegra_spi_isr_thread, IRQF_ONESHOT,
> > +                       dev_name(&pdev->dev), tspi);
> 
> Can we use devm_request_threaded_irq instead? to save some code.

I don't have any quams about applying it as-is. That can be done as a
follow on patch.

g.


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_feb
