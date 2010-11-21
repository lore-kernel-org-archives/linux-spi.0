From: Ryan Mallon <ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>
Subject: Re: [PATCH v6 08/12] gpio: add ti-ssp gpio driver
Date: Mon, 22 Nov 2010 09:02:45 +1300
Message-ID: <4CE97AE5.3040801@bluewatersys.com>
References: <1290182156-20104-1-git-send-email-cyril@ti.com>
	<1290182156-20104-9-git-send-email-cyril@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
	dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org,
	rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org, alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org
To: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1290182156-20104-9-git-send-email-cyril-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 11/20/2010 04:55 AM, Cyril Chemparathy wrote:
> TI's SSP controller pins can be directly read and written to behave like a
> GPIO.  This patch adds a GPIO driver that exposes such functionality.
> 
> Signed-off-by: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
> ---

> +static int __devinit ti_ssp_gpio_probe(struct platform_device *pdev)
> +{
> +	const struct ti_ssp_gpio_data *pdata = pdev->dev.platform_data;
> +	struct device *dev = &pdev->dev;
> +	struct ti_ssp_gpio_chip *gpio;
> +	int error;
> +
> +	if (!pdata) {
> +		dev_err(dev, "platform data not found\n");
> +		return -EINVAL;
> +	}
> +
> +	gpio = kzalloc(sizeof(*gpio), GFP_KERNEL);
> +	if (!gpio) {
> +		dev_err(dev, "cannot allocate driver data\n");
> +		return -ENOMEM;
> +	}
> +
> +	gpio->dev = dev;
> +	gpio->iosel = SSP_PIN_SEL(0, SSP_IN) | SSP_PIN_SEL(1, SSP_IN) |
> +		      SSP_PIN_SEL(2, SSP_IN) | SSP_PIN_SEL(3, SSP_IN);
> +	error = ti_ssp_set_iosel(gpio->dev, gpio->iosel);
> +	if (error < 0) {
> +		dev_err(dev, "gpio io setup failed (%d)\n", error);
> +		goto error;
> +	}
> +
> +	spin_lock_init(&gpio->lock);
> +	platform_set_drvdata(pdev, gpio);

This looks wrong. gpio is of type ti_ssp_gpio_chip, but the ssp core
functions, ssp_read, etc, use dev_to_ssp:

static inline struct ti_ssp *dev_to_ssp(struct device *dev)
{
	return dev_get_drvdata(dev->parent);
}

If I understand correctly, the ssp core can only be used to for one
peripheral at a time. Currently the code will allow you to install
several peripherals at once, which will lead to odd behaviour at
runtime. Maybe a better approach would be to have something like this in
drivers/mfd/ti-ssp.c:

struct ti_ssp {
	struct resource		*res;
	struct device		*dev;
	void __iomem		*regs;
	struct clk		*clk;
	int			irq;
	wait_queue_head_t	wqh;
	int			in_use;
};

static struct ti_ssp ti_ssp = {
	.in_use = 0,
};
static DEFINE_SPINLOCK(ti_ssp_lock);

struct ti_ssp *ti_ssp_get(void)
{
	spin_lock(&ti_ssp_lock);
	if (ti_ssp.in_use) {
		spin_unlock(&ti_ssp_lock);
		return NULL;
	}

	ti_ssp.in_use = 1;
	spin_unlock(&ti_ssp_lock);
	return &ti_ssp;
}

int ti_ssp_put(void)
{
	spin_lock(&ti_ssp_lock);
	if (!ti_ssp.in_use) {
		spin_unlock(&ti_ssp_lock);
		return -ENODEV;
	}
	
	ti_ssp.in_use = 0;	
	spin_unlock(&ti_ssp_lock);
	return 0;
}

This way, the ssp core api functions can take struct ti_ssp * as their
first argument (which can still be an opaque pointer) and the code
protects against multiple peripherals attempting to register the ssp core.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
